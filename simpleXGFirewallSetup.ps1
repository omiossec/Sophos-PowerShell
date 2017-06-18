
#this script setup a new XG Firewall
#this is the Hyper-v Server used to run the virtual Firewall
$ComputerName = "MyHyperVServer"
#the name of the virtual firewall VM
$vmname = "MyNewFirewal"
#the Ram of the firewall, from 1Gb to unlimited but be aware of the licence
$ram = 6GB
#the number of vCpu, from 1 to unlimited check your licence
$vmproc = 4 

#the path of the VM on the Hyper-V server
$path = "e:\xfSophosFirewall"

#Names of the virtual switch used in this example
#the admin vSwitch used for initial setup and later for admin
$vswitchadmin = "admin"
#The virtual Switch used for external access during the setup and later
$vswtichwan = "Wan"
#the virtual switch used for internal network
$vswitchlan = "lan"

#the Path of the 2 VHD
$fwPRIMARYVhd = "$path\PRIMARY-DISK.vhd"
$fwAUXILIARYVhd = "$path\AUXILIARY-DISK.vhd"

#create the VM
New-VM -Verbose -name $vmname -MemoryStartupBytes  $ram  -Generation 1  -Path $path  -ComputerName $ComputerName
#Setup vm processor
Set-VMProcessor  -Count $vmProc -VMName $vmname -ComputerName $ComputerName 

#remove all net interface 
Get-VMNetworkAdapter -VMName $vmname -ComputerName $ComputerName | Remove-VMNetworkAdapter

# add the 2 harddrive to the newly vm
Add-VMHardDiskDrive -path $fwPRIMARYVhd -vmname $vmname -ComputerName $ComputerName -ControllerType IDE -ControllerNumber 0
Add-VMHardDiskDrive -path $fwAUXILIARYVhd -vmname $vmname -ComputerName $ComputerName -ControllerType IDE -ControllerNumber 0

# Admin setup interface 
# I use a vlan, but you can also use a dedicaded network
Add-VMNetworkAdapter -ComputerName $ComputerName -VMName $vmname -SwitchName $vswitchadmin -Name setup 

#Add the wan interface, on the 
Add-VMNetworkAdapter -ComputerName $ComputerName -VMName $vmname -SwitchName $vswtichwan -Name wan
Set-VMNetworkAdaptervlan -vmname $vmname -VMNetworkAdapterName wan -access -vlanID 5 -computername $ComputerName
 

#add the lan interface. It's a trunk interface with a default vlan
Add-VMNetworkAdapter -ComputerName $ComputerName -VMName $vmname -SwitchName $vswitchlan -Name lan
Set-VMNetworkAdapter -ComputerName $ComputerName -VMName $vmname -Name lan  -MacAddressSpoofing On
Set-VMNetworkAdaptervlan -vmname $vmname -VMNetworkAdapterName lan -Trunk -AllowedVlanIdList "6,7" -NativeVlanId 10