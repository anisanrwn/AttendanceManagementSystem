"""Change face_encoding from bytes to JSON string

Revision ID: 9ecbde6723a4
Revises: 3901a16151d1
Create Date: 2025-05-19 15:20:37.625424

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa
from sqlalchemy.dialects import postgresql

# revision identifiers, used by Alembic.
revision: str = '9ecbde6723a4'
down_revision: Union[str, None] = '3901a16151d1'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    """Upgrade schema."""
    # ### commands auto generated by Alembic - please adjust! ###
    op.alter_column('employees', 'face_encoding',
               existing_type=postgresql.BYTEA(),
               type_=sa.Text(),
               existing_nullable=True)
    # ### end Alembic commands ###


def downgrade() -> None:
    """Downgrade schema."""
    # ### commands auto generated by Alembic - please adjust! ###
    op.alter_column('employees', 'face_encoding',
               existing_type=sa.Text(),
               type_=postgresql.BYTEA(),
               existing_nullable=True)
    # ### end Alembic commands ###
