program MyNetInspector;

{$R *.dres}

uses
  Vcl.Forms,
  Main in 'GUI\Main.pas' {FRMMain},
  Vcl.Themes,
  Vcl.Styles,
  SynaIP in 'Modules\SynaIP.pas',
  Connection in 'Class\Connection\Connection.pas',
  ConnectionList in 'Class\Connection\ConnectionList.pas',
  ProcessManager in 'Class\Process\ProcessManager.pas',
  TCPProtocol in 'Class\Protocol\TCP\TCPProtocol.pas',
  Utilities in 'Class\Other\Utilities.pas',
  Process in 'Class\Process\Process.pas',
  About in 'GUI\About.pas' {FRMAbout},
  AppController in 'Controller\AppController.pas',
  UDPProtocol in 'Class\Protocol\UDP\UDPProtocol.pas',
  VirusTotal in 'Class\VirusTotal\VirusTotal.pas',
  SendReport in 'Class\VirusTotal\SendReport.pas',
  VirusTotalReport in 'GUI\VirusTotalReport.pas' {FRMVirusTotalReport},
  VirusTotalManager in 'Class\VirusTotal\VirusTotalManager.pas',
  GlobalConstant in 'Class\Other\GlobalConstant.pas',
  VirusTotalAPI in 'GUI\VirusTotalAPI.pas' {FRMVirusTotalAPI};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Light');
  Application.CreateForm(TFRMMain, FRMMain);
  Application.Run;
end.
