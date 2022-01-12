@echo off

@echo Habilitando usuario Administrador local

@echo off

net user Administrador T4t4nk4m0n!2020 /active:yes


set /p usuario=Ingrese usuario con permisos para acceder a 172.19.19.191:

net use \\172.19.19.191 * /user:%usuario%


cls



Title Instalador desatendido
color 0a
@echo off 
@echo off
@echo ...............................................................
@ECHO Presionar el numero correspondiente al tipo de equipo deseado.
@ECHO ...............................................................

ECHO 1 - Gerencia.
ECHO 2 - Gestion.
ECHO 3 - Informes.
ECHO 4 - Tesoreria.
ECHO 5 - Personal.
ECHO 6 - Basico / ATC.
ECHO 7 - Recepcion.
ECHO 8 - Ingresos.
ECHO 9 - Instalar Drivers de Impresoras
ECHO 10 - VPN

set /p menu=Elija una opcion:
IF %menu%==1 GOTO Gerencia
IF %menu%==2 GOTO Gestion
IF %menu%==3 GOTO Informes
IF %menu%==4 GOTO Tesoreria
IF %menu%==5 GOTO Personal
IF %menu%==6 GOTO ATC
IF %menu%==7 GOTO Recepcion
IF %menu%==8 GOTO Ingresos
IF %menu%==9 GOTO Drivers
IF %menu%==10 GOTO VPN

:Gerencia
@echo Copiando instaladores
@echo ---------------------------------------------------
mkdir "C:\Autoinstalable"
mkdir "C:\drivers"
robocopy "\\172.19.19.191\ShareRusso\Programas\Autoinstalable\instaladoresger" "c:\Autoinstalable" /E
robocopy "\\172.19.19.191\ShareRusso\Programas\Autoinstalable\drivers " "C:\drivers " /E
@echo off Copia finalizada exitosamente
@echo ------------------------------------------------------
@echo -----------------------------------------------------
@echo PuTTY
mkdir "C:\PuTTY"
@echo -----------------------------------------------------
robocopy "\\172.19.19.191\ShareRusso\Programas\PuTTY" "C:\Putty" /E
@echo ------------------------------------------------------
@RHPRO
mkdir "C:\RHPRO"
@echo -----------------------------------------------------
robocopy "\\172.19.19.191\ShareRusso\Programas\Autoinstalable\rhpro" "C:\RHPRO" /E
@echo -----------------------------------------------------
cd c:\
@echo 7zip
@echo -----------------------------------------------------
C:\autoinstalable\7zip.exe /S
@echo -----------------------------------------------------
@echo adobe
@echo -----------------------------------------------------
C:\autoinstalable\adobe.exe /sAll /rs /msi EULA_ACCEPT=YES
@echo -----------------------------------------------------
@echo aio
@echo -----------------------------------------------------
C:\autoinstalable\aio.exe /S
@echo -----------------------------------------------------
@echo antivirus
@echo -----------------------------------------------------
C:\autoinstalable\antivirus
@echo chrome
@echo -----------------------------------------------------
C:\autoinstalable\ChromeSetup.exe /silent /install
@echo -----------------------------------------------------
@echo financials
@echo -----------------------------------------------------
C:\autoinstalable\financials1.exe /S
@echo -----------------------------------------------------
@echo financials 
@echo -----------------------------------------------------
C:\autoinstalable\financials2.exe /S
@echo -----------------------------------------------------
@echo Libreoffice
@echo -----------------------------------------------------
C:\autoinstalable\libreoffice.msi /passive
@echo -----------------------------------------------------
@echo Firefox
@echo -----------------------------------------------------
C:\autoinstalable\firefox.exe /S
@echo -----------------------------------------------------
@echo Classic Shell
@echo -----------------------------------------------------
C:\autoinstalable\inicio.exe /passive
@echo -----------------------------------------------------
@echo Flash
@echo -----------------------------------------------------
C:\autoinstalable\flash.exe /passive
@echo VNC
@echo -----------------------------------------------------
C:\autoinstalable\vnc.exe /silent
cd c:\autoinstalable
reg import vnc.reg
cd c:\Program Files\RealVNC\VNC Server
vnclicense -add M2B74-3BN9A-SKBFH-7HAL8-ENVWA

