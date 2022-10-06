set folder_name1="folder1"
set folder_name2="folder2"

if Not exist %folder_name1% (
GOTO :error
) else if Not exist %folder_name2% (
GOTO :error2
)





:error
echo 請建立 %folder_name1% 資料夾並將前端檔案放進於此
pause
exit

:error2
echo 請建立 %folder_name2% 資料夾並將後端檔案放進於此
pause
exit