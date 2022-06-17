@echo off

set /p ip=Ingrese una Ip?:
net use \\%ip%\c$ /user:administrador T4t4nk4m0n!2020
mkdir "\\%ip%\c$\VNC"
echo Copiando Archivos
robocopy "\\nb-cnd-it00\share\VNC " "\\%ip%\c$\VNC " /E




wmic /user:administrador /password:T4t4nk4m0n!2020 /node:%ip% process call create "cmd.exe /c start /WAIT C:\VNC\vncinstall.bat"
net use \\%ip%\c$ /d /y>nul 2>&1

pause