@echo -----------------------------------------------------
@echo Xming
@echo -----------------------------------------------------
C:\autoinstalable\Xming.exe /S
@echo -----------------------------------------------------
@echo Ocularis
@echo -----------------------------------------------------
C:\autoinstalable\ocularis1.exe /S
@echo -----------------------------------------------------
@echo Codecs
@echo -----------------------------------------------------
C:\autoinstalable\ocularis2.exe /S
@echo Agregando accesos directos
@echo ---------------------------------------------------
robocopy "\\172.19.19.191\ShareRusso\Programas\Autoinstalable\Accesos" "C:\users\public\desktop" /E
@echo -----------------------------------------------------
@echo Accesos agregados correctamente
@echo -----------------------------------------------------
@echo Instalando Drivers de impresora
@echo -----------------------------------------------------
pnputil.exe -a c:\drivers\*.inf 
@echo -----------------------------------------------------
@echo Habilitando SMB1
@echo ----------------------------------------------------
DISM /Online /Enable-Feature /All /FeatureName:SMB1Protocol 
@echo -----------------------------------------------------
@echo Creando regla Firewall de Windows
@echo -----------------------------------------------------
netsh advFirewall Firewall add rule name="Habilitar ICMP en IPv4" protocol=icmpv4:8,any dir=in action=allow
netsh advfirewall firewall add rule name="TCP Port 5900" dir=in action=allow protocol=TCP localport=5900
@echo -----------------------------------------------------
@echo Deshabilitando Windows Update
@echo -----------------------------------------------------
SC CONFIG WUAUSERV START= DISABLED
@echo -----------------------------------------------------
@echo Se realizó la instalación correctamente, el batch procederá a cerrarse.
exit

:Gestion
@echo Copiando instaladores
@echo ---------------------------------------------------
mkdir "C:\Autoinstalable"
mkdir "C:\drivers"
robocopy "\\172.19.19.191\ShareRusso\Programas\Autoinstalable\drivers " "C:\drivers " /E
robocopy "\\172.19.19.191\ShareRusso\Programas\Autoinstalable\instaladoresges" "c:\Autoinstalable" /E
@echo off Copia finalizada exitosamente
@echo ------------------------------------------------------
@echo -----------------------------------------------------
@echo PuTTY
@echo -----------------------------------------------------
mkdir "C:\PuTTY"
@echo -----------------------------------------------------
robocopy "\\172.19.19.191\ShareRusso\Programas\PuTTY" "C:\Putty" /E
@echo -------------------------------------------------------
cd c:\
@echo -----------------------------------------------------
@echo creando carpeta local en c:\
@echo -----------------------------------------------------
mkdir "C:\local"
@echo -----------------------------------------------------
@echo Copiando Ruticola, Printfil y WinqVT a C:\
@echo -----------------------------------------------------
robocopy "\\172.19.19.191\ShareRusso\Programas\Autoinstalable\Gestion" "C: " /E
mkdir C:\Ruticola
robocopy "\\172.19.19.191\ShareRusso\Programas\Ruticola" "C:\Ruticola" /E
@echo -----------------------------------------------------
@echo Copia finalizada exitosamente
@echo -----------------------------------------------------
@echo Cargando Registro Ruticola
@echo ---------------------------------------------------
@echo ---------------------------------------------------
 cd C:\Ruticola\
reg import ruticola.reg
@echo -------------------------------------------------
@echo Registro cargado corretamente
@echo -------------------------------------------------
@echo Printfil
@echo ----------------------------------------------------
C:\autoinstalable\Printfil.exe /DIR="C:\Printfil" /SILENT
C:\autoinstalable\Ta-Ta.pfl  /SILENT
copy C:\autoinstalable\Printfil\Printfil.ini C:\Printfil
@echo ----------------------------------------------------
@echo 7zip
@echo -----------------------------------------------------
C:\autoinstalable\7zip.exe /S
@echo -----------------------------------------------------
@echo adobe
@echo -----------------------------------------------------
C:\autoinstalable\adobe.exe /sAll /rs /msi EULA_ACCEPT=YES
@echo -----------------------------------------------------
@echo aio
@echo -----------------------------------------------------
C:\autoinstalable\aio.exe /S
@echo -----------------------------------------------------
@echo antivirus
@echo -----------------------------------------------------
C:\autoinstalable\antivirus
@echo chrome
@echo -----------------------------------------------------
C:\autoinstalable\ChromeSetup.exe /silent /install
@echo -----------------------------------------------------
@echo Libreoffice
@echo -----------------------------------------------------
C:\autoinstalable\libreoffice.msi /passive
@echo -----------------------------------------------------
@echo Firefox
@echo -----------------------------------------------------
C:\autoinstalable\firefox.exe /S
@echo -----------------------------------------------------
@echo Classic Shell
@echo -----------------------------------------------------
C:\autoinstalable\inicio.exe /passive
@echo -----------------------------------------------------
@echo Flash
@echo -----------------------------------------------------
C:\autoinstalable\flash.exe /passive
@echo VNC
@echo -----------------------------------------------------
C:\autoinstalable\vnc.exe /silent
cd c:\autoinstalable
reg import vnc.reg

cd c:\Program Files\RealVNC\VNC Server

vnclicense -add M2B74-3BN9A-SKBFH-7HAL8-ENVWA

