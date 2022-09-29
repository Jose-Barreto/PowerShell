
#
# Tic Tac Toe
#

[Array] $Board = (0,0,0,0,0,0,0,0,0)
[int] $XWins = 0
[int] $OWins = 0

Function Clear-Board {
    0..($Board.Count-1) | % { $Board[$_] = 0 }
}

Function Get-BoardTile ([int] $I) {
    $Tile = " [ "
    Switch ($Board[$I]) {
    0 { $Tile += "$I" }
    1 { $Tile += "X" }
    2 { $Tile += "O" }
    }
    $Tile += " ] "
    Return $Tile
}

Function Write-Board {
    0..2 | % {
        $Row = $_
        0..2 | % { 
            $Col = $_
            $Index = ($Row) * 3 + $Col
            $Value = Get-BoardTile($Index)
            Write-Host "Index $Index - Value $Value"
        }
    }
}

Function Test-Winner {
    $Winners = ""
}

Clear-Board
Write-Board
Test-Winner
