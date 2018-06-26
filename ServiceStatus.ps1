$services = Get-Service
$countR = 0
$countS = 0
$countTotal = 0

ForEach ($item in $services) {
    if($item.Status -eq 'Running') {
        $countR++        
    }
    else {
        $countS++
    }
    $countTotal++

}

Write-Host "Total Services Running" $countR -foregroundColor green
Write-Host "Total Services Stopped" $countS -BackgroundColor red
Write-Host "Total Services" $countTotal