[Setup]
#define AppName "RSBot"
#define AppVersion "2.9.9"
#define AppPublisher "Silkroad Developer Community"
#define AppURL "https://github.com/Silkroad-Developer-Community/RSBot"
#define AppExeName "RSBot.exe"

AppName={#AppName}
AppVersion={#AppVersion}
AppPublisher={#AppPublisher}
AppPublisherURL={#AppURL}
AppSupportURL={#AppURL}
AppUpdatesURL={#AppURL}
DefaultDirName={autopf}\{#AppName}
DefaultGroupName={#AppName}
AllowNoIcons=yes

; "PrivilegesRequired=admin" is necessary for RSBot to attach to the game process
PrivilegesRequired=admin
OutputDir=..
OutputBaseFilename=RSBot-Setup-{#AppVersion}
Compression=lzma
SolidCompression=yes
WizardStyle=modern dark includetitlebar
AppMutex=RSBotMutex
CloseApplications=yes

[Dirs]
Name: "{app}"; Permissions: users-modify

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
; Main application and standard data (ignores version to always overwrite core files)
Source: "..\Build\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs; Excludes: "..\Build\User\*, ..\Build\Data\Python\Plugins\*"

; Persistent User Configuration (only installs if it doesn't exist, never uninstalls)
Source: "..\Build\User\*"; DestDir: "{app}\User"; Flags: recursesubdirs createallsubdirs onlyifdoesntexist uninsneveruninstall

; Persistent Python Plugins (only installs if it doesn't exist, never uninstalls)
; NOTE: Need to change this behavior to overwrite when Python version is bumped.
; Plugins\RSBot.Python\RSBot.Python.csproj & scripts\download_python.ps1
Source: "..\Build\Data\Python\Plugins\*"; DestDir: "{app}\Data\Python\Plugins"; Flags: recursesubdirs createallsubdirs onlyifdoesntexist uninsneveruninstall

[Icons]
Name: "{group}\{#AppName}"; Filename: "{app}\{#AppExeName}"
Name: "{autodesktop}\{#AppName}"; Filename: "{app}\{#AppExeName}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#AppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(AppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

[UninstallDelete]
; Clean up runtime-generated logs but preserve User settings
Type: filesandordirs; Name: "{app}\Build\User\Logs"
