from fastapi import APIRouter, Depends, HTTPException, Form, Path, Request, Query
from sqlalchemy.orm import Session, joinedload
from app.database import get_db
from app.models import model as m
from app.schemas import schemas as s
from app.services.activity_log import create_activity_log  
from app.utils.auth_log import get_current_user  
from app.utils.verifpass import hash_password, validate_password_strength
from app.utils.time import get_ntp_time 
from typing import List, Optional
from datetime import timezone, timedelta

router = APIRouter(prefix="/user", tags=["User"])

@router.get("/view", response_model=List[s.UserRead])
def get_users(db: Session = Depends(get_db)):
    try:
        users = db.query(m.User).options(
            joinedload(m.User.employee),
            joinedload(m.User.roles)
        ).all()
        return users
    except Exception as e:
        raise HTTPException(status_code=500, detail="Failed to fetch users")

@router.get("/available_employees", response_model=List[s.EmployeeRead])
async def get_available_employees(db: Session = Depends(get_db)):
    try:
        employees = db.query(m.Employee).outerjoin(m.User).filter(m.User.user_id == None).all()
        return employees
    except Exception as e:
        raise HTTPException(status_code=500, detail="Failed to fetch employees")

@router.get("/available_roles", response_model=List[s.RoleRead])
async def get_available_roles(db: Session = Depends(get_db)):
    try:
        roles = db.query(m.Roles).all()
        return roles
    except Exception as e:
        raise HTTPException(status_code=500, detail="Failed to fetch roles")
    
@router.get("/view/{user_id}")
def get_user_detail(user_id: int, db: Session = Depends(get_db)):
    wib = timezone(timedelta(hours=7))

    user = db.query(m.User).options(
        joinedload(m.User.employee),
        joinedload(m.User.roles)
    ).filter(m.User.user_id == user_id).first()

    if not user:
        raise HTTPException(status_code=404, detail="User not found")

    logs = (
        db.query(m.ActivityLog)
        .filter(m.ActivityLog.detail.ilike(f"%{user.username}%"))
        .order_by(m.ActivityLog.timestamp.asc())
        .all()
    )

    created_by = "-"
    created_when = None
    last_modified_by = None
    last_modified_when = None

    created_logs = [log for log in logs if "created" in log.detail.lower()]
    updated_logs = [log for log in logs if "updated" in log.detail.lower()]
    deleted_logs = [log for log in logs if "deleted" in log.detail.lower()]

    last_deleted_time = deleted_logs[-1].timestamp if deleted_logs else None

    final_created_log = None
    for log in reversed(created_logs):
        if not last_deleted_time or log.timestamp > last_deleted_time:
            final_created_log = log
            break

    if final_created_log:
        created_by = final_created_log.user.username if final_created_log.user else "-"
        created_when = final_created_log.timestamp.astimezone(wib).strftime("%Y-%m-%d %H:%M:%S")

    for log in reversed(updated_logs):
        if not final_created_log or log.timestamp > final_created_log.timestamp:
            last_modified_by = log.user.username if log.user else "-"
            last_modified_when = log.timestamp.astimezone(wib).strftime("%Y-%m-%d %H:%M:%S")
            break

    if final_created_log:
        if last_modified_by: 
            result_created_by = last_modified_by
            result_created_when = last_modified_when
        else:
            result_created_by = created_by
            result_created_when = created_when
    else:
        if last_modified_by:  
            result_created_by = last_modified_by
            result_created_when = last_modified_when
        elif user.activity_date:
            result_created_by = "-"
            result_created_when = user.activity_date.astimezone(wib).strftime("%Y-%m-%d %H:%M:%S")
        else: 
            result_created_by = "-"
            result_created_when = None

    result = {
        "user_id": user.user_id,
        "first_name": user.employee.first_name if user.employee else "-",
        "last_name": user.employee.last_name if user.employee else "-",
        "username": user.username,
        "email": user.email,
        "roles": [r.roles_name for r in user.roles],
        "created": {
            "when": result_created_when,
            "by": result_created_by
        }
    }

    if last_modified_by:
        result["last_modified"] = {
            "when": last_modified_when,
            "by": last_modified_by
        }

    return result

