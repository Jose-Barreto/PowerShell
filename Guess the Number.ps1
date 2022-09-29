#
# Guess the number
#

[int] $Number = (Get-Random 100) + 1
[int] $Guess = 0

Write-Host "I'm thinking of a number between 1 and 100."

While ($Number -ne $Guess) {

    Write-Host -NoNewline "What is the number? "
    $Guess = [int] (Read-Host)

    If ($Guess -gt $Number) { Write-Host "$Guess is too high." }
    If ($Guess -lt $Number) { Write-Host "$Guess is too low." }    

}
Write-Host "Correct! $Number is the number I was thinking!"