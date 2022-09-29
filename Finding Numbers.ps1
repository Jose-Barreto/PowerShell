# PowerShell lessons
# Calculating minimum and maximum numbers

cls

# Minimum using the [double] data type

[double] $last1 = 1
[double] $last2 = 0
[double] $last3 = 0
 while ($last1 –ne $last2) 
 { 
#    Write-Host $last1
    $last3 = $last2
    $last2 = $last1
    $last1 /= 2 
}
Write-Host "The smallest double is $last3. After that, we get $last2"

# Minimum using the [single] data type

[single] $last1 = 1
[single] $last2 = 0
[single] $last3 = 0
 while ($last1 –ne $last2) 
 { 
#    Write-Host $last1
    $last3 = $last2
    $last2 = $last1
    $last1 /= 2 
}
Write-Host "The smallest single is $last3. After that, we get $last2"

# Maximum using the [double] data type

[double] $last1 = 1
[double] $last2 = 0
[double] $last3 = 0
 while ($last1 –ne $last2) 
 { 
#    Write-Host $last1
    $last3 = $last2
    $last2 = $last1
    $last1 *= 2 
}
Write-Host "The largest double is $last3. After that, we get $last2"

# Maximum using the [single] data type

[single] $last1 = 1
[single] $last2 = 0
[single] $last3 = 0
 while ($last1 –ne $last2) 
 { 
#    Write-Host $last1
    $last3 = $last2
    $last2 = $last1
    $last1 *= 2 
}
Write-Host "The largest single is $last3. After that, we get $last2"

#
# Sample output 
#
# The smallest double is 4.94065645841247E-324. After that, we get 0
# The smallest single is 1.401298E-45. After that, we get 0
# The largest double is 8.98846567431158E+307. After that, we get Infinity
# The largest single is 1.701412E+38. After that, we get Infinity
#