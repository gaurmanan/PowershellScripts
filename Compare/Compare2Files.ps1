Write-Host "This script compares 2 files." -Foregroundcolor Yellow

$path1 = Read-Host "Input for the first file"
$path2 = Read-Host "Input for the second file"

$st1 = Test-Path $path1 -PathType Leaf
$st2 = Test-Path $path2 -PathType Leaf

if(-not $st1)
{
    Write-Host "$path1 is not a file." -Foregroundcolor Red
}

if(-not $st2)
{
    Write-Host "$path2 is not a file." -Foregroundcolor Red
}

if(($st1) -and ($st2))
{
    $hash1 = (Get-FileHash -Path $path1 -Algorithm MD5).hash
    $hash2 = (Get-FileHash -Path $path2 -Algorithm MD5).hash
    if($hash1 -ne $hash2)
    {
        Write-Host "The two files are different." -Foregroundcolor Magenta
    }
    else
    {
        Write-Host "Files are same." -Foregroundcolor Green
    }
}

Read-Host "Press enter key to exit"