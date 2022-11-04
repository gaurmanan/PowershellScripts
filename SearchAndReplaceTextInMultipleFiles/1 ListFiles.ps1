''>file.txt
$basefolder = read-host 'Input base folder path: '
$pattern = read-host 'Input the file pattern you are looking for: '


foreach ($i in (Get-ChildItem -Path $basefolder -Recurse))
{
	if ($i.Name -match $pattern)
	{
		""+$i.FullName >> file.txt
	}
}