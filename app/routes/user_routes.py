from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.database import get_db
from app.models import model as m
from app.schemas import schemas as s
from typing import List

router = APIRouter(
    prefix="/user",
    tags=["User"]
)

# Ambil employee yang belum punya user
@router.get("/available_employees", response_model=List[s.EmployeeRead])
async def get_available_employees(db: Session = Depends(get_db)):
    employees = db.query(m.Employee).all()
    return employees

@router.get("/available_roles", response_model=List[s.RoleRead])
async def get_available_roles(db: Session = Depends(get_db)):
    roles = db.query(m.Roles).all()
    return roles

@router.post("/create", response_model=s.UserRead)
async def create_user(
    user: s.UserCreate, db: Session = Depends(get_db)
):
    # Check if role exists
    role_name = user.roles[0]
    role = db.query(m.Roles).filter(m.Roles.roles_name == role_name).first()

    if not role:
        raise HTTPException(status_code=404, detail="Role not found")

    # Create new user
    new_user = m.User(
        username=user.username,
        email=user.email,
        password=user.password,  # Ideally, password should be hashed
        employee_id=user.employee_id,
    )
    db.add(new_user)
    db.commit()
    db.refresh(new_user)

    # Add role to UserRoles
    user_role = m.UserRoles(user_id=new_user.user_id, roles_id=role.roles_id)
    db.add(user_role)
    db.commit()

    # REFETCH new_user with relationships
    new_user = db.query(m.User).filter(m.User.user_id == new_user.user_id).first()

    return new_user
