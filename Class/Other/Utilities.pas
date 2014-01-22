Unit Utilities;

Interface

Uses
  Winapi.Windows, System.SysUtils;

Type
  TUtilities = Class(TObject)
  Strict Private
    { strict private declarations here }
    Class Var FInstance: TUtilities;
    Constructor Create;
  Private
    { private declarations here }
  Protected
    { protected declarations here }
  Public
    { public declarations here }
    Class Function GetInstance: TUtilities;
    Destructor Destroy; Override;

    Function readINI(path: String; name: String; keyName: String;
      default: String): String;
    Function writeINI(path: String; name: String; keyName: String;
      value: String): BOOL;
  End;

Implementation

Constructor TUtilities.Create;
Begin
  Inherited Create;
End;

Class Function TUtilities.GetInstance: TUtilities;
Begin
  If (FInstance = Nil) Then
    FInstance := TUtilities.Create();

  Result := FInstance;
End;

Function TUtilities.readINI(path: String; name: String; keyName: String;
  default: String): String;
Var
  buffer: Array [0 .. 255] Of Char;
Begin
  GetPrivateProfileString(PChar(Name), PChar(keyName), PChar(Default), buffer,
    SizeOf(buffer), PChar(path));
  Result := String(buffer);
End;

Function TUtilities.writeINI(path: String; name: String; keyName: String;
  value: String): BOOL;
Begin
  Result := WritePrivateProfileString(PChar(Name), PChar(keyName), PChar(value),
    PChar(path));
End;

Destructor TUtilities.Destroy;
Begin
  Inherited Destroy;
End;

End.
