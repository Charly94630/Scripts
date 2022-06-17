@echo off

set /p ip=Ingrese una Ip?:
net use \\%ip%\c$ /user:administrador 
mkdir "\\%ip%\c$\Anydesk"
echo Copiando Archivos
robocopy "\\nb-cnd-it00\share\anydesk " "\\%ip%\c$\Anydesk " /E




wmic /user:administrador /password: /node:%ip% process call create "cmd.exe /c start /WAIT C:\Anydesk\anydeskdeploy.bat"
net use \\%ip%\c$ /d /y>nul 2>&1

pause
