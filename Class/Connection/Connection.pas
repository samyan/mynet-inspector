Unit Connection;

Interface

Uses
  Winapi.Windows, Vcl.Dialogs, System.SysUtils, Vcl.Graphics, Winapi.IpHlpApi,
  Winapi.IpRtrMib, Process;

Type
  TConnection = Class(TObject)
  Private
    { private declarations here }
    process: TProcess;

    pid: DWORD;
    protocol: String;
    localPort: DWORD;
    localIP: DWORD;
    remotePort: DWORD;
    remoteIP: DWORD;
    state: DWORD;
  Protected
    { protected declarations here }
  Public
    { public declarations here }
    Constructor Create; Overload;
    Constructor Create(processName: String; processPath: String; pid: DWORD;
      protocol: String; localPort: DWORD; localIP: DWORD; remotePort: DWORD;
      remoteIP: DWORD; state: DWORD; smallIcon: TIcon); Overload;
    Destructor Destroy; Override;

    Property aProcess: TProcess Read process Write process;
    Property aPID: DWORD Read pid Write pid;
    Property aProtocol: String Read protocol Write protocol;
    Property aLocalPort: DWORD Read localPort Write localPort;
    Property aLocalIP: DWORD Read localIP Write localIP;
    Property aRemotePort: DWORD Read remotePort Write remotePort;
    Property aRemoteIP: DWORD Read remoteIP Write remoteIP;
    Property aState: DWORD Read state Write state;
  End;

Implementation

Constructor TConnection.Create;
Begin
  Inherited Create;
  self.process := TProcess.Create;
End;

Constructor TConnection.Create(processName: String; processPath: String;
  pid: DWORD; protocol: String; localPort: DWORD; localIP: DWORD;
  remotePort: DWORD; remoteIP: DWORD; state: DWORD; smallIcon: TIcon);
Begin
  Inherited Create;
  self.process := TProcess.Create;

  self.pid := pid;
  self.protocol := protocol;
  self.localPort := localPort;
  self.localIP := localIP;
  self.remotePort := remotePort;
  self.remoteIP := remoteIP;
  self.state := state;

  self.process.aName := processName;
  self.process.aPath := processPath;
  self.process.aSmallIcon := smallIcon;
End;

Destructor TConnection.Destroy;
Begin
  self.process.Destroy;
  Inherited Destroy;
End;

End.
