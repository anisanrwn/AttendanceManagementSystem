from fastapi import Request
from sqlalchemy.orm import Session
from typing import Optional
from user_agents import parse  
from app.models import model as m

def create_activity_log(
    db: Session,
    request: Optional[Request],  
    action: str,
    detail: Optional[str] = None,
    user_id: Optional[int] = None,
):
    try:
        ip_address = request.client.host if request and request.client else "unknown"
        user_agent_string = request.headers.get("user-agent", "unknown") if request else "unknown"

        user_agent = parse(user_agent_string)

        os_info = user_agent.os.family  
        os_version = user_agent.os.version_string  
        browser_info = user_agent.browser.family  
        browser_version = user_agent.browser.version_string  

        device_info = f"{os_info} {os_version} - {browser_info} {browser_version}"

        log = m.ActivityLog(
            action=action,
            detail=detail,
            ip_address=ip_address,
            device=device_info,
            user_id=user_id
        )

        db.add(log)
        db.commit()
        db.refresh(log)
        return log
    except Exception as e:
        db.rollback()
        print(f"Failed to create activity log: {e}")
