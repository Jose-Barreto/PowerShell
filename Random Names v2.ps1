#
# Random words and their popularity with Bing
#

#
# Defines array with common vowels, consonants and endings
#

[array] $Vowels = "a;a;a;a;e;e;e;e;i;i;i;o;o;o;u;u;y" -split ";"
[array] $Consonants = "b;b;br;c;c;c;ch;cr;d;f;g;h;j;k;l;m;m;m;n;n;p;p;ph;qu;r;r;r;s;s;s;sh;t;tr;v;w;x;z" -split ";"
[array] $Endings = "r;r;s;r;l;n;n;n;c;c;t;p" -split ";"

#
# Functions for random vowels, consonants, endings and words
#

function Get-RandomVowel 
{ return $Vowels[(Get-Random($Vowels.Length))] }

function Get-RandomConsonant
{ return $Consonants[(Get-Random($Consonants.Length))] }

function Get-RandomEnding
{ return $Endings[(Get-Random($Endings.Length))] }

function Get-RandomSyllable ([int32] $PercentConsonants, [int32] $PercentEndings)
{  
   [string] $Syllable = ""
   if ((Get-Random(100)) -le $PercentConsonants) 
   { $Syllable+= Get-RandomConsonant }
   $Syllable+= Get-RandomVowel
   if ((Get-Random(100)) -le $PercentEndings) 
   { $Syllable+= Get-RandomEnding }
   return $Syllable
}

function Get-RandomWord ([int32] $MinSyllables, [int32] $MaxSyllables)
{  
   [string] $Word = ""
   [int32] $Syllables = ($MinSyllables) + (Get-Random(($MaxSyllables - $MinSyllables + 1)))
   for ([int32] $Count=1; $Count -le $Syllables; $Count++) 
   { $Word += Get-RandomSyllable 70 20 } <# Consonant 70% of the time, Ending 20% #>
   return $Word
}

#
# Function to see how many pages Google finds for a given term
#

Function Get-BingCount([string] $Term) {

    # Navigate to the Bing page to query the $term
    $ie.Navigate("http://bing.com/search?q=%2B"+$term); 

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

# Check for 20 random words...
Write-Host
Write-Host "Here are 20 random words and their popularity"
Write-Host

1..20 | % {
    # Get a random word
    $word = Get-RandomWord 2 5

    # Check the popularity with Bing
    $count = ([string] (Get-BingCount $word)).Padleft(12)
    $countint = [int] $count
    
    # Select Color based on popularity. 
    if     ($countint -eq 0)       { $color = "white"  }
    elseif ($countint -lt 1000)    { $color = "green"  }
    elseif ($countint -lt 1000000) { $color = "yellow" }
    else                           { $color = "red"    }  

    # Write the info with the right color
    Write-Host "$count --> $word" -ForegroundColor $color
}

# Quit Internet Explorer
$ie.quit(); 

