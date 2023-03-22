from typing import Protocol
from service.unit_of_work import AbstractUnitOfWork
from models.model_user.user import User


class UserServiceProtocol(Protocol):
    def get_by_id(self, id: int) -> User:
        pass

    def create(self, obj: User) -> User:
        pass

    def update(self, id: int, obj: User) -> User:
        pass

    def delete(self, id: int):
        pass


class UserService:
    uow: AbstractUnitOfWork

    def __init__(self, uow):
        self.uow = uow

    def create(self, model: User) -> int:
        with self.uow:
            self.uow.repo.create(model)
            self.uow.commit()
            model_id = model.id
        return model_id

    def get(self, model_id: int) -> T:
        with self.uow:
            return self.uow.repo.get_by_id(model_id)

    def delete(self, model_id: int):
        with self.uow:
            self.uow.repo.delete(model_id)
            self.uow.commit()

    def update(self, model_id: int, model: T) -> T:
        with self.uow:
            self.uow.repo.update(model_id, model)
            self.uow.commit()
        return self.get(model_id)
