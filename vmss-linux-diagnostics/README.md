# Deployment of a VM Scale Set of Ubuntu Linux VM with LAD Extension 3.X and Autoscaling

+ See latest updates to LAD 3.X [here](https://github.com/Azure/azure-linux-extensions/tree/azure-master/Diagnostic)
+ VMSS Based on [this](https://github.com/Azure/azure-quickstart-templates/tree/master/201-vmss-ubuntu-autoscale)
+ LAD Extension based on [this](https://github.com/Azure/azure-linux-extensions/blob/master/Diagnostic/virtual-machines-linux-diagnostic-extension-v3.md)
+ The template assumes an existing storage account for the LAD data
+ The template assumes an existing key vault for the SAS token to access the storage account
+ The template logs a custom log to a blob sink and the CPU perf counter to a blob sink