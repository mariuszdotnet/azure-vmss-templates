# Deployment of a VM Scale Set of Ubuntu Linux VM with LAD Extension and Autoscaling

+ VMSS Based on [this](https://github.com/Azure/azure-quickstart-templates/tree/master/201-vmss-ubuntu-autoscale)
+ LAD Extension based on [this](https://github.com/Azure/azure-linux-extensions/tree/master/Diagnostic)
+ The template assumes an existing storage account for the LAD data
+ For deploying LAD with individual VMs use [this](https://docs.microsoft.com/en-ca/azure/virtual-machines/virtual-machines-linux-classic-diagnostic-extension) tutorial and the config files in this repo with this Azure CLI command:
"azure vm extension set linux-lad-rg linux-lad-vm LinuxDiagnostic Microsoft.OSTCExtensions 2.3 -c C:\Users\makolo\azure\PublicConfig.json  -e C:\Users\makolo\azure\PrivateConfig.json"
