Unit Process;

Interface

Uses
  System.SysUtils, Vcl.Graphics;

Type
  TProcess = Class(TObject)
  Private
    { private declarations here }
    name: String;
    path: String;
    smallIcon: TIcon;
  Protected
    { protected declarations here }
  Public
    { public declarations here }
    Constructor Create; Overload;
    Constructor Create(name: String; path: String; smallIcon: TIcon); Overload;
    Destructor Destroy; Override;

    Property aName: String Read name Write name;
    Property aPath: String Read path Write path;
    Property aSmallIcon: TIcon Read smallIcon Write smallIcon;
  End;

Implementation

Constructor TProcess.Create;
Begin
  Inherited Create;
End;

Constructor TProcess.Create(name: String; path: String; smallIcon: TIcon);
Begin
  Inherited Create;
  self.name := Name;
  self.path := path;
  self.smallIcon := smallIcon;
End;

Destructor TProcess.Destroy;
Begin
  Inherited Destroy;
End;

End.
