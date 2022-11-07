''>file.txt
$basefolder = read-host 'Input base folder path: '
$pattern = read-host 'Input the file pattern you are looking for: '


foreach ($i in (Get-ChildItem -Path $basefolder -Recurse -Include ('*'+$pattern+'*') -File))
{
        ""+$i.FullName >> file.txt
}