#!/bin/sh
gcloud components install beta

PROJECT_ID=hw2-cloud-infrastructure
BILLING_ACCOUND_ID=$( gcloud beta billing accounts list --limit=1 | grep  -o -E '([A-Z0-9]{6})-([A-Z0-9]{6})-([A-Z0-9]{6})' )

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
gcloud iam service-accounts keys create ~/.config/gcloud/${PROJECT_ID}.json --iam-account terraform@${PROJECT_ID}.iam.gserviceaccount.com
export GOOGLE_APPLICATION_CREDENTIALS= "~/${PROJECT_ID}.sa-private-key.json"
gcloud auth application-default print-access-token
gcloud auth application-default login

gcloud projects add-iam-policy-binding $PROJECT_ID --member="serviceAccount:terraform@${PROJECT_ID}.iam.gserviceaccount.com" --role="roles/cloudsql.admin"

echo -e "\033[1;42m [STEP 4] Create Webserver DockerImage and Upload to gcr.io \033[0m"


gcloud auth configure-docker gcr.io
export TF_VAR_WS_DOCKERIMAGE="gcr.io/${PROJECT_ID}/webapp:tag"
docker build -t $TF_VAR_WS_DOCKERIMAGE ./FlaskApp/
docker push $TF_VAR_WS_DOCKERIMAGE

export $(grep -v '^#' Infrastructure/database.env | xargs)

echo -e "\033[1;42m [STEP 5] Deploy Terraform Configuration \033[0m"

# Initialize the configuration
terraform -chdir=Infrastructure/ init --upgrade

# Plan and deploy
terraform -chdir=Infrastructure/ apply -var-file dev.tfvars

# Pass deployment to GKE cluster
kubectl apply -f Infrastructure/deployment.yaml

