Function Get-GoogleCount([string] $Term) {

    # Create Internet Explorer object
    $ie = New-Object -ComObject "InternetExplorer.Application"      

    # Navigate to the Google page to query the $term
    $ie.Navigate("google.com?#q="+$term); 

    # Wait for the page to load
    while ($ie.Busy) { 
        Write-Host "Waiting for Google page for $term to load"
        Start-Sleep -Milliseconds 10 
    }     

    # Wait for the document to be ready
    While (($ie.Document.IHTMLDocument3_getElementById("resultStats").innertext) -eq $null) { 
        Write-Host "Waiting for Google document for $term to be ready"
        Start-Sleep -Milliseconds 10 
    }

    # Get the count of pages
    $element = $ie.Document.IHTMLDocument3_getElementById("resultStats")
    $result = [int] $element.innertext.split(" ")[1]
    
    # Quit Internet Explorer
    $ie.quit(); 

    # Return the count
    return $result
}

Function Get-BingCount([string] $Term) {

    # Create Internet Explorer object
    $ie = New-Object -ComObject "InternetExplorer.Application"      

    # Navigate to the Bing page to query the $term
    $ie.Navigate("bing.com/search?q="+$term); 

    # Wait for the page to load
    while ($ie.Busy) { 
        Write-Host "Waiting for Bing page for $term to load"
        Start-Sleep -Milliseconds 10 
    }     

    # Wait for the document to be ready
    While ( ($ie.Document.IHTMLDocument3_getElementById("b_tween").innertext) -eq $null) { 
        Write-Host "Waiting for Bing document for $term to be ready"
        Start-Sleep -Milliseconds 10 
    }

    # Get the count of pages
    $element = $ie.Document.IHTMLDocument3_getElementById("b_tween")
    $result = [int] $element.innertext.split(" ")[0]
    
    # Quit Internet Explorer
    $ie.quit(); 

    # Return the count
    return $result
}

$word = "Mediterranean" 
$q1 = Get-GoogleCount($word)
$q2 = Get-BingCount($word)
"Count for the word $word from Google is $q1 and from Bing is $q2"