#
# Counting words in a text file
# Uses the text from Alice in Wonderland from http://www.gutenberg.org/ebooks/11.txt.utf-8
# 

Cls
$FileName = ".\Alice.TXT"
Write-Host "Reading file $FileName..." 
$File = Get-Content $FileName
$TotalLines = $File.Count
Write-Host "$TotalLines lines read from the file."

$SearchWord = "WONDERLAND"
$Found = 0
$WordCount = 0
$Longest = ""
$Dictionary = @{}
$LineCount = 0

$File | foreach {
    $Line = $_
    $LineCount++
    Write-Progress -Activity "Processing words..." -PercentComplete ($LineCount*100/$TotalLines) 
    $Line.Split(" .,:;?!/()[]{}-```"") | foreach {
        $Word = $_.ToUpper()
        If ($Word[0] -ge 'A' -and $Word[0] -le "Z") {
            $WordCount++
            If($Word.Contains($SearchWord)) { $Found++ }
            If($Word.Length -gt $Longest.Length) { $Longest = $Word }
            If($Dictionary.ContainsKey($Word)) {
                $Dictionary.$Word++
            } else {
                $Dictionary.Add($Word, 1)
            }
        }
    } 
}

Write-Progress -Activity "Processing words..." -Completed
$DictWords = $Dictionary.Count
Write-Host "There were $WordCount total words in the text"
Write-Host "There were $DictWords distinct words in the text"
Write-Host "The word $SearchWord was found $Found times."
Write-Host "The longest word was $Longest" 
Write-Host
Write-Host "Most used words with more than 4 letters:"

$Dictionary.GetEnumerator() | ? { $_.Name.Length -gt 4 } | Sort Value -Descending | Select -First 20