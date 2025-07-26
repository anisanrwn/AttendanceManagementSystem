from pydantic import BaseModel, EmailStr
from typing import Optional, List
from datetime import date, time, datetime

class RoleLockStatus(BaseModel):
    roles_id: int
    roles_name: str
    status: bool  

class ManageRoleLock(BaseModel):
    role_id: int
    action: str
   
    
class PermissionBase(BaseModel):
    permission_type: str
    request_date: date | None = None
    start_date: date
    end_date: date
    reason: str | None = None

class PermissionCreate(PermissionBase):
    pass

class Permission(PermissionBase):
    permissions_id: int
    user_id: int | None
    employee_id: int
    permission_status: str
    approved_date: date | None

    class Config:
        from_attributes = True

class UserOut(BaseModel):
    user_id: int
    fname: str
    lname: str
    email: str

    class Config:
        from_attributes = True

class EmployeeBase(BaseModel):
    first_name: str
    last_name: str
    nrp_id: int
    email: EmailStr
    phone_number: str
    position: str
    department: str
    join_date: date
    
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

class AttendanceClockInSession(BaseModel):
    employee_id: int
    clock_in_latitude: float
    clock_in_longitude: float
    image_base64: str
    clock_in_reason: Optional[str] = None

class AttendanceClockOutSession(BaseModel):
    employee_id: int
    image_base64: str
    clock_out_latitude: float
    clock_out_longitude: float
    clock_out_reason: str | None = None

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

class AttendanceStatusResponse(BaseModel):
    attendance_id: Optional[int]
    attendance_date: date
    employee_id: int
    clock_in: Optional[str]
    clock_out: Optional[str]
    totalHours: Optional[int]
    attendance_status: str
    clock_in_latitude: Optional[float]
    clock_in_longitude: Optional[float]
    clock_in_verified: Optional[bool]
    face_verified: Optional[bool]
    
    class Config:
        from_attributes = True

class AttendanceVerifyIdentity(BaseModel):
    employee_id: int
    image_base64: str


class UserLogin(BaseModel):
    email: EmailStr
    password: str
class ActivityLogCreate(BaseModel):
    action: str
    detail: Optional[str] = None
    user_id: Optional[int] = None
    ip_address: Optional[str] = None
    device: Optional[str] = None 

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
        
class EmployeeResponse(BaseModel):
    employee_id: int
    first_name: Optional[str]
    last_name: Optional[str]
    nrp_id: Optional[int]
    email: Optional[str]
    phone_number: Optional[str]
    position: Optional[str]
    department: Optional[str]
    face_encoding: Optional[str]

    class Config:
        from_attributes = True
        
class PermissionResponse(BaseModel):
    permissions_id: int
    employee_id: int
    employee_name: str
    user_id: Optional[int]
    permission_type: str
    request_date: Optional[date]
    start_date: date
    end_date: date
    reason: str
    permission_status: str
    approved_date: Optional[date]
    user_email: Optional[str]

    class Config:
        from_attributes = True

class PermissionUpdate(BaseModel):
    permission_status: str
    approved_date: Optional[date] = None

class PermissionListResponse(BaseModel):
    permissions: list[PermissionResponse]
    
class ActivityLogResponse(BaseModel):
    timestamp: str
    user_name: str
    user_role_class: str  
    action: str
    ip_address: Optional[str]
    device: Optional[str]

    class Config:
        from_attributes = True
        
class UserResponse(BaseModel):
    status: str
    message: Optional[str] = None
    email: Optional[str] = None
    user_id: Optional[int] = None
    employee_id: Optional[int] = None
    username: Optional[str] = None
    roles: list[RoleRead] = None
    employee: Optional[dict] = None

    class Config:
        from_attributes = True

