Unit AppController;

Interface

Uses
  Winapi.Windows, System.SysUtils, Vcl.Graphics, Vcl.Dialogs, Vcl.ComCtrls,
  Vcl.Controls, Winsock, ProcessManager, TCPProtocol, UDPProtocol,
  ConnectionList, SynaIP, VirusTotalManager, SendReport, GlobalConstant,
  VirusTotalReport, Vcl.Forms, Utilities;

Type
  TAppController = Class(TObject)
  Private
    { private declarations here }
    listView: TListView;
    imageList: TImageList;
    statusBar: TStatusBar;

    vtAPIKey: String;
    connections: TConnectionList;

    Procedure getVTApiKey;
  Protected
    { protected declarations here }
  Public
    { public declarations here }
    Constructor Create; Overload;
    Constructor Create(listView: TListView; imageList: TImageList;
      statusBar: TStatusBar); Overload;
    Destructor Destroy; Override;

    Procedure loadConnections;
    Procedure refreshConnections;
    Procedure closeConnection(id: Integer);
    Procedure killProcess(id: Integer);
    Procedure scanFile(id: Integer);

    Property aListView: TListView Read listView Write listView;
    Property aImageList: TImageList Read imageList Write imageList;
    Property aStatusBar: TStatusBar Read statusBar Write statusBar;
  End;

Implementation

Constructor TAppController.Create;
Begin
  Inherited Create;
  self.getVTApiKey;
End;

Constructor TAppController.Create(listView: TListView; imageList: TImageList;
  statusBar: TStatusBar);
Begin
  Inherited Create;
  self.listView := listView;
  self.imageList := imageList;
  self.statusBar := statusBar;
  self.getVTApiKey;
End;

Procedure TAppController.loadConnections;
Var
  index: Integer;
  listItem: TListItem;
  tcp4Protocol: TTCPProtocol;
  udp4Protocol: TUDPProtocol;
Begin
  self.connections := TConnectionList.Create;
  tcp4Protocol := TTCPProtocol.Create;
  udp4Protocol := TUDPProtocol.Create;

  self.connections.addConnectionList(tcp4Protocol.getConnections); // TCP v4
  self.connections.addConnectionList(udp4Protocol.getProcessConnections); // UDP v4

  Try
    self.listView.Items.Clear;
    self.listView.Items.BeginUpdate;

    For Index := 0 To connections.getConnectionCount - 1 Do
    Begin
      listItem := self.listView.Items.Add;

      If (self.connections.getConnection(Index).aProcess.aSmallIcon.Empty = False) Then
        listItem.ImageIndex := self.imageList.AddIcon(self.connections.getConnection(Index).aProcess.aSmallIcon);

      listItem.Caption := self.connections.getConnection(Index).aProcess.aName;
      listItem.SubItems.Add(self.connections.getConnection(Index).aProcess.aPath);
      listItem.SubItems.Add(IntToStr(self.connections.getConnection(Index).aPID));
      listItem.SubItems.Add(self.connections.getConnection(Index).aProtocol);
      listItem.SubItems.Add(IntToStr(htons(self.connections.getConnection(Index).aLocalPort)));
      listItem.SubItems.Add(ReverseIP(IpToStr(self.connections.getConnection(Index).aLocalIP)));
      listItem.SubItems.Add(IntToStr(htons(self.connections.getConnection(Index).aRemotePort)));
      listItem.SubItems.Add(ReverseIP(IpToStr(self.connections.getConnection(Index).aRemoteIP)));

      If ((self.connections.getConnection(Index).aProtocol.Equals('TCP')) Or
        (self.connections.getConnection(Index).aProtocol.Equals('TCPv6'))) Then
        listItem.SubItems.Add(tcp4Protocol.stateToStr(self.connections.getConnection(Index).aState))
      Else
        listItem.SubItems.Add('-');
    End;
  Finally
    self.listView.Items.EndUpdate;
  End;

  self.statusBar.Panels.Items[0].Text := 'Endpoints: ' + IntToStr(self.connections.getConnectionCount);

  udp4Protocol.Free;
  tcp4Protocol.Free;
