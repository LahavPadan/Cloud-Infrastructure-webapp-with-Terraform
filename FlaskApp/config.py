import os

user = os.environ['TF_VAR_POSTGRES_USER']
password = os.environ['TF_VAR_POSTGRES_PASSWORD']
host = os.environ['TF_VAR_POSTGRES_HOST']
database = os.environ['TF_VAR_POSTGRES_DB']
port = os.environ['TF_VAR_POSTGRES_PORT']

DATABASE_CONNECTION_URI = f'postgresql+psycopg2://{user}:{password}@{host}:{port}/{database}'