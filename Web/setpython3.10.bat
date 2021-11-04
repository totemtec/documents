@echo OFF

set PYTHON_HOME=C:\Programs\Python\Python310

set PATH=%PYTHON_HOME%;%PYTHON_HOME%\Scripts\;%PATH%

setx PYTHON_HOME "%PYTHON_HOME%;%PYTHON_HOME%\Scripts\;" /m

python --version

pause