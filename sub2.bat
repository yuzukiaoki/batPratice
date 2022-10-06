SET target=%1%

powershell.exe -File deploy.ps1 "%target%\dist" "%target%\WebAPI"