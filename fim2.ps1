

Write-Host ""
Write-Host "What would you like to do?"
Write-Host "A) Collect new Baseline?"
Write-Host "B) Begin monitoring files with saved Baseline?"

$response = Read-Host -Prompt "Please enter 'A' or 'B' "
Write-Host ""

Function Calculate-File-Hash($filepath) {
    $filehash = Get-FileHash -Path $filepath -Algorithm SHA512
    return $filehash
}

Function Erase-Baseline() {
    $baselineExists = Test-Path -Path .\Desktop\baseline.txt
    if ($baselineExists) {
    #Delete it
    Remove-Item -Path .\Desktop\baseline.txt
    }
}


if ($response -eq "A".ToUpper()) {
    #Calculate Hash from the target files and store in baseline.txt
   Erase-Baseline
    #Collect all files in the target folder
    $files = Get-ChildItem -Path .\Desktop\fim
    
    #For each file, calculate the hash and write to baseline.txt
    foreach ($f in $files) {
    $hash = Calculate-File-Hash $f.FullName
    "$($hash.Path)|$($hash.Hash)" | Out-File -FilePath .\Desktop\baseline.txt -Append
    }
}
elseif ($response -eq "B".ToUpper()) {

    $fileHashDictionary = @{}

    #Load file|hash from baseline.txt and store them in a dictionary
    $filePathsandHashes = Get-Content -Path .\Desktop\baseline.txt
   
    foreach ($f in $filePathsandHashes) {
        $fileHashDictionary.add($f.Split("|")[0],$f.Split("|")[1])
    }

   
    $fileHashDictionary

    #Begin (continuously) monitoring files with saved Baseline
    while ($true) {
        Start-Sleep -Seconds 1

        $files = Get-ChildItem -Path .\Desktop\fim
    
        #For each file, calculate the hash and write to baseline.txt
        foreach ($f in $files) {
            $hash = Calculate-File-Hash $f.FullName
            #"$($hash.Path)|$($hash.Hash)" | Out-File -FilePath .\Desktop\baseline.txt -Append

            #Notify if a new file has been created
            if ($fileHashDictionary[$hash.Path] -eq $null) {
                #A new file has been created!
                Write-Host "$($hash.Path) has been created!" -ForegroundColor Green
     }
     else{
           
            #Notify if a new file has been changed
            if ($fileHashDictionary[$hash.Path] -eq $hash.Hash) {
            #The file has not changed
            }
            else {
            Write-Host "$($hash.Path) has changed!!!" -ForegroundColor Red
            }
     }
     
    


    }

         foreach ($key in $fileHashDictionary.Keys) {
        $baselineFileStillExists = Test-Path -Path $key
        if (-Not $baselineFileStillExists) {
        #One of the baseline files has been deleted, notify the user
        Write-Host "$($key) has been deleted" -ForegroundColor Yellow

        }
     }
  }
}