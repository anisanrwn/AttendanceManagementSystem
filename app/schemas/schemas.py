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
    attendance_date: date
    clock_in_latitude: float
    clock_in_longitude: float
    clock_in_reason: Optional[str] = None

class AttendanceCreate(BaseModel):
    employee_id: int
    clock_in_latitude: float
    clock_in_longitude: float
    attendance_date: date
    image_base64: str  # from camera capture
    clock_in_reason: Optional[str] = None

class AttendanceClockOut(BaseModel):
    employee_id: int
    clock_out_latitude: float
    clock_out_longitude: float
    image_base64: str
    clock_out_reason: Optional[str] = None


class AttendanceOut(BaseModel):
    attendance_id: int
    employee_id: int
    attendance_date: date
    clock_in: Optional[time]
    clock_in_latitude: Optional[float]
    clock_in_longitude: Optional[float]
    clock_in_verified: bool
    attendance_status: str
    face_verified: bool

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