End;

Procedure TAppController.refreshConnections;
Begin
  self.loadConnections;
End;

Procedure TAppController.closeConnection(id: Integer);
Var
  tcp4Protocol: TTCPProtocol;
Begin
  tcp4Protocol := TTCPProtocol.Create;

  If ((self.connections.getConnection(id).aProtocol.Equals('TCP')) Or
    (self.connections.getConnection(id).aProtocol.Equals('TCPv6'))) Then
    If (tcp4Protocol.closeConnection(self.connections.getConnection(id)) = True) Then
      self.loadConnections
    Else
      MessageBoxEx(0, PChar(TGlobalConstant.CLOSE_MESSAGE),
        PChar(TGlobalConstant.ALERT_MESSAGE_TITLE), MB_ICONWARNING, 0);

  tcp4Protocol.Free;
End;

Procedure TAppController.killProcess(id: Integer);
Var
  procManager: TProcessManager;
Begin
  procManager := TProcessManager.Create;

  If (procManager.killProcess(Cardinal(self.connections.getConnection(id).aPID)) = True) Then
    self.loadConnections
  Else
    MessageBoxEx(0, PChar(TGlobalConstant.KILL_MESSAGE),
      PChar(TGlobalConstant.ALERT_MESSAGE_TITLE), MB_ICONWARNING, 0);

  procManager.Destroy;
End;

Procedure TAppController.scanFile(id: Integer);
Var
  vtManager: TVirusTotalManager;
  threadHandle: THandle;
  frmVTReport: TFRMVirusTotalReport;
Begin
  If Not(self.vtAPIKey.Equals('')) Then
  Begin
    If Not(self.connections.getConnection(id).aProcess.aPath.Equals('')) Then
    Begin
      vtManager := TVirusTotalManager.Create(self.vtAPIKey, self.connections.getConnection(id).aProcess.aPath);
      vtManager.Start;

      Try
        threadHandle := vtManager.Handle;

        Repeat
          Case MsgWaitForMultipleObjects(1, threadHandle, False, INFINITE, QS_ALLINPUT) Of
            WAIT_OBJECT_0:
              Break;
            WAIT_OBJECT_0 + 1:
              Application.ProcessMessages;
            WAIT_FAILED:
              RaiseLastOSError;
          Else
            Break;
          End;
        Until False;

        frmVTReport := TFRMVirusTotalReport.Create(Nil);
        frmVTReport.lblFile.Caption := self.connections.getConnection(id).aProcess.aPath;
        frmVTReport.lblMD5.Caption := vtManager.getResponse.aMD5Hash;
        frmVTReport.lblSHA256.Caption := vtManager.getResponse.aSHA256Hash;
        frmVTReport.lblSHA1.Caption := vtManager.getResponse.aSHA1Hash;
        frmVTReport.aScanURL := vtManager.getResponse.aPermanentLink;
        frmVTReport.Show;
      Finally
        vtManager.Free;
      End;
    End;
  End
  Else
  Begin
    MessageBoxEx(0, PChar(TGlobalConstant.VIRUS_TOTAL_API_ERROR),
      PChar(TGlobalConstant.ALERT_MESSAGE_TITLE), MB_ICONWARNING, 0);
  End;
End;

Procedure TAppController.getVTApiKey;
Begin
  self.vtAPIKey := TUtilities.GetInstance.readINI(ParamStr(0) + TGlobalConstant.INI_FILE_NAME,
    TGlobalConstant.INI_NAME_GENERAL, TGlobalConstant.INI_VT_KEY_NAME, TGlobalConstant.INI_DEFAULT_VALUE);

  If (self.vtAPIKey.Equals(TGlobalConstant.INI_DEFAULT_VALUE)) Then
    self.vtAPIKey := '';
End;

Destructor TAppController.Destroy;
Begin
  Inherited Destroy;
End;

End.
