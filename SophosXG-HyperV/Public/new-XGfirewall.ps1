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

.PARAMETER defaultvswitch
	Specify the default vSwitch for the Admin interface

.PARAMETER interfaces
	Specify interface name, mode and vswitch
	
.EXAMPLE
	new-XGFirewall -SamAccountName Fxcat

	
.NOTES
	Olivier Miossec Mediactive Network (http://www.mediactive.fr)
	https://github.com/omiossec/Sophos-PowerShell
	Twitter @omiossec_med
	Linkedin https://www.linkedin.com/in/omiossec/
#>

	[CmdletBinding(SupportsShouldProcess = $true)]
	PARAM (
		[parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ValueFromPipeline = $true)]
		[String]$vmname,

		[Parameter(mandatory=$false)]
        [String] $computername="Localhost",
		[ValidateSet("nat","transparant","Promiscuis")]
        [Parameter(mandatory=$false)]
        [String] $mode="nat",
		)

	BEGIN
	{
	}

	PROCESS 
	{


	}

	END 
	{
		
	}

}