from sqlalchemy import Column, Integer, String, ForeignKey, Date, Time, Text, LargeBinary, DateTime, Boolean
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func
from app.database import Base

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
    face_encoding = Column(LargeBinary)

    user = relationship("User", back_populates="employee", uselist=False)
    attendances = relationship("Attendance", back_populates="employee")
    permissions = relationship("Permission", back_populates="employee")


class User(Base):
    __tablename__ = 'user'

    user_id = Column(Integer, primary_key=True, index=True)
    employee_id = Column(Integer, ForeignKey('employees.employee_id'), index=True)
    username = Column(String(100), unique=True)
    email = Column(String(100), unique=True)
    password = Column(String(500))

    employee = relationship("Employee", back_populates="user")
    roles = relationship("Roles", secondary="user_roles", back_populates="users")
    activity_logs = relationship("ActivityLog", back_populates="user")

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
    clock_in = Column(Time)
    clock_out = Column(Time)
    attendance_date = Column(Date)
    attendance_status = Column(String(10))
    employee = relationship("Employee", back_populates="attendances")


class Permission(Base):
    __tablename__ = 'permissions'

    permissions_id = Column(Integer, primary_key=True, index=True)
    employee_id = Column(Integer, ForeignKey('employees.employee_id'))
    permission_type = Column(String(50))
    request_date = Column(Date)
    start_date = Column(Date)
    end_date = Column(Date)
    reason = Column(Text)
    permission_status = Column(String(10))
    approved_date = Column(Date)

    employee = relationship("Employee", back_populates="permissions")

class ActivityLog(Base):
    __tablename__ = "activity_logs"

    log_id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey('user.user_id'), nullable=True)
    action = Column(String(500), nullable=False)
    detail = Column(Text, nullable=True)
    ip_address = Column(String(45), nullable=True)
    timestamp = Column(DateTime(timezone=True), server_default=func.now())

    user = relationship("User", back_populates="activity_logs")

class RoleLock(Base):
    __tablename__ = "lock_system"

    lock_id = Column(Integer, primary_key=True, index=True)
    role_id = Column(Integer, ForeignKey("roles.roles_id"))
    start_date = Column(DateTime, nullable=False)
    end_date = Column(DateTime, nullable=False)
    reason = Column(Text, nullable=True)

    role = relationship("Roles", back_populates="locks")

