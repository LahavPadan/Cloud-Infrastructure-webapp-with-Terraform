from .schema import db
from werkzeug.exceptions import abort

def get_allPosts(model):
    posts = model.query.all()
    return [post.__dict__ for post in posts]

def get_post(model, id):
    post = model.query.get(id)
    if post is None:
        abort(404)
    return post.__dict__

def add_instance(model, **kwargs):
    instance = model(**kwargs)
    db.session.add(instance)
    commit_changes()


def delete_instance(model, id):
    model.query.filter_by(id=id).delete()
    commit_changes()


def edit_instance(model, id, **kwargs):
    instance = model.query.filter_by(id=id).all()[0]
    for attr, new_value in kwargs.items():
        setattr(instance, attr, new_value)
    commit_changes()


def commit_changes():
    db.session.commit()