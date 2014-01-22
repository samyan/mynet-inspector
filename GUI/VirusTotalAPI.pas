Unit VirusTotalAPI;

Interface

Uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.StdCtrls, Vcl.ImgList, GlobalConstant, Utilities;

Type
  TFRMVirusTotalAPI = Class(TForm)
    txtAPIKey: TEdit;
    Label01: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    btnSave: TButton;
    imgListIcons: TImageList;
    Procedure btnSaveClick(Sender: TObject);
    Procedure FormCreate(Sender: TObject);
  Private
    { Private declarations }
  Public
    { Public declarations }
  End;

Var
  FRMVirusTotalAPI: TFRMVirusTotalAPI;

Implementation

{$R *.dfm}

Procedure TFRMVirusTotalAPI.btnSaveClick(Sender: TObject);
Begin
  If Not(String(txtAPIKey.Text).Equals('')) Then
  Begin
    TUtilities.GetInstance.writeINI(ParamStr(0) + TGlobalConstant.INI_FILE_NAME,
      TGlobalConstant.INI_NAME_GENERAL, TGlobalConstant.INI_VT_KEY_NAME,
      String(txtAPIKey.Text));

    MessageBoxEx(0, PChar(TGlobalConstant.INI_RESTART_APP_MESSAGE),
      PChar(TGlobalConstant.INFO_MESSAGE_TITLE), MB_ICONINFORMATION, 0);

    self.Close;
  End;
End;

Procedure TFRMVirusTotalAPI.FormCreate(Sender: TObject);
Var
  temp: String;
Begin
  temp := TUtilities.GetInstance.readINI(ParamStr(0) + TGlobalConstant.INI_FILE_NAME,
    TGlobalConstant.INI_NAME_GENERAL, TGlobalConstant.INI_VT_KEY_NAME,
    TGlobalConstant.INI_DEFAULT_VALUE);

  If Not(temp.Equals(TGlobalConstant.INI_DEFAULT_VALUE)) Then
    txtAPIKey.Text := temp;
End;

End.
