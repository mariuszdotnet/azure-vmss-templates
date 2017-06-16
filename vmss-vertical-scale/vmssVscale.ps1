Login-AzureRmAccount


Get-AzureRmSubscription

$subscriptionId = "5aec60e9-f535-4bd7-a951-2833f043e918"

Select-AzureRmSubscription -SubscriptionId $subscriptionId

$VmssName = 'gremlinsj'
$resourceGroupName = 'vmss-lad-rg'
$newVmssSize = "Standard_A3"
$vmss = Get-AzureRmVmss -ResourceGroupName $ResourceGroupName -VMScaleSetName $VmssName
$vmss.Sku.Name = $newVmssSize
Update-AzureRmVmss -ResourceGroupName $ResourceGroupName -Name $VmssName -VirtualMachineScaleSet $vmss 
#Update-AzureRmVmssInstance -ResourceGroupName $resourceGroupName -VMScaleSetName $VmssName -InstanceId "0","1","2" 
Update-AzureRmVmssInstance -ResourceGroupName $resourceGroupName -VMScaleSetName $VmssName -InstanceId "0"
