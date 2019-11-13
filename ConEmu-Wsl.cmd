@echo off
call %~dp0ConEmu-SetEsc.cmd
echo %ESC%[9999H
set "PATH=%ConEmuBaseDirShort%\wsl;%PATH%"
"%ConEmuBaseDirShort%\conemu-cyg-64.exe" --wsl
