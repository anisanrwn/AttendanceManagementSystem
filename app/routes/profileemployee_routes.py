from fastapi import APIRouter, HTTPException, Depends
from sqlalchemy.orm import Session
from app.database import get_db
from app.models import model as m
from app.schemas import schemas as s

router = APIRouter(prefix="/profileemployee", tags=["ProfileEmployee"])

@router.get("/{employee_id}", response_model=s.EmployeeRead)
def get__profile(employee_id: int, db: Session = Depends(get_db)):
    employee = db.query(m.Employee).filter(m.Employee.employee_id == employee_id).first()
    if not employee:
        raise HTTPException(status_code=404, detail="Employee not found")
    return employee