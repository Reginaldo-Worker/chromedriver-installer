@echo off
:: Verificar e instalar Python
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Python não encontrado. Instalando...
    winget install Python.Python.3.10
    setx PATH "%PATH%;C:\Python310;C:\Python310\Scripts"
) else (
    echo Python já está instalado.
)

:: Verificar e instalar pip
python -m pip --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Pip não encontrado. Instalando...
    python -m ensurepip --upgrade
) else (
    echo Pip já está instalado.
)

:: Verificar e instalar selenium
python -c "import selenium" >nul 2>&1
if %errorlevel% neq 0 (
    echo Selenium não encontrado. Instalando...
    python -m pip install selenium
) else (
    echo Selenium já está instalado.
)

pause