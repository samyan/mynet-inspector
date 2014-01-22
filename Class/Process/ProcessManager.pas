Unit ProcessManager;

Interface

Uses
  System.SysUtils, Winapi.Windows, Vcl.Graphics, TLHelp32, ShellAPI, PsAPI,
  Vcl.Dialogs;

Type
  TProcessManager = Class(TObject)
  Private
    { private declarations here }
  Protected
    { protected declarations here }
  Public
    { public declarations here }
    Constructor Create; Overload;
    Destructor Destroy; Override;

    Function getProcessName(pid: Cardinal): String;
    Function getProcessPath(pid: Cardinal): String;
    Function getProcessIcon(processPath: String): TIcon;
    Function killProcess(pid: DWORD): BOOL;
  End;

Implementation

Constructor TProcessManager.Create;
Begin
  Inherited Create;
End;

Function TProcessManager.getProcessName(pid: Cardinal): String;
Var
  procHandle: THandle;
  procEntry: TProcessEntry32;
Begin
  procHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  procEntry.dwSize := SizeOf(procEntry);

  If (Process32First(procHandle, procEntry)) Then
  Begin
    Repeat
      If (procEntry.th32ProcessID = pid) Then
      Begin
        Result := procEntry.szExeFile;
        Break;
      End;
    Until Not(Process32Next(procHandle, procEntry));
  End;

  CloseHandle(procHandle);
End;

Function TProcessManager.getProcessPath(pid: Cardinal): String;
Var
  procHandle: THandle;
  path: Array [0 .. MAX_PATH - 1] Of Char;
Begin
  Result := '-';
  procHandle := OpenProcess(PROCESS_ALL_ACCESS, False, pid);

  If (procHandle <> 0) Then
  Begin
    If (GetModuleFileNameEx(procHandle, 0, path, MAX_PATH) > 0) Then
    Begin
      SetLength(Result, Length(path));
      Result := String(path);
    End
  End;

  CloseHandle(procHandle);
End;

Function TProcessManager.getProcessIcon(processPath: String): TIcon;
Var
  iconHandle: HICON;
Begin
  Result := Nil;

  If (ExtractIconEx(PChar(processPath), 0, HICON(Nil^), iconHandle, 1)
    <> -1) Then
  Begin
    Result := TIcon.Create;
    Result.Handle := iconHandle;
  End;
End;

Function TProcessManager.killProcess(pid: Cardinal): BOOL;
Var
  procHandle: THandle;
Begin
  Result := False;

  procHandle := OpenProcess(PROCESS_ALL_ACCESS, False, pid);

  If (procHandle <> 0) Then
    If (TerminateProcess(procHandle, 0)) Then
      Result := True;

  CloseHandle(procHandle);
End;

Destructor TProcessManager.Destroy;
Begin
  Inherited Destroy;
End;

End.
