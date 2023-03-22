from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from sqlalchemy.orm.session import Session
from typing import Protocol
import os

from repository.repository_user import UserRepository
from utils.database import get_db_uri

DEFAULT_SESSION_FACTORY = sessionmaker(
    bind=create_engine(
        get_db_uri(os.getenv('DB_HOST'),
                   os.getenv('DB_NAME'), os.getenv('SM_DB_USER_SECRET_NAME'),
                   os.getenv('SM_DB_PASSWORD_SECRET_NAME')),
    )
)


class AbstractUnitOfWork(Protocol):
    session: Session
    users: UserRepository

    def __enter__(self):
        ...

    def __exit__(self, *args):
        ...

    def commit(self):
        ...

    def rollback(self):
        ...


class SqlAlchemyUnitOfWork:

    def __init__(self, session_factory=DEFAULT_SESSION_FACTORY):
        self.session_factory = session_factory

    def __enter__(self):
        self.session = self.session_factory()
        self.users = UserRepository(self.session)
        return self

    def __exit__(self, *args):
        self.session.close()

    def commit(self):
        try:
            self.session.commit()
        except Exception:
            self.rollback()
            raise

    def rollback(self):
        self.session.rollback()
