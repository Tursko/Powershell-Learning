# $serviceName holds the name of the service you want to restart
# To get the name of the service you can run the command below
#   (This is just an example, and it will show the full service name)
#   Get-Service -Name Audio* | ForEach { $_.Name } 
# You can also run it and enter the service name
# From Powershell you can go to the dir you saved the script in and type something like
#    .\Restart-Service nameOfYourServiceHere
#    *example* .\Restart-Service AudioSrv

Param(
    [string]$serviceName = 'AudioSrv'
)

$services = GetNervice
$count = 0

ForEach ($item in $services) {
    if($item.Name -eq $serviceName) {
        Write-Host $serviceName "process has been FOUND" -ForegroundColor green

        if($item.Status -eq "Running") {
            Write-Host $item "process is currently RUNNING"
            Stop-Service $item
        }
        if($item.Status -eq "Stopped") { #I check this regardless
            Write-Host $item "process has been STOPPED" -ForegroundColor Red
            
            Start-Service $item

            ForEach ($item1 in $services) {
                if($item1.Name -eq $serviceName) {
                    if($item1.Status -eq "Running") {
                        Write-Host $item "has STARTED" -ForegroundColor green
                    }
                }
            }

        } else {
            Write-Host "The service" $item "did not STOP, are you running the script as an Admin?" -ForegroundColor red
        }
        $count++
        break
    }
}
if ($count -eq 0) {
    Write-Host $serviceName "was not running"
}

pause
