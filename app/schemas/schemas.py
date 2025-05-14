from pydantic import BaseModel, EmailStr
from typing import Optional, List
from datetime import date, time, datetime

class EmployeeBase(BaseModel):
    first_name: str
    last_name: str
    nrp_id: int
    email: EmailStr
    phone_number: str
    position: str
    department: str
    
class UserLoginResponse(BaseModel):
    access_token: str
    refresh_token: str
    token_type: str
    user_id: int
    email: str
    roles: List[str]
class EmployeeCreate(EmployeeBase):
    pass

class EmployeeUpdate(BaseModel):
    first_name: Optional[str] = None
    last_name: Optional[str] = None
    email: Optional[EmailStr] = None
    phone_number: Optional[str] = None
    position: Optional[str] = None
    department: Optional[str] = None

class EmployeeRead(EmployeeBase):
    employee_id: int

    class Config:
        from_attributes = True

class RoleBase(BaseModel):
    roles_id: int
    roles_name: str

class RoleRead(RoleBase):
    pass

    class Config:
        from_attributes = True

class UserBase(BaseModel):
    username: str
    email: EmailStr

class UserCreate(UserBase):
    password: str
    roles: list[RoleRead]
    employee_id: Optional[int] = None

class UserRead(UserBase):
    user_id: int
    employee: Optional[EmployeeRead] 
    roles: list[RoleRead]

    class Config:
        from_attributes = True

class UserRolesBase(BaseModel):
    user_id: int
    roles_id: int

class UserRolesCreate(UserRolesBase):
    pass

class UserRolesRead(UserRolesBase):
    class Config:
        from_attributes = True
 
class AttendanceBase(BaseModel):
    employee_id: int
    clock_in: time
    clock_out: time
    attendance_date: date
    attendance_status: str

class AttendanceCreate(AttendanceBase):
    pass

class AttendanceRead(AttendanceBase):
    attendance_id: int

    class Config:
        from_attributes = True


class PermissionBase(BaseModel):
    employee_id: int
    permission_type: str
    request_date: date
    start_date: date
    end_date: date
    reason: str
    permission_status: str
    approved_date: Optional[date] = None

class PermissionCreate(PermissionBase):
    pass

class PermissionRead(PermissionBase):
    permissions_id: int

    class Config:
        from_attributes = True

   
class UserLogin(BaseModel):
    email: EmailStr
    password: str

class ActivityLogCreate(BaseModel):
    action: str
    detail: Optional[str] = None
    user_id: Optional[int] = None
    ip_address: Optional[str] = None

    class Config:
        from_attributes = True

class RoleLockBase(BaseModel):
    role_id: int
    start_date: datetime
    end_date: datetime
    reason: Optional[str]

class RoleLockStatus(BaseModel):
    roles_id: int
    roles_name: str
    status: bool 

    class Config:
        from_attributes = True

class NotificationOut(BaseModel):
    notification_id: int
    title: str
    message: str
    created_at: datetime
    is_read: bool
    notification_type: str

    class Config:
        from_attributes = True