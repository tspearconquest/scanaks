#!/usr/bin/env sh
#################
#This script will gather logs from an AKS cluster. The goal is to collect those logs for troubleshooting purposes.
#This script is work in progress. It is developed in best effort.
#
#Author: Walter Lopez <walter.lopez[at]microsoft.com>
#
#TO DO
# Validate that the required utilities are installed and suggested where to find them if not.
# Validate that the user is logged in to Azure.
# Validate that the user has chosen the right subscription.
# Validate that the user is merged to an AKS cluster.
# Add a myriad of exceptions.
# Other tasks not documented here yet.

#Variables
##########
# Prompt the user to enter the RESOURCE_GROUP
read -p "Enter the RESOURCE_GROUP: " RESOURCE_GROUP

# Prompt the user to enter the CLUSTER_NAME
read -p "Enter the CLUSTER_NAME: " CLUSTER_NAME

#General information
####################

#Determine the version of the Azure CLI
az version > azure-cli-version.txt

#Determine the version of the installed "kubectl" utility.
kubectl version --short > kubectl-version.txt

#Gather basic information about the AKS cluster.
kubectl cluster-info > k_cluster-info.txt

#Export details about the AKS cluster.
az aks show -g $RESOURCE_GROUP -n $CLUSTER_NAME > az-aks-show_`date +%F_%H-%M-%S_%z`.json

#Check out the existing worker nodes of the AKS cluster.
kubectl get nodes -o wide > k_nodes_`date +%F_%H-%M-%S_%z`.txt

#Check out the existing pods of the AKS cluster.
kubectl get pods -A -o wide > k_pods_`date +%F_%H-%M-%S_%z`.txt

#Create a dump of the events in the cluster.
kubectl get events > k_get-events_`date +%F_%H-%M-%S_%z`.txt
