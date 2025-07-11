"""update role lock

Revision ID: 9978874b0892
Revises: 435610fa3430
Create Date: 2025-06-17 21:23:15.093251

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa
from sqlalchemy.dialects import postgresql

# revision identifiers, used by Alembic.
revision: str = '9978874b0892'
down_revision: Union[str, None] = '435610fa3430'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    """Upgrade schema."""
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_column('lock_system', 'start_date')
    op.drop_column('lock_system', 'end_date')
    # ### end Alembic commands ###


def downgrade() -> None:
    """Downgrade schema."""
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('lock_system', sa.Column('end_date', postgresql.TIMESTAMP(), autoincrement=False, nullable=False))
    op.add_column('lock_system', sa.Column('start_date', postgresql.TIMESTAMP(), autoincrement=False, nullable=False))
    # ### end Alembic commands ###
