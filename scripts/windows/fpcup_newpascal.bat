@ECHO OFF
REM ######################################################################################
REM               fpcup for windows
REM ######################################################################################

ECHO.
ECHO =====================================================================================
ECHO   Fpcup by NewPascal
ECHO =====================================================================================
ECHO.

if EXIST .\fpcup.exe (
fpcup.exe --installdir="c:\NewPascalFPConly" --fpcURL="newpascal"
)

ECHO.
ECHO =====================================================================================
ECHO   Fpcup by NewPascal ready;
ECHO =====================================================================================
ECHO.
PAUSE