# start by pulling the python image
FROM python:3.8-alpine

# copy the requirements file into the image
COPY ./requirements.txt /app/requirements.txt
     
# switch working directory
WORKDIR /app   

# install the dependencies and packages in the requirements file
RUN \
apk add build-base &&\
apk add postgresql-dev &&\
# apt-get -y install libpq-dev gcc &&\
#  python3 -m pip install psycopg2 &&\
#  python3 -m pip install wheel &&\
#  apk add --no-cache postgresql-libs && \
#  apk add --no-cache --virtual .build-deps gcc musl-dev postgresql-dev && \
 python3 -m pip install -r requirements.txt --no-cache-dir 
# apk --purge del .build-deps

# telling Flask where to find the application
ENV FLASK_APP=app

# copy every content from the local file to the image
COPY . /app

# configure the container to run in an executed manner
ENTRYPOINT [ "python" ]

CMD ["app.py" ]