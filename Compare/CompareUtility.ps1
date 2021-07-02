Write-Host "This script compares all the files and folders and returns list of differences, if any." -Foregroundcolor Yellow

if(Test-Path ".\CompareResult.txt" -PathType Leaf){Remove-Item ".\CompareResult.txt" -Force}

$path1 = Read-Host "Input basepath for the first folder"
$path2 = Read-Host "Input basepath for the second folder"

Write-Host "Comparing..." -Foregroundcolor Red

$path1Length = $path1.Length
$path2Length = $path2.Length

if($path1[$path1.Length-1] -ne "\")
{
    $path1 += "\"
}

if($path2[$path2.Length-1] -ne "\")
{
    $path2 += "\"
}

$path1Length = $path1.Length
$path2Length = $path2.Length

$directories1 = (Get-ChildItem -path $path1 -Recurse -Directory).FullName
$directories2 = (Get-ChildItem -path $path2 -Recurse -Directory).FullName

$files1 = (Get-ChildItem -path $path1 -Recurse -File).FullName
$files2 = (Get-ChildItem -path $path2 -Recurse -File).FullName

"Folders missing in the second base path.
======================================================================" >> ".\CompareResult.txt"
$count = 0
foreach($directory in $directories1)
{
    $check = $path2+$directory.Substring($path1Length,$directory.Length-$path1Length)
    if(-not ($directories2.Contains($check)))
    {
       " ==== "+$directory+" - "+" <none> "+" ==== " >> ".\CompareResult.txt"
       $count++
    }
}

"

[Total $count differences observed.]

" >> ".\CompareResult.txt"

"

Folders missing in the first base path.
======================================================================" >> ".\CompareResult.txt"
$count = 0
foreach($directory in $directories2)
{
    $check = $path1+$directory.Substring($path2Length,$directory.Length-$path2Length)
    if(-not ($directories1.Contains($check)))
    {
       " ==== "+" <none> "+" - "+$directory+" ==== " >> ".\CompareResult.txt"
       $count++
    }
}

"

[Total $count differences observed.]

" >> ".\CompareResult.txt"

"

Files missing in the second base path.
======================================================================" >> ".\CompareResult.txt"

$compared =""
$comparedCount = 0
$count = 0
foreach($file in $files1)
{
    $check = $path2+$file.Substring($path1Length,$file.Length-$path1Length)
    if($files2.Contains($check))
    {
        $check = $path2+$file.Substring($path1Length,$file.Length-$path1Length)
        if($files2.Contains($check))
        {
            $hash1 = (Get-FileHash -Path $file -Algorithm MD5).hash
            $hash2 = (Get-FileHash -Path $check -Algorithm MD5).hash
            if($hash1 -ne $hash2)
            {
               $compared += " ==== "+"$file"+" - "+$check+" ==== `n"
               $comparedCount++
            }
         }
    }
    else
    {
       " ==== "+$file+" - "+" <none> "+" ==== " >> ".\CompareResult.txt"
       $count++
    }
}

"

[Total $count differences observed.]

" >> ".\CompareResult.txt"

"

Files missing in the first base path.
======================================================================" >> ".\CompareResult.txt"
$count = 0
foreach($file in $files2)
{
    $check = $path1+$file.Substring($path2Length,$file.Length-$path2Length)
    if(-not ($files1.Contains($check)))
    {
       " ==== "+" <none> "+" - "+$file+" ==== " >> ".\CompareResult.txt"
       $count++
    }

}

"

[Total $count differences observed.]

" >> ".\CompareResult.txt"

"

Files which are different.
======================================================================" >> ".\CompareResult.txt"
$compared >> ".\CompareResult.txt"

"

[Total $comparedCount differences observed.]

" >> ".\CompareResult.txt"

Write-Host "Done." -Foregroundcolor Green
Read-Host "Press enter key to exit"