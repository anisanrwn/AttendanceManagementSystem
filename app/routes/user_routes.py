from fastapi import APIRouter, Depends, HTTPException, Form, Path
from sqlalchemy.orm import Session, joinedload
from app.database import get_db
from app.models import model as m
from app.schemas import schemas as s
from typing import List, Optional

router = APIRouter(
    prefix="/user",
    tags=["User"]
)

#view user table
@router.get("/view", response_model=list[s.UserRead])
def get_users(db: Session = Depends(get_db)):
    users = db.query(m.User).options(
        joinedload(m.User.employee),
        joinedload(m.User.roles)
    ).all()
    return users

#fetch employee list from database to add account
@router.get("/available_employees", response_model=List[s.EmployeeRead])
async def get_available_employees(db: Session = Depends(get_db)):
    employees = db.query(m.Employee).all()
    return employees

#fetch roles list from database to add account
@router.get("/available_roles", response_model=List[s.RoleRead])
async def get_available_roles(db: Session = Depends(get_db)):
    roles = db.query(m.Roles).all()
    return roles

#add account
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
        existing_user = db.query(m.User).filter((m.User.username == username) | (m.User.email == email)).first()
        if existing_user:
            raise HTTPException(status_code=400, detail="Username or Email already exists.")
        
        new_user = m.User(
            employee_id=employee_id,
            username=username,
            email=email,
            password=password
        )
        db.add(new_user)
        db.commit()
        db.refresh(new_user)

        role = db.query(m.Roles).filter_by(roles_name=role_name).first()
        if not role:
            raise HTTPException(status_code=400, detail="Role not found.")

        user_role = m.UserRoles(
            user_id=new_user.user_id,
            roles_id=role.roles_id
        )
        db.add(user_role)
        db.commit()

        # Refresh user with joined relationships
        new_user = db.query(m.User).options(
            joinedload(m.User.employee),
            joinedload(m.User.roles)
        ).filter(m.User.user_id == new_user.user_id).first()

        return new_user

    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=400, detail=f"Error processing request: {str(e)}")

#delete user data
@router.delete("/delete/{user_id}", response_model=s.UserRead)
async def delete_user(
    user_id: int = Path(..., title="The ID of the account to delete"),
    db: Session = Depends(get_db)
):
    user = db.query(m.User).filter(m.User.user_id == user_id).first()
    if user is None:
        raise HTTPException(status_code=404, detail="account not found")
    
    try:
        db.delete(user)
        db.commit()
        return user
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=400, detail=f"Error deleting Account: {str(e)}")

@router.put("/update/{user_id}", response_model=s.UserRead)
def update_user(
    user_id: int,
    username: str = Form(...),
    email: str = Form(...),
    password: Optional[str] = Form(None),
    role_name: Optional[str] = Form(None),
    db: Session = Depends(get_db)
):
    user = db.query(m.User).filter_by(user_id=user_id).first()
    if not user:
        raise HTTPException(status_code=404, detail="User not found")

    user.username = username
    user.email = email
    if password:
        user.password = password  # Hash if needed

    if role_name:
        role = db.query(m.Roles).filter_by(roles_name=role_name).first()
        if not role:
            raise HTTPException(status_code=400, detail="Role not found.")
        db.query(m.UserRoles).filter_by(user_id=user_id).delete()
        db.add(m.UserRoles(user_id=user_id, roles_id=role.roles_id))

    db.commit()
    return db.query(m.User).options(joinedload(m.User.employee), joinedload(m.User.roles)).get(user_id)
