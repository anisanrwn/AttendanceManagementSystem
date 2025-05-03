from fastapi import APIRouter, Depends, HTTPException, Form, Path
from sqlalchemy.orm import Session, joinedload
from app.database import get_db
from app.models import model as m
from app.schemas import schemas as s
from app.utils.logger import log_activity
from app.utils.verifpass import hash_password
from typing import List, Optional

router = APIRouter(
    prefix="/user",
    tags=["User"]
)

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

        log_activity(db, "Created user", f"User {username} created successfully")
        return db.query(m.User).options(
            joinedload(m.User.employee),
            joinedload(m.User.roles)
        ).filter(m.User.user_id == new_user.user_id).first()
    except HTTPException:
        db.rollback()
        raise
    except Exception as e:
        db.rollback()
        log_activity(db, "User creation failed", str(e))
        raise HTTPException(status_code=500, detail="Failed to create user")

@router.put("/update/{user_id}", response_model=s.UserRead)
def update_user(
    user_id: int,
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
            hashed_password = hash_password(password)
            user.password = hashed_password

        if role_name:
            role = db.query(m.Roles).filter_by(roles_name=role_name).first()
            if not role:
                raise HTTPException(status_code=400, detail="Role not found")
            db.query(m.UserRoles).filter_by(user_id=user_id).delete()
            db.add(m.UserRoles(user_id=user_id, roles_id=role.roles_id))

        db.commit()
        log_activity(db, "Updated user", f"User {username} updated successfully")
        return db.query(m.User).options(
            joinedload(m.User.employee),
            joinedload(m.User.roles)
        ).filter(m.User.user_id == user_id).first()
    except HTTPException:
        db.rollback()
        raise
    except Exception as e:
        db.rollback()
        log_activity(db, "User update failed", str(e))
        raise HTTPException(status_code=500, detail="Failed to update user")

@router.delete("/delete/{user_id}", response_model=s.UserRead)
async def delete_user(
    user_id: int = Path(..., title="The ID of the account to delete"),
    db: Session = Depends(get_db)
):
    try:
        user = db.query(m.User).filter_by(user_id=user_id).first()
        if not user:
            raise HTTPException(status_code=404, detail="Account not found")

        db.delete(user)
        db.commit()
        log_activity(db, "Deleted user", f"User {user_id} deleted successfully")
        return user
    except Exception as e:
        db.rollback()
        log_activity(db, "User deletion failed", str(e))
        raise HTTPException(status_code=500, detail="Failed to delete account")