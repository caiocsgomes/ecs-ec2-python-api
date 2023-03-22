from flask import Flask

import pytest
from src.domain.model_address import Address
from src.repository.repository_sqlalchemy import SqlAlchemyRepository

from src.service.unit_of_work import DEFAULT_SESSION_FACTORY
from src.utils.config import TestConfig
from src.utils.factory import create_app

config = TestConfig()
test_app = create_app(config)


@pytest.fixture()
def app():
    return test_app


@pytest.fixture
def session():
    return DEFAULT_SESSION_FACTORY()


@pytest.fixture()
def address_repo(session):
    return SqlAlchemyRepository(session, Address)
