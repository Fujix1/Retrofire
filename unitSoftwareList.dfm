object frmSoftwareList: TfrmSoftwareList
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = #12477#12501#12488#12454#12455#12450#12522#12473#12488
  ClientHeight = 770
  ClientWidth = 623
  Color = clBtnFace
  Constraints.MinHeight = 300
  Constraints.MinWidth = 450
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = #12513#12452#12522#12458
  Font.Style = []
  KeyPreview = True
  Scaled = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyPress = FormKeyPress
  OnResize = FormResize
  TextHeight = 17
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 623
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 0
    DesignSize = (
      623
      41)
    object cmbSoftlist: TComboBox
      Left = 8
      Top = 8
      Width = 447
      Height = 25
      Style = csDropDownList
      Anchors = [akLeft, akTop, akRight]
      Color = cl3DLight
      Ctl3D = False
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = #12513#12452#12522#12458
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
      OnChange = cmbSoftlistChange
    end
    object SearchBox1: TSearchBox
      Left = 461
      Top = 8
      Width = 156
      Height = 25
      Anchors = [akTop, akRight]
      MaxLength = 28
      TabOrder = 1
      OnChange = SearchBox1Change
      OnEnter = SearchBox1Enter
      OnExit = SearchBox1Exit
      OnKeyPress = SearchBox1KeyPress
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 41
    Width = 623
    Height = 672
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object ListView1: TListView
      Left = 0
      Top = 0
      Width = 623
      Height = 672
      Align = alClient
      Columns = <
        item
          Caption = #12466#12540#12512#21517
          Width = 250
        end
        item
          Caption = 'ZIP'#21517
          Width = 75
        end
        item
          Caption = #12513#12540#12459#12540
          Width = 155
        end
        item
          Caption = #24180#24230
          Width = 45
        end
        item
          Caption = #12510#12473#12479
          Width = 70
        end>
      DoubleBuffered = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      FullDrag = True
      HideSelection = False
      OwnerData = True
      ReadOnly = True
      RowSelect = True
      ParentDoubleBuffered = False
      ParentFont = False
      PopupMenu = PopupMenu1
      TabOrder = 0
      ViewStyle = vsReport
      OnAdvancedCustomDrawItem = ListView1AdvancedCustomDrawItem
      OnColumnClick = ListView1ColumnClick
      OnData = ListView1Data
      OnDataFind = ListView1DataFind
      OnDblClick = ListView1DblClick
      OnKeyPress = ListView1KeyPress
      OnSelectItem = ListView1SelectItem
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 713
    Width = 623
    Height = 57
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object chkAlwaysOnTop: TCheckBox
      Left = 14
      Top = 10
      Width = 97
      Height = 17
      Caption = #24120#12395#25163#21069#12395#34920#31034
      TabOrder = 0
      OnClick = chkAlwaysOnTopClick
    end
    object StatusBar1: TStatusBar
      Left = 0
      Top = 36
      Width = 623
      Height = 21
      Panels = <
        item
          Alignment = taCenter
          Width = 100
        end
        item
          Alignment = taCenter
          Width = 400
        end
        item
          Alignment = taCenter
          Width = 100
        end>
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 5
    OnTimer = Timer1Timer
    Left = 392
    Top = 81
  end
  object ActionList1: TActionList
    Left = 440
    Top = 81
    object actCopyZipName: TAction
      Caption = 'ZIP'#21517#12434#12467#12500#12540#12377#12427
      ShortCut = 16451
      OnExecute = actCopyZipNameExecute
      OnUpdate = actCopyZipNameUpdate
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 480
    Top = 81
    object ZIP1: TMenuItem
      Action = actCopyZipName
    end
  end
end
