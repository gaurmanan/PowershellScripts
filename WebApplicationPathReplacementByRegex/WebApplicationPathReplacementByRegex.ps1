#path to change
$path = Read-Host "Input current path"
$pathReplace = Read-Host "Input path to replace"

$appsInIIS= Get-WebApplication -Site "Default Web Site"
foreach($item in $appsInIIS){
    $pp = $item.PhysicalPath #path
    $site = ($item.path -split '/')[0] #site
    if($site.trim() -eq ''){$site = "Default Web Site"}
    $name = ($item.path -split '/')[1] #name
    $pool = $item.applicationPool #pool
    if($pp -match [regex]::Escape($path)){
        echo "Name: $name"
        echo "old path: $pp"
        $newpath = $pp -replace [regex]::Escape($path),$pathReplace
        if(Test-Path $newpath){
            echo "New Path: $newpath"
            Remove-WebApplication -Name $name -Site $site
            New-WebApplication -Name $name -Site $site -PhysicalPath $newpath -ApplicationPool $pool
        }
        else
        {
            Write-Host "The new path $newpath does not exist" -ForegroundColor Red
        }
    }
}