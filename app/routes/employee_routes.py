from fastapi import APIRouter, UploadFile, File, Form, Depends, HTTPException, Path
from sqlalchemy.orm import Session
from app.database import get_db
from app.models import model as m
from app.schemas import schemas as s
from app.utils.logger import log_activity
from app.utils.face_encoding import read_image, encode_face
import numpy as np
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

        encoding_bytes = np.array(encoding).tobytes()

        employee = m.Employee(
            first_name=first_name,
            last_name=last_name,
            nrp_id=nrp_id,
            email=email,
            phone_number=phone_number,
            position=position,
            department=department,
            face_encoding=encoding_bytes,
        )

        db.add(employee)
        db.commit()
        db.refresh(employee)
        log_activity(db, "Added employee", f"Employee {first_name} {last_name} added successfully")           
        return employee
    
    except Exception as e:
        db.rollback()
        log_activity(db, "Add employee failed", str(e))
        raise HTTPException(status_code=400, detail=f"Error processing request: {str(e)}")

#edit atau update employee data
@router.post("/edit/{employee_id}", response_model=s.EmployeeUpdate)
async def edit_employee(
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
        log_activity(db, "Updated employee", f"Employee {employee_id} updated successfully")
        return employee
    
    except Exception as e:
        db.rollback()
        log_activity(db, "Update employee failed", str(e))
        raise HTTPException(status_code=400, detail=f"Error updating employee: {str(e)}")

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
        log_activity(db, "Deleted employee", f"Employee {employee_id} deleted successfully")
        return employee
    except Exception as e:
        db.rollback()
        log_activity(db, "Delete employee failed", str(e))
        raise HTTPException(status_code=400, detail=f"Error deleting employee: {str(e)}")

#view profile
@router.get("/profile/{employee_id}", response_model=s.EmployeeRead)
def get_employee_profile(employee_id: int, db: Session = Depends(get_db)):
    employee = db.query(m.Employee).filter(m.Employee.employee_id == employee_id).first()
    if not employee:
        raise HTTPException(status_code=404, detail="Employee not found")
        
    log_activity(db, "Viewed employee profile", f"Viewed profile of employee ID {employee_id}")
    return {
        "employee_id": employee.employee_id,
        "first_name": employee.first_name,
        "last_name": employee.last_name,
        "nrp_id": employee.nrp_id,
        "email": employee.email,
        "phone_number": employee.phone_number,
        "position": employee.position,
        "department": employee.department,
    }