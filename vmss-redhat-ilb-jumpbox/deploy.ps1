# Variables that need to be set

# The subscriptionId
$subscriptionId = '<SUBSCRIPTIONID>'
# Root path to script, template and parameters.  All have to be in the same folder.
$rootPath = '<ROOTPATHTOSCRIPT>' # Replace with $PSScriptRoot if you want to run it as a script; EXAMPLE: $rootPath = 'C:\Users\makolo\Documents\GitHub\azure-vmss-templates\vm-simple-rhel'
# Name of the resource group
$resourceGroupName = '<RESOURCEGROUPNAME>'
# Resource Group Location 
$resourceGroupLocation = '<REGION>' # Run <Get-AzureLocation> to find out azure locations; EXAMPLE: 'East US 2'
# Name of the deployment
$deploymentName = '<DEPLOYMENTNAME>'

Login-AzureRmAccount

Get-AzureSubscription

Select-AzureSubscription -SubscriptionId $subscriptionId

# Create the new Azure Resource Group
New-AzureRmResourceGroup -Name $resourceGroupName -Location $resourceGroupLocation

# Run the below to test the ARM template
Test-AzureRmResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateFile "$rootPath\azuredeploy.json" -TemplateParameterFile "$rootPath\azuredeploy.parameters.json"

# Use parameter file
New-AzureRmResourceGroupDeployment -Mode Incremental -Name $deploymentName -ResourceGroupName $resourceGroupName -TemplateFile "$rootPath\azuredeploy.json" -TemplateParameterFile "$rootPath\azuredeploy.parameters.json"

# Input parameters manually via CLI
New-AzureRmResourceGroupDeployment -Mode Incremental -Name $deploymentName -ResourceGroupName $resourceGroupName -TemplateFile "$rootPath\azuredeploy.json"

# Delete the deployment
Remove-AzureRmResourceGroup $resourceGroupName