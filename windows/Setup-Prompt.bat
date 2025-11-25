@echo off
REM ------------------------------------------------------------------------
REM Configures a Kali-style two-line prompt for CMD (Command Prompt).
REM Uses 'setx' to make the PROMPT environment variable permanent.
REM 
REM Colors used (ANSI Escape Codes):
REM $E[36m = Cyan
REM $E[35m = Magenta
REM $E[0m  = Reset
REM ------------------------------------------------------------------------

echo Setting custom command prompt...

REM Note: %%COMPUTERNAME%% is used to escape the % symbol inside the batch file.
REM Note: $$ is used at the end to print a single literal $ symbol.

setx PROMPT "$E[36m┌──$E[35m(%%COMPUTERNAME%%) $E[36m$P$_$E[0m└─$$ "

echo.
echo SUCCESS: Custom prompt variable set.
echo.
echo [IMPORTANT]
echo You must close this window and open a NEW Command Prompt 
echo to see the changes.
echo.
pause
