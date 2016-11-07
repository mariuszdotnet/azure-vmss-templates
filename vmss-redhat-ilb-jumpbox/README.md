# Simple deployment of a VM Scale Set of RedHat Linux VMs with Tomcat Webserver via VM Extensions

This template allows you to deploy a simple VM Scale Set of Linux VMs using the latest patched version of RedHat Linux 7.2. The template depends on an existing virtual network and subnet in a different resource group.

This template has the following:
+ ILB configured on static IP
+ Probe
+ Load balancing with Source IP Affinity Mode - 3-tuple (Source IP, Destination IP, Protocol)
+ Autoscale manual

To connect to the VMs in the VMSS create a jumpbox with a public IP in the recource group with the virutal network.

To ssh into one of the VMs in the scale set, go to resources.azure.com to find the private IP address of the VM, make sure you are ssh'ed into the jumpbox, then execute the following command:

ssh {username}@{vm-private-ip-address} 

or with the following to test the ILB NAT

ssh -p {vmportnumber} {username}@{ilb-ip-address}

To check Linux Release and Distribution Version run this command in the bash cli on the VM

cat /etc/*-release

PARAMETER RESTRICTIONS
======================

vmssName must be 3-61 characters in length. It should also be globally unique across all of Azure. If it isn't globally unique, it is possible that this template will still deploy properly, but we don't recommend relying on this pseudo-probabilistic behavior.
instanceCount must be 100 or less.
