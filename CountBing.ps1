#
# Popularity (via Bing) of the PowerShell cmdlets in a module
# 

#
# Function to see how many pages Bing finds for a given term
# 

# Adds assembly to support URL encoding and the web client 

Add-Type -Assembly System.Web
$WebClient = New-Object system.Net.WebClient 

Function Get-BingCount([string] $Term) { 

    # Add plus and quotes, encodes for URL
    $Term = '+"' + $Term + '"'
    $Term = [System.Web.HttpUtility]::UrlEncode($Term) 

    # Load the page as a string
    $URL = "http://www.bing.com/search?q=" + $Term
    $Page = Invoke-WebRequest $URL

    # searches for the string before the number of hits on the page
    $String1 = '<span class="sb_count">'
    $Index1 = $Page.Content.IndexOf($String1) 

    # if found the right string, finds the exact end of the number
    If ($Index1 -ne -1) {
        $Index1 += $String1.Length
        $Index2 = $Page.Content.IndexOf(" ", $Index1)
        $result = $Page.Content.Substring($Index1, $Index2 - $index1)
    } else { $result = "0" } 

    # Return the count
    return $result
} 

#
# Main code
# 

$CmdletList = Get-Command  -Module Storage | Select Name, ModuleName
$CmdletCount = $CmdletList.Count -1 

0..$CmdletCount | % { 

    # Tracks progress
    Write-Progress -Activity "Checking cmdlet popularity" -PercentComplete ($_ * 100 / $CmdletCount) 

    # Check the popularity with Bing
     $count = [int64] (Get-BingCount $CmdletList[$_].Name)

    # Format as a row, output it
    $Row = "" | Select CmdletName, ModuleName, BingCount
    $Row.CmdletName  = $CmdletList[$_].Name
    $Row.ModuleName  = $CmdletList[$_].ModuleName
    $Row.BingCount = $count
    $Row
} 

Write-Progress -Activity "Checking cmdlet popularity" -Completed 

# Releases resources used by the web client
$WebClient.Dispose()


