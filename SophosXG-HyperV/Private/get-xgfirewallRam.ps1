function get-xgfirewallRam
{

    [CmdletBinding()]
	PARAM (
		[parameter(Mandatory = $true)]
		[int]$cpu
    )

    $hashCPURam = @{1=2GB;2=4GB;4=6GB;6=8GB;8=16GB;16=24GB}


    return $hashCPURam.get_item($cpu)



}