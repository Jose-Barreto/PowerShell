﻿#
# Finding Prime Numbers
#

# Primes between 2 and 1000
#

Cls

Write-Host "Calculating prime numbers" 
Write-Host "" 

$count = 0
2..1000 | foreach {

    $number = $_
    $divisor = [math]::Sqrt($number)
    $prime = $true

    2..$divisor | foreach {
        if ($number % $_ -eq 0) {
            $prime = $false
        }
    }

    If ($prime) {
        Write-Host -NoNewline $number.ToString().PadLeft(4)
        $count++
        If ($count % 10 -eq 0) {
            Write-Host ""
        }
    }

}

Write-Host ""
Write-Host "$count primes between 2 and 1000"
Write-Host ""

$count = 0
1000000..1000999 | foreach {

    $number = $_
    $divisor = [math]::Sqrt($number)
    $prime = $true

    2..$divisor | foreach {
        if ($number % $_ -eq 0) {
            $prime = $false
        }
    }

    If ($prime) {
        Write-Host -NoNewline $number.ToString().PadLeft(8)
        $count++
        If ($count % 5 -eq 0) {
            Write-Host ""
        }
    }

}

Write-Host ""
Write-Host "$count primes between 1000000 and 1000999"
Write-Host ""

#
# Sample output
#
# Calculating prime numbers
# 
#    3   5   7  11  13  17  19  23  29  31  37  41  43  47  53  59  61  67  71  73
#   79  83  89  97 101 103 107 109 113 127 131 137 139 149 151 157 163 167 173 179
#  181 191 193 197 199 211 223 227 229 233 239 241 251 257 263 269 271 277 281 283
#  293 307 311 313 317 331 337 347 349 353 359 367 373 379 383 389 397 401 409 419
#  421 431 433 439 443 449 457 461 463 467 479 487 491 499 503 509 521 523 541 547
#  557 563 569 571 577 587 593 599 601 607 613 617 619 631 641 643 647 653 659 661
#  673 677 683 691 701 709 719 727 733 739 743 751 757 761 769 773 787 797 809 811
#  821 823 827 829 839 853 857 859 863 877 881 883 887 907 911 919 929 937 941 947
#  953 967 971 977 983 991 997
# 167 primes between 2 and 1000
# 
#  1000003 1000033 1000037 1000039 1000081 1000099 1000117 1000121 1000133 1000151
#  1000159 1000171 1000183 1000187 1000193 1000199 1000211 1000213 1000231 1000249
#  1000253 1000273 1000289 1000291 1000303 1000313 1000333 1000357 1000367 1000381
#  1000393 1000397 1000403 1000409 1000423 1000427 1000429 1000453 1000457 1000507
#  1000537 1000541 1000547 1000577 1000579 1000589 1000609 1000619 1000621 1000639
#  1000651 1000667 1000669 1000679 1000691 1000697 1000721 1000723 1000763 1000777
#  1000793 1000829 1000847 1000849 1000859 1000861 1000889 1000907 1000919 1000921
#  1000931 1000969 1000973 1000981 1000999
# 75 primes between 1000000 and 1000999
# 