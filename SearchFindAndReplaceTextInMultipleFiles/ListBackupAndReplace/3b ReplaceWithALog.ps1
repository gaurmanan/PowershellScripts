$value1 = read-host 'Input the string you wish to replace: '
$value2 = read-host 'Input the replacement sting: '

$content = Get-Content ".\file.txt"
'' > ReplacementLog.txt
$number = 0
foreach ($i in $content)
{
    if($i.Trim() -ne ''){
    if(Test-Path -Path $i -PathType leaf){
        $matches = Select-String $i -pattern $value1
        $count = $matches.length
        if($count -gt 0){
        $number = $number+1
	    ((Get-Content -path $i -Raw) -replace $value1,$value2|Set-Content -Path $i -force)
        '=====================================================================================' >> ReplacementLog.txt
        ''+$number+'. Path:'+$i >> ReplacementLog.txt
        'Total Replacements: '+$count >> ReplacementLog.txt
        'Changes: ' >> ReplacementLog.txt
        $matches >> ReplacementLog.txt
        }
    }}
}
'Total Occourances: '+$number > TotalOccurancesLog.txt