Title Forticlient Deploy
echo off
mkdir c:\forticlient
pushd c:\forticlient
robocopy "\\9.39.252.55\Compartir\IT\Herramientas\Basico pc\forti " "C:\forticlient\ "
FortiClient.msi /quiet /norestart INSTALLLEVEL=3
pushd "C:\Program Files (x86)\Fortinet\FortiClient\"
start "" Forticlient.exe
fcconfig -m vpn -f "c:\forticlient\settings.conf" -o importvpn -i 1

exit