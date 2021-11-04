@echo OFF

set PYTHON_HOME=C:\tools\Python27

set PATH=%PYTHON_HOME%;%PYTHON_HOME%\Scripts\;%PATH%

setx PYTHON_HOME "%PYTHON_HOME%;%PYTHON_HOME%\Scripts\;" /m

python --version

pause