from sqlalchemy import Column, Integer, String, ForeignKey, Date, Float, Text, DateTime, Boolean, Index, Time
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func
from app.database import Base
from datetime import datetime

class Employee(Base):
    __tablename__ = 'employees'
    
    employee_id = Column(Integer, primary_key=True, index=True)
    first_name = Column(String(100))
    last_name = Column(String(100))
    nrp_id = Column(Integer, unique=True)
    email = Column(String(100), unique=True)
    phone_number = Column(String(13))
    position = Column(String(100))
    department = Column(String(100))
    join_date = Column(Date, nullable=False)
    face_encoding = Column(Text) 

    user = relationship("User", back_populates="employee", uselist=False, cascade="all, delete")
    attendances = relationship("Attendance", back_populates="employee")
    permissions = relationship("Permission", back_populates="employee")


class User(Base):
    __tablename__ = 'user'

    user_id = Column(Integer, primary_key=True, index=True)
    employee_id = Column(Integer, ForeignKey('employees.employee_id'), index=True)
    username = Column(String(100), unique=True)
    email = Column(String(100), unique=True)
    password = Column(String(500))
    activity_date= Column(DateTime(timezone=True), server_default=func.now())
    
    employee = relationship("Employee", back_populates="user")
    roles = relationship("Roles", secondary="user_roles", back_populates="users")
    activity_logs = relationship("ActivityLog", back_populates="user")
    notifications = relationship("Notification", back_populates="user", cascade="all, delete-orphan")
    permissions = relationship("Permission", back_populates="user")
    login_attempts = relationship("LoginAttempt", back_populates="user", cascade="all, delete-orphan", order_by="desc(LoginAttempt.attempt_time)")

class Notification(Base):
    __tablename__ = 'notifications'

    notification_id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey('user.user_id'), nullable=False, index=True)
    title = Column(String(255), nullable=False)
    message = Column(String(1000), nullable=False)
    notification_type = Column(String(50), default='info', index=True)
    is_read = Column(Boolean, default=False, index=True)
    created_at = Column(DateTime, default=datetime.utcnow, index=True)
    read_at = Column(DateTime, nullable=True)

    user = relationship("User", back_populates="notifications")

    __table_args__ = (
        Index('ix_notifications_user_read', 'user_id', 'is_read'),
    )


class LoginAttempt(Base):
    __tablename__ = 'login_attempts'

    logAtt_id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey('user.user_id'))
    email = Column(String(100), index=True, nullable=False)
    ip_address = Column(String(45), nullable=False)
    attempt_time = Column(DateTime, default=func.now(), nullable=False)
    is_successful = Column(Boolean, default=False)
    user_agent = Column(Text)
    failed_attempts = Column(Integer, default=0)
    lockout_until = Column(DateTime)

    user = relationship('User', back_populates='login_attempts')

class Roles(Base):
    __tablename__ = 'roles'

    roles_id = Column(Integer, primary_key=True, index=True)
    roles_name = Column(String(25), unique=True)

    users = relationship("User", secondary="user_roles", back_populates="roles")
    locks = relationship("RoleLock", back_populates="role", cascade="all, delete-orphan")


class UserRoles(Base):
    __tablename__ = 'user_roles'

    user_id = Column(Integer, ForeignKey('user.user_id'), primary_key=True)
    roles_id = Column(Integer, ForeignKey('roles.roles_id'), primary_key=True)

class Attendance(Base):
    __tablename__ = 'attendance'

    attendance_id = Column(Integer, primary_key=True, index=True)
    employee_id = Column(Integer, ForeignKey('employees.employee_id'))
    attendance_date = Column(Date)
    late = Column(Integer, default=0, nullable=False)
    attendance_status = Column(String(20))
    clock_in = Column(Time)  
    clock_in_latitude = Column(Float)
    clock_in_longitude = Column(Float)
    clock_in_verified = Column(Boolean, default=False)
    clock_in_reason = Column(Text, nullable=True)
    clock_in_distance = Column(Float, nullable=True)
    clock_out = Column(Time, nullable=True) 
    clock_out_latitude = Column(Float, nullable=True)
    clock_out_longitude = Column(Float, nullable=True)
    clock_out_verified = Column(Boolean, default=False)
    clock_out_reason = Column(Text, nullable=True)
    clock_out_distance = Column(Float, nullable=True)
    attendance_date = Column(Date)
    attendance_status = Column(String(20))
    face_verified = Column(Boolean, default=False)
    working_hour = Column(Integer, nullable=True)
    overtime = Column(Integer, nullable=True)
    employee = relationship("Employee", back_populates="attendances")

class Permission(Base):
    __tablename__ = 'permissions'

    permissions_id = Column(Integer, primary_key=True, index=True)
    employee_id = Column(Integer, ForeignKey('employees.employee_id'))
    user_id = Column(Integer, ForeignKey('user.user_id'), nullable=True)
    permission_type = Column(String(50))
    request_date = Column(Date)
    start_date = Column(Date)
    end_date = Column(Date)
    reason = Column(Text)
    permission_status = Column(String(10))
    approved_date = Column(Date)

    employee = relationship("Employee", back_populates="permissions")
    user = relationship("User", back_populates="permissions")

class ActivityLog(Base):
    __tablename__ = "activity_logs"

    log_id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey('user.user_id'), nullable=True)
    action = Column(String(500), nullable=False)
    detail = Column(Text, nullable=True)
    ip_address = Column(String(100), nullable=True)
    device = Column(String(500), nullable=True) 
    timestamp = Column(DateTime(timezone=True), server_default=func.now())

    user = relationship("User", back_populates="activity_logs")

class RoleLock(Base):
    __tablename__ = "lock_system"

    lock_id = Column(Integer, primary_key=True, index=True)
    role_id = Column(Integer, ForeignKey("roles.roles_id"))
    
    role = relationship("Roles", back_populates="locks")
    