@echo -----------------------------------------------------
@echo Xming
@echo -----------------------------------------------------
C:\autoinstalable\Xming.exe /silent
@echo -----------------------------------------------------
@echo Cargando DLL
@echo -----------------------------------------------------
regsvr32 C:\Ruticola\TABCTL32.OCX
regsvr32 C:\Ruticola\comctl32.ocx
@echo -----------------------------------------------------
@echo Agregando accesos directos
@echo ----------------------------------------------------
robocopy "\\172.19.19.191\ShareRusso\Programas\Autoinstalable\accesos2" "C:\users\public\desktop" /E
@echo -----------------------------------------------------
@echo Accesos agregados exitosamente
@echo -----------------------------------------------------
@echo -----------------------------------------------------
@echo Instalando Drivers de impresora
@echo -----------------------------------------------------
pnputil.exe -a c:\drivers\*.inf 
@echo -----------------------------------------------------
@echo Habilitando SMB1
@echo ----------------------------------------------------
DISM /Online /Enable-Feature /All /FeatureName:SMB1Protocol 
@echo -----------------------------------------------------
@echo Creando regla Firewall de Windows
@echo -----------------------------------------------------
netsh advFirewall Firewall add rule name="Habilitar ICMP en IPv4" protocol=icmpv4:8,any dir=in action=allow
netsh advfirewall firewall add rule name="TCP Port 5900" dir=in action=allow protocol=TCP localport=5900
@echo -----------------------------------------------------
@echo Deshabilitando Windows Update
@echo -----------------------------------------------------
SC CONFIG WUAUSERV START= DISABLED
@echo -----------------------------------------------------
@echo Se realizó la instalación correctamente, el batch procederá a cerrarse.
exit

:Informes
@echo Copiando instaladores
@echo ---------------------------------------------------
mkdir "C:\Autoinstalable"
mkdir "C:\drivers"
robocopy "\\172.19.19.191\ShareRusso\Programas\Autoinstalable\drivers " "C:\drivers " /E
robocopy "\\172.19.19.191\ShareRusso\Programas\Autoinstalable\instaladoresinf" "c:\Autoinstalable" /E
@echo ---------------------------------------------------
@echo Copiando Drivers a C:\drivers
@echo ---------------------------------------------------
@echo ---------------------------------------------------
robocopy "\\172.19.19.191\ShareRusso\Programas\Autoinstalable\drivers " "C:\drivers " /E
@echo ----------------------------------------------------
@echo off Copia finalizada exitosamente
@echo ------------------------------------------------------
@echo -----------------------------------------------------
cd c:\
@echo Creando directorio Informes en C:\
@echo -----------------------------------------------------
mkdir "C:\Informes"
@echo Copiando Tickets/Envases y Encomienda Facil a C:\Informes
@echo --------------------------------------------------------
robocopy "\\172.19.19.191\ShareRusso\Programas\Autoinstalable\Informes" "C:\Informes" /E
@echo ------------------------------------------------------
@echo Copia finalizada exitosamente
@echo -----------------------------------------------------
@echo PuTTY
mkdir "C:\PuTTY"
@echo -----------------------------------------------------
robocopy "\\172.19.19.191\ShareRusso\Programas\PuTTY" "C:\Putty" /E
@echo ------------------------------------------------------
@echo 7zip
@echo -----------------------------------------------------
C:\autoinstalable\7zip.exe /S
@echo -----------------------------------------------------
@echo adobe
@echo -----------------------------------------------------
C:\autoinstalable\adobe.exe /sAll /rs /msi EULA_ACCEPT=YES
@echo -----------------------------------------------------
@echo aio
@echo -----------------------------------------------------
C:\autoinstalable\aio.exe /S
@echo -----------------------------------------------------
@echo antivirus
@echo -----------------------------------------------------
C:\autoinstalable\antivirus
@echo chrome
@echo -----------------------------------------------------
C:\autoinstalable\ChromeSetup.exe /silent /install
@echo -----------------------------------------------------
@echo -----------------------------------------------------
@echo Libreoffice
@echo -----------------------------------------------------
C:\autoinstalable\libreoffice.msi /passive
@echo -----------------------------------------------------
@echo Firefox 46.01
@echo -----------------------------------------------------
C:\autoinstalable\firefox.exe /S
@echo -----------------------------------------------------
@echo Classic Shell
@echo -----------------------------------------------------
C:\autoinstalable\inicio.exe /passive
@echo -----------------------------------------------------
@echo Flash
@echo -----------------------------------------------------
C:\autoinstalable\flash.exe /passive
@echo VNC
@echo -----------------------------------------------------
C:\autoinstalable\vnc.exe /silent
cd c:\autoinstalable
reg import vnc.reg

