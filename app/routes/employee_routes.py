from fastapi import APIRouter, UploadFile, File, Form, Depends, HTTPException, Request, Path
from sqlalchemy.orm import Session
from app.database import get_db
from app.models import model as m
from app.schemas import schemas as s
from app.services.activity_log import create_activity_log
from app.utils.auth_log import get_current_user  
from app.utils.face_recog import read_image, encode_face
import json
from typing import Optional, List

router = APIRouter(prefix="/employee", tags=["Employee"])

#view all employee data
@router.get("/view", response_model=List[s.EmployeeRead])
async def get_all_employees(db: Session = Depends(get_db)):
    employees = db.query(m.Employee).all()
    return employees

#add employee data
@router.post("/add", response_model=s.EmployeeRead)
async def add_employee(
    request: Request,
    current_user: m.User = Depends(get_current_user),
    first_name: str = Form(...),
    last_name: str = Form(...),
    nrp_id: int = Form(...),
    email: str = Form(...),
    phone_number: str = Form(...),
    position: str = Form(...),
    department: str = Form(...),
    file: UploadFile = File(...),
    db: Session = Depends(get_db)
):
    try:
        existing_employee = db.query(m.Employee).filter(m.Employee.nrp_id == nrp_id).first()
        if existing_employee:
            raise HTTPException(status_code=400, detail="Employee with this NRP ID already exists")

        image_bytes = await file.read()
        img = read_image(image_bytes)
        encoding = encode_face(img)

        if not encoding:
            raise HTTPException(status_code=400, detail="No face detected in the uploaded image.")

        encoding_json = json.dumps(encoding)

        employee = m.Employee(
            first_name=first_name,
            last_name=last_name,
            nrp_id=nrp_id,
            email=email,
            phone_number=phone_number,
            position=position,
            department=department,
            face_encoding=encoding_json,
        )

        db.add(employee)
        db.commit()
        db.refresh(employee)

        create_activity_log(
            db=db,
            request=request,
            user_id=current_user.user_id,
            action="Added employee",
            detail=f"Employee {first_name} {last_name} added by {current_user.username}"
        )

        return employee

    except Exception as e:
        db.rollback()
        create_activity_log(
            db=db,
            request=request,
            user_id=current_user.user_id,
            action="Add employee failed",
            detail=str(e)
        )
        raise HTTPException(status_code=400, detail=f"Error processing request: {str(e)}")


#edit atau update employee data
@router.post("/edit/{employee_id}", response_model=s.EmployeeUpdate)
async def edit_employee(
    request: Request,
    current_user: m.User = Depends(get_current_user),
    employee_id: int = Path(..., title="The ID of the employee to update"),
    first_name: Optional[str] = Form(None),
    last_name: Optional[str] = Form(None),
    email: Optional[str] = Form(None),
    phone_number: Optional[str] = Form(None),
    position: Optional[str] = Form(None),
    department: Optional[str] = Form(None),
    db: Session = Depends(get_db)
):
    employee = db.query(m.Employee).filter(m.Employee.employee_id == employee_id).first()

    if employee is None:
        raise HTTPException(status_code=404, detail="Employee not found")

    try:
        if first_name is not None:
            employee.first_name = first_name
        if last_name is not None:
            employee.last_name = last_name
        if email is not None:
            employee.email = email
        if phone_number is not None:
            employee.phone_number = phone_number
        if position is not None:
            employee.position = position
        if department is not None:
            employee.department = department

        db.commit()
        db.refresh(employee)

        create_activity_log(
            db=db,
            request=request,
            user_id=current_user.user_id,
            action="Updated employee",
            detail=f"Employee {first_name} updated by {current_user.username}"
        )

        return employee

    except Exception as e:
        db.rollback()
        create_activity_log(
            db=db,
            request=request,
            user_id=current_user.user_id,
            action="Update employee failed",
            detail=str(e)
        )
        raise HTTPException(status_code=400, detail=f"Error processing request: {str(e)}")



#delete employee data
@router.delete("/delete/{employee_id}", response_model=s.EmployeeRead)
async def delete_employee(
    employee_id: int = Path(..., title="The ID of the employee to delete"),
    db: Session = Depends(get_db)
):
    employee = db.query(m.Employee).filter(m.Employee.employee_id == employee_id).first()
    if employee is None:
        raise HTTPException(status_code=404, detail="Employee not found")
    
    try:
        db.delete(employee)
        db.commit()
        create_activity_log(db, "Deleted employee", f"Employee {employee_id} deleted successfully")
        return employee
    except Exception as e:
        db.rollback()
        create_activity_log(db, "Delete employee failed", str(e))
        raise HTTPException(status_code=400, detail=f"Error deleting employee: {str(e)}")

#view profile
@router.get("/profile/{employee_id}", response_model=s.EmployeeRead)
def get_employee_profile(
    employee_id: int,
    db: Session = Depends(get_db),
    current_user: m.User = Depends(get_current_user),
    request: Request = None
):
    employee = db.query(m.Employee).filter(m.Employee.employee_id == employee_id).first()
    if not employee:
        raise HTTPException(status_code=404, detail="Employee not found")

    create_activity_log(
        db=db,
        request=request,
        user_id=current_user.user_id,
        action="Viewed employee profile",
        detail=f"{current_user.username} viewed profile of employee ID {employee_id}"
    )

    return employee


@router.get("/departmentfilter")
async def get_departments(db: Session = Depends(get_db)):
    try:
        departments = db.query(m.Employee.department).distinct().all()
        return [dept[0] for dept in departments if dept[0]]
    except Exception as e:
        raise HTTPException(status_code=500, detail="Failed to fetch departments")

@router.get("/positionfilter")
async def get_positions(db: Session = Depends(get_db)):
    try:
        positions = db.query(m.Employee.position).distinct().all()
        return [pos[0] for pos in positions if pos[0]]
    except Exception as e:
        raise HTTPException(status_code=500, detail="Failed to fetch positions")
    
@router.get("/check_email/{email}")
def check_email(email: str, exclude_id: Optional[int] = None, db: Session = Depends(get_db)):
    query = db.query(m.Employee).filter(m.Employee.email == email)
    if exclude_id:
        query = query.filter(m.Employee.employee_id != exclude_id)
    
    employee = query.first()
    if employee:
        return {"available": False}
    return {"available": True}

