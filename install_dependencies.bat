@echo off
SETLOCAL EnableDelayedExpansion

:: Configurações
set PYTHON_VERSION=3.12.1
set PYTHON_URL=https://www.python.org/ftp/python/%PYTHON_VERSION%/python-%PYTHON_VERSION%-amd64.exe
set INSTALL_DIR=%~dp0
set VENV_NAME=venv

:: Verificar e instalar Python
echo Verificando instalação do Python...
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Python não encontrado. Instalando Python %PYTHON_VERSION%...
    
    :: Baixar o instalador do Python
    echo Baixando instalador do Python...
    powershell -Command "(New-Object Net.WebClient).DownloadFile('%PYTHON_URL%', '%INSTALL_DIR%python_installer.exe')"
    
    :: Instalar Python silenciosamente
    echo Instalando Python...
    start /wait "" "%INSTALL_DIR%python_installer.exe" /quiet InstallAllUsers=1 PrependPath=1 Include_test=0
    del "%INSTALL_DIR%python_installer.exe"
    
    :: Atualizar PATH
    setx PATH "%PATH%;C:\Python312;C:\Python312\Scripts"
    set PATH=%PATH%;C:\Python312;C:\Python312\Scripts
    
    echo Python %PYTHON_VERSION% instalado com sucesso.
) else (
    echo Python já está instalado.
)

:: Verificar e atualizar pip
echo Verificando pip...
python -m pip --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Pip não encontrado. Instalando...
    python -m ensurepip --upgrade
) else (
    echo Pip já está instalado. Atualizando...
    python -m pip install --upgrade pip
)

:: Criar ambiente virtual
echo Criando ambiente virtual...
if not exist "%INSTALL_DIR%%VENV_NAME%" (
    python -m venv "%INSTALL_DIR%%VENV_NAME%"
    echo Ambiente virtual criado em %INSTALL_DIR%%VENV_NAME%
) else (
    echo Ambiente virtual já existe.
)

:: Ativar o ambiente virtual e instalar dependências
echo Instalando dependências no ambiente virtual...
call "%INSTALL_DIR%%VENV_NAME%\Scripts\activate.bat"
pip install selenium
pip install chromedriver-autoinstaller

:: Verificar instalação do Selenium
python -c "import selenium; print('Selenium instalado com sucesso!')"

echo.
echo Instalação concluída com sucesso!
echo Ambiente virtual está em: %INSTALL_DIR%%VENV_NAME%
echo.

pause