cd c:\Program Files\RealVNC\VNC Server

vnclicense -add M2B74-3BN9A-SKBFH-7HAL8-ENVWA

@echo -----------------------------------------------------
@echo Xming
@echo -----------------------------------------------------
C:\autoinstalable\Xming.exe /silent
@echo ------------------------------------------------------
@echo Agrgando excepción web
@echo -----------------------------------------------------
netsh http add urlacl url=http://+:11001/ user=everyone 
netsh http add urlacl url=http://+:11001/ user=todos
@echo ------------------------------------------------------
@echo Instalando Drivers de impresora
@echo ------------------------------------------------------
pnputil.exe -a c:\drivers\*.inf 
@echo ------------------------------------------------------
@echo Instalando Framework
@echo -------------------------------------------------------
C:\informes\EncomiendaFacil\Framework.exe
@echo -------------------------------------------------------
@echo Agregando accesos directos
@cho -------------------------------------------------------
robocopy "\\172.19.19.191\ShareRusso\Programas\Autoinstalable\accesos3" "C:\users\public\desktop" /E
@echo -----------------------------------------------------
@echo Accesos agregados exitosamente
@echo------------------------------------------------------
@echo Habilitando SMB1
@echo ----------------------------------------------------
DISM /Online /Enable-Feature /All /FeatureName:SMB1Protocol 
@echo -----------------------------------------------------
@echo Creando regla Firewall de Windows
@echo -----------------------------------------------------
netsh advFirewall Firewall add rule name="Habilitar ICMP en IPv4" protocol=icmpv4:8,any dir=in action=allow
netsh advfirewall firewall add rule name="TCP Port 5900" dir=in action=allow protocol=TCP localport=5900
@echo -----------------------------------------------------
@echo Deshabilitando Windows Update
@echo -----------------------------------------------------
SC CONFIG WUAUSERV START= DISABLED
@echo -----------------------------------------------------
@echo Se realizó la instalación correctamente, el batch procederá a cerrarse.
exit

:Recepcion
@echo Copiando instaladores
@echo ---------------------------------------------------
mkdir "C:\Autoinstalable"
mkdir "C:\drivers"
robocopy "\\172.19.19.191\ShareRusso\Programas\Autoinstalable\instaladoresges" "c:\Autoinstalable" /E
robocopy "\\172.19.19.191\ShareRusso\Programas\Autoinstalable\drivers " "C:\drivers " /E
@echo ---------------------------------------------------
@echo off Copia finalizada exitosamente
@echo ------------------------------------------------------
@echo -----------------------------------------------------
cd c:\
@echo creando carpeta local en c:\
@echo -----------------------------------------------------
mkdir "C:\local"
@echo -----------------------------------------------------
@echo Copiando Ruticola y Printfil a C:\
@echo -----------------------------------------------------

robocopy "\\172.19.19.191\ShareRusso\Programas\Autoinstalable\Gestion" "C:\" /E
mkdir C:\Ruticola
robocopy "\\172.19.19.191\ShareRusso\Programas\Ruticola" "C:\Ruticola" /E
@echo -----------------------------------------------------
@echo Copia finalizada exitosamente
@echo -----------------------------------------------------
@echo Cargando Registro Ruticola
@echo -----------------------------------------------------
cd C:\Ruticola\
reg import ruticola.reg
@echo -------------------------------------------------
@echo Registro cargado corretamente
@echo -----------------------------------------------------
@echo Cargando DLL
@echo -----------------------------------------------------
regsvr32 C:\Ruticola\TABCTL32.OCX
regsvr32 C:\Ruticola\comctl32.ocx
@echo -----------------------------------------------------
@echo Creando directorio tkrecep en C:\
@echo -----------------------------------------------------
mkdir "C:\tkrecep"
@echo -----------------------------------------------------
@echo Copiando Printer Manager a C:\
@echo -----------------------------------------------------
mkdir "C:\Printer_Manager"
@echo -----------------------------------------------------
robocopy "\\172.19.19.191\ShareRusso\Programas\Autoinstalable\Printer Manager" "C:\Printer_Manager" /E
@echo -----------------------------------------------------
@echo PuTTY
@echo -----------------------------------------------------
mkdir "C:\PuTTY"
@echo -----------------------------------------------------
robocopy "\\172.19.19.191\ShareRusso\Programas\PuTTY" "C:\Putty" /E
@echo ------------------------------------------------------
@echo Printfil
@echo ----------------------------------------------------
C:\autoinstalable\Printfil.exe /DIR="C:\Printfil" /SILENT
C:\autoinstalable\Ta-Ta.pfl  /SILENT
copy C:\autoinstalable\Printfil\Printfil.ini C:\Printfil 
@echo ----------------------------------------------------
@echo 7zip
@echo -----------------------------------------------------
C:\autoinstalable\7zip.exe /S
@echo -----------------------------------------------------
@echo adobe
@echo -----------------------------------------------------
C:\autoinstalable\adobe.exe /sAll /rs /msi EULA_ACCEPT=YES
@echo -----------------------------------------------------
@echo aio
@echo -----------------------------------------------------
C:\autoinstalable\aio.exe /S
@echo -----------------------------------------------------
@echo antivirus
@echo -----------------------------------------------------
C:\autoinstalable\antivirus
@echo chrome
@echo -----------------------------------------------------
C:\autoinstalable\ChromeSetup.exe /silent /install
@echo -----------------------------------------------------
@echo Libreoffice
@echo -----------------------------------------------------
C:\autoinstalable\libreoffice.msi /passive
@echo -----------------------------------------------------
@echo Firefox
@echo -----------------------------------------------------
C:\autoinstalable\firefox.exe /silent
@echo -----------------------------------------------------
@echo Classic Shell
@echo -----------------------------------------------------
C:\autoinstalable\inicio.exe /passive
@echo -----------------------------------------------------
@echo Flash
@echo -----------------------------------------------------
C:\autoinstalable\flash.exe /passive
@echo VNC
@echo -----------------------------------------------------
C:\autoinstalable\vnc.exe /silent
cd c:\autoinstalable
reg import vnc.reg
cd c:\Program Files\RealVNC\VNC Server

