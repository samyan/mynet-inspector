Unit VirusTotal;

Interface

Uses
  Winapi.Windows, System.SysUtils, System.Classes, DBXJSON,
  IdMultipartFormData, IdHTTP, SendReport, GlobalConstant;

Const
  SEND_URL = 'http://www.virustotal.com/vtapi/v2/file/scan';

Type
  TVirusTotal = Class(TObject)
  Private
    { private declarations here }
    apiKey: String;
  Protected
    { protected declarations here }
  Public
    { public declarations here }
    Constructor Create; Overload;
    Constructor Create(apiKey: String); Overload;
    Destructor Destroy; Override;

    Function sendFile(filePath: String): TSendReport;

    Property aAPIKey: String Read apiKey Write apiKey;
  End;

Implementation

Constructor TVirusTotal.Create;
Begin
  Inherited Create;
End;

Constructor TVirusTotal.Create(apiKey: String);
Begin
  Inherited Create;
  self.apiKey := apiKey;
End;

Function TVirusTotal.sendFile(filePath: String): TSendReport;
Var
  httpRequest: TIdHTTP;
  params: TIdMultipartFormDataStream;
  response: TStringStream;
  jsonParser: TJSONObject;
Begin
  Result := Nil;
  httpRequest := TIdHTTP.Create(Nil);
  params := TIdMultipartFormDataStream.Create;
  response := TStringStream.Create('');
  jsonParser := TJSONObject.Create;

  Try
    params.AddFormField('apikey', self.apiKey);
    params.AddFile('file', filePath, 'application/octet-stream');

    httpRequest.Post(SEND_URL, params, response);

    Try
      If (response <> Nil) Then
      Begin
        jsonParser := TJSONObject.ParseJSONValue
          (TEncoding.ASCII.GetBytes(response.DataString), 0) As TJSONObject;

        Result := TSendReport.Create;
        Result.aResponseCode := jsonParser.GetValue('response_code').Value;
        Result.aVerboseMsg := jsonParser.GetValue('verbose_msg').Value;
        Result.aResource := jsonParser.GetValue('resource').Value;
        Result.aScanID := jsonParser.GetValue('scan_id').Value;
        Result.aPermanentLink := jsonParser.GetValue('permalink').Value;
        Result.aSHA256Hash := jsonParser.GetValue('sha256').Value;
        Result.aSHA1Hash := jsonParser.GetValue('sha1').Value;
        Result.aMD5Hash := jsonParser.GetValue('md5').Value;
      End;
    Except
      On E: Exception Do
        MessageBoxEx(0, PChar(E.Message), PChar(TGlobalConstant.ALERT_MESSAGE_TITLE), MB_ICONWARNING, 0);
    End;
  Finally
    jsonParser.Free;
    params.Free;
    response.Free;
    httpRequest.Free;
  End;
End;

Destructor TVirusTotal.Destroy;
Begin
  Inherited Destroy;
End;

End.
