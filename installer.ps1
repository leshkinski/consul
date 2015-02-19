Param(
    [parameter(Mandatory=$true, Position=0)]
    [ValidateSet("bootstrap", "server", "client")]
    [string]
    $InstallType
    )

switch ($InstallType)
{
    'bootstrap'
    {
        Write-Host "$InstallType selected"
        Invoke-Command {.\boostrap\consul_service.exe install}
    }
    'server'
    {
        Write-Host "$InstallType selected"
        Invoke-Command {.\server\consul_service.exe install}
    }
    'client'
    {
        Write-Host "$InstallType selected"
        Invoke-Command {.\client\consul_service.exe install}
    }
    Default 
    {
        Write-host "No valid choice."
    }
}
