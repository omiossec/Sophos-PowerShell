function copy-xgfirewallFiles
{

    [CmdletBinding()]
	PARAM (
		[parameter(Mandatory = $false)]
		[String]$destination="c:\temp\",
        [parameter(Mandatory = $true)]
		[String]$source, 
        [parameter(Mandatory = $false)]
		[String]$computername="localhost"
		)

	BEGIN
	{
 
	}

	PROCESS 
	{
         if (test-path -Path $source)
        {
            #  (Get-Item $source) -is [System.IO.DirectoryInfo]
            if ((Get-Item $source) -isnot [System.IO.DirectoryInfo])
            {
                write-verbose "Folder $source is not a directory"
                # check if the file is a zip file
                $extn = [IO.Path]::GetExtension($source)
                if ($extn -eq "zip")
                {
                    #unzip the file in the same folder
                    write-verbose "Trying to unzip the file"
                    $source = expand-xgfirewallzip -FilePath $source -force
                }

            }


         if ($computername -eq "Localhost")
        {

            write-verbose "Try to see if the $destination folder exist"
            if (!(test-path -Path $destination))
            {
                #try to create the destination
                try {

                    New-Item -ItemType Directory -Path $destination
                }
                catch {
                    Write-Error "Error could not create the directory $destination on computer $computername"
                    Exit-PSHostProcess
                }
            }

            try 
            {
                write-verbose "List vhd in $source"
                $xgVhds = get-childitem $source

                foreach ($vhd in $xgvhds)
                {
                    $path = Join-Path $destination $vhd
                    write-verbose "trying to copy $path to $destination"
                }

            
            }
            catch 
            {

            }


        }   
        else 
        {
            # test the path on the remote computer
            $folderExist = test-xgfirewallFolder -destination $destination -computername $computername

            try 
            {
                $xgVhds = get-item $source

                foreach ($vhd in $xgvhd)
                {
                    Join-Path $destination $vhd
                }

            
            }
            catch 
            {

            }


            $session = New-PSSession -ComputerName MEMBERSRV1
            Send-File -Path C:test.xml -Destination C: -Session $session
            Remove-PSSession $session
        }        




        }
       
    }

    END 
    {

    }





}