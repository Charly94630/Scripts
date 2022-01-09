@Limpiando cola de impresión.

net stop spooler
sc config spooler depend= RPCSS
del /Q /F /S "%systemroot%\System32\Spool\Printers\*.*"
del /Q /F /S "C:\WINDOWS\Temp\*.*"
del /Q /F /S "C:\*.tmp"
del /Q /F /S "D:\*.tmp"
net start spooler


pause

