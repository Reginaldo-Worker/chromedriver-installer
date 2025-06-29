; Script gerado pelo Inno Setup Script Wizard.
; CONSIDERE QUE NO ESBOÇO DO GERADOR DE SCRIPT SÃO INSERIDOS OS VALORES EDITÁVEIS.
; CONFIRA A DOCUMENTAÇÃO PARA DETALHES SOBRE A CRIAÇÃO DE SCRIPTS INNO SETUP!

[Setup]
; NOTA: O valor de AppId identifica exclusivamente esta aplicação.
; Não use o mesmo AppId em outro instalador.
; (Para gerar um novo GUID, clique em Tools | Generate GUID inside the IDE.)
AppId={clique em Tools
AppName=Chrome Driver installer
AppVersion=1.0
;AppVerName=Chrome Driver installer 1.0
AppPublisher=Reginaldo P. Carvalho
AppPublisherURL=https://github.com/Reginaldo-Worker/chromedriver-installer
AppSupportURL=https://github.com/Reginaldo-Worker/chromedriver-installer
AppUpdatesURL=https://github.com/Reginaldo-Worker/chromedriver-installer
DefaultDirName={autopf}\Chrome Driver installer
DisableProgramGroupPage=yes
; Remova o comentário da linha abaixo para executar em modo administrativo sem pedir
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

; Você pode incluir outros arquivos necessários aqui

[Icons]
Name: "{autoprograms}\Chrome Driver installer"; Filename: "{app}\chromedriver_auto.exe"
Name: "{autodesktop}\Chrome Driver installer"; Filename: "{app}\chromedriver_auto.exe"; Tasks: desktopicon

[Run]
; Executar o batch file para instalar dependências
Filename: "{app}\install_dependencies.bat"; Description: "Instalar dependências do Python"; Flags: runhidden

; Executar o programa após a instalação (opcional)
Filename: "{app}\chromedriver_auto.exe"; Description: "{cm:LaunchProgram,Meu Programa Python}"; Flags: nowait postinstall skipifsilent
