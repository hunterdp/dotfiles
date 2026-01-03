@echo off
echo.
doskey dsh=ssh -i %HOMEDRIVE%%HOMEPATH%\.ssh\id_rsa dph@$1.home.dphtech.com
doskey dth=ssh -i %HOMEDRIVE%%HOMEPATH%\.ssh\id_rsa dph@$1.truckee.dphtech.com
doskey vscode="C:\Users\david\AppData\Local\Programs\Microsoft VS Code Insiders\Code - Insiders.exe" $1
