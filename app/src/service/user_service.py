from typing import Protocol, TypeVar, Generic

from models.model_user import User
from service.unit_of_work import AbstractUnitOfWork


class UserService:
    uow: AbstractUnitOfWork

    def __init__(self, uow):
        self.uow = uow

    def create(self, user: User) -> int:
        with self.uow:
            self.uow.users.create(user)
            self.uow.commit()
            model_id = user.id
        return model_id

    def get(self, user_id: int) -> User:
        with self.uow:
            return self.uow.users.get_by_id(user_id)

    def delete(self, user_id: int):
        with self.uow:
            self.uow.users.delete(user_id)
            self.uow.commit()

    def update(self, user_id: int, user: User) -> User:
        with self.uow:
            self.uow.users.update(user_id, user)
            self.uow.commit()
        return self.get(user_id)
