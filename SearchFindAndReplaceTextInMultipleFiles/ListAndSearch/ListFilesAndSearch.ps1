''>file.txt
$basefolder = read-host 'Input base folder path: '
$pattern = read-host 'Input the file pattern you are looking for: '
$value1 = read-host "Please input the string you are trying to search: "


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
        '=====================================================================================' >> SearchedLog.txt
        ''+$number+'. Path:'+$i >> SearchedLog.txt
        'Total Replacements: '+$count >> SearchedLog.txt
        'Changes: ' >> SearchedLog.txt
        $matches >> SearchedLog.txt
        }
    }}
}

'Total Occourances: '+$number > SearchLog.txt