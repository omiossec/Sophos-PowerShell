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
        #Zip or Folder
        #test if the source exist and if it's a ZIP or a folder
        



	}

	PROCESS 
	{

        if (test-path -Path $source)
        {
            $filetype = get-item $source 

            if ($filetype -isnot [System.IO.DirectoryInfo])
            {
                 # check if the file is a zip file
                $extn = [IO.Path]::GetExtension($source)
                if ($extn -eq "zip")
                {
                    #unzip the file in the same folder
                    $source = expand-xgfirewallzip.ps -FilePath $source -force
                }

            }

        if ($computername -eq "Localhost")
        {

            # test if the destination existe 
            if (!(test-path -Path $destination))
            {
                #try to create the destination
                try {
                    New-Item -ItemType Directory -Path $destination
                }
                catch {
                    Write-Error "Error could not create the directory $destination"
                    Exit-PSHostProcess
                }
            }

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

    END 
    {

    }





}