object FRMAbout: TFRMAbout
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'About'
  ClientHeight = 305
  ClientWidth = 473
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lblVisitProject: TLabel
    Left = 8
    Top = 283
    Width = 130
    Height = 13
    Cursor = crHandPoint
    Hint = 'https://github.com/Fakedo0r/Sub-Soul'
    Caption = 'MyNet Inspector on GitHub'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsUnderline]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    OnClick = lblVisitProjectClick
  end
  object btnOK: TButton
    Left = 382
    Top = 271
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 0
    OnClick = btnOKClick
  end
  object gbInformation: TGroupBox
    Left = 8
    Top = 8
    Width = 449
    Height = 89
    Caption = 'Information'
    TabOrder = 1
    object Label01: TLabel
      Left = 16
      Top = 20
      Width = 172
      Height = 13
      Caption = 'MyNet Inspector v0.2 [29.11.2013]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 16
      Top = 39
      Width = 161
      Height = 13
      Caption = 'Licensed under the GNU GPL3, v3'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 16
      Top = 58
      Width = 250
      Height = 13
      Caption = 'Copyright '#169' 2013 SecurityNull, All Rights Reserved.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
  end
  object gbCredits: TGroupBox
    Left = 8
    Top = 103
    Width = 449
    Height = 106
    Caption = 'Credits to'
    TabOrder = 2
    object lblVisitSynapse: TLabel
      Left = 16
      Top = 20
      Width = 157
      Height = 13
      Cursor = crHandPoint
      Hint = 'http://www.ararat.cz/synapse/doku.php'
      Caption = 'Ararat Synapse [SynaIP Module]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsUnderline]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = lblVisitSynapseClick
    end
    object lblVisitVirusTotal: TLabel
      Left = 16
      Top = 39
      Width = 111
      Height = 13
      Cursor = crHandPoint
      Hint = 'https://www.virustotal.com/'
      Caption = 'VirusTotal Scan Service'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsUnderline]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = lblVisitVirusTotalClick
    end
    object lblVisitGitHub: TLabel
      Left = 16
      Top = 58
      Width = 87
      Height = 13
      Cursor = crHandPoint
      Hint = 'https://github.com/'
      Caption = 'GitHub Repository'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsUnderline]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = lblVisitGitHubClick
    end
    object VisitIconFinder: TLabel
      Left = 16
      Top = 77
      Width = 51
      Height = 13
      Cursor = crHandPoint
      Hint = 'https://www.iconfinder.com/'
      Caption = 'IconFinder'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsUnderline]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = VisitIconFinderClick
    end
  end
  object GB_Thanks: TGroupBox
    Left = 8
    Top = 215
    Width = 449
    Height = 50
    Caption = 'Thanks to'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    object Label3: TLabel
      Left = 16
      Top = 24
      Width = 117
      Height = 13
      Caption = '- Poseidon [Bug reports]'
    end
  end
end
