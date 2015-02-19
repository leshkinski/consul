Param(
    [parameter(ParameterSetName='ComputerName', Position=0)]
    [string]
    $ComputerName,

    [parameter(ParameterSetName='IP', Position=0)]
    [System.Net.IPAddress]
    $IPAddress,

    [parameter(Mandatory=$true , Position=1)]
    [int]
    $Port,

    [parameter(Mandatory=$true, Position=2)]
    [ValidateSet("TCP", "UDP")]
    [string]
    $Protocol
    )

$RemoteServer = If ([string]::IsNullOrEmpty($ComputerName)) {$IPAddress} Else {$ComputerName}

If ($Protocol -eq 'TCP')
{
    $test = New-Object System.Net.Sockets.TcpClient
    
    Try
    {
        Write-Verbose "Connecting to $RemoteServer :$Port (TCP).."
        $test.Connect($RemoteServer, $Port)
        Write-Verbose "Connection successful"
        exit 0
    }
    Catch
    {
        
        Write-Verbose "Connection failed"
        $Error[0]
        exit 2

    }
    Finally
    {
        $test.Close()
        $test.Dispose()
    }
}

If ($Protocol -eq 'UDP')
{
    $test = New-Object System.Net.Sockets.UdpClient
    Try
    {
        Write-Verbose "Connecting to $RemoteServer :$Port (UDP).."
        $test.Connect($RemoteServer, $Port)
        Write-Verbose "Connection successful"
        exit 0
    }
    Catch
    {
        Write-Verbose "Connection failed"
        exit 2
    }
    Finally
    {
        $test.Close()
        $test.Dispose()
    }
}
