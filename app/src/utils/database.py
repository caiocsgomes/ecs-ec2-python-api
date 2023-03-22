import os

from models.model_address import Address
from models.model_user import User
from sqlalchemy import MetaData, Column, Integer, String, Table, ForeignKey
from sqlalchemy.orm import registry, relationship
from utils.logger import get_logger
from service.aws_secrets_manager import SecretsManagerService


def start_mappers():
    metadata = MetaData()
    mapper_registry = registry(metadata=metadata)

    user_table = Table('user',
                       metadata,
                       Column('id', Integer, primary_key=True),
                       Column('name', String, nullable=False),
                       Column('email', String, nullable=False),
                       )
    mapper_registry.map_imperatively(User, user_table, properties={
        'address': relationship(Address, backref='user', cascade='all, delete-orphan', lazy='joined')
    })

    address_table = Table('address',
                          metadata,
                          Column('id', Integer, primary_key=True),
                          Column('user_id', Integer, ForeignKey('user.id'), nullable=False),
                          Column('street', String, nullable=False),
                          Column('number', Integer, nullable=False),
                          Column('city', String, nullable=False),
                          Column('state', String, nullable=False),
                          Column('country', String, nullable=False)
                          )

    mapper_registry.map_imperatively(Address, address_table)


def get_db_uri(host=None, db_name=None, sm_db_user_secret_name=None, sm_db_password_secret_name=None):
    env = os.getenv("ENV")
    port = 5432
    if env == "LOCALHOST":
        password = os.environ.get("DB_PASSWORD", "password")
        user = os.environ.get("DB_USER", "postgres")
        db_name = os.environ.get("DB_NAME", "postgres")
        return make_postgres_uri(host, port, db_name, user, password)
    else:
        sm_service = SecretsManagerService()
        password = sm_service.get_secret(sm_db_password_secret_name)
        user = sm_service.get_secret(sm_db_user_secret_name)
        return make_postgres_uri(host, port, db_name, user, password)


def make_postgres_uri(host, port, db_name, user, password):
    return f"postgresql://{user}:{password}@{host}:{port}/{db_name}"
