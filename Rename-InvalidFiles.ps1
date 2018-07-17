# Author: Taylor Riley (Tursko)
# http://github.com/Tursko

Param (
    $path = 'C:\Users\t\Desktop\DateData'
    )
Write-Host "Indexing $path" -ForegroundColor Blue
$fileListMain = Get-ChildItem -Path $path -Recurse 

#100% functional!
# This function takes a list of files
# And will ONLY rename files, FOLDERS ARE EXCLUDED. 
function RenameFilesOnly($fileList) {
    Write-Host "Renaming Files Only...." -ForegroundColor Green
    Write-Host "Searching dir:" $path
    ForEach ($fileName in $fileList) {
        if($fileName.Attributes -match 'Directory') { # Avoiding directories
            continue
        }else {
            if($fileName.Name[0] -ne '.') { # Avoiding certain hidden files
                $fixedName = $fileName.Name
                # Below are the fields we are correcting
                $fixedName = $fixedName.Replace("#","Nos")
                $fixedName = $fixedName.Replace("~","")
                $fixedName = $fixedName.Replace("&"," and ")
                $fixedName = $fixedName.Replace("{","")
                $fixedName = $fixedName.Replace("}","")
                $fixedName = $fixedName.Replace("%","")
                $fixedname = $fixedName -replace '([0-9][0-9])\.([0-9][0-9])\.([0-9][0-9])', '$1-$2-$3'
                $fixedname = $fixedName -replace '([0-9])\.([0-9][0-9])\.([0-9][0-9])', '0$1-$2-$3'
                $fixedname = $fixedName -replace '([0-9])\.([0-9])\.([0-9][0-9])', '0$1-0$2-$3'
                #Now renaming the file
                Rename-Item -LiteralPath $fileName.FullName $fixedName
           
            }
        }
    }
    Write-Host "File Renaming Complete!" -ForegroundColor Green
}

####################################CALL FUNCTIONS HERE#################################
RenameFilesOnly($fileListMain)
########################################################################################
