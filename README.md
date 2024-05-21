# Introduction 
This is a project for demonstrating a private Bicep module registry using Azure Container Registry.

It contains  
- a pipeline to create an Azure Container Registry instance
- a pipeline to push bicep modules into the ACR instance
- a pipeline to deploy Azure resources using the bicep modules in the ACR
- some bicep modules for demonstrative purposes 

# Pre-requisities

- An Azure subscription and at least one resource group
- An Azure DevOps organization and a project
- An Azure DevOps service connection able to deploy to the targeted resource group

# Prepare

1. Duplicate this repository into a repository of your own.
2. Change the parameter default values and hardcoded values to match your environment in artifacts contained by .azureDevOps folder
    - Subscription id's
    - Service connection names
    - Agent pool definitions
    - Resource group names
    - Resource names
3. Create pipelines based on the following yaml files:
    - .azuredevops/acr.yml
    - .azuredevops/push-to-acr.yml
    - .azuredevops/deploy-myapp.yml
4. Run the acr.yml pipeline to create an ACR instance in your resource group.
5. Assing your service connection principal ACR push and ACR pull roles to the ACR instance.

# Push bicep modules into the ACR

Run the push-to-acr pipeline to push bicep files from modules folder into ACR. Review the ACR in Azure portal (Services/Repositories) to see if the push actually worked.

# Use bicep modules from the ACR

Run the deploy-myapp pipeline to deploy Azure resources (an application service plan, a storage account and a function app).