function test-xgfirewallFolder 
{


	[CmdletBinding()]
	PARAM (
		[parameter(Mandatory = $true)]
		[String]$destination,
		[Parameter(mandatory=$false)]
        [String] $computername="Localhost"
		)

	BEGIN
	{
	}

	PROCESS 
	{
        $VmFolder = $Global:VmGlobaldier + "/" + $vmname

   
              if ($computername -eq "localhost")
              {
                    $pathresult = test-path -path $destination
                    return $pathresult
              }
              else 
              {
                    try 
                    {
                            # Check if folder exist
                                $pssession = new-pssession -ComputerName $Global:ServerProd 

                                invoke-command -session $pssession -ScriptBlock {
                                
                                    $pathresult = test-path -path $using:destination 

                                    return $pathresult

                                }
                    }
                    catch 
                    {
                        return $false
                    }
                    finally
                    {
                        Remove-PSSession $pssession
                    }
              }



	}

	END 
	{
		
	}




}