vnclicense -add M2B74-3BN9A-SKBFH-7HAL8-ENVWA


@echo -----------------------------------------------------
@echo Xming
@echo -----------------------------------------------------
C:\autoinstalable\Xming.exe /silent
@echo -----------------------------------------------------
@echo Copiando Drivers a C:\drivers
@echo ---------------------------------------------------
mkdir "C:\drivers"
@echo ---------------------------------------------------
robocopy "\\172.19.19.191\ShareRusso\Programas\Autoinstalable\drivers" "C:\drivers" /E
@echo ----------------------------------------------------
@echo Instalando drivers de impresora
@echo -----------------------------------------------------
pnputil.exe -a c:\drivers\*.inf 
@echo -----------------------------------------------------
@echo Agregando accesos directos
@echo ----------------------------------------------------
robocopy "\\172.19.19.191\ShareRusso\Programas\Autoinstalable\accesos4" "C:\users\public\desktop" /E
@echo -----------------------------------------------------
@echo Accesos agregados exitosamente
@echo -----------------------------------------------------
@echo Habilitando SMB1
@echo ----------------------------------------------------
DISM /Online /Enable-Feature /All /FeatureName:SMB1Protocol 
@echo -----------------------------------------------------
@echo Creando regla Firewall de Windows
@echo -----------------------------------------------------
netsh advFirewall Firewall add rule name="Habilitar ICMP en IPv4" protocol=icmpv4:8,any dir=in action=allow
netsh advfirewall firewall add rule name="TCP Port 5900" dir=in action=allow protocol=TCP localport=5900
@echo -----------------------------------------------------
@echo Deshabilitando Windows Update
@echo -----------------------------------------------------
SC CONFIG WUAUSERV START= DISABLED
@echo -----------------------------------------------------
@echo Se realizó la instalación correctamente, el batch procederá a cerrarse.
exit

:Tesoreria
@echo Copiando instaladores
@echo ---------------------------------------------------
mkdir "C:\Autoinstalable"
mkdir "C:\drivers"
robocopy "\\172.19.19.191\ShareRusso\Programas\Autoinstalable\instaladoresges" "c:\Autoinstalable" /E
robocopy "\\172.19.19.191\ShareRusso\Programas\Autoinstalable\drivers " "C:\drivers " /E
@echo off Copia finalizada exitosamente
@echo ------------------------------------------------------
@echo -----------------------------------------------------
@echo PuTTY
mkdir "C:\PuTTY"
@echo -----------------------------------------------------
robocopy "\\172.19.19.191\ShareRusso\Programas\PuTTY" "C:\Putty" /E
@echo -----------------------------------------------------
@RHPRO
@echo ------------------------------------------------------
mkdir "C:\RHPRO"
@echo -----------------------------------------------------
robocopy "\\172.19.19.191\ShareRusso\Programas\Autoinstalable\rhpro" "C:\RHPRO" /E
@echo -----------------------------------------------------
@echo ----------------------------------------------------
@echo 7zip
@echo -----------------------------------------------------
C:\autoinstalable\7zip.exe /S
@echo -----------------------------------------------------
@echo adobe
@echo -----------------------------------------------------
C:\autoinstalable\adobe.exe /sAll /rs /msi EULA_ACCEPT=YES
@echo -----------------------------------------------------
@echo aio
@echo -----------------------------------------------------
C:\autoinstalable\aio.exe /S
@echo -----------------------------------------------------
@echo antivirus
@echo -----------------------------------------------------
C:\autoinstalable\antivirus
@echo chrome
@echo -----------------------------------------------------
C:\autoinstalable\ChromeSetup.exe /silent /install
@echo -----------------------------------------------------
@echo financials
@echo -----------------------------------------------------
C:\autoinstalable\financials1.exe /S
@echo -----------------------------------------------------
@echo financials 
@echo -----------------------------------------------------
C:\autoinstalable\financials2.exe /S
@echo -----------------------------------------------------
@echo Libreoffice
@echo -----------------------------------------------------
C:\autoinstalable\libreoffice.msi /passive
@echo -----------------------------------------------------
@echo Firefox
@echo -----------------------------------------------------
C:\autoinstalable\firefox.exe /S
@echo -----------------------------------------------------
@echo Classic Shell
@echo -----------------------------------------------------
C:\autoinstalable\inicio.exe /passive
@echo -----------------------------------------------------
@echo Flash
@echo -----------------------------------------------------
C:\autoinstalable\flash.exe /passive
@echo VNC
@echo -----------------------------------------------------
C:\autoinstalable\vnc.exe /silent
cd c:\autoinstalable
reg import vnc.reg

