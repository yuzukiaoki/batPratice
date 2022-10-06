param([string]$frontend, [string]$backend)
[string]$iis = "C:\inetpub\wwwroot"
[string]$frontend_name = "dist"
[string]$backend_name = "WebAPI"


if ($backend -eq "")
{

    [string]$frontend = Read-Host -Prompt "Enter frontend path"
    [string]$backend = Read-Host -Prompt "Enter backend path"
}

try
{
    Get-Item $frontend -ErrorAction Stop
    Get-Item $backend -ErrorAction Stop
    Get-Item $iis -ErrorAction Stop

    xcopy /i /e /y /q $frontend "C:\inetpub\wwwroot\$frontend_name"
    xcopy /i /e /y /q $backend "C:\inetpub\wwwroot\$backend_name"
}
catch
{
    Write-Output "path not exist"
    Write-Output "---------------------------------------------------"
    Write-Output $_
}
ConvertTo-WebApplication -PSPath "IIS:\Sites\Default Web Site\$frontend_name"
ConvertTo-WebApplication -PSPath "IIS:\Sites\Default Web Site\$backend_name"

