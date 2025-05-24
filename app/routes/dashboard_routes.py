from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy import func
from collections import defaultdict
from sqlalchemy.orm import Session
from app.database import get_db
from app.models import model as m
from datetime import datetime, timedelta, timezone, date, time

router = APIRouter(prefix="/dashboard", tags=["dashboard"])

@router.get("/today_rate")
async def get_today_attendance(db: Session = Depends(get_db)):
    today = date.today()
    try:
        total_employees = db.query(m.Employee).count()
        present_today = db.query(func.count(m.Attendance.attendance_id)).filter(
            m.Attendance.attendance_date == today,
            m.Attendance.clock_in != None 
        ).scalar()
        
        attendance_percentage = 0
        if total_employees > 0:
            attendance_percentage = round((present_today / total_employees) * 100, 2)
        
        return {"percentage": attendance_percentage, "present": present_today, "total": total_employees}
    except Exception as e:
        raise HTTPException(status_code=500, detail="Failed to calculate attendance")
    
@router.get("/count")
async def get_total_employees(db: Session = Depends(get_db)):
    try:
        total = (
            db.query(m.User).join(m.User.roles).filter(m.Roles.roles_id == 3).count()
        )
        return {"total": total}
    except Exception as e:
        raise HTTPException(status_code=500, detail="Failed to fetch total employees")
    
@router.get("/pending_list")
async def get_pending_permissions(db: Session = Depends(get_db)):
    try:
        pending_count = db.query(m.Permission).filter(m.Permission.permission_status == "Pending").count()
        return {"pending": pending_count}
    except Exception as e:
        raise HTTPException(status_code=500, detail="Failed to fetch pending permissions")
    
@router.get("/department-summary")
def department_attendance_summary(db: Session = Depends(get_db)):
    results = (
        db.query(m.Employee.department, func.count(m.Attendance.attendance_id).label("present"))
        .join(m.Attendance, m.Employee.employee_id == m.Attendance.employee_id)
        .filter(m.Attendance.attendance_status == "Punch Out")
        .group_by(m.Employee.department)
        .all()
    )

    return [{"department": r[0], "present": r[1]} for r in results]

@router.get("/attendance-trend")
def attendance_trend_monthly(db: Session = Depends(get_db)):
    results = db.query(
        func.date_trunc('month', m.Attendance.attendance_date).label('month'),
        m.Attendance.attendance_status,
        func.count(m.Attendance.attendance_id)
    ).group_by(
        'month',
        m.Attendance.attendance_status
    ).order_by(
        'month'
    ).all()

    return [{"month": r[0].date().isoformat()[:7], "status": r[1], "count": r[2]} for r in results]

@router.get("/weekly-working-hours/{employee_id}")
def get_weekly_working_hours(employee_id: int, db: Session = Depends(get_db)):
    today = datetime.today()
    start_of_week = today - timedelta(days=today.weekday())

    records = db.query(m.Attendance).filter(
        m.Attendance.employee_id == employee_id,  
        m.Attendance.attendance_date >= start_of_week.date()
    ).all()

    working_hours = defaultdict(float)
    days_present = set()

    for r in records:
        weekday = r.attendance_date.strftime('%A')
        days_present.add(weekday)

        if r.clock_in and r.clock_out:
            clock_in_dt = datetime.combine(r.attendance_date, r.clock_in)
            clock_out_dt = datetime.combine(r.attendance_date, r.clock_out)

            if clock_out_dt < clock_in_dt:
                clock_out_dt += timedelta(days=1)

            duration = (clock_out_dt - clock_in_dt).total_seconds() / 3600
            working_hours[weekday] += duration

    ordered_days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
    filtered_days = [day for day in ordered_days if day in days_present]
    result = [round(working_hours.get(day, 0), 2) for day in filtered_days]

    return {
        "labels": filtered_days,
        "series": result
    }

@router.get("/monthly-attendance/{employee_id}")
def get_monthly_attendance(employee_id: int, db: Session = Depends(get_db)):
    from collections import defaultdict

    # Ambil semua data attendance per employee
    records = db.query(
        m.Attendance.attendance_date,
        m.Attendance.attendance_status,
        func.count().label('count')
    ).filter(
        m.Attendance.employee_id == employee_id
    ).group_by(
        m.Attendance.attendance_date,
        m.Attendance.attendance_status
    ).all()

    month_names = {
        1: 'Jan', 2: 'Feb', 3: 'Mar', 4: 'Apr',
        5: 'May', 6: 'Jun', 7: 'Jul', 8: 'Aug',
        9: 'Sep', 10: 'Oct', 11: 'Nov', 12: 'Dec'
    }

    # Prepare result dictionary, 12 bulan per status
    result = defaultdict(lambda: [0]*12)

    for row in records:
        # row.attendance_date harusnya datetime.date
        month = row.attendance_date.month  # dapatkan bulan
        month_index = month - 1
        result[row.attendance_status][month_index] += row.count

    return {
        "labels": list(month_names.values()),
        "series": [
            {"name": status, "data": counts}
            for status, counts in result.items()
        ]
    }
