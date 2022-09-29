$Start = Get-Date
$BaseDate = (Get-Date "2016/12/31 12:59:59")
$FullYear = 366*24*60*60
$File = ”.\file.csv” 
"Date,Customer,Type,Value" | Out-File -FilePath $File -Encoding utf8

1..2000 | % {

    Write-Progress -Activity “Generating File” -PercentComplete ($_/20) 
    $Lines = ""

    1..1000 | % {

        $Dt = $BaseDate.AddSeconds(-(Get-Random $FullYear))
        $Ct = (Get-Random 100)
        if ((Get-Random 5) -lt 4) {$Ty="Sale"} else { $Ty="Return"}
        $Vl = (Get-Random 100000) / 100
        $Lines += [string]$Dt + "," + [string]$Ct + "," + $Ty + "," + [string]$Vl + [char]10 + [char]13

    }

    $Lines | Out-File -FilePath $File -Encoding utf8 -Append

}

$End = Get-Date
"Started at $Start and ended at $End"
$Diff = ($End-$Start).TotalSeconds
"Processing took $Diff seconds"                                                                                   