@router.post("/create", response_model=s.UserRead)
async def create_user(
    request: Request,
    current_user: m.User = Depends(get_current_user),
    employee_id: Optional[int] = Form(None),
    username: str = Form(...),
    email: str = Form(...),
    password: str = Form(...),
    role_name: str = Form(...),
    db: Session = Depends(get_db)
):
    try:
        if employee_id:
            employee = db.query(m.Employee).filter_by(employee_id=employee_id).first()
            if employee and not email:
                email = employee.email

        existing_user = db.query(m.User).filter(
            (m.User.username == username) | 
            (m.User.email == email)
        ).first()
        if existing_user:
            raise HTTPException(status_code=400, detail="Username or Email already exists")
        
        validate_password_strength(password)
        hashed_password = hash_password(password)

        new_user = m.User(
            employee_id=employee_id,
            username=username,
            email=email,
            password=hashed_password,
            activity_date=get_ntp_time()
        )
        db.add(new_user)
        db.commit()
        db.refresh(new_user)

        role = db.query(m.Roles).filter_by(roles_name=role_name).first()
        if not role:
            raise HTTPException(status_code=400, detail="Role not found")

        user_role = m.UserRoles(user_id=new_user.user_id, roles_id=role.roles_id)
        db.add(user_role)
        db.commit()
        
        create_activity_log(
            db=db,
            request=request,
            user_id=current_user.user_id,
            action="Created user",
            detail=f"User {username} created successfully by {current_user.username}"
        )

        return db.query(m.User).options(
            joinedload(m.User.employee),
            joinedload(m.User.roles)
        ).filter(m.User.user_id == new_user.user_id).first()

    except HTTPException:
        db.rollback()
        raise

    except Exception as e:
        db.rollback()
        
        create_activity_log(
            db=db,
            request=request,
            user_id=current_user.user_id,
            action="User creation failed",
            detail=str(e)
        )

        raise HTTPException(status_code=500, detail="Failed to create user")

@router.put("/update/{user_id}", response_model=s.UserRead)
def update_user(
    request: Request,
    user_id: int,
    current_user: m.User = Depends(get_current_user),  
    username: str = Form(...),
    email: str = Form(...),
    password: Optional[str] = Form(None),
    role_name: Optional[str] = Form(None),
    db: Session = Depends(get_db)
):
    try:
        user = db.query(m.User).filter_by(user_id=user_id).first()
        if not user:
            raise HTTPException(status_code=404, detail="User not found")

        user.username = username
        user.email = email

        if password:
            validate_password_strength(password)
            hashed_password = hash_password(password)
            user.password = hashed_password
            user.activity_date = get_ntp_time()

        if role_name:
            role = db.query(m.Roles).filter_by(roles_name=role_name).first()
            if not role:
                raise HTTPException(status_code=400, detail="Role not found")
            db.query(m.UserRoles).filter_by(user_id=user_id).delete()
            db.add(m.UserRoles(user_id=user_id, roles_id=role.roles_id))

        db.commit()

        create_activity_log(
            db=db,
            request=request,
            user_id=current_user.user_id,
            action="Updated user",
            detail=f"User {username} updated successfully by {current_user.username}"
        )

        return db.query(m.User).options(
            joinedload(m.User.employee),
            joinedload(m.User.roles)
        ).filter(m.User.user_id == user_id).first()
    
    except HTTPException:
        db.rollback()
        raise
    except Exception as e:
        db.rollback()

        create_activity_log(
            db=db,
            request=request,
            user_id=current_user.user_id,
            action="User update failed",
            detail=str(e)
        )

        raise HTTPException(status_code=500, detail="Failed to update user")

@router.delete("/delete/{user_id}", response_model=s.UserRead)
async def delete_user(
    request: Request,
    current_user: m.User = Depends(get_current_user),  
    user_id: int = Path(..., title="The ID of the account to delete"),
    db: Session = Depends(get_db)
):
    try:
        user = db.query(m.User).filter_by(user_id=user_id).first()
        if not user:
            raise HTTPException(status_code=404, detail="Account not found")

        db.delete(user)
        db.commit()

        create_activity_log(
            db=db,
            request=request,
            user_id=current_user.user_id,
            action="Deleted user",
            detail=f"User {user_id} deleted successfully by {current_user.username}"
        )

        return user

    except Exception as e:
        db.rollback()

        create_activity_log(
            db=db,
            request=request,
            user_id=current_user.user_id,
            action="User deletion failed",
            detail=str(e)
        )

        raise HTTPException(status_code=500, detail="Failed to delete account")


@router.put("/sync-email/{user_id}")
def sync_email_from_employee(user_id: int, db: Session = Depends(get_db)):
    user = db.query(m.User).filter(m.User.user_id == user_id).first()
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    if not user.employee_id:
        raise HTTPException(status_code=400, detail="User is not linked to an employee")
    employee = db.query(m.Employee).filter(m.Employee.employee_id == user.employee_id).first()
    if not employee:
        raise HTTPException(status_code=404, detail="Employee not found")
    try:
        user.email = employee.email
        db.commit()
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=500, detail=f"Database error: {str(e)}")

    return {"message": "Email synced from employee successfully"}


@router.get("/check_email/{email}")
def check_email_availability(email: str, exclude_id: Optional[int] = Query(None), db: Session = Depends(get_db)):
    query = db.query(m.User).filter(m.User.email == email)
    if exclude_id:
        query = query.filter(m.User.user_id != exclude_id)
    existing = query.first()
    return {"available": existing is None}

@router.get("/check_username/{username}")
def check_username_availability(username: str, exclude_id: Optional[int] = Query(None), db: Session = Depends(get_db)):
    query = db.query(m.User).filter(m.User.username == username)
    if exclude_id:
        query = query.filter(m.User.user_id != exclude_id)
    existing = query.first()
    return {"available": existing is None}
