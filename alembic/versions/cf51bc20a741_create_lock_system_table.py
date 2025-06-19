"""create lock_system table

Revision ID: cf51bc20a741
Revises: d7b29270b265
Create Date: 2025-06-18 02:40:45.345284

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = 'cf51bc20a741'
down_revision: Union[str, None] = 'd7b29270b265'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    """Upgrade schema."""
    pass


def downgrade() -> None:
    """Downgrade schema."""
    pass
