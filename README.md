# Work Process in Linux machine

## To Run: 
- Install Terraform, gcloud CLI, docker and kubectl
- run build.sh 


Setting up terraform 
https://medium.com/google-cloud/terraform-credentials-setup-in-gcp-c81c8ebaff5d
https://blog.gruntwork.io/a-comprehensive-guide-to-managing-secrets-in-your-terraform-code-1d586955ace1


https://cloud.google.com/iam/docs/creating-managing-service-account-keys#iam-service-account-keys-create-gcloud
service account key

- Problem: Cannot find a way to download the json key to my computer via gcloud


Uploading webserver dockerimage to gcr.io
https://ahmet.im/blog/google-container-registry-tips/


Create variables for docker images

https://haseebmajid.dev/blog/simple-app-flask-sqlalchemy-and-docker
create a flask web app && postgres dockerfile

https://runnable.com/docker/python/dockerize-your-flask-application
dockerize the flask web app

https://github.com/mesmacosta/cloudsql-sqlserver-tooling
https://medium.com/ci-t/automating-the-cloud-sql-triad-with-terraform-python-and-gcloud-2a17edfef3c4
integrate postgres dockerfile into terraform infrastructure


Deploy the webapp
https://blog.devgenius.io/how-to-provision-configure-deploy-to-google-cloud-platform-97dbbe36fcde

- Problem: Local-exec command in GKE_cluster/main.tf


## Tried, but didn't work out:

https://www.willianantunes.com/blog/2021/05/the-easiest-way-to-run-a-container-on-gce-with-terraform/
use the webserver image to create a webserver instance in google's compute engine


