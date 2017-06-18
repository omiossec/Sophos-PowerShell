function new-XGFirewall
{

<#
.SYNOPSIS
	This function will create a XG Firewall Vm on a Hyper-v Host
.DESCRIPTION
	This function will create a XG Firewall Vm on a Hyper-v Host

.PARAMETER  computername
	Specify the hyper-v server hostname

.PARAMETER  source
	Specify the xgfirewall zip file or the folder

.PARAMETER  destination
	Specify the xgfirewall VM Folder
	
.PARAMETER vmname
    Specify the name of the XG Firewall to Create

.PARAMETER vCpu
    Specify the number of vCpu determine the Ram
	
.PARAMETER mode
    Specify the firewall mode, Transparant, Nat, Promiscuis

.PARAMETER adminvswitch
	Specify the default vSwitch for the Admin interface

.PARAMETER adminvlan
	Specify the default vlan for the Admin interface

.PARAMETER netInterface
	Specify interface name, mode and vswitch, arrays  name, vswitch, vlan

.PARAMETER EnableVMQ

.PARAMETER AuthorisedIP
	Specify IP address that can connect to the admin interface

	
.EXAMPLE
	new-XGFirewall -computername localhost -source "c:\sophos\" -destination "f:\vm\firewall\" -vmname "firewall" -vcpu 2 -mode "nat" -defaultvswitch "wan"

	
.NOTES
	Olivier Miossec Mediactive Network (http://www.mediactive.fr)
	https://github.com/omiossec/Sophos-PowerShell
	Twitter @omiossec_med
	Linkedin https://www.linkedin.com/in/omiossec/
#>

	[CmdletBinding(SupportsShouldProcess = $true)]
	PARAM (
		[parameter(Mandatory = $true)]
		[String]$vmname,

		[Parameter(mandatory=$false)]
        [String] $computername="Localhost",
		[ValidateSet("nat","transparant","Promiscuis")]
        [Parameter(mandatory=$false)]
        [String] $mode="nat",
		[String] $source,
		[String] $destination,
		[int] $cpu,
		[string] $adminvswitch,
		[string] $adminvlan,
		[String[]] $NetInterfaces,
		[String[]] $PermitedAdminIP

		)

	BEGIN
	{
	}

	PROCESS 
	{

		# create the destination folder 

		# copy zip/folder to the destination 

		# create the VM 
		$xgfirewallRam = get-xgfirewallRam -cpu $cpu
		New-VM -Verbose -name $vmname -MemoryStartupBytes  $xgfirewallRam  -Generation 1  -Path $path  -ComputerName $computername

		# setup vCpu
		Set-VMProcessor  -Count $vmProc -VMName $vmname -ComputerName $node

		#remove all net interface 
		Get-VMNetworkAdapter -VMName $vmname -ComputerName $computername | Remove-VMNetworkAdapter 

		# attach disk to the VM

		 

		

		# create admin netadapter 

		new-vmnetadapter -name XGAdmin

		# create x netadapter and configure vlan and vmq

		# static mac Address

		# configure mac spoofing according to the mode



	}

	END 
	{
		
	}

}