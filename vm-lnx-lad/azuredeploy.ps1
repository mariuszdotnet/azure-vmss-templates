<# 
Script: Install LAD 3.x via PS on Linux VM
Author: Mariusz Kolodziej - Microsoft 
Date: June 23, 2017
Version: 1.0
References:
    See below inline code documentation

THIS CODE AND INFORMATION IS PROVIDED "AS IS" WITHOUT WARRANTY OF
ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO
THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
PARTICULAR PURPOSE.

IN NO EVENT SHALL MICROSOFT AND/OR ITS RESPECTIVE SUPPLIERS BE
LIABLE FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR ANY
DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS,
WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS
ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE
OF THIS CODE OR INFORMATION.
#>

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