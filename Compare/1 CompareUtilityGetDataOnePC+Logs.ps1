Write-Host "This script returns folder list and file list along with checksum within a base folder." -Foregroundcolor Yellow

if(Test-Path ".\CompareResult.txt" -PathType Leaf){Remove-Item ".\CompareResult.txt" -Force}

$path1 = Read-Host "Input basepath for folder"

if(Test-Path $path1 -PathType Container)
{
    Write-Host "Processing..." -Foregroundcolor Red
    
    $path1Length = $path1.Length
    
    if($path1[$path1.Length-1] -ne "\")
    {
        $path1 += "\"
    }
    
    $path1Length = $path1.Length
    
    $directories1 = (Get-ChildItem -path $path1 -Recurse -Directory -Force).FullName
    $dno = $directories1.Length
    
    $files1 = (Get-ChildItem -path $path1 -Recurse -File -Force).FullName
    $fno = $files1.Length
    
    $count = 0
"Folders list:
======================================================================" >> ".\CompareResult.txt"
    foreach($directory in $directories1)
    {
        $count++
        $directory.Substring($path1Length,$directory.Length-$path1Length) >> ".\CompareResult.txt"
        $string = '('+$count+'/'+$dno+')'+$directory.Substring($path1Length,$directory.Length-$path1Length)
        echo $string
    }
    Write-Host "folders are done." -ForegroundColor Green
        $count = 0
"

Files with MD5 checksum:
======================================================================" >> ".\CompareResult.txt"
    foreach($file in $files1)
    {
        $count++
        $string  = $file.Substring($path1Length,$file.Length-$path1Length) +':'+ (Get-FileHash -Path $file -Algorithm MD5).hash
        $string >> ".\CompareResult.txt"
        $string = '('+$count+'/'+$fno+')'+$string
        echo $string
    }
    Write-Host "Done." -Foregroundcolor Green
}
else
{
    if(-not (Test-Path $path1 -PathType Container) )
    {
        Write-Host "$path1 is not a directory." -ForegroundColor Red
    }
}
Read-Host "Press enter key to exit"