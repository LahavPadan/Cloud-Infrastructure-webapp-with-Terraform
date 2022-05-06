from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from .schema import db
import os

database = os.environ['POSTGRES_DB']
user = os.environ['POSTGRES_USER']
password = os.environ['POSTGRES_PASSWORD']
host = os.environ['POSTGRES_IP']
port = os.environ['POSTGRES_PORT']

flask_app = Flask(__name__)
db = SQLAlchemy()

def create_app(debug=False):
    if debug: # create a local db when debugging
        flask_app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///site.db' 
    else: # connect to remote db when NOT debugging
        DATABASE_CONNECTION_URI = f'postgresql+psycopg2://{user}:{password}@{host}:{port}/{database}'
        flask_app.config['SQLALCHEMY_DATABASE_URI'] = DATABASE_CONNECTION_URI
        
    flask_app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    flask_app.app_context().push()
    db.init_app(flask_app)
    db.create_all()
    return flask_app