cd c:\Program Files\RealVNC\VNC Server

vnclicense -add M2B74-3BN9A-SKBFH-7HAL8-ENVWA

@echo -----------------------------------------------------
@echo Instalando Drivers de impresoras
@echo ------------------------------------------------------
pnputil.exe -a c:\drivers\*.inf 
@echo ------------------------------------------------------
@echo Habilitando SMB1
@echo ----------------------------------------------------
DISM /Online /Enable-Feature /All /FeatureName:SMB1Protocol 
@echo -----------------------------------------------------
@echo Creando accessos directos
@echo -----------------------------------------------------
robocopy "\\172.19.19.191\ShareRusso\Programas\Autoinstalable\accesos5" "C:\users\public\desktop" /E
@echo -----------------------------------------------------
@echo Creando regla Firewall de Windows
@echo -----------------------------------------------------
netsh advFirewall Firewall add rule name="Habilitar ICMP en IPv4" protocol=icmpv4:8,any dir=in action=allow
netsh advfirewall firewall add rule name="TCP Port 5900" dir=in action=allow protocol=TCP localport=5900
@echo -----------------------------------------------------
@echo Deshabilitando Windows Update
@echo -----------------------------------------------------
SC CONFIG WUAUSERV START= DISABLED
@echo -----------------------------------------------------
@echo Se realizó la instalación correctamente, el batch procederá a cerrarse.
exit

:Personal
@echo Copiando instaladores
@echo ---------------------------------------------------
mkdir "C:\Autoinstalable"
mkdir "C:\drivers"
robocopy "\\172.19.19.191\ShareRusso\Programas\Autoinstalable\instaladoresges" "c:\Autoinstalable" /E
robocopy "\\172.19.19.191\ShareRusso\Programas\Autoinstalable\drivers " "C:\drivers " /E
@echo off Copia finalizada exitosamente
@echo ------------------------------------------------------
@RHPRO
@echo ------------------------------------------------------
mkdir "C:\RHPRO"
@echo -----------------------------------------------------
robocopy "\\172.19.19.191\ShareRusso\Programas\Autoinstalable\rhpro" "C:\RHPRO" /E
@echo -----------------------------------------------------
@echo PuTTY
mkdir "C:\PuTTY"
@echo -----------------------------------------------------
robocopy "\\172.19.19.191\ShareRusso\Programas\PuTTY" "C:\PuTTY" /E
@echo -----------------------------------------------------
@echo 7zip
@echo -----------------------------------------------------
C:\autoinstalable\7zip.exe /S
@echo -----------------------------------------------------
@echo adobe
@echo -----------------------------------------------------
C:\autoinstalable\adobe.exe /sAll /rs /msi EULA_ACCEPT=YES
@echo -----------------------------------------------------
@echo aio
@echo -----------------------------------------------------
C:\autoinstalable\aio.exe /S
@echo -----------------------------------------------------
@echo antivirus
@echo -----------------------------------------------------
C:\autoinstalable\antivirus
@echo chrome
@echo -----------------------------------------------------
C:\autoinstalable\ChromeSetup.exe /silent /install
@echo -----------------------------------------------------
@echo Libreoffice
@echo -----------------------------------------------------
C:\autoinstalable\libreoffice.msi /passive
@echo -----------------------------------------------------
@echo Firefox
@echo -----------------------------------------------------
C:\autoinstalable\firefox.exe /S
@echo -----------------------------------------------------
@echo Classic Shell
@echo -----------------------------------------------------
C:\autoinstalable\inicio.exe /passive
@echo -----------------------------------------------------
@echo Flash
@echo -----------------------------------------------------
C:\autoinstalable\flash.exe /passive
@echo VNC
@echo -----------------------------------------------------
C:\autoinstalable\vnc.exe /silent
cd c:\autoinstalable
reg import vnc.reg

