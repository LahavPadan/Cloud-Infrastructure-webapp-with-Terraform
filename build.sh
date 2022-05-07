#!/bin/sh

# if [[ ! ( -n "$1" && ( "$1" == "dev" || "$1" == "prod") )]]; then
#     echo "Invalid Argument. Please supply 'dev'/'prod' as your script argument"
#     exit
# fi
# export TF_VAR_CONFIG = "$1" 

export TF_VAR_CONFIG="dev" 


gcloud components install beta

PROJECT_ID=cloud-infrastructure-hw2-v2
BILLING_ACCOUND_ID=$( gcloud beta billing accounts list --limit=1 | grep -o -E '([A-Z0-9]{6})-([A-Z0-9]{6})-([A-Z0-9]{6})' )
TERRAFORM_MEMBER=serviceAccount:terraform@${PROJECT_ID}.iam.gserviceaccount.com

echo -e "\033[1;42m [STEP 1] Create Project and Enable Billing\033[0m"

export TF_VAR_PROJECT_ID=$PROJECT_ID
gcloud projects create $PROJECT_ID --name=$PROJECT_ID --labels=type=hw 2>/dev/null
gcloud config set project $PROJECT_ID
gcloud beta billing projects link $PROJECT_ID --billing-account $BILLING_ACCOUND_ID

echo -e "\033[1;42m [STEP 2] Enable required APIs \033[0m"

gcloud services enable datacatalog.googleapis.com
gcloud services enable cloudresourcemanager.googleapis.com
gcloud services enable cloudbilling.googleapis.com
gcloud services enable iam.googleapis.com
gcloud services enable storage.googleapis.com

gcloud services enable compute.googleapis.com
gcloud services enable container.googleapis.com 
gcloud services enable containerregistry.googleapis.com
gcloud services enable serviceusage.googleapis.com
gcloud services enable sqladmin.googleapis.com

echo -e "\033[1;42m [STEP 3] Create a Terraform Service Account \033[0m"

gcloud iam service-accounts create terraform  --display-name "Terraform account" 2>/dev/null
gcloud projects add-iam-policy-binding $PROJECT_ID --member=$TERRAFORM_MEMBER --role="roles/iam.serviceAccountUser"
gcloud projects add-iam-policy-binding $PROJECT_ID --member=$TERRAFORM_MEMBER --role="roles/compute.networkAdmin"
gcloud projects add-iam-policy-binding $PROJECT_ID --member=$TERRAFORM_MEMBER --role="roles/cloudsql.admin"
gcloud projects add-iam-policy-binding $PROJECT_ID --member=$TERRAFORM_MEMBER --role="roles/viewer"
gcloud projects add-iam-policy-binding $PROJECT_ID --member=$TERRAFORM_MEMBER --role="roles/container.admin"
gcloud projects add-iam-policy-binding $PROJECT_ID --member=$TERRAFORM_MEMBER --role="roles/compute.networkUser"
gcloud projects add-iam-policy-binding $PROJECT_ID --member=$TERRAFORM_MEMBER --role="roles/container.clusterAdmin"


gcloud iam service-accounts keys create ~/.config/gcloud/$PROJECT_ID.json --iam-account terraform@${PROJECT_ID}.iam.gserviceaccount.com
export GOOGLE_APPLICATION_CREDENTIALS=~/.config/gcloud/$PROJECT_ID.json
gcloud auth application-default print-access-token


echo -e "\033[1;42m [STEP 4] Deploy Terraform Configuration \033[0m"

# gcp region to deploy on
export TF_VAR_REGION="us-central1"

# Plan and deploy
terraform -chdir=Infrastructure/ init --upgrade
terraform -chdir=Infrastructure/ apply -var-file "${TF_VAR_CONFIG}.tfvars"



gcloud compute addresses create db-ip --region $TF_VAR_REGION


export POSTGRES_DB='posts'
export POSTGRES_USER='postgres'
export POSTGRES_PASSWORD='secret password'
export POSTGRES_IP=$( gcloud compute addresses describe db-ip --region ${TF_VAR_REGION} | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' )
export POSTGRES_PORT=5432 # default postgres port


echo -e "\033[1;42m [STEP 5] Create Webserver DockerImage and Upload to gcr.io \033[0m"

gcloud auth configure-docker gcr.io
export WS_DOCKERIMAGE="gcr.io/${PROJECT_ID}/webapp:tag"
docker build -t $WS_DOCKERIMAGE FlaskApp/
docker push $WS_DOCKERIMAGE


echo -e "\033[1;42m [STEP 6] Configure Components \033[0m"

# Pass deployment to GKE cluster
gcloud container clusters get-credentials node-demo-k8s --region $TF_VAR_REGION

envsubst < Infrastructure/modules/app_cluster/app_deploy.yaml | kubectl apply -f -

gcloud container clusters get-credentials postgres-demo-k8s --region $TF_VAR_REGION
kubectl apply -f Infrastructure/modules/postgres_cluster/pv_deploy.yaml
envsubst < Infrastructure/modules/postgres_cluster/postgres_deploy.yaml | kubectl apply -f -
envsubst < Infrastructure/modules/postgres_cluster/postgres_service_deploy.yaml | kubectl apply -f -


