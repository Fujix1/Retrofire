object frmUpdater: TfrmUpdater
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #12450#12483#12503#12487#12540#12488#12481#12455#12483#12463
  ClientHeight = 214
  ClientWidth = 464
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
  object Label1: TLabel
    Left = 48
    Top = 32
    Width = 31
    Height = 13
    Caption = 'Label1'
  end
  object Button1: TButton
    Left = 352
    Top = 168
    Width = 89
    Height = 25
    Caption = #12481#12455#12483#12463
    Default = True
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 240
    Top = 168
    Width = 91
    Height = 25
    Cancel = True
    Caption = #12461#12515#12531#12475#12523
    TabOrder = 1
    OnClick = Button2Click
  end
end
