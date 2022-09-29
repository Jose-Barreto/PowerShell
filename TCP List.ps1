Function Get-ProcessName ([int] $ProcessID)
{ 
    $Process = Get-Process -Id $ProcessID
    Return $Process.Name
}

Function Get-DomainName([string] $IpAddress)
{
    $Domain = Resolve-DnsName -Name $IpAddress
    Return $Domain.NameHost
}

Get-NetTCPConnection -State Established | Sort RemotePort, OwningProcess |
    FT -AutoSize RemotePort, RemoteAddress,
       @{Expression={Get-DomainName($_.RemoteAddress)}; Label="HostName"}, 
       OwningProcess,
       @{Expression={Get-ProcessName($_.OwningProcess)}; Label="ProcessName"}
