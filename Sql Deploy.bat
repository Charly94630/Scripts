@echo off
reg Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > NUL && set OS=32BIT || set OS=64BIT
set /p local=Ingrese numero de local(eje:0158):
FOR /F "usebackq" %%i IN (`hostname`) DO SET hostname=%%i
echo Instalando Sistemas de Citekn en %hostname%
if %OS%==32BIT (
	echo Utilizo instaladores de 32bits
	echo Instalando .NET FRAMEWORK
	"Parte 1\dotNetFx40_Full_x86_x64"
	echo Instalando SQLSERVER
	"Parte 1\SQLEXPR_x86_ESN.exe" /q /ACTION=Install /FEATURES=SQL,Tools /INSTANCENAME=SQLTA_TA /SQLSYSADMINACCOUNTS="Builtin\Administrators" /SQLSVCACCOUNT="NT AUTHORITY\SYSTEM" /SECURITYMODE=SQL /SAPWD="***" /IAcceptSQLServerLicenseTerms=TRUE
	)
if %OS%==64BIT (
	echo Utilizo instaladores de 64bits
	"Parte 1\SQLEXPR_x64_ESN" /q /ACTION=Install /FEATURES=SQL,Tools /INSTANCENAME=SQLM_AHORRO /SQLSYSADMINACCOUNTS="Builtin\Administrators" /SQLSVCACCOUNT="NT AUTHORITY\SYSTEM" /SECURITYMODE=SQL /SAPWD="****" /IAcceptSQLServerLicenseTerms=TRUE	
	)

echo Instalando Mnet
msiexec  /i "Parte 1\INSTALADOR MNET\Programa Manager.msi" /q
echo Instalando SLINKNET
msiexec  /i "Parte 1\INSTALADOR SLINKED-NET\InstaladorSlinkedIN.msi" /q
echo Actualizando SLINKNET
copy "Parte 2\*.*" C:\ISHIDA\SLinkedNET /y
echo Actualizando MNET 1
xcopy "Parte 3" C:\ISHIDA\MNET /e /h /c /i /y
copy "Parte 4\*.*" C:\ISHIDA /y
rem echo Configurando Configuracion.dat
rem type C:\ISHIDA\Configuracion.dat | powershell -Command "$input | ForEach-Object { $_ -replace \"PC-L164-GES\", \"%hostname%\" }" > temp.txt
rem move temp.txt C:\ISHIDA\Configuracion.dat
rem type C:\ISHIDA\Configuracion.dat | powershell -Command "$input | ForEach-Object { $_ -replace \"0064\", \"%local%\" }" > temp.txt
rem move temp.txt C:\ISHIDA\Configuracion.dat
rem echo Configurando loca.dat
rem type C:\ISHIDA\SLinkedNET\local.dat | powershell -Command "$input | ForEach-Object { $_ -replace \"0064\", \"%local%\" }" > temp.txt
rem move temp.txt C:\ISHIDA\SLinkedNET\local.dat

pause