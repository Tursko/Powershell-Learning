Param (
    $path = 'C:\Users\triley\Desktop\BL Files'
    )
#$fileNames = Get-ChildItem -Path $scriptPath -Recurse
$fileListMain = Get-ChildItem -Path $path -Recurse 

####################################CALL FUNCTIONS HERE#################################
RenameFilesOnly($fileListMain)
#RenameAll($fileListMain)
########################################################################################

#This function takes a list of files
#And will rename all files & folders
function RenameAll($fileList) {
    Write-Host "Renaming All Files...." -ForegroundColor Green
    Write-Host "Searching dir:" $path
    ForEach ($fileName in $fileList) {
         if($fileName.Name[0] -ne ".") {
            $fixedName = $fileName.Name

            $fixedName = $fixedName.Replace("#","")
            $fixedName = $fixedName.Replace("%","")
            #Write-Host $fileName.FullName
            Rename-Item -LiteralPath $fileName.FullName $fixedName

        }
    }
    Write-Host "File Renaming Complete!" -ForegroundColor Green
}

#100% functional!
#This function takes a list of files
#And will only rename files, folders will be excluded.
function RenameFilesOnly($fileList) {
    Write-Host "Renaming Files Only...." -ForegroundColor Green
    Write-Host "Searching dir:" $path
    ForEach ($fileName in $fileList) {
        #We don't care about the actual file names. 
        if($fileName.Attributes -match 'Directory') {
            continue
        }
        else {
            if($fileName.Name[0] -ne '.') {
                $fixedName = $fileName.Name

                $fixedName = $fixedName.Replace("#","")
                $fixedName = $fixedName.Replace("%","")
                Rename-Item -LiteralPath $fileName.FullName $fixedName
            }
        }
    }
    Write-Host "File Renaming Complete!" -ForegroundColor Green
}