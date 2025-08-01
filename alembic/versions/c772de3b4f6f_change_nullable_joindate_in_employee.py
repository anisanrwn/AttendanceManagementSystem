"""change nullable joindate in employee

Revision ID: c772de3b4f6f
Revises: 5a5eed8cf460
Create Date: 2025-07-27 13:04:50.661951

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = 'c772de3b4f6f'
down_revision: Union[str, None] = '5a5eed8cf460'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    """Upgrade schema."""
    # ### commands auto generated by Alembic - please adjust! ###
    op.alter_column('employees', 'join_date',
               existing_type=sa.DATE(),
               nullable=False)
    # ### end Alembic commands ###


def downgrade() -> None:
    """Downgrade schema."""
    # ### commands auto generated by Alembic - please adjust! ###
    op.alter_column('employees', 'join_date',
               existing_type=sa.DATE(),
               nullable=True)
    # ### end Alembic commands ###