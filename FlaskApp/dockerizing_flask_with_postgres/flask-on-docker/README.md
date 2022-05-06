run "docker-compose up -d --build" from flask-on-docker to build the container
go to http://localhost:5000 for sanity check
create database by running "docker-compose exec web python manage.py create_db"
run "docker-compose exec db psql --username=hello_flask --dbname=hello_flask_dev" 
run "\l" you are supposed to see your database
run \q to exit psql