@echo off	

if not exist "C:\Program Files\Wavelink\Velocity\Velocity.exe" (


mkdir C:\Velocity
robocopy "\\NB-CND-IT00\share\velocity " "C:\Velocity " /E

cd c:\Velocity\PDA-Simulador-TATA-VelocityClient-v.1.2

velocity_client_2.1.18.msi /quiet

mkdir c:\ProgramData\Wavelink
robocopy c:\Velocity\Wavelink C:\ProgramData\Wavelink /E

del "c:\users\public\desktop\Velocity.lnk" /q

copy c:\velocity\velocity.bat.lnk c:\users\public\desktop\ /y

)ELSE (

echo Velocity ya existe

exit
)


