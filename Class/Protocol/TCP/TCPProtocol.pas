Unit TCPProtocol;

Interface

Uses
  Winapi.Windows, Winapi.IpHlpApi, Winapi.IpRtrMib, System.SysUtils,
  System.Classes, Vcl.Dialogs, System.Types,
  Connection, ConnectionList, ProcessManager;

Const
  TCP_TABLE_OWNER_PID_ALL = 5;
  AF_INET = 2;
  IPV4_NETWORK_TYPE = 'TCP';

Type
  PMIB_TCPROW_OWNER_PID = ^MIB_TCPROW_OWNER_PID;

  MIB_TCPROW_OWNER_PID = Packed Record
    dwState: DWORD;
    dwLocalAddr: DWORD;
    dwLocalPort: DWORD;
    dwRemoteAddr: DWORD;
    dwRemotePort: DWORD;
    dwOwningPid: DWORD;
  End;

  PMIB_TCPTABLE_OWNER_PID = ^MIB_TCPTABLE_OWNER_PID;

  MIB_TCPTABLE_OWNER_PID = Packed Record
    dwNumEntries: DWORD;
    table: Array [0 .. 0] Of MIB_TCPROW_OWNER_PID;
  End;

  TCP_TABLE_CLASS = Integer;

  TTCPProtocol = Class(TObject)
  Private
    { private declarations here }
    connectionList: TConnectionList;
  Protected
    { protected declarations here }
  Public
    { public declarations here }
    Constructor Create; Overload;
    Destructor Destroy; Override;

    Function getConnections: TConnectionList;
    Function closeConnection(connection: TConnection): BOOL;
    Function stateToStr(state: DWORD): String;
  End;

Implementation

Function GetExtendedTcpTable(pTcpTable: Pointer; dwSize: PDWORD; bOrder: BOOL;
  lAf: ULONG; TableClass: TCP_TABLE_CLASS; Reserved: ULONG): DWORD; Stdcall;
  External 'iphlpapi.dll';

Constructor TTCPProtocol.Create;
Begin
  Inherited Create;
  self.connectionList := TConnectionList.Create;
End;

Function TTCPProtocol.getConnections: TConnectionList;
Var
  tableSize: DWORD;
  i: DWORD;
  tcpTable: PMIB_TCPTABLE_OWNER_PID;
  connection: TConnection;
  procMan: TProcessManager;
Begin
  Result := self.connectionList;
  tableSize := 0;

  If (GetExtendedTcpTable(Nil, @tableSize, False, AF_INET,
    TCP_TABLE_OWNER_PID_ALL, 0) <> ERROR_INSUFFICIENT_BUFFER) Then
    Exit;

  GetMem(tcpTable, tableSize);

  If (GetExtendedTcpTable(tcpTable, @tableSize, False, AF_INET,
    TCP_TABLE_OWNER_PID_ALL, 0) <> NO_ERROR) Then
    Exit;

  If (tcpTable <> NIl) Then
  Begin
    procMan := TProcessManager.Create;

    For i := 0 To tcpTable.dwNumEntries - 1 Do
    Begin
      connection := TConnection.Create;

      connection.aPID := tcpTable.table[i].dwOwningPid;
      connection.aProtocol := IPV4_NETWORK_TYPE;
      connection.aLocalPort := tcpTable.table[i].dwLocalPort;
      connection.aLocalIP := tcpTable.table[i].dwLocalAddr;
      connection.aRemotePort := tcpTable.table[i].dwRemotePort;
      connection.aRemoteIP := tcpTable.table[i].dwRemoteAddr;
      connection.aState := tcpTable.table[i].dwState;

      connection.aProcess.aName := procMan.getProcessName(tcpTable.table[i].dwOwningPid);
      connection.aProcess.aPath := procMan.getProcessPath(tcpTable.table[i].dwOwningPid);

      If (connection.aProcess.aPath <> '') Then
        connection.aProcess.aSmallIcon := procMan.getProcessIcon(connection.aProcess.aPath);

      self.connectionList.addConnection(connection);
    End;

    procMan.Destroy;
    FreeMem(tcpTable);
  End;

  Result := self.connectionList;
End;

Function TTCPProtocol.closeConnection(connection: TConnection): BOOL;
Var
  tcpRow: MIB_TCPROW;
Begin
  Result := False;

  If (connection.aState = MIB_TCP_STATE_ESTAB) Then
  Begin
    tcpRow.dwState := MIB_TCP_STATE_DELETE_TCB;
    tcpRow.dwLocalAddr := connection.aLocalIP;
    tcpRow.dwLocalPort := connection.aLocalPort;
    tcpRow.dwRemoteAddr := connection.aRemoteIP;
    tcpRow.dwRemotePort := connection.aRemotePort;

    If (SetTcpEntry(tcpRow) = NO_ERROR) Then
      Result := True;
  End;
End;

Function TTCPProtocol.stateToStr(state: Cardinal): String;
Var
  temp: String;
Begin
  Case state Of
    MIB_TCP_STATE_CLOSED:
      temp := 'CLOSED';
    MIB_TCP_STATE_LISTEN:
      temp := 'LISTENING';
    MIB_TCP_STATE_SYN_SENT:
      temp := 'SYN_SENT';
    MIB_TCP_STATE_SYN_RCVD:
      temp := 'SYN_RCVD';
    MIB_TCP_STATE_ESTAB:
      temp := 'ESTABLISHED';
    MIB_TCP_STATE_FIN_WAIT1:
      temp := 'FIN_WAIT1';
    MIB_TCP_STATE_FIN_WAIT2:
      temp := 'FIN_WAIT2';
    MIB_TCP_STATE_CLOSE_WAIT:
      temp := 'CLOSE_WAIT';
    MIB_TCP_STATE_CLOSING:
      temp := 'CLOSING';
    MIB_TCP_STATE_LAST_ACK:
      temp := 'LAST_ACK';
    MIB_TCP_STATE_TIME_WAIT:
      temp := 'TIME_WAIT';
    MIB_TCP_STATE_DELETE_TCB:
      temp := 'DELETE_TCB';
  Else
    temp := 'UNKNOWN_STATE';
  End;

  Result := temp;
End;

Destructor TTCPProtocol.Destroy;
Begin
  Inherited Destroy;
End;

End.
