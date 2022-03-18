Title AnyDesk Deploy
@echo off
pushd c:\
anydesk.exe --install  “C:\Program Files (x86)\AnyDesk” --start-with-win --create-desktop-icon
echo Fly.4102 | anydesk.exe --set-password
