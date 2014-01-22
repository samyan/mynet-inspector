Unit Main;

Interface

Uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, ShellAPI, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ComCtrls, Vcl.ToolWin, Vcl.ImgList, AppController, IdBaseComponent, About,
  Vcl.Menus, VirusTotalAPI;

Type
  TFRMMain = Class(TForm)
    lsvConnections: TListView;
    STB_Status: TStatusBar;
    tlbMenu: TToolBar;
    imgListImages: TImageList;
    ToolButton1: TToolButton;
    tlbtnClose: TToolButton;
    tlbtnKill: TToolButton;
    ToolButton2: TToolButton;
    tlbtnScan: TToolButton;
    ToolButton3: TToolButton;
    tlbtnAbout: TToolButton;
    tlbtnRefresh: TToolButton;
    imgListIcons: TImageList;
    mmMenuBar: TMainMenu;
    miOptions: TMenuItem;
    miVirusTotalAPI: TMenuItem;
    Procedure FormCreate(Sender: TObject);
    Procedure tlbtnCloseClick(Sender: TObject);
    Procedure tlbtnRefreshClick(Sender: TObject);
    Procedure tlbtnKillClick(Sender: TObject);
    Procedure tlbtnScanClick(Sender: TObject);
    Procedure tlbtnAboutClick(Sender: TObject);
    Procedure miVirusTotalAPIClick(Sender: TObject);
  Private
    { Private declarations }
    AppController: TAppController;
  Public
    { Public declarations }
  End;

Var
  FRMMain: TFRMMain;

Implementation

{$R *.dfm}

Procedure TFRMMain.FormCreate(Sender: TObject);
Begin
  self.AppController := TAppController.Create(self.lsvConnections, self.imgListIcons, self.STB_Status);
  self.AppController.loadConnections;
End;

Procedure TFRMMain.miVirusTotalAPIClick(Sender: TObject);
Var
  frmVTApi: TFRMVirusTotalAPI;
Begin
  frmVTApi := TFRMVirusTotalAPI.Create(Nil);
  frmVTApi.Show;
End;

Procedure TFRMMain.tlbtnAboutClick(Sender: TObject);
Var
  frmAbout: TFRMAbout;
Begin
  frmAbout := TFRMAbout.Create(Nil);
  frmAbout.Show;
End;

Procedure TFRMMain.tlbtnCloseClick(Sender: TObject);
Begin
  If (self.lsvConnections.ItemIndex > -1) Then
    If (self.AppController <> Nil) Then
      self.AppController.closeConnection(self.lsvConnections.ItemIndex);
End;

Procedure TFRMMain.tlbtnKillClick(Sender: TObject);
Begin
  If (self.lsvConnections.ItemIndex > -1) Then
    If (self.AppController <> Nil) Then
      self.AppController.killProcess(self.lsvConnections.ItemIndex);
End;

Procedure TFRMMain.tlbtnRefreshClick(Sender: TObject);
Begin
  If (self.AppController <> Nil) Then
    self.AppController.refreshConnections;
End;

Procedure TFRMMain.tlbtnScanClick(Sender: TObject);
Begin
  If (self.lsvConnections.ItemIndex > -1) Then
    If (self.AppController <> Nil) Then
      self.AppController.scanFile(self.lsvConnections.ItemIndex);
End;

End.
