Title VNC Deploy
@echo off
mkdir c:\uvnc
robocopy "\\9.39.252.55\Compartir\IT\Herramientas\Basico pc\uvnc " "C:\uvnc\ "
mkdir "C:\program Files\uvnc bvba\UltraVNC"
pushd c:\uvnc
copy ultravnc.ini "C:\program files\uvnc bvba\UltraVNC\ultravnc.ini"
UltraVNC_1_3_42_X64_Setup /loadinf=silent.inf /silent /log
pushd C:\Program Files\uvnc bvba\UltraVNC
winvnc.exe

exit