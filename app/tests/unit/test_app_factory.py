from src.utils.config import TestConfig
from src.utils.factory import create_app


def test_create_app(app):
    assert app.config is not None
    assert len(app.blueprints) > 0
