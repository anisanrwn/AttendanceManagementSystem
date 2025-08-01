"""remove attendance table

Revision ID: be6302412047
Revises: 8978809de49f
Create Date: 2025-06-11 19:03:16.668910

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa
from sqlalchemy.dialects import postgresql

# revision identifiers, used by Alembic.
revision: str = 'be6302412047'
down_revision: Union[str, None] = '8978809de49f'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    """Upgrade schema."""
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_index(op.f('ix_attendance_attendance_id'), table_name='attendance')
    op.drop_table('attendance')
    # ### end Alembic commands ###


def downgrade() -> None:
    """Downgrade schema."""
    # ### commands auto generated by Alembic - please adjust! ###
    op.create_table('attendance',
    sa.Column('attendance_id', sa.INTEGER(), autoincrement=True, nullable=False),
    sa.Column('employee_id', sa.INTEGER(), autoincrement=False, nullable=True),
    sa.Column('clock_in', postgresql.TIME(), autoincrement=False, nullable=True),
    sa.Column('clock_in_latitude', sa.DOUBLE_PRECISION(precision=53), autoincrement=False, nullable=True),
    sa.Column('clock_in_longitude', sa.DOUBLE_PRECISION(precision=53), autoincrement=False, nullable=True),
    sa.Column('clock_in_verified', sa.BOOLEAN(), autoincrement=False, nullable=True),
    sa.Column('clock_in_reason', sa.TEXT(), autoincrement=False, nullable=True),
    sa.Column('clock_in_distance', sa.DOUBLE_PRECISION(precision=53), autoincrement=False, nullable=True),
    sa.Column('clock_out', postgresql.TIME(), autoincrement=False, nullable=True),
    sa.Column('clock_out_latitude', sa.DOUBLE_PRECISION(precision=53), autoincrement=False, nullable=True),
    sa.Column('clock_out_longitude', sa.DOUBLE_PRECISION(precision=53), autoincrement=False, nullable=True),
    sa.Column('clock_out_verified', sa.BOOLEAN(), autoincrement=False, nullable=True),
    sa.Column('clock_out_reason', sa.TEXT(), autoincrement=False, nullable=True),
    sa.Column('clock_out_distance', sa.DOUBLE_PRECISION(precision=53), autoincrement=False, nullable=True),
    sa.Column('attendance_date', sa.DATE(), autoincrement=False, nullable=True),
    sa.Column('attendance_status', sa.VARCHAR(length=20), autoincrement=False, nullable=True),
    sa.Column('face_verified', sa.BOOLEAN(), autoincrement=False, nullable=True),
    sa.ForeignKeyConstraint(['employee_id'], ['employees.employee_id'], name=op.f('attendance_employee_id_fkey')),
    sa.PrimaryKeyConstraint('attendance_id', name=op.f('attendance_pkey'))
    )
    op.create_index(op.f('ix_attendance_attendance_id'), 'attendance', ['attendance_id'], unique=False)
    # ### end Alembic commands ###
