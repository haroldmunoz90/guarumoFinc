@echo off
Setlocal enabledelayedexpansion

Set "Pattern=es-mx"
Set "Replace=es-mx"

For %%a in (*.ini) Do (
    Set "File=%%~a"
    Ren "%%a" "!File:%Pattern%=%Replace%!"
)

Pause&Exit