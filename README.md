# Introduction 
This is a project for demonstrating a private Bicep module registry using Azure Container Registry.

# Getting Started

## Pre-requisities

- An Azure subscription and a resource group
- Azure DevOps organization and project
- An Azure DevOps service connection able to deploy to the targeted resource group

## Prepare

1. Duplicate this repository into a repository of your own.
2. Change the pool definition of each yml file in .azuredevops folder to match the agent pool you are using.
3. Create pipelines based on the following yaml files:
    - ./azuredevops/acr.yml
    - ./azuredevops/push-to-acr.yml
4. Run the acr.yml pipeline to create an ACR instance in your resource group.
5. Assing your service connection principal ACR push and ACR pull roles to the ACR instance.

## Push bicep modules to ACR

## Use bicep modules from ACR