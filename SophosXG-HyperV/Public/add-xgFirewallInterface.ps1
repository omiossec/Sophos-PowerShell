function add-xgFirewallInterface
{


<# 
This function add a vm netadapter on the XG Firewall (Limited to 7 + 1 Admin)
Create the interface and name it
setup the Mac address (optionnal)
Connect to the vswitch 
Apply Trunk or Access vlan 
disable or enable VMQ
#>


    [CmdletBinding()]
	PARAM (
		[parameter(Mandatory = $true)]
		[string]$xgfirewallVm,
        [parameter(Mandatory = $false)]
		[string]$computername = "localhost",
        [parameter(Mandatory = $true)]
        [String] $interfaceName,
        [parameter(Mandatory = $true)]
        [String] $vswitch,
        [Parameter(mandatory=$false)]
        [ValidateSet("access","trunk","none")]
        [String] $mode="none",
        [parameter(Mandatory = $false)]
        [int] $vlan
    )


    # test if vm exist 

    $computerVersion = get-hypervVersion -computername $computername

    $XGVm = get-vm -Name $xgfirewallVm -ComputerName $computername -ErrorAction SilentlyContinue

    if ($XGVm -eq $null)
    {
        Write-Error -Message "The XG Firewall VM $xgfirewallVm do not exist on computer $computer." -ErrorAction Stop
    }

    if (($XGVm -ne "Off") -and ($computerVersion -ne "2016"))
    {
        Write-Error -Message "The XG Firewall VM $xgfirewallVm is running on host $computer. Can not add Interface on a non Win2016 Server" -ErrorAction Stop
    }


    # performe add interface 

    Add-VMNetworkAdapter -computername $computername -VMName $xgfirewallVm -name $interfaceName -SwitchName $vswitch

    if ($PSBoundParameters.ContainsKey('vlan'))
    {
        Set-VMNetworkAdapterVlan -ComputerName $computername -VMName $xgfirewallVm -VMNetworkAdapterName $interfaceName -Access -VlanId $vlan
    }


}