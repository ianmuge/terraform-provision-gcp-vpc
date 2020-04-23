# Prerequites
Set the GCP project variables on the workspace environment
```
export GCP_PROJECT="" 
export GCP_AUTH_KIND="serviceaccount" 
export GCP_SERVICE_ACCOUNT_FILE="" 
export GCP_SCOPES="https://www.googleapis.com/auth/compute"
export GCP_ZONE='us-central1-a'
export GCP_REGION='us-central1'
```
# Setup
## Initialization
```
terraform init
```
## Plan Execution
```
terraform plan
```
## Apply
```
terraform apply -auto-approve
```
## Confirm
```
terraform output
```
# Teardown
```
terraform destroy -refresh=false
```