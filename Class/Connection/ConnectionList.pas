Unit ConnectionList;

Interface

Uses
  Winapi.Windows, System.Classes, System.Types, Connection;

Type
  TConnectionList = Class(TObject)
  Private
    { private declarations here }
    connectionList: TList;
  Protected
    { protected declarations here }
  Public
    { public declarations here }
    Constructor Create;
    Destructor Destroy; Override;

    Procedure addConnection(connection: TConnection);
    Procedure deleteConnection(id: Integer);
    Procedure clearConnections;
    Procedure addConnectionList(connectionList: TConnectionList);

    Function getConnection(index: Integer): TConnection;
    Function getConnectionCount: Integer;
  End;

Implementation

Constructor TConnectionList.Create;
Begin
  Inherited Create;
  self.connectionList := TList.Create;
End;

Procedure TConnectionList.addConnection(connection: TConnection);
Begin
  self.connectionList.Add(connection);
End;

Procedure TConnectionList.deleteConnection(id: Integer);
Begin
  self.connectionList.Delete(id);
End;

Procedure TConnectionList.addConnectionList(connectionList: TConnectionList);
Var
  i: Integer;
Begin
  For i := 0 To connectionList.getConnectionCount - 1 Do
    self.connectionList.Add(connectionList.getConnection(i));
End;

Function TConnectionList.getConnection(index: Integer): TConnection;
Begin
  Result := self.connectionList.Items[Index];
End;

Function TConnectionList.getConnectionCount: Integer;
Begin
  Result := self.connectionList.Count;
End;

Procedure TConnectionList.clearConnections;
Begin
  self.connectionList.Clear;
End;

Destructor TConnectionList.Destroy;
Begin
  If (self.connectionList <> Nil) Then
  Begin
    self.connectionList.Clear;
    self.connectionList.Free;
  End;

  Inherited Destroy;
End;

End.
