Param (
    #$path = 'Z:\BL'
    $path = '\\x\data\BL'
    )
#$fileNames = Get-ChildItem -Path $scriptPath -Recurse
Write-Host "Indexing $path" -ForegroundColor Blue
$fileListMain = Get-ChildItem -Path $path -Recurse 

#This function takes a list of files
#And will rename all files & folders
function RenameAll($fileList) {
    Write-Host "Renaming All Files...." -ForegroundColor Green
    Write-Host "Searching dir:" $path
    ForEach ($fileName in $fileList) {
         if($fileName.Name[0] -ne ".") {
            Write-Host $fixedName;
            $fixedName = $fileName.Name

            $fixedName = $fixedName.Replace("#","Nos")

            $fixedName = $fixedName.Replace("~","")
            $fixedName = $fixedName.Replace("&"," and ")
            $fixedName = $fixedName.Replace("{","")
            $fixedName = $fixedName.Replace("}","")
            $fixedName = $fixedName.Replace("%","")
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

                $fixedName = $fixedName.Replace("#","Nos")
                $fixedName = $fixedName.Replace("~","")
                $fixedName = $fixedName.Replace("&"," and ")
                $fixedName = $fixedName.Replace("{","")
                $fixedName = $fixedName.Replace("}","")
                $fixedName = $fixedName.Replace("%","")
                Rename-Item -LiteralPath $fileName.FullName $fixedName
            }
        }
    }
    Write-Host "File Renaming Complete!" -ForegroundColor Green
}

####################################CALL FUNCTIONS HERE#################################
RenameFilesOnly($fileListMain)
#RenameAll($fileListMain)
########################################################################################
