from flask import render_template, request, url_for, flash, redirect 
from init import create_app, db, Posts
from database import *

################################# Entry point in the dockerfile ########################################## 

app = create_app()
app.config['SECRET_KEY'] = 'your secret key'

@app.route('/')
def index():
    posts = get_allPosts(Posts)
    return render_template('index.html', posts=posts)

@app.route('/<int:post_id>')
def post(post_id):
    post = get_post(Posts, post_id)
    return render_template('post.html', post=post)

@app.route('/create', methods=('GET', 'POST'))
def create():
    if request.method == 'POST':
        title = request.form['title']
        content = request.form['content']

        if not title:
            flash('Title is required!')
        else:
            add_instance(Posts, title=title, content=content)
            return redirect(url_for('index'))

    return render_template('create.html')

if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0')
