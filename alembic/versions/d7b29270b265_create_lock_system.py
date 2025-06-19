"""create lock_system

Revision ID: d7b29270b265
Revises: bbe46a5a2e13
Create Date: 2025-06-18 02:30:34.087151

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = 'd7b29270b265'
down_revision: Union[str, None] = 'bbe46a5a2e13'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    """Upgrade schema."""
    pass


def downgrade() -> None:
    """Downgrade schema."""
    pass
