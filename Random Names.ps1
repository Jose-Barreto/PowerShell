
#
# Creating common names
#
# Using the top first names published by the SSA at http://www.ssa.gov/OACT/babynames/
# And the top last names from http://en.wikipedia.org/wiki/List_of_most_common_surnames_in_North_America
#

$first = "Noah Sophia Liam Emma Jacob Olivia Mason Isabella William Ava Ethan Mia Michael Emily Alexander Abigail Jayden Madison Daniel Elizabeth".Split(" ")
$last = "Smith Johnson Williams Brown Jones Miller Davis Garcia Rodriguez Wilson Martinez Anderson Taylor Thomas Hernandez Moore Martin Jackson Thompson White".Split(" ")

Cls
Write-Host "Random full name generator"
Write-Host

1..30 | foreach { 
    $f = $first[ (Get-Random $first.count ) ]
    $m = [char] (65 + (Get-Random 26) )
    $l = $last[ (Get-Random $last.count) ]
    $full = $f+" "+$m+" "+$l
    Write-Host -NoNewline $full.PadRight(25)
    If ($_ % 3 -eq 0) {
        Write-Host ""
    }
}
#
# Sample output
#
# Random full name generator
# 
# Emily B Miller           Olivia N Hernandez       William U Martinez       
# Mia I Jones              Olivia W Miller          William G Williams       
# Noah M Williams          Daniel V Thomas          Jayden X White           
# William Y Martin         Elizabeth A Thompson     Isabella W Taylor        
# Mia A Martinez           Abigail G Johnson        Madison M Brown          
# Ethan I Williams         Noah L Taylor            Noah L Martinez          
# Madison K Rodriguez      Michael Z Smith          Daniel X Davis           
# Mason B Thompson         William I Thomas         Sophia A Miller          
# Mia U Smith              Emily R Taylor           Noah F Brown             
# Daniel Q Wilson          Elizabeth R Taylor       Mason E Jackson  
#
