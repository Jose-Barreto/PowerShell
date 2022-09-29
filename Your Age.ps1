#
# How long have you lived?
#

Write-Host "When were you born (mm-dd-yy)? " -NoNewline
$bornstring = Read-Host

$born = Get-Date -Date $bornstring
$week = $born.DayOfWeek
$diff = ((Get-Date) - $born).Days

Write-Host "You were born on a $week"
Write-Host "You lived for $diff days"