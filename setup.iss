; Script gerado pelo Inno Setup Script Wizard.
; CONSIDERE QUE NO ESBOÇO DO GERADOR DE SCRIPT SÃO INSERIDOS OS VALORES EDITÁVEIS.
; CONFIRA A DOCUMENTAÇÃO PARA DETALHES SOBRE A CRIAÇÃO DE SCRIPTS INNO SETUP!
; NOTA: O valor de AppId identifica exclusivamente esta aplicação.
; Não use o mesmo AppId em outro instalador.
; (Para gerar um novo GUID, clique em Tools | Generate GUID inside the IDE.)
; Inno Setup Script
[Setup]
AppId={{C0326ADF-A5A3-4182-85F7-BAEA9B646A03}
AppName=Chrome Driver installer
AppVersion=1.2
AppPublisher=Reginaldo P. Carvalho
AppPublisherURL=https://github.com/Reginaldo-Worker/chromedriver-installer
AppSupportURL=https://github.com/Reginaldo-Worker/chromedriver-installer
AppUpdatesURL=https://github.com/Reginaldo-Worker/chromedriver-installer
DefaultDirName={autopf}\Chrome Driver installer
DisableProgramGroupPage=yes
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
Source: "C:\Users\Reginaldo\Desktop\chromedriver-installer-execultaveis\install_dependencies.bat"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\Reginaldo\Desktop\chromedriver-installer-execultaveis\chromedriver_auto.exe"; DestDir: "{app}"; Flags: ignoreversion

[Icons]
Name: "{autoprograms}\Chrome Driver installer"; Filename: "{app}\chromedriver_auto.exe"
Name: "{autodesktop}\Chrome Driver installer"; Filename: "{app}\chromedriver_auto.exe"; Tasks: desktopicon

[Run]
; Executar o .bat como admin, oculto
Filename: "cmd.exe"; Parameters: "/c ""{app}\install_dependencies.bat"""; Flags: runhidden

; Executar o programa principal após instalação
Filename: "{app}\chromedriver_auto.exe"; Description: "{cm:LaunchProgram,Chrome Driver installer}"; Flags: nowait postinstall skipifsilent
