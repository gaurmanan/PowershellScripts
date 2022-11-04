
$backupfolder = read-host 'Input folder path where you need to take backup: '
$basefolder = read-host 'Input base folder path: '

$content = Get-Content ".\file.txt"
''>BackupLog.txt
foreach ($i in $content)
{
    if($i -ne ''){
	$j = $i -replace [regex]::Escape($basefolder),$backupfolder 
    "Base: "+$i>>BackupLog.txt
    "Backup: "+$j>>BackupLog.txt
    $path = Split-Path -Path $j
    if(-not (Test-Path $path)) {New-Item $path -ItemType Directory}
    Copy-Item -path $i -Destination $j -force}
}