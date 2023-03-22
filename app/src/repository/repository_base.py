from typing import TypeVar, Protocol
from abc import ABC
from sqlalchemy.orm import Session

T = TypeVar('T')


class BaseRepository(Protocol):
    def get_by_id(self, session: Session, obj_id: int) -> T:
        ...

    def create(self, session: Session, obj: T) -> T:
        ...

    def update(self, obj_id: int, obj: T) -> T:
        ...

    def delete(self, session: Session, obj_id: int):
        ...