cd c:\Program Files\RealVNC\VNC Server

vnclicense -add M2B74-3BN9A-SKBFH-7HAL8-ENVWA

@echo -----------------------------------------------------
@echo Instalando Drivers de impresoras
@echo ------------------------------------------------------
pnputil.exe -a c:\drivers\*.inf 
@echo ------------------------------------------------------
@echo Habilitando SMB1
@echo ----------------------------------------------------
DISM /Online /Enable-Feature /All /FeatureName:SMB1Protocol 
@echo -----------------------------------------------------
@echo Creando regla Firewall de Windows
@echo -----------------------------------------------------
netsh advFirewall Firewall add rule name="Habilitar ICMP en IPv4" protocol=icmpv4:8,any dir=in action=allow
netsh advfirewall firewall add rule name="TCP Port 5900" dir=in action=allow protocol=TCP localport=5900
@echo -----------------------------------------------------
@echo Deshabilitando Windows Update
@echo -----------------------------------------------------
SC CONFIG WUAUSERV START= DISABLED
@echo -----------------------------------------------------
@echo Se realizó la instalación correctamente, el batch procederá a cerrarse.
exit

:ATC
@echo Copiando instaladores
@echo ---------------------------------------------------
mkdir "C:\Autoinstalable"
robocopy "\\172.19.19.191\ShareRusso\Programas\Autoinstalable\instaladoresatc" "c:\Autoinstalable" /E
@echo off Copia finalizada exitosamente
@echo ----------------------------------------------------
@echo -----------------------------------------------------
@echo 7zip
@echo -----------------------------------------------------
C:\autoinstalable\7zip.exe /S
@echo -----------------------------------------------------
@echo adobe
@echo -----------------------------------------------------
C:\autoinstalable\adobe.exe /sAll /rs /msi EULA_ACCEPT=YES
@echo -----------------------------------------------------
@echo aio
@echo -----------------------------------------------------
C:\autoinstalable\aio.exe /S
@echo -----------------------------------------------------
@echo antivirus
@echo -----------------------------------------------------
C:\autoinstalable\antivirus
@echo chrome
@echo -----------------------------------------------------
C:\autoinstalable\ChromeSetup.exe /silent /install
@echo -----------------------------------------------------
@echo Libreoffice
@echo -----------------------------------------------------
C:\autoinstalable\libreoffice.msi /passive
@echo -----------------------------------------------------
@echo Firefox
@echo -----------------------------------------------------
C:\autoinstalable\firefox.exe /S
@echo -----------------------------------------------------
@echo Classic Shell
@echo -----------------------------------------------------
C:\autoinstalable\inicio.exe /passive
@echo -----------------------------------------------------
@echo Flash
@echo -----------------------------------------------------
C:\autoinstalable\flash.exe /passive
@echo VNC
@echo -----------------------------------------------------
C:\autoinstalable\vnc.exe /silent

cd c:\Program Files\RealVNC\VNC Server
cd c:\autoinstalable
reg import vnc.reg

vnclicense -add M2B74-3BN9A-SKBFH-7HAL8-ENVWA

@echo -----------------------------------------------------
@echo BarAgent
@echo -----------------------------------------------------
C:\autoinstalable\InConcertAgent.exe /Z Server=172.19.10.69
@echo -----------------------------------------------------
@VPN
@echo -----------------------------------------------------
C:\autoinstalable\anyconnect-win-4.8.03052-iseposture-predeploy-k9.msi /quiet
C:\autoinstalable\anyconnect-win-4.8.03052-posture-predeploy-k9.msi /quiet
C:\autoinstalable\anyconnect-win-4.8.03052-core-vpn-predeploy-k9.msi /quiet
@echo ------------------------------------------------------
@echo Creando regla Firewall de Windows
@echo -----------------------------------------------------
netsh advFirewall Firewall add rule name="Habilitar ICMP en IPv4" protocol=icmpv4:8,any dir=in action=allow
netsh advfirewall firewall add rule name="TCP Port 5900" dir=in action=allow protocol=TCP localport=5900
@echo -----------------------------------------------------
@echo Deshabilitando Windows Update
@echo -----------------------------------------------------
SC CONFIG WUAUSERV START= DISABLED
@echo -----------------------------------------------------
@echo Se realizó la instalación correctamente, el batch procederá a cerrarse.
exit

