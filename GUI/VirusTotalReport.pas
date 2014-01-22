Unit VirusTotalReport;

Interface

Uses
  Winapi.Windows, Winapi.ShellAPI, Winapi.Messages, System.SysUtils,
  System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ImgList, Vcl.StdCtrls;

Type
  TFRMVirusTotalReport = Class(TForm)
    Label1: TLabel;
    lblMD5: TLabel;
    Label2: TLabel;
    lblSHA256: TLabel;
    Label3: TLabel;
    lblSHA1: TLabel;
    Label4: TLabel;
    lblFile: TLabel;
    btnViewReport: TButton;
    imgListIcons: TImageList;
    Procedure btnViewReportClick(Sender: TObject);
  Private
    { Private declarations }
    scanURL: String;
  Public
    { Public declarations }
    Property aScanURL: String Read scanURL Write scanURL;
  End;

Var
  FRMVirusTotalReport: TFRMVirusTotalReport;

Implementation

{$R *.dfm}

Procedure TFRMVirusTotalReport.btnViewReportClick(Sender: TObject);
Begin
  ShellExecute(0, 'OPEN', PChar(scanURL), '', '', SW_SHOWNORMAL);
End;

End.
