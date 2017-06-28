@echo off
metaeditor.exe /portable /compile:%1.mq4 /log
if %errorlevel% equ 0  (
   echo "Compilation failed..."
   type %1.log
   exit /b 1
) else (
   type %1.log
   exit /b 0
)