:Ingresos
@echo Copiando instaladores
@echo ---------------------------------------------------
mkdir "C:\Autoinstalable"
robocopy "\\172.19.19.191\ShareRusso\Programas\Autoinstalable\instaladoresing" "c:\Autoinstalable" /E
@echo off Copia finalizada exitosamente
@echo ----------------------------------------------------
@echo 7zip
@echo -----------------------------------------------------
C:\autoinstalable\7zip.exe /S
@echo -----------------------------------------------------
@echo adobe
@echo -----------------------------------------------------
C:\autoinstalable\adobe.exe /sAll /rs /msi EULA_ACCEPT=YES
@echo -----------------------------------------------------
@echo aio
@echo -----------------------------------------------------
C:\autoinstalable\aio.exe /S
@echo -----------------------------------------------------
@echo antivirus
@echo -----------------------------------------------------
C:\autoinstalable\antivirus
@echo chrome
@echo -----------------------------------------------------
C:\autoinstalable\ChromeSetup.exe /silent /install
@echo -----------------------------------------------------
@echo Libreoffice
@echo -----------------------------------------------------
C:\autoinstalable\libreoffice.msi /passive
@echo -----------------------------------------------------
@echo Firefox
@echo -----------------------------------------------------
C:\autoinstalable\firefox.exe /S
@echo -----------------------------------------------------
@echo Classic Shell
@echo -----------------------------------------------------
C:\autoinstalable\inicio.exe /passive
@echo -----------------------------------------------------
@echo Flash
@echo -----------------------------------------------------
C:\autoinstalable\flash.exe /passive
@echo VNC
@echo -----------------------------------------------------
C:\autoinstalable\vnc.exe /silent
cd c:\autoinstalable
reg import vnc.reg
cd c:\Program Files\RealVNC\VNC Server

vnclicense -add M2B74-3BN9A-SKBFH-7HAL8-ENVWA

@echo -----------------------------------------------------
@echo VPN
@echo -----------------------------------------------------
C:\autoinstalable\anyconnect-win-4.8.03052-iseposture-predeploy-k9.msi /quiet
C:\autoinstalable\anyconnect-win-4.8.03052-posture-predeploy-k9.msi /quiet
C:\autoinstalable\anyconnect-win-4.8.03052-core-vpn-predeploy-k9.msi /quiet
@echo ------------------------------------------------------

@echo ------------------------------------------------------
@echo Creando regla Firewall de Windows
@echo -----------------------------------------------------
netsh advFirewall Firewall add rule name="Habilitar ICMP en IPv4" protocol=icmpv4:8,any dir=in action=allow
netsh advfirewall firewall add rule name="TCP Port 5900" dir=in action=allow protocol=TCP localport=5900
@echo -----------------------------------------------------
@echo Deshabilitando Windows Update
@echo -----------------------------------------------------
SC CONFIG WUAUSERV START= DISABLED
@echo -----------------------------------------------------
@echo Se realizó la instalación correctamente, el batch procederá a cerrarse.
exit

:Drivers
@echo Copiando Drivers
@echo -----------------------------------------------------
mkdir "C:\drivers"
robocopy "\\172.19.19.191\ShareRusso\Programas\Autoinstalable\drivers " "C:\drivers " /E
@echo -----------------------------------------------------
@echo Instalando Drivers de impresora
@echo -----------------------------------------------------
pnputil.exe -a c:\drivers\*.inf 
@echo -----------------------------------------------------


:VPN
@echo Copiando instaladores
@echo ---------------------------------------------------
mkdir "C:\Autoinstalable"
robocopy "\\172.19.19.191\ShareRusso\Programas\Autoinstalable\instaladoresing" "c:\Autoinstalable" /E
@echo off Copia finalizada exitosamente
@echo ----------------------------------------------------
@echo VNC
@echo -----------------------------------------------------
C:\autoinstalable\vnc.exe /silent
cd c:\autoinstalable
reg import vnc.reg
cd c:\Program Files\RealVNC\VNC Server

vnclicense -add M2B74-3BN9A-SKBFH-7HAL8-ENVWA
@echo VPN
@echo -----------------------------------------------------
C:\autoinstalable\anyconnect-win-4.8.03052-iseposture-predeploy-k9.msi /quiet
C:\autoinstalable\anyconnect-win-4.8.03052-posture-predeploy-k9.msi /quiet
C:\autoinstalable\anyconnect-win-4.8.03052-core-vpn-predeploy-k9.msi /quiet
@echo --------------------------
@echo Creando regla Firewall de Windows
@echo -----------------------------------------------------
netsh advFirewall Firewall add rule name="Habilitar ICMP en IPv4" protocol=icmpv4:8,any dir=in action=allow
netsh advfirewall firewall add rule name="TCP Port 5900" dir=in action=allow protocol=TCP localport=5900

@echo Instalación Finalizada con éxito

@echo off
