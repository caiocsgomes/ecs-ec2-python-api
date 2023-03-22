from flask import Blueprint, request

from service.unit_of_work import SqlAlchemyUnitOfWork
from service.user_service import UserService
from utils.exceptions import UserNotFoundException
from utils.logger import get_logger
from utils.responses import respond_with, ENTITY_NOT_FOUND_404
from models.model_user import UserSchema

routes_user = Blueprint('routes_user', __name__)
logger = get_logger(__name__)
schema = UserSchema()
service = UserService(SqlAlchemyUnitOfWork())


@routes_user.route('/v1/user', methods=['POST'])
def create_user():
    user = schema.load(request.json)
    try:
        user.id = service.create(user)
        return {'id': user.id}, 201
    except Exception as e:
        logger.error(e)
        return {'message': 'Error creating user'}, 500


@routes_user.route('/v1/user/<int:user_id>', methods=['GET'])
def get_user(user_id):
    try:
        user = service.get(user_id)
        return schema.dump(user), 200
    except UserNotFoundException:
        return respond_with(ENTITY_NOT_FOUND_404)
    except Exception as e:
        logger.error(e)
        return {'message': 'Error getting user'}, 500


@routes_user.route('/v1/user/<int:user_id>', methods=['PUT'])
def update_user(user_id):
    user = schema.load(request.json)
    try:
        user = service.update(user_id, user)
        return schema.dump(user), 200
    except Exception as e:
        logger.error(e)
        return {'message': 'Error updating user'}, 500


@routes_user.route('/v1/user/<int:user_id>', methods=['DELETE'])
def delete_user(user_id):
    try:
        service.delete(user_id)
        return {'message': 'User deleted'}, 200
    except Exception as e:
        logger.error(e)
        return {'message': 'Error deleting user'}, 500
