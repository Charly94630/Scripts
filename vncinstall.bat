@echo off



pushd c:\vnc
C:\VNC\vnc.exe /silent
reg import vnc.reg

cd c:\Program Files\RealVNC\VNC Server
vnclicense -add M2B74-3BN9A-SKBFH-7HAL8-ENVWA


@echo Creando regla Firewall de Windows
@echo off
netsh advFirewall Firewall add rule name="Habilitar ICMP en IPv4" protocol=icmpv4:8,any dir=in action=allow
netsh advfirewall firewall add rule name="TCP Port 5900" dir=in action=allow protocol=TCP localport=5900
@echo Reglas creadas correctamente
@echo off
netsh interface IPV6 set global randomizeidentifier=disabled
netsh interface IPV6 set privacy state=disable
netsh interface ipv6 6to4 set state state=disabled
netsh interface ipv6 isatap set state state=disabled
netsh interface ipv6 set teredo disable