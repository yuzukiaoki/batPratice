@echo OFF
rem change to UTF-8
rem chcp 65001
SET SVN_VERSION=%6%

SET ENV_FILE=frontend\.env
SET ENV_KEY="VUE_APP_SVN_VERSION" "VUE_APP_API_PATH_PREFIX"
SET ENV_VALUE="'%SVN_VERSION%'" "'../WebAPI/api/'"

SET DB_IP=%2%
SET DB_name=%3%
SET DBLoginAccount=%4%
SET DBLoginPassword=%5%
SET PATH_web=backend\DripWebAPI\Web.config
SET target=%1%

rem 當target路徑包含空白且 拿來做判斷會有問題 故與SVN版本互換
IF "%6%"=="" (
    GOTO :InputProcess
) ELSE (
    GOTO :MainProcess
)

:InputProcess
SET /p SVN_VERSION=請輸入SVN VERSION:

SET ENV_FILE=frontend\.env
SET ENV_KEY="VUE_APP_SVN_VERSION" "VUE_APP_API_PATH_PREFIX"
SET ENV_VALUE="'%SVN_VERSION%'" "'../WebAPI/api/'"

SET /p DB_IP=請輸入資料庫IP:
SET /p DB_name=請輸入資料庫名稱:
SET /p DBLoginAccount=請輸入資料庫帳號:
SET /p DBLoginPassword=請輸入資料庫密碼:
SET PATH_web=backend\DripWebAPI\Web.config
SET "target=..\release"
SET /p target=請輸入存放路徑:


:MainProcess

SET folder_name1="frontend"
SET folder_name2="backend"
SET replace_file="replace.exe"
SET xml_file="change_xml_file.exe"
SET shell_file="power.ps1"

rem check file exist
if Not exist %folder_name1% (
    GOTO :error
) else if Not exist %folder_name2% (
    GOTO :error2
) else if Not exist %replace_file% (
    GOTO :error3
) else if Not exist %xml_file% (
    GOTO :error4
) else if Not exist %shell_file% (
    GOTO :error5
)

rem  excute replace.exe、change .env file content
"replace.exe" -f "%ENV_FILE%" -k %ENV_KEY% -v %ENV_VALUE%

rem excute change_xml_file.exe、change web.config content
"change_xml_file.exe" "%PATH_web%" %DB_IP% %DB_name% %DBLoginAccount% %DBLoginPassword%

rem excute power.ps1、npm build
cd frontend
powershell -File ..\power.ps1

rem build backend
cd %~dp0
"nuget.exe" restore "backend\WebAPI.sln"
call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\Common7\Tools\VsDevCmd.bat"
"MSBuild.exe" "backend\WebAPI.sln"

rem copy result to dest
XCOPY /I /E /Y /Q backend\WebAPI %target%\WebAPI
XCOPY /I /E /Y /Q frontend\dist %target%\dist

pause
exit

:error
echo 請建立 %folder_name1% 資料夾並將前端檔案放進於此
pause
exit

:error2
echo 請建立 %folder_name2% 資料夾並將後端檔案放進於此
pause
exit

:error3
echo 請將 %replace_file% 放置於當前資料夾
pause
exit

:error4
echo 請將 %xml_file% 放置於當前資料夾
pause
exit

:error5
echo 請將 %shell_file% 放置於當前資料夾
pause
exit