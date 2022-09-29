#
# Calculating Pi without using [math]::Pi
#

[double] $halfpi=1
[int] $num=1
[double] $factorial=1
[double] $oddfactorial=1
[double] $pi = 1
[double] $previouspi = 0

while ($previouspi -ne $pi) {
    $previouspi = $pi
    $factorial *= $num
    $oddfactorial *= (($num*2)+1)
    $halfpi += $factorial / $oddfactorial
    $pi = 2 * $halfpi
    Write-Output "Step $num - Pi is $pi" 
    $num++
}

$num--
Write-Output ""
Write-Output "Calculated Pi as $pi after $num iterations."
$SystemPi = [Math]::Pi
Write-Output "The system Pi is $SystemPi (returned by [Math]::Pi)."
[double] $Difference = $SystemPi - $pi
Write-Output "Difference between the two is $Difference"

#
# Sample output:
#
# Calculated Pi as 3.14159265358979 after 50 iterations.
# The system Pi is 3.14159265358979 (returned by [Math]::Pi).
# Difference between the two is 8.88178419700125E-16
# 