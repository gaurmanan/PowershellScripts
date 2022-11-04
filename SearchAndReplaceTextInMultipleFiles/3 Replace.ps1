$value1 = read-host 'Input the string you wish to replace: '
$value2 = read-host 'Input the replacement sting: '

$content = Get-Content ".\file.txt"
foreach ($i in $content)
{
    if($i.Trim() -ne ''){
    if(Test-Path -Path $i -PathType leaf){
	    ((Get-Content -path $i -Raw) -replace $value1,$value2|Set-Content -Path $i -force)
    }}
}