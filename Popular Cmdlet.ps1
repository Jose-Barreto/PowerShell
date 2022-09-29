#
# Popularity (via Bing) of the PowerShell cmdlets in a module
#

#
# Function to see how many pages Bing finds for a given term
#

# Adds assembly to support URL encoding
Add-Type -Assembly System.Web

Function Get-BingCount([string] $Term) {

    # Add plus and quotes, encodes for URL
    $Term = [System.Web.HttpUtility]::UrlEncode($Term) 
    $Term = "+" + "`"" + $Term + "`""

    # Navigate to the Bing page to query the $term
    $ie.Navigate("http://bing.com/search?q="+$term); 

    # Wait for the page to load
    $timeout = 0
    while ($ie.Busy) { 
        # Write-Host "Waiting for Bing page for $term to load"
        Start-Sleep -Milliseconds 100
        $timeout++
        If ($timeout  -gt 100) {
            return "L-Error"
        }
    }     

    # Wait for the document to be ready
    $timeout = 0
    $element1 = $ie.Document.IHTMLDocument3_getElementById("b_tween").innertext
    $element2 = $ie.Document.IHTMLDocument3_getElementById("b_content").innertext
    While ($element1 -eq $null -and $element2 -eq $null) { 
        # Write-Host "Waiting for Bing document for $term to be ready"
        Start-Sleep -Milliseconds 100
        $timeout++
        If ($timeout  -gt 100) {
            return "D-Error"
        }
        $element1 = $ie.Document.IHTMLDocument3_getElementById("b_tween").innertext
        $element2 = $ie.Document.IHTMLDocument3_getElementById("b_content").innertext
    }

    # Get the count of pages
    If ($element1 -ne $null) { $result = $element1.split(" ")[0] }
                       else  { $result = "0" }
    
    # Return the count
    return $result
}

#
# Main code
#

# Create Internet Explorer object
$ie = New-Object -ComObject "InternetExplorer.Application"      

$CmdletList = Get-Command -Module SmbShare | Select Name
$CmdletCount = $CmdletList.Count -1

0..$CmdletCount | % {

    # Tracks progress
    Write-Progress -Activity "Checking cmdlet popularity" -PercentComplete ($_ * 100 / $CmdletCount)

    # Check the popularity with Bing
    $cmdlet = $CmdletList[$_].Name
    $count = [string] (Get-BingCount $cmdlet)
    $countint = [int] $count
    
    # Format as a row, output it
    $Row = "" | Select CmdletName, BingCount
    $Row.CmdletName  = $cmdlet
    $Row.BingCount = $countint
    $Row
}

Write-Progress -Activity "Checking cmdlet popularity" -Completed

# Quit Internet Explorer
$ie.quit(); 

