import flask_sqlalchemy
from datetime import datetime
from . import db


class Posts(db.Model):  # Posts table
    __tablename__ = 'posts'
    id = db.Column(db.Integer, primary_key=True) # auto increments by default
    created = db.Column(db.DateTime(timezone=True), server_default=datetime.utcnow)
    title = db.Column(db.String(100), nullable=False)
    content = db.Column(db.Text)

    def __repr__(self) -> str:
        return f"Post('{self.title}', '{self.created}')"

