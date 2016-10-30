# Variables that need to be set

# The subscriptionId
$subscriptionId = '5aec60e9-f535-4bd7-a951-2833f043e918'
# Root path to script, template and parameters.  All have to be in the same folder.
$rootPath = 'C:\Users\makolo\Documents\GitHub\azure-vmss-templates\vmss-redhat-ilb-jumpbox' # Replace with $PSScriptRoot if you want to run it as a script; EXAMPLE: $rootPath = 'C:\Users\makolo\Documents\GitHub\azure-vmss-templates\vm-simple-rhel'
# Name of the resource group
$resourceGroupName = 'vmss-rg'
# Resource Group Location 
$resourceGroupLocation = 'East US 2' # Run <Get-AzureLocation> to find out azure locations; EXAMPLE: 'East US 2'
# Name of the deployment
$deploymentName = 'applybite'

Login-AzureRmAccount

Get-AzureSubscription

Select-AzureSubscription -SubscriptionId $subscriptionId

# Create the new Azure Resource Group
New-AzureRmResourceGroup -Name $resourceGroupName -Location $resourceGroupLocation

# Run the below to test the ARM template
Test-AzureRmResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateFile "$rootPath\azuredeploy.json" -TemplateParameterFile "$rootPath\azuredeploy.parameters.json"

# Use parameter file
# New-AzureRmResourceGroupDeployment -Name $deploymentName -ResourceGroupName $resourceGroupName -TemplateFile "$rootPath\azuredeploy.json" -TemplateParameterFile "$rootPath\azuredeploy.parameters.json"

# Input parameters manually via CLI
New-AzureRmResourceGroupDeployment -Name $deploymentName -ResourceGroupName $resourceGroupName -TemplateFile "$rootPath\azuredeploy.json"

# Delete the deployment
# Remove-AzureRmResourceGroup $resourceGroupName
