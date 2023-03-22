
from sqlalchemy.orm import Session

from models.model_user import User
from utils.exceptions import UserNotFoundException


class UserRepository:
    session: Session

    def __init__(self, session: Session):
        self.session = session

    def get_by_id(self, user_id: int) -> User:
        user = self.session.query(User).filter_by(id=user_id).first()
        if user is None:
            raise UserNotFoundException(f"User id {user_id} not found")
        self.session.expunge(user)
        return user

    def create(self, user: User):
        self.session.add(user)
        return user

    def update(self, user_id: int, new_obj: User) -> User:
        user = self.get_by_id(user_id)
        new_address_keys = [x for x in vars(new_obj) if not x.startswith('_')]
        for key in new_address_keys:
            if new_obj[key] != user[key]:
                setattr(user, key, new_obj[key])
        return user

    def delete(self, user_id: int) -> User:
        user = self.get_by_id(user_id)
        if user is None:
            raise NotFoundException("User not found")
        self.session.delete(user)
        return user
