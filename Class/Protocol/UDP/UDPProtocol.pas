unit UDPProtocol;

Interface

Uses
  Winapi.Windows, Winapi.IpHlpApi, Winapi.IpRtrMib, System.SysUtils,
  System.Classes, Vcl.Dialogs, System.Types,
  Connection, ConnectionList, ProcessManager, SynaIP;

Const
  UDP_TABLE_OWNER_PID = 1;
  AF_INET = 2;
  IPV4_NETWORK_TYPE = 'UDP';

Type
  PMIB_UDPROW_OWNER_PID = ^MIB_UDPROW_OWNER_PID;

  MIB_UDPROW_OWNER_PID = Packed Record
    dwLocalAddr: DWORD;
    dwLocalPort: DWORD;
    dwOwningPid: DWORD;
  End;

  PMIB_UDPTABLE_OWNER_PID  = ^MIB_UDPTABLE_OWNER_PID;

  MIB_UDPTABLE_OWNER_PID  = Packed Record
    dwNumEntries: DWORD;
    table: Array [0 .. 0] Of MIB_UDPROW_OWNER_PID;
  End;

  UDP_TABLE_CLASS = Integer;

  TUDPProtocol = Class(TObject)
  Private
    { private declarations here }
    connectionList: TConnectionList;
  Protected
    { protected declarations here }
  Public
    { public declarations here }
    Constructor Create; Overload;
    Destructor Destroy; Override;

    Function getProcessConnections: TConnectionList;
  End;

Implementation

Function GetExtendedUdpTable(pUdpTable: Pointer; dwSize: PDWORD; bOrder: BOOL;
  lAf: ULONG; TableClass: UDP_TABLE_CLASS; Reserved: ULONG): DWORD; Stdcall;
  External 'iphlpapi.dll';

Constructor TUDPProtocol.Create;
Begin
  Inherited Create;
  self.connectionList := TConnectionList.Create;
End;

Function TUDPProtocol.getProcessConnections: TConnectionList;
Var
  tableSize: DWORD;
  i: DWORD;
  udpTable: PMIB_UDPTABLE_OWNER_PID;
  connection: TConnection;
  procManage: TProcessManager;
Begin
  Result := self.connectionList;
  tableSize := 0;

  If (GetExtendedUdpTable(Nil, @tableSize, False, AF_INET, UDP_TABLE_OWNER_PID,
    0) <> ERROR_INSUFFICIENT_BUFFER) Then
    Exit;

  GetMem(udpTable, tableSize);

  If (GetExtendedUdpTable(udpTable, @tableSize, True, AF_INET,
    UDP_TABLE_OWNER_PID, 0) <> NO_ERROR) Then
    Exit;

  If (udpTable <> NIl) Then
  Begin
    procManage := TProcessManager.Create;

    For i := 0 To udpTable.dwNumEntries - 1 Do
    Begin
      connection := TConnection.Create;

      connection.aPID := udpTable.table[i].dwOwningPid;
      connection.aProtocol := IPV4_NETWORK_TYPE;
      connection.aLocalPort := udpTable.table[i].dwLocalPort;
      connection.aLocalIP := udpTable.table[i].dwLocalAddr;
      connection.aRemotePort := 0;
      connection.aRemoteIP := 0;
      connection.aState := 100;

      connection.aProcess.aName := procManage.getProcessName(udpTable.table[i].dwOwningPid);
      connection.aProcess.aPath := procManage.getProcessPath(udpTable.table[i].dwOwningPid);

      If (connection.aProcess.aPath <> '') Then
        connection.aProcess.aSmallIcon := procManage.getProcessIcon(connection.aProcess.aPath);

      self.connectionList.addConnection(connection);
    End;

    procManage.Destroy;
    FreeMem(udpTable);
  End;

  Result := self.connectionList;
End;

Destructor TUDPProtocol.Destroy;
Begin
  Inherited Destroy;
End;

End.
