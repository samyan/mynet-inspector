Unit SendReport;

Interface

Uses
  System.SysUtils;

Type
  TSendReport = Class(TObject)
  Private
    { private declarations here }
    responseCode: String;
    verboseMsg: String;
    resource: String;
    scanID: String;
    permanentLink: String;
    sha256Hash: String;
    sha1Hash: String;
    md5Hash: String;
  Protected
    { protected declarations here }
  Public
    { public declarations here }
    Constructor Create; Overload;
    Destructor Destroy; Override;

    Property aResponseCode: String Read responseCode Write responseCode;
    Property aVerboseMsg: String Read verboseMsg Write verboseMsg;
    Property aResource: String Read resource Write resource;
    Property aScanID: String Read scanID Write scanID;
    Property aPermanentLink: String Read permanentLink Write permanentLink;
    Property aSHA256Hash: String Read sha256Hash Write sha256Hash;
    Property aSHA1Hash: String Read sha1Hash Write sha1Hash;
    Property aMD5Hash: String Read md5Hash Write md5Hash;
  End;

Implementation

Constructor TSendReport.Create;
Begin
  Inherited Create;
End;

Destructor TSendReport.Destroy;
Begin
  Inherited Destroy;
End;

End.
