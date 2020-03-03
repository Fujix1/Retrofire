object Form6: TForm6
  Left = 0
  Top = 0
  Caption = #12473#12463#12522#12540#12531#12471#12519#12483#12488#12463#12522#12540#12490#12540
  ClientHeight = 507
  ClientWidth = 528
  Color = clBtnFace
  Constraints.MinHeight = 350
  Constraints.MinWidth = 500
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #12513#12452#12522#12458
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PrintScale = poNone
  Scaled = False
  OnHide = FormHide
  DesignSize = (
    528
    507)
  PixelsPerInch = 96
  TextHeight = 18
  object Label1: TLabel
    Left = 29
    Top = 15
    Width = 440
    Height = 18
    Caption = 'ZIP'#21517#12364#21476#12367#12394#12387#12383#12426#12289#37325#35079#12375#12383#12473#12463#12522#12540#12531#12471#12519#12483#12488#12394#12393#12434#12463#12522#12540#12491#12531#12464#12375#12414#12377#12290
  end
  object Label2: TLabel
    Left = 24
    Top = 431
    Width = 4
    Height = 18
    Anchors = [akLeft, akRight, akBottom]
  end
  object btnAnalyze: TButton
    Left = 24
    Top = 459
    Width = 129
    Height = 34
    Anchors = [akLeft, akBottom]
    Caption = #35299#26512'(&A)'
    TabOrder = 0
    OnClick = btnAnalyzeClick
  end
  object btnCleanup: TButton
    Left = 352
    Top = 459
    Width = 153
    Height = 34
    Anchors = [akRight, akBottom]
    Caption = #12463#12522#12540#12531#12450#12483#12503#38283#22987'(&S)'
    Enabled = False
    TabOrder = 1
    OnClick = btnCleanupClick
  end
  object GroupBox1: TGroupBox
    Left = 24
    Top = 48
    Width = 481
    Height = 122
    Anchors = [akLeft, akTop, akRight]
    Caption = #20316#26989#38917#30446
    TabOrder = 2
    DesignSize = (
      481
      122)
    object CheckBox1: TCheckBox
      Left = 16
      Top = 24
      Width = 459
      Height = 17
      Anchors = [akLeft, akTop, akRight]
      Caption = #19981#26126#12394'ZIP'#21517#12398#12473#12463#12522#12540#12531#12471#12519#12483#12488#12434#21066#38500
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
    object CheckBox2: TCheckBox
      Left = 16
      Top = 47
      Width = 459
      Height = 17
      Anchors = [akLeft, akTop, akRight]
      Caption = #12501#12457#12523#12480#20869#12398#12300'0000.png'#12301#12434#21462#12426#20986#12375#12390#12289#12300'ZIP'#21517'.png'#12301#12395#25913#21517#12377#12427
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
    object CheckBox3: TCheckBox
      Left = 16
      Top = 70
      Width = 459
      Height = 17
      Anchors = [akLeft, akTop, akRight]
      Caption = #19981#35201#12501#12457#12523#12480#12434#21066#38500#12377#12427
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
    object CheckBox4: TCheckBox
      Left = 16
      Top = 93
      Width = 459
      Height = 17
      Anchors = [akLeft, akTop, akRight]
      Caption = 'PNG'#20197#22806#12398#12501#12449#12452#12523#12434#21066#38500#12377#12427
      Checked = True
      State = cbChecked
      TabOrder = 3
    end
  end
  object ListView1: TListView
    Left = 24
    Top = 184
    Width = 481
    Height = 240
    Anchors = [akLeft, akTop, akRight, akBottom]
    Columns = <
      item
        Caption = #31278#39006
        Width = 130
      end
      item
        Caption = #12501#12449#12452#12523#12539#12501#12457#12523#12480#21517
        Width = 320
      end>
    ColumnClick = False
    ReadOnly = True
    RowSelect = True
    TabOrder = 3
    ViewStyle = vsReport
  end
  object btnCancel: TButton
    Left = 217
    Top = 459
    Width = 129
    Height = 34
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #38281#12376#12427
    TabOrder = 4
    OnClick = btnCancelClick
  end
end
