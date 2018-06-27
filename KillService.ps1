#Name of the service we want to kill and restart

$serviceName = "AudioSrv" #change this to whatever servicename you want. 
#Please check the service name by typing 'Get-Service' on your own Powershell instance

$services = Get-Service
$count = 0

ForEach ($item in $services) {
    if($item.Name -eq $serviceName) {
        Write-Host $serviceName "process has been FOUND" -ForegroundColor green

        Stop-Service -Name $serviceName

        #Restart-Service
        if($item.Status -eq "Stopped") {
            Write-Host $serviceName "process has been STOPPED" -ForegroundColor Red
            
            Start-Service $serviceName

            ForEach ($item1 in $services) {
                if($item1.Name -eq $serviceName) {
                    if($item1.Status -eq "Running") {
                        Write-Host $serviceName "has STARTED" -ForegroundColor green
                    }
                }
            }

        } else {
            Write-Host "The service" $serviceName "did not STOP, do you have the correct permissions?" -ForegroundColor red
        }
        $count++
        break
    }
}
if ($count -eq 0) {
    Write-Host $serviceName "was not running"
}

pause
