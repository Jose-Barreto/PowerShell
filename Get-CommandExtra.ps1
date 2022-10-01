$Module = "Azure"
$Output = ".\" + $Module + "Cmdlets.HTML"

"Create HTML file with all commands and parameters for the " + $Module + " Module"
"Output goes to the " + $Output + "File"

$Cmdlet = "" | Select Name, Parameters
Get-command -Module $Module | % {
  Get-Help $_ | % { 
    $ParameterSetCount = 1
    $CmdletName = $_.Name
    $ParameterSets = $_.syntax.syntaxItem 
    $ParameterSets | % {

      If ($ParameterSets.Count -gt 1) { 
        $Cmdlet.Name=$CmdletName+" ("+$ParameterSetCount+")"
        $ParameterSetCount++
      } else { 
        $Cmdlet.Name=$CmdletName 
      } 

      $Parameters = $_.parameter
      $StringPar=""
      If ($Parameters) {
        $First=$true
        $Parameters | % { 
          If ($First) {$First=$false} else {$StringPar+="%%"}
          $StringPar+= " -"+$_.name+" "; 
          if ($_.parameterValue -and ($_.parameterValue -notlike "Switch*")) { 
            $StringPar+= "<"+$_.parameterValue+"> " 
          } 
        }
      }
      $StringPar=$StringPar.Replace("Nullable``1","")
      $StringPar=$StringPar.Replace("System.[[System.Int32, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089]]","Int32")
      $StringPar=$StringPar.Replace("System.[[System.Boolean, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089]]","Boolean")
      $Cmdlet.parameters=$StringPar;

      $Cmdlet  
    }
  } 
} | ConvertTo-HTML | Out-File $Output