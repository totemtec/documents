@echo OFF

chcp 65001

set PYTHON_HOME=C:\tools\Python27

set PATH=%PYTHON_HOME%;%PYTHON_HOME%\Scripts\;%PATH%

setx PYTHON_HOME "%PYTHON_HOME%;%PYTHON_HOME%\Scripts\;" /m

IF %ERRORLEVEL% NEQ 0 ( 
   echo "请以管理员身份来运行" 
) ELSE (
   python --version
)

pause