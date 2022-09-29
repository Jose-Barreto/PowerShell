$SourcePath = "C:\Users\josebda\OneDrive\"
$BackupPath = "D:\Backup-" + (Get-Date).ToString("yyyy-MM-dd")
$BackupPath = $BackupPath + "\OneDrive\"
if (-not (Test-Path $BackupPath)) {
   "Making folder $BackupPath"
   MD $BackupFolder | Out-Null
}

Write-Progress -Activity "Getting File List" -PercentComplete 0
$FileList = DIR $SourcePath -Recurse -File

$Total = $FileList.Count
$Pinned = [math]::Pow(2, 19)
$Count = 0
$BadCount = 0

$FileList | % {

    $File = $_.FullName
    $Folder = $_.DirectoryName

    $BackupFile = $File.Replace($SourcePath, $BackupPath)
    $BackupFolder = $Folder.Replace($SourcePath, $BackupPath)
    if (-not (Test-Path $BackupFolder)) {
       "Making folder $BackupFolder"
       MD $BackupFolder | Out-Null
    }

    Try { 

       attrib -U +P $File
       $FileAttrib = (Dir $File).Attributes.value__

       if ($FileAttrib -and $Pinned) {
            Copy-Item -Path $File -Destination $BackupFile 
       } else {
          "Attribute not reset for $File"
          $CopyError = $true
       }

       attrib +U -P $File
       $FileAttrib = (Dir $File).Attributes.value__

       if (-not ($FileAttrib -and $Pinned)) {
          "Attribute not reset for $File"
          $CopyError = $true
       } else {
          $CopyError = $false
       }

    } 
    Catch { 
       $CopyError = $true
    }

    If ($CopyError) {
        $BadCount++
        "Error copying: $File, $Backup"
    }

    $Count++
    If ($Count % 1000 -eq 0) {
        Write-Progress -Activity "File $Count of $Total" -PercentComplete ($Count/$Total*100) 
    }

}
Write-Progress -Activity "Checking Files" -Completed
"Finished copying $Count files. There were $BadCount copy errors."