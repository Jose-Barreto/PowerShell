#
# Write Anagrams
#

Add-Type -Assembly System.Web
$WebClient = New-Object system.Net.WebClient 

Function Get-BingCount([string] $Term) { 

    Write-Progress -Percent $Complete -Activity "Looking for anagrams. Checking $Term"

    # Add plus and quotes, encodes for URL
    $Term = '+"' + $Term + '"'
    $Term = [System.Web.HttpUtility]::UrlEncode($Term) 

    # Load the page as a string
    $URL = "http://www.bing.com/search?q=" + $Term
    $Page = $WebClient.DownloadString($URL)

    # searches for the string before the number of hits on the page
    $String1 = '<span class="sb_count">'
    $Index1 = $Page.IndexOf($String1) 

    # if found the right string, finds the exact end of the number
    If ($Index1 -ne -1) {
        $Index1 += $String1.Length
        $Index2 = $Page.IndexOf(" ", $Index1)
        $result = $Page.Substring($Index1, $Index2 - $index1)
    } else { $result = "0" } 

    # Convert to integer
    $result = [int64] $result

    # Return the count
    return $result
} 

Clear-Host
Write-Host "Enter a name: " -NoNewline
$Name = Read-Host

$Name = $Name.ToLower()
$Length = $Name.Length
$Iterations = [math]::Pow(2,$Length)

$Complete = 0
Write-Progress -Activity "Looking for anagrams" -PercentComplete $Complete

$Dictionary = @{}
$Anagram = $Name
$Bing = Get-BingCount($Anagram)
$Dictionary.Add($Anagram, $Bing)

1..$Iterations | % {

    $Src = Get-Random $Length
    $Dst = Get-Random $Length
    # Write-Host "Debug step $_ anagram $anagram Src $src Dst $dst "

    If ($Src -ne $Dst) {
        $SrcChar = $Anagram[$Src]
        $DstChar = $Anagram[$Dst]
        
        $Anagram = $Anagram.Remove($Src, 1)
        $Anagram = $Anagram.Insert($Src, $DstChar)
        $Anagram = $Anagram.Remove($Dst, 1)
        $Anagram = $Anagram.Insert($Dst, $SrcChar)
    }

    If(-not $Dictionary.ContainsKey($Anagram)) {
       $Bing = Get-BingCount($Anagram)
       $Dictionary.Add($Anagram, $Bing)
    }

    If ($_ % 10 -eq 0) {
        $Complete = $_ * 100 / $Iterations
        Write-Progress -Activity "Looking for anagrams" -PercentComplete $Complete
    }
}

Write-Progress -Activity "Looking for anagrams" -Completed

Write-Host
Write-Host "Anagrams found"
Write-Host

$Dictionary.GetEnumerator() | Sort Value |  % {
    $Name = $_.Name
    $Count = $_.Value
    Write-Host "- $Name ($Count)"
}

$Count = $Dictionary.Count
Write-Host
Write-Host "Found $Count anagrams after $Iterations iterations:"
Write-Host
