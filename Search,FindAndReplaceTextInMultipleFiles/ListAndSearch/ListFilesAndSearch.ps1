''>file.txt
$basefolder = read-host 'Input base folder path: '
$pattern = read-host 'Input the file pattern you are looking for: '


foreach ($i in (Get-ChildItem -Path $basefolder -Recurse -Include ('*'+$pattern+'*') -File))
{
        ""+$i.FullName >> file.txt
}

$content = Get-Content ".\file.txt"
'' > Occourance.txt
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

'Total Occourances: '+$number > SearchLog.txt