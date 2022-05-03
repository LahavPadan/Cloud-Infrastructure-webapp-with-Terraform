root-folder-of-your-project/ <--- Main project
│
├── gce-with-container/  <--- Our custom module
|   |
│   ├── main.tf
│   └── variables.tf
|
├── modules
│   ├── webserver
|   |   ├── main.tf
│   |   └── variables.tf
|   |
|   ├── instanceGroup
|       ├── main.tf
│       └── variables.tf
|                                     
├── main.tf <--- We'll use gce-with-container here
├── terraform.tfvars <--- Values for what we defined in variables.tf
├── variables.tf <--- terraform.tfvars has the values for each defined variables
├── dev.tfvars
├── prod.tfvars
└── versions.tf  <-- Here you will find the terraform block which specifies the required provider version and required Terraform version for this configuration