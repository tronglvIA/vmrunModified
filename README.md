# VMWARE_VMRUN MODIFIED WITH BATCH SCRIPT

# Setup

Replace Path_to vmrun.exe depend on where VMware Workstation was installed: 
set vmrun="'Path_to vmrun.exe'"

# Usage

'''
usage: vmwareauto.bat [/Option] [PARAMETERS]

options:
   /h				show this help message and exit
   /startvm		[path to vmx file]
				start a VM (default: none)
   /suspendvm		[all | {path to vmx file}]
				suspend all VMs are running or specify VM
   /snapshotvm		[all | {path to vmx file}]
				snapshot all VMs are running or specify VM
   /revertToSnapshotvm	[all | {path to vmx file}]
				revertToSnapshot with name all VMs are running or specify VM and start
   /deleteSnapshotvm	[all | {path to vmx file}]
				deleteSnapshot with name all on VMs are running or specify VM and start
'''

# Example

Starting a virtual machine with Workstation on a Windows host:
'''
$ vmwareauto.bat /startvm D:\vmware\win7.vmx
'''

Creating a snapshot of all virtual machine are running with Workstation on a Windows host:
'''
$ vmwareauto.bat /suspendvm all
'''
