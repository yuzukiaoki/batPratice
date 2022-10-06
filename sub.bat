@echo OFF

SET target=%1%
SET PathToDevOpsFolder=\\192.168.10.223\DrIP Share(G)\DevOps
rem \\192.168.10.223\DrIP Share(G)\DevOps
SET RemoteLoginAccount=%2%
rem Win2016-New\administrator
SET RemoteLoginPassword=%3%
rem P@ssw0rd
SET RemoteServerIP=%4%
rem 192.168.30.33

IF "%4%"=="" (
    GOTO :InputProcess
) ELSE (
    GOTO :MainProcess
)

:InputProcess
SET /p target=target path:
SET /p PathToDevOpsFolder=Path to DevOps Folder:
SET /p RemoteLoginAccount=Remote Login Account:
SET /p RemoteLoginPassword=Remote Login Password:
SET /p RemoteServerIP=Remote Server IP:

:MainProcess
"%PathToDevOpsFolder%\PSTools\PsExec.exe" \\%RemoteServerIP% -accepteula -u %RemoteLoginAccount% -i -p %RemoteLoginPassword% "XCOPY" /I /E /Y /Q %target% "C:\Deploy"
"%PathToDevOpsFolder%\PSTools\PsExec.exe" \\%RemoteServerIP% -accepteula -u %RemoteLoginAccount% -i -p %RemoteLoginPassword% "C:\Deploy\powershell.exe" -File "C:\Deploy\deploy.ps1" "C:\Deploy\dist" "C:\Deploy\DripWebAPI"