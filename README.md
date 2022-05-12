![](showcase.mp4)

### Run in Linux enviroment

## To Run: 
1. Install Terraform, gcloud CLI, Docker and Kubectl, (in Windows, minGW is also needed for envsubst)
2. run build.sh [either dev/prod]

## Project Setup

root-folder-of-your-project/ <--- Main project
│
├── build.sh <--- Automated script to run everything
|
|
├── Infrastructure/  <--- Kubernetes and Terraform related stuff
|   |
|   | <-----------  Kubernetes
|   |
|   |
|   ├── deployments/ <--- persistent-volume, postgreSQL server and instance, webApp 
|   |   └── ......
|   |  
|   |  
|   | <-----------  Terraform
│   ├── main.tf
│   ├── variables.tf
│   ├── providers.tf
│   ├── dev.tfvars
│   ├── prod.tfvars
│   │
│   └── modules/  <--- Terraform modules
|       └── GKE_cluster/
│           ├── main.tf
│           └── variables.tf
│
│           
├── FlaskApp/  <--- The flask webapp
    └── ......

## Useful links

### Setting up terraform 
[_terraform-credentials-setup-in-gcp_](https://medium.com/google-cloud/terraform-credentials-setup-in-gcp-c81c8ebaff5d)
[_guide-to-managing-secrets-in-your-terraform-code_](https://blog.gruntwork.io/a-comprehensive-guide-to-managing-secrets-in-your-terraform-code-1d586955ace1)

### Service account key:
- [_managing service account keys_](https://cloud.google.com/iam/docs/creating-managing-service-account-keys#iam-service-account-keys-create-gcloud)


### Uploading webserver dockerimage to gcr.io
- [_gcr tips_](https://ahmet.im/blog/google-container-registry-tips/)

### Create a flask web app && postgres dockerfile
- [_simple-app-flask-sqlalchemy-and-docker_](https://haseebmajid.dev/blog/simple-app-flask-sqlalchemy-and-docker)
- [_blog creation walkthrough_](https://www.digitalocean.com/community/tutorials/how-to-make-a-web-application-using-flask-in-python-3)

### Dockerize the flask web app
- [_dockerize flask-application_](https://runnable.com/docker/python/dockerize-your-flask-application)

### Reserve IPs
- [_gcp docs_](https://cloud.google.com/kubernetes-engine/docs/tutorials/configuring-domain-name-static-ip#gcloud)

### setting up GKE
- [_gcp docs_](https://cloud.google.com/architecture/deploying-highly-available-postgresql-with-gke)

- [_troubleshooting_](https://www.how-hard-can-it.be/when-gke-tells-your-terraform-service-account-to-go-away/)

### Deploy the webapp on GKE
- [_deploy-to-google-cloud-platform_](https://blog.devgenius.io/how-to-provision-configure-deploy-to-google-cloud-platform-97dbbe36fcde)


