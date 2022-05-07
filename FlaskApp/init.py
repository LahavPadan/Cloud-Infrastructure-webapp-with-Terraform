from flask import Flask
from flask_sqlalchemy import SQLAlchemy
import os
from datetime import datetime



database = os.environ['POSTGRES_DB']
user = os.environ['POSTGRES_USER']
password = os.environ['POSTGRES_PASSWORD']
host = os.environ['POSTGRES_IP']
port = os.environ['POSTGRES_PORT']

flask_app = Flask(__name__)
db = SQLAlchemy()

class Posts(db.Model):  # Posts table
    __tablename__ = 'posts'
    id = db.Column(db.Integer, primary_key=True) # auto increments by default
    created = db.Column(db.DateTime(timezone=True), default=datetime.utcnow)
    title = db.Column(db.String(100), nullable=False)
    content = db.Column(db.Text)

    def __repr__(self) -> str:
        return f"Post('{self.title}', '{self.created}')"

def create_app(debug=False):
    if debug: # create a local db when debugging
        flask_app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///site.db' 
    else: # connect to remote db when NOT debugging
        DATABASE_CONNECTION_URI = f'postgresql://{user}:{password}@{host}:{port}/{database}'
        flask_app.config['SQLALCHEMY_DATABASE_URI'] = DATABASE_CONNECTION_URI
        
    flask_app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    flask_app.app_context().push()
    db.init_app(flask_app)
    db.create_all()
    return flask_app