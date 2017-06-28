@echo off
start terminal.exe /portable config\test.ini
timeout /t 10 > NUL
taskkill /F /IM terminal.exe
exit /b 0
