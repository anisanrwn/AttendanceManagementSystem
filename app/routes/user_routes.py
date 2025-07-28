from fastapi import APIRouter, Depends, HTTPException, Form, Path, Request, Query
from sqlalchemy.orm import Session, joinedload
from app.database import get_db
from app.models import model as m
from app.schemas import schemas as s
from app.services.activity_log import create_activity_log  
from app.utils.auth_log import get_current_user  
from app.utils.verifpass import hash_password, validate_password_strength
from typing import List, Optional

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

@router.post("/create", response_model=s.UserRead)
async def create_user(
    request: Request,
    current_user: m.User = Depends(get_current_user),  # ✅ Tambahkan ini
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
            password=hashed_password
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
