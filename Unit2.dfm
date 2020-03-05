object Form2: TForm2
  Left = 216
  Top = 127
  BorderIcons = [biMinimize, biMaximize]
  BorderStyle = bsDialog
  Caption = 'Retrofire: '#12466#12540#12512#24773#22577#12398#21462#24471
  ClientHeight = 143
  ClientWidth = 567
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = #12513#12452#12522#12458
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  Scaled = False
  OnShow = FormShow
  DesignSize = (
    567
    143)
  PixelsPerInch = 96
  TextHeight = 17
  object Label4: TLabel
    Left = 20
    Top = 110
    Width = 212
    Height = 16
    AutoSize = False
    Font.Charset = SHIFTJIS_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #12513#12452#12522#12458
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel
    Left = 296
    Top = 113
    Width = 4
    Height = 18
    Anchors = [akLeft, akBottom]
    Caption = ' '
    Font.Charset = SHIFTJIS_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #12513#12452#12522#12458
    Font.Style = []
    ParentFont = False
  end
  object btnOK: TButton
    Left = 395
    Top = 105
    Width = 79
    Height = 27
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    Enabled = False
    TabOrder = 0
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 480
    Top = 105
    Width = 79
    Height = 27
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #12461#12515#12531#12475#12523
    ModalResult = 2
    TabOrder = 1
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 14
    Width = 551
    Height = 81
    Anchors = [akLeft, akTop, akRight]
    Caption = #12466#12540#12512#24773#22577#12434#21462#24471#12377#12427'MAME'#23455#34892#12501#12449#12452#12523#12434#25351#23450#12375#12390#12367#12384#12373#12356
    Font.Charset = SHIFTJIS_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #12513#12452#12522#12458
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      551
      81)
    object Edit2: TEdit
      Left = 12
      Top = 34
      Width = 500
      Height = 26
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      OnChange = Edit2Change
    end
    object Button3: TButton
      Left = 517
      Top = 34
      Width = 24
      Height = 26
      Anchors = [akTop, akRight]
      Caption = '...'
      TabOrder = 1
      OnClick = Button3Click
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 'MAME'#23455#34892#12501#12449#12452#12523' (*.exe)|*.exe||!cmd.exe'
    Left = 383
    Top = 2
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 8
    Top = 20
  end
end
