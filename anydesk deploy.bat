Title Anydesk Deploy
@echo off
xcopy "\\9.39.252.55\Compartir\IT\Herramientas\Basico pc\AnyDesk\" "c:\ "
pushd c:\
start AnyDeskdeploy.bat
exit