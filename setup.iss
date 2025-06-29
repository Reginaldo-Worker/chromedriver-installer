; Script gerado pelo Inno Setup Script Wizard.
; CONSIDERE QUE NO ESBO�O DO GERADOR DE SCRIPT S�O INSERIDOS OS VALORES EDIT�VEIS.
; CONFIRA A DOCUMENTA��O PARA DETALHES SOBRE A CRIA��O DE SCRIPTS INNO SETUP!

[Setup]
; NOTA: O valor de AppId identifica exclusivamente esta aplica��o.
; N�o use o mesmo AppId em outro instalador.
; (Para gerar um novo GUID, clique em Tools | Generate GUID inside the IDE.)
AppId={{YOUR-APP-ID-GOES-HERE}
AppName=Chrome Driver installer
AppVersion=1.0
;AppVerName=Chrome Driver installer 1.0
AppPublisher=Reginaldo P. Carvalho
AppPublisherURL=https://github.com/Reginaldo-Worker/chromedriver-installer
AppSupportURL=https://github.com/Reginaldo-Worker/chromedriver-installer
AppUpdatesURL=https://github.com/Reginaldo-Worker/chromedriver-installer
DefaultDirName={autopf}\Chrome Driver installer
DisableProgramGroupPage=yes
; Remova o coment�rio da linha abaixo para executar em modo administrativo sem pedir
PrivilegesRequired=admin
OutputDir=C:\Output
OutputBaseFilename=auto_instaler_chromedriver
SolidCompression=yes
WizardStyle=modern

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "brazilianportuguese"; MessagesFile: "compiler:Languages\BrazilianPortuguese.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
; Arquivos do seu programa Python
Source: "C:\Users\Reginaldo\Desktop\chromedriver-installer-execultaveis\install_dependencies.bat"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\Reginaldo\Desktop\chromedriver-installer-execultaveis\chromedriver_auto.exe"; DestDir: "{app}"; Flags: ignoreversion

; Voc� pode incluir outros arquivos necess�rios aqui

[Icons]
Name: "{autoprograms}\Chrome Driver installer"; Filename: "{app}\chromedriver_auto.exe"
Name: "{autodesktop}\Chrome Driver installer"; Filename: "{app}\chromedriver_auto.exe"; Tasks: desktopicon

[Run]
; Executar o batch file para instalar depend�ncias
Filename: "{app}\install_dependencies.bat"; Description: "Instalar depend�ncias do Python"; Flags: runhidden

; Executar o programa ap�s a instala��o (opcional)
Filename: "{app}\chromedriver_auto.exe"; Description: "{cm:LaunchProgram,Meu Programa Python}"; Flags: nowait postinstall skipifsilent

[Code]
function InitializeSetup(): Boolean;
begin
  // Verificar se o Python est� instalado
  if not RegKeyExists(HKLM, 'Software\Python\PythonCore\3.10\InstallPath') then
  begin
    if MsgBox('Python 3.10 n�o foi detectado no seu sistema. Deseja instalar agora?', mbConfirmation, MB_YESNO) = IDYES then
    begin
      // Baixar e instalar Python automaticamente
      ShellExec('open', 'https://www.python.org/ftp/python/3.10.0/python-3.10.0-amd64.exe', 
                '/quiet InstallAllUsers=1 PrependPath=1', '', SW_SHOW, ewWaitUntilTerminated, ResultCode);
    end
    else
    begin
      Result := False;
      MsgBox('A instala��o n�o pode continuar sem Python 3.10.', mbError, MB_OK);
      Exit;
    end;
  end;
  
  Result := True;
end;