#Name of the service we want to kill and restart
#change this to whatever servicename you want. 
#Please check the service name by typing 'Get-Service' on your own Powershell instance
Param(
    [string]$serviceName = 'AudioSrv'
)

$services = Get-Service
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
            Write-Host "The service" $item "did not STOP, do you have the correct permissions?" -ForegroundColor red
        }
        $count++
        break
    }
}
if ($count -eq 0) {
    Write-Host $serviceName "was not running"
}

pause
