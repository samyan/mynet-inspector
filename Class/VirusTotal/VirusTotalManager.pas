Unit VirusTotalManager;

Interface

Uses
  Winapi.Windows, System.Classes, VirusTotal, SendReport, VirusTotalReport;

Type
  TVirusTotalManager = Class(TThread)
  Private
    { private declarations here }
    vtScanner: TVirusTotal;
    vtSendReport: TSendReport;

    apiKey: String;
    fileName: String;
  Protected
    { protected declarations here }
    Procedure Execute; Override;
  Public
    { public declarations here }
    Constructor Create; Overload;
    Constructor Create(apiKey: String; fileName: String); Overload;
    Destructor Destroy; Override;

    Function getResponse: TSendReport;

    Property aAPIKey: String Read apiKey Write apiKey;
  End;

Implementation

Constructor TVirusTotalManager.Create;
Begin
  Inherited Create(True);
End;

Constructor TVirusTotalManager.Create(apiKey: String; fileName: String);
Begin
  Inherited Create(True);

  self.apiKey := apiKey;
  self.fileName := fileName;
End;

Procedure TVirusTotalManager.Execute;
Begin
  self.vtScanner := TVirusTotal.Create(self.apiKey);
  self.vtSendReport := vtScanner.sendFile(self.fileName);
  self.vtScanner.Free;
End;

Function TVirusTotalManager.getResponse;
begin
  Result := self.vtSendReport;
end;

Destructor TVirusTotalManager.Destroy;
Begin
  Inherited Destroy;
End;

End.
