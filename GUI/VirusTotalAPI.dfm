object FRMVirusTotalAPI: TFRMVirusTotalAPI
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'VirusTotal API Configuration'
  ClientHeight = 153
  ClientWidth = 402
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label01: TLabel
    Left = 8
    Top = 8
    Width = 135
    Height = 13
    Caption = '1) Go to VirusTotal Web Site'
  end
  object Label1: TLabel
    Left = 8
    Top = 27
    Width = 261
    Height = 13
    Caption = '2) Register and get API Key from your personal profile'
  end
  object Label2: TLabel
    Left = 8
    Top = 46
    Width = 79
    Height = 13
    Caption = '3) Come back  :)'
  end
  object Label3: TLabel
    Left = 8
    Top = 77
    Width = 88
    Height = 13
    Caption = 'VirusTotal API KEY'
  end
  object txtAPIKey: TEdit
    Left = 8
    Top = 96
    Width = 377
    Height = 21
    TabOrder = 0
  end
  object btnSave: TButton
    Left = 320
    Top = 123
    Width = 66
    Height = 25
    Caption = 'Save'
    HotImageIndex = 0
    ImageIndex = 0
    ImageMargins.Left = 5
    Images = imgListIcons
    TabOrder = 1
    OnClick = btnSaveClick
  end
  object imgListIcons: TImageList
    ColorDepth = cd32Bit
    Left = 344
    Top = 16
    Bitmap = {
      494C0101010008001C0010001000FFFFFFFF2110FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000F000000170000001A0000
      001A0000001A0000001A0000001A0000001A0000001A0000001A0000001A0000
      001A0000001A0000001A000000170000000F0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000001E000000B7000000E70A0A
      018A0A0A018A0A0A018A0A0A018A0A0A018A0A0A018A0A0A018A0A0A018A0A0A
      018A0A0A018A000000E7000000B70000001E0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000DB636363FFFAFA
      EAFFF4F4E4FFF4F4E4FFF4F4E4FFF4F4E4FFF4F4E4FFF4F4E4FFF4F4E4FFF4F4
      E4FFFAFAEAFF636363FF000000DB000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000CE616161FFF6F6
      E9FFECECDFFFECECDFFFECECDFFFECECDFFFECECDFFFECECDFFFECECDFFFECEC
      DFFFF6F6E9FF616161FF000000CE000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000C9636363FFF8F8
      EFFFF1F1E7FFF1F1E7FFF1F1E7FFF1F1E7FFF1F1E7FFF1F1E7FFF1F1E7FFF1F1
      E7FFF8F8EFFF636363FF000000C9000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000C5666666FFFBFB
      F5FFF6F6F0FFF6F6F0FFF6F6F0FFF6F6F0FFF6F6F0FFF6F6F0FFF6F6F0FFF6F6
      F0FFFBFBF5FF666666FF000000C5000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000C16A6A6AFFFEFE
      FBFFFBFBF8FFFBFBF8FFFBFBF8FFFBFBF8FFFBFBF8FFFBFBF8FFFBFBF8FFFBFB
      F8FFFEFEFBFF6A6A6AFF000000C1000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000BE6D6D6DFFD9D9
      D9FFFFFFFEFFFFFFFEFFFFFFFEFFFFFFFEFFFFFFFEFFFFFFFEFFFFFFFEFFFFFF
      FEFFD9D9D9FF6D6D6DFF000000BE000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000BB717171FF6868
      68FF686868FF686868FF686868FF686868FF686868FF686868FF686868FF6868
      68FF686868FF717171FF000000BB000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000B8747474FF3838
      38FF383838FF383838FF383838FF383838FF383838FF383838FF383838FF3838
      38FF383838FF747474FF000000B8000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000B5787878FF4242
      42FF595959FF424242FFCABCBCFFC6B8B8FFC6B8B8FFCEC0C0FFCEC0C0FFCABC
      BCFF424242FF787878FF000000B5000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000B27B7B7BFF4F4F
      4FFF636363FF4F4F4FFFCBC2C2FFC2B9B9FFC2B9B9FF4F4F4FFF4F4F4FFFCBC2
      C2FF4F4F4FFF7B7B7BFF000000B2000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000B07D7D7DFF5B5B
      5BFF6D6D6DFF5B5B5BFFD1CCCCFFC8C3C3FFC8C3C3FF5B5B5BFF5B5B5BFFD1CC
      CCFF5B5B5BFF828282FF000000B0000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000AE848484FF6464
      64FF7D7D7DFF646464FFD9D8D8FFD4D3D3FFD4D3D3FF646464FF646464FFD9D8
      D8FF404040EB000000AE0000003E000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000081000000AC0000
      00AC000000AC000000AC0D0D0D660D0D0D660D0D0D660D0D0D660D0D0D660D0D
      0D66000000AC0000003C00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000}
  end
end
