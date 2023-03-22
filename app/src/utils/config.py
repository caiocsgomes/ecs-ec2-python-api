import logging


class Config:
    DEBUG = False
    DEVELOPMENT = False
    LOCALHOST = False
    LOG_LEVEL = logging.INFO
    APP_NAME = 'simple-tracking'
    SQLALCHEMY_DATABASE_URI = None
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    TESTING = False


class ProdConfig(Config):
    pass


class DevConfig(Config):
    pass


class TestConfig(Config):
    DEBUG = True
    DEVELOPMENT = True
    LOCALHOST = True
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    LOG_LEVEL = logging.DEBUG
    TESTING = True


class LocalConfig(Config):
    DEBUG = True
    DEVELOPMENT = True
    LOCALHOST = True
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    LOG_LEVEL = logging.DEBUG
