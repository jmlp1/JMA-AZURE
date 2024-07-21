# Azure DevOps pipeline + Terraform Deployment Tutorial

## Steps:
    - Configure Azure
      - Create a service principal account
      - Assign permissions to Azure keyvault and storage account, Entra AD RBAC permissions are not enough in Free Tier
      - Set Azure Subscription Permissions for the Service Principal
    - Configure Azure and ADO 
      - Create a Service Principal Account      
    - Create the VM Terraform Code     
    - Created a pipeline yaml

## Objective
    To extract the ADO Service Connection details for using them as variables in an ADO pipeline for creating a VM 
    in an Azure Subscription using Terraform as the provider.
        
             
