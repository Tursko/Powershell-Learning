#Author: Taylor Riley (Tursko)
#http://github.com/Tursko

Param (
    $path = 'C:\Users\t\Desktop\DateData'
    )
Write-Host "Indexing $path" -ForegroundColor Blue
$fileListMain = Get-ChildItem -Path $path -Recurse 

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
        }else {
            if($fileName.Name[0] -ne '.') {
                $fixedName = $fileName.Name

                $fixedName = $fixedName.Replace("#","Nos")
                $fixedName = $fixedName.Replace("~","")
                $fixedName = $fixedName.Replace("&"," and ")
                $fixedName = $fixedName.Replace("{","")
                $fixedName = $fixedName.Replace("}","")
                $fixedName = $fixedName.Replace("%","")
                $fixedname = $fixedName -replace '([0-9][0-9])\.([0-9][0-9])\.([0-9][0-9])', '$1-$2-$3'
                $fixedname = $fixedName -replace '([0-9])\.([0-9][0-9])\.([0-9][0-9])', '0$1-$2-$3'
                $fixedname = $fixedName -replace '([0-9])\.([0-9])\.([0-9][0-9])', '0$1-0$2-$3'
                Rename-Item -LiteralPath $fileName.FullName $fixedName
           
            }
        }
    }
    Write-Host "File Renaming Complete!" -ForegroundColor Green
}

####################################CALL FUNCTIONS HERE#################################
RenameFilesOnly($fileListMain)
########################################################################################
