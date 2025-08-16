# Set vars
SUB_ID=66e29895-29f9-40af-9194-dba712a21a03
RG=LB-RG1
LOC=souteastasia
AKS_NAME=aks
ACR_NAME=acrgitops$RANDOM

#az account set --subscription $SUB_ID
#az group create -n $RG -l $LOC

# ACR
az acr create -n $ACR_NAME -g $RG --sku Standard
echo "ACR_NAME=$ACR_NAME"

# AKS (with Monitor add-on)
#az aks create -g $RG -n $AKS_NAME --node-count 2 --enable-addons monitoring --generate-ssh-keys
#az aks get-credentials -g $RG -n $AKS_NAME

# Attach ACR pull to AKS
az aks update -g $RG -n $AKS_NAME --attach-acr $ACR_NAME

# (Optional but recommended) Enable Defender for Containers & K8s
az security pricing create -n KubernetesService --tier Standard
az security pricing create -n ContainerRegistry --tier Standard

# Install Argo CD (internal admin login)
#kubectl create namespace argocd
#kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Forward UI locally (keep this running in a separate shell if you want to use the UI)
# kubectl port-forward svc/argocd-server -n argocd 8080:443
# Password:
# kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo

