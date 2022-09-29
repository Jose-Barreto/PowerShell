<# 
    .SYNOPSIS 
       Organize pictures in your OneDrive camera roll folder

    .DESCRIPTION 
       Organize pictures in your OneDrive pictures folder
       Creates folders named after the year and month, then moves picture files to them
       Default to your OneDrive camera roll
       
    .NOTES 
        File Name : Organize-Pictures.PS1
        Authors   : Jose Barreto
        Version   : 1.0 (09/2/2016)

    .LINK 
        To provide feedback visit https://blogs.technet.microsoft.com/josebda/

    .EXAMPLE 
       .\Organize-Pictures.ps1
 
       Organizes all OneDrive camera roll for the current user.
       Uses folder C:\Users\<user>\OneDrive\Pictures\Camera Roll

    .EXAMPLE 
       Organize-Pictures.ps1 -Path "C:\Pictures\Camera Roll"
 
       Organizes all pictures in the specified folder.

    .EXAMPLE 
       Organize-Pictures.ps1 -Path "D:\Camera Roll" -Confirm $false -RemoveEmptyFolders $false
 
       Organizes all pictures in the specified folder.
       Does not prompt for confirmation. Does not remove empty folders.

#> 

[CmdletBinding(DefaultParameterSetName="Default")]

# Define parameters and defaults

param(
    [parameter(ParameterSetName="Default", Position=0, Mandatory=$false)]
    [ValidateNotNullOrEmpty()]
    [string] $Path = $($env:userprofile + "\OneDrive\Pictures\Camera Roll"),

    [parameter(ParameterSetName="Default", Position=1, Mandatory=$false)]
    [ValidateNotNullOrEmpty()]
    [string] $Confirm = $true,

    [parameter(ParameterSetName="Default", Position=2, Mandatory=$false)]
    [ValidateNotNullOrEmpty()]
    [string] $RenameIfExists = $true,

    [parameter(ParameterSetName="Default", Position=3, Mandatory=$false)]
    [ValidateNotNullOrEmpty()]
    [string] $RemoveEmptyFolders = $true
)

# Set strict mode to check typos on variable and property names

Set-StrictMode -Version Latest

# Shows error, cancels script

Function ShowError { 
Param ([string] $Message)
    $Message = $Message + “ – cmdlet was cancelled”
    Write-Error $Message -ErrorAction Stop
}
 
# Checks if the Path provided is valid

if ($Path -eq "") {
    ShowError("Path cannot be blank")
}

if ($Path.EndsWith("\")) {
    $Path = $Path.Substring(0, $Path.Length-1)
}

if (-not (Test-Path $Path)) {
    ShowError("Invalid Path - "+$Path)
}

# Asks for confirmation

if ($Confirm) {

    Cls
    Write-Host "This script will organize files at <$Path> and all subfolders."
    Write-Host "Files will be moved to a folder named after the year and month the file was last written."
    Write-Host "This operation cannot be easily undone."
    Write-Host ""
    if ($RenameIfExists -eq $true ) { $action = "renamed" } else { $action = "skipped" }
    Write-Host "Existing files at destination will be $action." 
    if ($RemoveEmptyFolders -eq $true) { Write-Host "Empty folders after the operation will be removed automatically." }
    Write-Host ""
    Write-Host -ForegroundColor Yellow -NoNewline "Are you sure you want to proceed (Y/N)? "

    $Answer = Read-Host 
    if ($Answer.ToUpper() -ne "Y") {
        ShowError("User did not confirm the operation")
    }

}

# Moves pictures to the new location

$FilesMoved = 0
$FilesSkipped = 0
$FoldersRemoved = 0

dir $Path -Recurse -File | % {

    # Get file and folder information

    $oldname = $_.FullName
    $newsubfolder = "\"+$_.LastWriteTime.Year +"\" + $_.LastWriteTime.Month.ToString().PadLeft(2, "0")
    $newname = $Path + $newsubfolder + "\" + $_.Name

    # Need to move the file

    if ($newname -ne $oldname) {

        # Create the new folder if necessary
        
        $newfolder = $newname.Substring(0, $newname.LastIndexOf("\"))
        MD $newfolder -ErrorAction SilentlyContinue | Out-Null

        # File already exists
        $SkipFile = $false

        if (Test-Path $newname) { 

            if ($RenameIfExists -eq $true) {
            
                # Rename the file

                Write-Host "File <$newname> already exists at destination. Renaming to avoid conflict."
                $newname = $newname.Replace(".", "-" + (New-Guid).Guid + ".") 

            } else { 

                Write-Host "File <$newname> already exists at destination. Skipping."
                $SkipFile = $true
                $FilesSkipped++
            }
        }

        # Move the file

        if ($SkipFile -eq $false) {
            "Moving to $newname"
            $_.MoveTo($newname)
            $FilesMoved++
        }

    } 
}

# Removes empty folders

if ($RemoveEmptyFolders -eq $true) {

    dir $Path -Recurse -Directory | sort FullName -Descending | % {

        # if folder is empty

        $dirname = $_.FullName
        if ((dir $dirname -Recurse) -eq $null) { 

            # remove folder

            Write-Host "Directory <$dirname> is empty - removing"
            $_.Delete(); 
            $FoldersRemoved++

        }
    }
}

# Final summary

Write-Host ""
Write-Host "$FilesMoved files moved."
if ($RenameIfExists -eq $false) { Write-Host "$FilesSkipped files skipped." }
if ($RemoveEmptyFolders -eq $true) { Write-Host "$FoldersRemoved empty folders." }


