#          #   Name                    Description                                N   S   E   W   U   D 
$Rooms = ( (00, "Exit!",               "exit!"                                    ,99, 99, 99, 01, 99, 99), 
           (01, "Entrance Hall",       "hall by the entrance. The door is locked" ,10, 02, 99, 99, 99, 99), 
           (02, "Downstairs Hall",     "hall at the bottom of the stairs"         ,01, 04, 03, 99, 11, 99), 
           (03, "Guest Bathroom",      "small guest bathroom downstaris"          ,99, 99, 05, 02, 99, 99), 
           (04, "Living Room",         "living room on the southeast side"        ,02, 99, 99, 05, 99, 99), 
           (05, "Family Room",         "family room with a large TV"              ,06, 99, 02, 99, 99, 99), 
           (06, "Nook",                "nook with a small dining table"           ,07, 05, 99, 24, 99, 99), 
           (07, "Kitchen",             "kitchen with a large granite counter"     ,08, 06, 99, 99, 99, 99), 
           (08, "Trash Hall",          "small hall with two large trash cans"     ,99, 07, 10, 09, 99, 99), 
           (09, "Garage",              "garage, the big door is closed"           ,99, 99, 08, 99, 99, 99), 
           (10, "Dining Room",         "dining room on the northeast side"        ,99, 01, 99, 08, 99, 99), 
           (11, "Upstairs Hall",       "hall at the top of the stairs"            ,99, 12, 16, 13, 99, 02), 
           (12, "Upstairs East Hall",  "hall with two tables and computers"       ,11, 15, 99, 99, 99, 99), 
           (13, "Upstairs North Hall", "hall with a large closet"                 ,18, 14, 11, 17, 99, 99), 
           (14, "Upstairs West Hall",  "hall with a small closet"                 ,13, 23, 99, 22, 99, 99), 
           (15, "Guest Room",          "guest room with a queen size bed"         ,12, 99, 99, 99, 99, 99), 
           (16, "Laundry",             "laundry room with a washer and dryer"     ,99, 99, 99, 11, 99, 99), 
           (17, "Main Bathroom",       "main bathroom with a bathtub"             ,99, 99, 13, 99, 99, 99), 
           (18, "Master Bedroom",      "master bedroom with a king size bed"      ,21, 13, 19, 99, 99, 99), 
           (19, "Master Closet",       "long and narrow walk-in closet"           ,99, 99, 99, 18, 20, 99), 
           (20, "Attic",               "attic, it is dark in here"                ,99, 99, 99, 99, 99, 19), 
           (21, "Master BathRoom",     "master bedroom with a shower and tub"     ,99, 18, 99, 99, 99, 99), 
           (22, "Children's Room",     "children's room with twin beds"           ,99, 99, 14, 99, 99, 99), 
           (23, "Entertainment Room",  "entertainment room with games and toys"   ,14, 99, 99, 99, 99, 99), 
           (24, "Patio",               "wooden patio, there's a key on the floor" ,99, 99, 06, 99, 99, 99) )

$Room = 20
$Message = "Find the way out of this house." 
$Key = $false

While ($Room -ne 0) {
    $Name  = $Rooms[$Room][1]
    $Desc  = $Rooms[$Room][2]
    $North = $Rooms[$Room][3]
    $South = $Rooms[$Room][4]
    $East  = $Rooms[$Room][5]
    $West  = $Rooms[$Room][6]
    $Up    = $Rooms[$Room][7]
    $Down  = $Rooms[$Room][8]

    $Available = "[Q]uit"
    If ($North -ne 99) { $Available += ", [N]orth" }
    If ($South -ne 99) { $Available += ", [S]outh" }
    If ($East  -ne 99) { $Available += ", [E]ast" }
    If ($West  -ne 99) { $Available += ", [W]est" }
    If ($Up    -ne 99) { $Available += ", [U]p" }
    If ($Down  -ne 99) { $Available += ", [D]own" }
    If ($Room -eq 24 -and -not $Key) { $Available += ", [K]ey" }

    Clear-Host
    Write-Host $Message
    $Message=""

    Write-Host
    Write-Host -ForegroundColor Yellow $Name
    Write-Host "You are at the $Desc"
    Write-Host
    

    Write-Host -ForegroundColor Green "Commands : $Available ? " -NoNewline
    $Cmd = Read-Host
    $Cmd = $Cmd.ToUpper()[0]

    Switch ($Cmd) {
    "Q" { $Room = 0 }
    "N" { If ($North -ne 99) { $Room = $North } }
    "S" { If ($South -ne 99) { $Room = $South } }
    "E" { If ($East  -ne 99) { $Room = $East  } }
    "W" { If ($West  -ne 99) { $Room = $West  } }
    "U" { If ($Up    -ne 99) { $Room = $Up    } }
    "D" { If ($Down  -ne 99) { $Room = $Down  } }
    "K" { If ($Key) {
             $Message = "You already have the key" 
          } ElseIf ($Room -eq 24) {
             $Message = "You grabbed the key." 
             $Rooms[24][2] = "wooden patio on the west side."
             $Rooms[01][2] = "hall by the entrance. The key unlocked the door."
             $Rooms[01][5] = 0
             $Key = $true
          } Else {
            $Message = "I don't see a key here."
          }
        }
    }

}

If ($Cmd -ne "Q") { Write-Host "You found the way out. Congratulations!" }
