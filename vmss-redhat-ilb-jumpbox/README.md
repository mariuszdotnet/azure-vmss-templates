# Simple deployment of a VM Scale Set of RedHat Linux VMs with a jumpbox

This template allows you to deploy a simple VM Scale Set of Linux VMs using the latest patched version of RedHat Linux 7.2. This template also deploys a jumpbox with a public IP address in the same virtual network. You can connect to the jumpbox via this public IP address, then connect from there to VMs in the scale set via private IP addresses. To ssh into the jumpbox, you could use the following command:

ssh {username}@{jumpbox-public-ip-address}

To ssh into one of the VMs in the scale set, go to resources.azure.com to find the private IP address of the VM, make sure you are ssh'ed into the jumpbox, then execute the following command:

ssh {username}@{vm-private-ip-address} 

or with the following to test the ILB

ssh -p {vmportnumber} {username}@{ilb-ip-address}

To check Linux Release and Distribution Version run this command in the bash cli on the VM

cat /etc/*-release

PARAMETER RESTRICTIONS
======================

vmssName must be 3-61 characters in length. It should also be globally unique across all of Azure. If it isn't globally unique, it is possible that this template will still deploy properly, but we don't recommend relying on this pseudo-probabilistic behavior.
instanceCount must be 100 or less.
