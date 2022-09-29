$SourcePath = "D:\"
$BackupPath = "F:\Backup 2019-03-08\"

Write-Progress -Activity "Getting File List" -PercentComplete 0
$FileList = DIR $SourcePath -Recurse -File

$Total = $FileList.Count
$Count = 0
$BadCount = 0

$FileList | % {

    $File = $_.FullName
    $Backup = $File.Replace($SourcePath, $BackupPath)

    Try { 
       $Match = (Get-FileHash $File).Hash -eq (Get-FileHash $Backup).Hash 
    } 
    Catch { 
       $Match = $false 
    }

    If (-not $Match) {
        $BadCount++
        "Hash mismatch: $File, $Backup"
    }

    $Count++
    If ($Count % 1000 -eq 0) {
        Write-Progress -Activity "File $Count of $Total" -PercentComplete ($Count/$Total*100) 
    }

}
Write-Progress -Activity "Checking Files" -Completed
"There were $BadCount bad files out of the $Count files checked"