from fastapi import APIRouter, Depends, HTTPException, Form, Path
from sqlalchemy.orm import Session, joinedload
from app.database import get_db
from app.models import model as m
from app.schemas import schemas as s
from app.utils.encrypt import encrypt_data
from app.utils.logger import log_activity
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
        log_activity("Fetched users", "Successfully fetched users list")
        return users
    except Exception as e:
        log_activity("Fetch users failed", str(e))
        raise HTTPException(status_code=500, detail="Failed to fetch users")

@router.get("/available_employees", response_model=List[s.EmployeeRead])
async def get_available_employees(db: Session = Depends(get_db)):
    try:
        employees = db.query(m.Employee).all()
        log_activity("Fetched employees", "Successfully fetched employees list")
        return employees
    except Exception as e:
        log_activity("Fetch employees failed", str(e))
        raise HTTPException(status_code=500, detail="Failed to fetch employees")

@router.get("/available_roles", response_model=List[s.RoleRead])
async def get_available_roles(db: Session = Depends(get_db)):
    try:
        roles = db.query(m.Roles).all()
        log_activity("Fetched roles", "Successfully fetched roles list")
        return roles
    except Exception as e:
        log_activity("Fetch roles failed", str(e))
        raise HTTPException(status_code=500, detail="Failed to fetch roles")

@router.post("/create", response_model=s.UserRead)
async def create_user(
    employee_id: int = Form(...),
    username: str = Form(...),
    email: str = Form(...),
    password: str = Form(...),
    role_name: str = Form(...),
    db: Session = Depends(get_db)
):
    try:
        existing_user = db.query(m.User).filter(
            (m.User.username == username) | 
            (m.User.email == email)
        ).first()
        if existing_user:
            raise HTTPException(status_code=400, detail="Username or Email already exists")

        encrypted_password = encrypt_data(password)

        new_user = m.User(
            employee_id=employee_id,
            username=username,
            email=email,
            password=encrypted_password
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

        log_activity("Created user", f"User {username} created successfully")
        return db.query(m.User).options(
            joinedload(m.User.employee),
            joinedload(m.User.roles)
        ).filter(m.User.user_id == new_user.user_id).first()
    except HTTPException:
        db.rollback()
        raise
    except Exception as e:
        db.rollback()
        log_activity("User creation failed", str(e))
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
            user.password = encrypt_data(password)

        if role_name:
            role = db.query(m.Roles).filter_by(roles_name=role_name).first()
            if not role:
                raise HTTPException(status_code=400, detail="Role not found")
            db.query(m.UserRoles).filter_by(user_id=user_id).delete()
            db.add(m.UserRoles(user_id=user_id, roles_id=role.roles_id))

        db.commit()
        log_activity("Updated user", f"User {username} updated successfully")
        return db.query(m.User).options(
            joinedload(m.User.employee),
            joinedload(m.User.roles)
        ).filter(m.User.user_id == user_id).first()
    except HTTPException:
        db.rollback()
        raise
    except Exception as e:
        db.rollback()
        log_activity("User update failed", str(e))
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
        log_activity("Deleted user", f"User {user_id} deleted successfully")
        return user
    except Exception as e:
        db.rollback()
        log_activity("User deletion failed", str(e))
        raise HTTPException(status_code=500, detail="Failed to delete account")