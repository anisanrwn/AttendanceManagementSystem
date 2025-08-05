from apscheduler.schedulers.background import BackgroundScheduler
from sqlalchemy.orm import Session
from app.database import SessionLocal
from app.utils.time import get_ntp_time
from app.models import model as m
from app.utils.attendance import mark_absent_for_missing_days

def mark_absent():
    db: Session = SessionLocal()
    try:
        employees = db.query(m.Employee).all()
        for emp in employees:
            mark_absent_for_missing_days(db, emp.employee_id)
        print(f"Scheduler run completed at {get_ntp_time()}")
    except Exception as e:
        print(f"Error in scheduler: {e}")
    finally:
        db.close()

def start_scheduler():
    scheduler = BackgroundScheduler(timezone="Asia/Jakarta")
    scheduler.add_job(mark_absent, 'cron', hour=20, minute=56)
    scheduler.start()