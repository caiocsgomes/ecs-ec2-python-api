from flask import Flask, jsonify

from routes.v1.routes_user import routes_user
from utils.config import Config
from utils.database import start_mappers


def create_app(config: Config) -> Flask:
    app = Flask(config.APP_NAME)
    app.config.from_object(config)

    app.register_blueprint(routes_user, url_prefix='/api')
    app.app_context()

    start_mappers()

    @app.route('/healthcheck')
    def health():
        resp = jsonify(health="healthy")
        resp.status_code = 200
        return resp

    return app
