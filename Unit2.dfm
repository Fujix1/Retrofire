object Form2: TForm2
  Left = 216
  Top = 127
  BorderIcons = [biMinimize, biMaximize]
  BorderStyle = bsDialog
  Caption = 'Retrofire - '#12466#12540#12512#24773#22577#21462#24471
  ClientHeight = 198
  ClientWidth = 721
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #12513#12452#12522#12458
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  Scaled = False
  OnShow = FormShow
  DesignSize = (
    721
    198)
  PixelsPerInch = 96
  TextHeight = 18
  object Label4: TLabel
    Left = 21
    Top = 157
    Width = 396
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
    Left = 439
    Top = 157
    Width = 4
    Height = 18
    Caption = ' '
    Font.Charset = SHIFTJIS_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #12513#12452#12522#12458
    Font.Style = []
    ParentFont = False
  end
  object btnOK: TButton
    Left = 510
    Top = 148
    Width = 92
    Height = 38
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    Enabled = False
    TabOrder = 0
    OnClick = btnOKClick
    ExplicitTop = 150
  end
  object btnCancel: TButton
    Left = 608
    Top = 148
    Width = 89
    Height = 38
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #12461#12515#12531#12475#12523
    ModalResult = 2
    TabOrder = 1
    ExplicitTop = 150
  end
  object GroupBox1: TGroupBox
    Left = 21
    Top = 16
    Width = 676
    Height = 121
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
      676
      121)
    object Edit2: TEdit
      Left = 12
      Top = 34
      Width = 614
      Height = 26
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      OnChange = Edit2Change
    end
    object Button3: TButton
      Left = 632
      Top = 34
      Width = 34
      Height = 26
      Anchors = [akTop, akRight]
      Caption = '...'
      TabOrder = 1
      OnClick = Button3Click
    end
    object chkSoftlist: TCheckBox
      Left = 12
      Top = 80
      Width = 369
      Height = 17
      Caption = #12477#12501#12488#12454#12455#12450#12522#12473#12488#12398#24773#22577#12418#21462#24471#12377#12427#65288#12486#12473#12488#29256#65289
      Font.Charset = SHIFTJIS_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #12513#12452#12522#12458
      Font.Style = []
      ParentFont = False
      TabOrder = 2
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
    Left = 432
    Top = 4
  end
end
