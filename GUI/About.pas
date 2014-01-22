Unit About;

Interface

Uses
  Winapi.Windows, Winapi.Messages, Winapi.ShellAPI, System.SysUtils,
  System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Vcl.StdCtrls;

Type
  TFRMAbout = Class(TForm)
    btnOK: TButton;
    lblVisitProject: TLabel;
    gbInformation: TGroupBox;
    Label01: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    gbCredits: TGroupBox;
    lblVisitSynapse: TLabel;
    lblVisitVirusTotal: TLabel;
    lblVisitGitHub: TLabel;
    VisitIconFinder: TLabel;
    GB_Thanks: TGroupBox;
    Label3: TLabel;
    Procedure btnOKClick(Sender: TObject);
    Procedure lblVisitProjectClick(Sender: TObject);
    Procedure lblVisitSynapseClick(Sender: TObject);
    Procedure lblVisitVirusTotalClick(Sender: TObject);
    Procedure lblVisitGitHubClick(Sender: TObject);
    Procedure VisitIconFinderClick(Sender: TObject);
  Private
    { Private declarations }
  Public
    { Public declarations }
  End;

Implementation

{$R *.dfm}

Procedure TFRMAbout.btnOKClick(Sender: TObject);
Begin
  self.Close;
End;

Procedure TFRMAbout.lblVisitGitHubClick(Sender: TObject);
Begin
  ShellExecute(0, 'OPEN', PChar(lblVisitGitHub.Hint), '', '', SW_SHOWNORMAL);
End;

Procedure TFRMAbout.lblVisitProjectClick(Sender: TObject);
Begin
  ShellExecute(0, 'OPEN', PChar(lblVisitProject.Hint), '', '', SW_SHOWNORMAL);
End;

Procedure TFRMAbout.lblVisitSynapseClick(Sender: TObject);
Begin
  ShellExecute(0, 'OPEN', PChar(lblVisitSynapse.Hint), '', '', SW_SHOWNORMAL);
End;

Procedure TFRMAbout.lblVisitVirusTotalClick(Sender: TObject);
Begin
  ShellExecute(0, 'OPEN', PChar(lblVisitVirusTotal.Hint), '', '', SW_SHOWNORMAL);
End;

Procedure TFRMAbout.VisitIconFinderClick(Sender: TObject);
Begin
  ShellExecute(0, 'OPEN', PChar(VisitIconFinder.Hint), '', '', SW_SHOWNORMAL);
End;

End.
