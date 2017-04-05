# Variables that need to be set

# The subscriptionId
$subscriptionId = '<subscriptionId>'
# Root path to script, template and parameters.  All have to be in the same folder.
$rootPath = '<rootPath>' # Replace with $PSScriptRoot if you want to run it as a script; EXAMPLE: $rootPath = 'C:\Users\makolo\Documents\GitHub\azure-vmss-templates\vm-simple-rhel'
# Name of the resource group
$resourceGroupName = '<resourceGroupName>'
# Resource Group Location 
$resourceGroupLocation = '<resourceGroupLocation>' # Run <Get-AzureLocation> to find out azure locations; EXAMPLE: 'East US 2'
# Name of the deployment
$deploymentName = '<deploymentName>'
# Key Vault Nme
$keyVaultName = '<keyVaultName>'

Login-AzureRmAccount

Get-AzureRmSubscription

Select-AzureRmSubscription -SubscriptionId $subscriptionId

# Create the new Azure Resource Group
New-AzureRmResourceGroup -Name $resourceGroupName -Location $resourceGroupLocation

# Run the below to test the ARM template
Test-AzureRmResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateFile "$rootPath\azuredeploy.json" -TemplateParameterFile "$rootPath\azuredeploy.parameters.json"

# Use parameter file
New-AzureRmResourceGroupDeployment -Mode Incremental -Name $deploymentName -ResourceGroupName $resourceGroupName -TemplateFile "$rootPath\azuredeploy.json" -TemplateParameterFile "$rootPath\azuredeploy.parameters.json"

# Input parameters manually via CLI
New-AzureRmResourceGroupDeployment -Mode Incremental -Name $deploymentName -ResourceGroupName $resourceGroupName -TemplateFile "$rootPath\azuredeploy.json"



# Create storage
# NEED TO UPDATE THIS

param
(
    [Parameter(Mandatory=$true, HelpMessage="Provide a password to store in the KeyVault")]
    [securestring] $password
)

#create the keyvault. note that this command is not idempotent.
$vault = New-AzureRmKeyVault -VaultName $keyVaultName -ResourceGroupName $resourceGroupName -EnabledForTemplateDeployment -Location $resourceGroupLocation

#create/set the secret
$secret = Set-AzureKeyVaultSecret -VaultName $keyVaultName -Name LADStorageAccesstKey -SecretValue $password

#echo the vault id
Write-Host Vault Id: $vault.ResourceId

#echo the vault secret
Write-Host Secret Id: $secret.Name



# Delete the deployment
Remove-AzureRmResourceGroup $resourceGroupName