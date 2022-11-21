Write-Host "This script returns all directories and files with checksum in a given parent directory." -Foregroundcolor Yellow

if(Test-Path ".\CompareResult.txt" -PathType Leaf){Remove-Item ".\CompareResult.txt" -Force}

$path1 = Read-Host "Input basepath for the first folder"

if(Test-Path $path1 -PathType Container)
{
    Write-Host "Comparing..." -Foregroundcolor Red
    
    $path1Length = $path1.Length
    
    if($path1[$path1.Length-1] -ne "\")
    {
        $path1 += "\"
    }
    
    $path1Length = $path1.Length
    
    $directories1 = (Get-ChildItem -path $path1 -Recurse -Directory).FullName
    
    $files1 = (Get-ChildItem -path $path1 -Recurse -File).FullName
    
    "Folders list:
    ======================================================================" >> ".\CompareResult.txt"
    foreach($directory in $directories1)
    {
        $directory.Substring($path2Length,$directory.Length-$path1Length) >> ".\CompareResult.txt"
    }
    
    "
    
    Files with MD5 checksum:
    ======================================================================" >> ".\CompareResult.txt"
    foreach($file in $files1)
    {
        $file.Substring($path2Length,$file.Length-$path1Length) +':'+ (Get-FileHash -Path $file -Algorithm MD5).hash >> ".\CompareResult.txt"
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