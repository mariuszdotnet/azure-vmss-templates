# Variables that need to be set

# The subscriptionId
$subscriptionId = '<SUBSCRIPTION ID>'

# Log in to Azure
Login-AzureRmAccount

# Select the right azure subscription
Select-AzureSubscription -SubscriptionId $subscriptionId

# RG name of the VM
$RGName = 'linux-vm-rg'

# VM name - This has been tested with Azure Gallery RHEL 7.2
$VmName = 'linuxvm'

# Location of the resources
$Location = 'east us'

# Extension Name
$ExtensionName = 'LinuxDiagnostic'

# Publisher Name
$Publisher = 'Microsoft.Azure.Diagnostics'

# LAD version
$Version = '3.0'

# See https://docs.microsoft.com/en-us/azure/virtual-machines/linux/diagnostic-extension for how to configure the Public and Private config settings and use LAD 3.X
# LAD config below is from here - https://github.com/mariuszdotnet/azure-vmss-templates/blob/master/vmss-linux-diagnostics/azuredeploy.json

$PublicConf = '{
                  "ladCfg": {
                      "diagnosticMonitorConfiguration": {
                          "metrics": {
                            "resourceId": "/subscriptions/<SUBSCRIPTIONID>/resourceGroups/linux-vm-rg/providers/Microsoft.Compute/virtualMachines/linuxvm"
                          }
                      }
                  },
                    "fileLogs": [
                      {
                        "file": "/var/log/waagent.log",
                        "sinks": "FilelogJsonBlob"
                      },
                      {
                        "file": "/var/log/messages",
                        "sinks": "MessagesJsonBlob"
                      }
                    ]                   
                  }'

$PrivateConf = '{
                    "storageAccountName": "<STORAGE ACCOUNT NAME>",
                    "storageAccountSasToken": "<SAS TOKEN>",
                    "sinksConfig": {
                      "sink": [
                        {
                            "name": "FilelogJsonBlob",
                            "type": "JsonBlob"
                        },
                        {
                            "name": "MessagesJsonBlob",
                            "type": "JsonBlob"
                        }    
                      ]
                    }
                  }'


# Install and configure the enxtension
Set-AzureRmVMExtension -ResourceGroupName $RGName -VMName $VmName -Location $Location `
  -Name $ExtensionName -Publisher $Publisher `
  -ExtensionType $ExtensionName -TypeHandlerVersion $Version `
  -Settingstring $PublicConf -ProtectedSettingString $PrivateConf