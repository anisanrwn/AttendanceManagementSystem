from sqlalchemy import Column, Integer, String, ForeignKey, Date, Time, Text, LargeBinary
from sqlalchemy.orm import relationship
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
    password = Column(String(100))

    employee = relationship("Employee", back_populates="user")
    roles = relationship("UserRoles", back_populates="user")


class Roles(Base):
    __tablename__ = 'roles'

    roles_id = Column(Integer, primary_key=True, index=True)
    roles_name = Column(String(25), unique=True)

    users = relationship("UserRoles", back_populates="role")


class UserRoles(Base):
    __tablename__ = 'user_roles'

    user_id = Column(Integer, ForeignKey('user.user_id'), primary_key=True)
    roles_id = Column(Integer, ForeignKey('roles.roles_id'), primary_key=True)

    user = relationship("User", back_populates="roles")
    role = relationship("Roles", back_populates="users")


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