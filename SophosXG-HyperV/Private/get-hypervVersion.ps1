function get-hypervVersion
{

	[CmdletBinding()]
	PARAM (
		[parameter(Mandatory = $true)]
		[String]$ComputerName
		)

	BEGIN
	{
	}

	PROCESS 
	{

		try {
			$hypervHost = get-vmhost -ComputerName $ComputerName 

			# try to count SupportedVmVersions 
			if ($hypervHost.SupportedVmVersions.Count -eq $null)
			{
				return "2102"
			}
			else {
				return "2016"
			}

		}
		catch {
			write-error "No Hyper-v Installed on Host $computername"
		}
    }
    END 
    {

    }






}