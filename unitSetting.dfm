object frmSetting: TfrmSetting
  Left = 234
  Top = 191
  BorderStyle = bsDialog
  Caption = #35373#23450
  ClientHeight = 532
  ClientWidth = 699
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #12513#12452#12522#12458
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  Scaled = False
  OnClose = FormClose
  OnShow = FormShow
  DesignSize = (
    699
    532)
  PixelsPerInch = 96
  TextHeight = 18
  object btnCancel: TBitBtn
    Left = 609
    Top = 489
    Width = 84
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #12461#12515#12531#12475#12523
    ModalResult = 2
    NumGlyphs = 2
    TabOrder = 2
    ExplicitLeft = 496
    ExplicitTop = 454
  end
  object btnOK: TBitBtn
    Left = 519
    Top = 489
    Width = 83
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    ModalResult = 1
    NumGlyphs = 2
    TabOrder = 1
    OnClick = btnOKClick
    ExplicitLeft = 406
    ExplicitTop = 454
  end
  object PageControl1: TPageControl
    Left = 6
    Top = 6
    Width = 688
    Height = 470
    ActivePage = TabSheet1
    Anchors = [akLeft, akTop, akRight, akBottom]
    Images = Form1.ImageList2
    TabOrder = 0
    ExplicitWidth = 575
    ExplicitHeight = 435
    object TabSheet1: TTabSheet
      Caption = 'MAME'#23455#34892#12501#12449#12452#12523
      ImageIndex = 37
      ExplicitWidth = 567
      ExplicitHeight = 402
      DesignSize = (
        680
        437)
      object btnAdd: TButton
        Left = 592
        Top = 12
        Width = 81
        Height = 24
        Anchors = [akTop, akRight]
        Caption = #36861#21152'(&A)...'
        TabOrder = 1
        OnClick = btnAddClick
        ExplicitLeft = 479
      end
      object btnDelete: TButton
        Left = 592
        Top = 70
        Width = 81
        Height = 24
        Anchors = [akTop, akRight]
        Caption = #21066#38500'(&R)'
        Enabled = False
        TabOrder = 3
        OnClick = btnDeleteClick
        ExplicitLeft = 479
      end
      object GroupBox1: TGroupBox
        Left = 12
        Top = 260
        Width = 661
        Height = 138
        Anchors = [akLeft, akRight]
        TabOrder = 6
        ExplicitTop = 234
        ExplicitWidth = 548
        DesignSize = (
          661
          138)
        object Label2: TLabel
          Left = 20
          Top = 44
          Width = 77
          Height = 18
          Alignment = taRightJustify
          Caption = #26412#20307#12501#12449#12452#12523':'
        end
        object Label3: TLabel
          Left = 20
          Top = 72
          Width = 77
          Height = 18
          Alignment = taRightJustify
          Caption = #20316#26989#12501#12457#12523#12480':'
        end
        object Label5: TLabel
          Left = 9
          Top = 16
          Width = 89
          Height = 18
          Alignment = taRightJustify
          Caption = #12503#12525#12501#12449#12452#12523#21517':'
        end
        object Label4: TLabel
          Left = 32
          Top = 101
          Width = 65
          Height = 18
          Alignment = taRightJustify
          Caption = #12458#12503#12471#12519#12531':'
        end
        object Edit1: TEdit
          Left = 103
          Top = 13
          Width = 518
          Height = 26
          Anchors = [akLeft, akTop, akRight]
          MaxLength = 64
          TabOrder = 0
          OnChange = Edit1Change
          ExplicitWidth = 405
        end
        object Edit2: TEdit
          Left = 103
          Top = 41
          Width = 518
          Height = 26
          Anchors = [akLeft, akTop, akRight]
          MaxLength = 255
          TabOrder = 1
          OnChange = Edit2Change
          ExplicitWidth = 405
        end
        object Edit3: TEdit
          Left = 103
          Top = 69
          Width = 518
          Height = 26
          Anchors = [akLeft, akTop, akRight]
          MaxLength = 255
          TabOrder = 3
          OnChange = Edit3Change
          ExplicitWidth = 405
        end
        object Button2: TButton
          Left = 629
          Top = 41
          Width = 26
          Height = 24
          Anchors = [akTop, akRight]
          Caption = '...'
          TabOrder = 2
          OnClick = Button2Click
          ExplicitLeft = 516
        end
        object Edit4: TEdit
          Left = 103
          Top = 98
          Width = 434
          Height = 26
          Anchors = [akLeft, akTop, akRight]
          MaxLength = 1024
          TabOrder = 5
          OnChange = Edit4Change
          ExplicitWidth = 321
        end
        object Button8: TButton
          Left = 629
          Top = 69
          Width = 26
          Height = 24
          Anchors = [akTop, akRight]
          Caption = '...'
          TabOrder = 4
          OnClick = Button8Click
          ExplicitLeft = 516
        end
        object CheckBox1: TCheckBox
          Left = 552
          Top = 103
          Width = 115
          Height = 17
          Anchors = [akTop, akRight]
          Caption = #12458#12503#12471#12519#12531#26377#21177
          TabOrder = 6
          OnClick = CheckBox1Click
          ExplicitLeft = 439
        end
      end
      object ListBox1: TListBox
        Left = 12
        Top = 12
        Width = 571
        Height = 242
        Style = lbOwnerDrawFixed
        Anchors = [akLeft, akTop, akRight, akBottom]
        Ctl3D = True
        ExtendedSelect = False
        ItemHeight = 14
        ParentCtl3D = False
        TabOrder = 0
        OnClick = ListBox1Click
        OnDrawItem = ListBox1DrawItem
        OnMeasureItem = ListBox1MeasureItem
        OnMouseDown = ListBox1MouseDown
        OnMouseMove = ListBox1MouseMove
        OnMouseUp = ListBox1MouseUp
        ExplicitWidth = 458
        ExplicitHeight = 207
      end
      object BitBtn2: TBitBtn
        Left = 592
        Top = 104
        Width = 31
        Height = 24
        Anchors = [akTop, akRight]
        Glyph.Data = {
          42010000424D4201000000000000420000002800000010000000100000000100
          08000000000000010000120B0000120B00000300000003000000FFFFFF000000
          0000FFFFFF000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000100000000000000
          0000010000000000010100000000000000010100000000000001010000000000
          0101000000000000000001010000000101000000000000000000000101000101
          0000000000000000000000000101010000000000000000000000000000010000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000}
        TabOrder = 4
        OnClick = BitBtn2Click
        ExplicitLeft = 479
      end
      object BitBtn3: TBitBtn
        Left = 592
        Top = 132
        Width = 31
        Height = 23
        Anchors = [akTop, akRight]
        Glyph.Data = {
          42010000424D4201000000000000420000002800000010000000100000000100
          08000000000000010000120B0000120B00000300000003000000FFFFFF000000
          0000FFFFFF000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000001000000000000000000000000000001010100
          0000000000000000000000010100010100000000000000000000010100000001
          0100000000000000000101000000000001010000000000000101000000000000
          0001010000000000010000000000000000000100000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000}
        TabOrder = 5
        OnClick = BitBtn3Click
        ExplicitLeft = 479
      end
      object btnCopy: TButton
        Left = 592
        Top = 41
        Width = 81
        Height = 24
        Anchors = [akTop, akRight]
        Caption = #35079#35069'(&D)'
        Enabled = False
        TabOrder = 2
        OnClick = btnCopyClick
        ExplicitLeft = 479
      end
    end
    object TabSheet2: TTabSheet
      Caption = #12487#12451#12524#12463#12488#12522
      ImageIndex = 12
      ExplicitWidth = 567
      ExplicitHeight = 402
      DesignSize = (
        680
        437)
      object GroupBox6: TGroupBox
        Left = 4
        Top = 9
        Width = 670
        Height = 223
        Anchors = [akLeft, akTop, akRight]
        Caption = #12487#12451#12524#12463#12488#12522#35373#23450
        TabOrder = 0
        ExplicitWidth = 557
        DesignSize = (
          670
          223)
        object ListView1: TListView
          Left = 11
          Top = 59
          Width = 569
          Height = 151
          Anchors = [akLeft, akTop, akRight]
          Columns = <
            item
              AutoSize = True
            end>
          ColumnClick = False
          HideSelection = False
          ShowColumnHeaders = False
          TabOrder = 1
          ViewStyle = vsReport
          OnEdited = ListView1Edited
          ExplicitWidth = 456
        end
        object ComboBox1: TComboBox
          Left = 11
          Top = 24
          Width = 569
          Height = 26
          Style = csDropDownList
          Anchors = [akLeft, akTop, akRight]
          DropDownCount = 10
          TabOrder = 0
          OnChange = ComboBox1Change
          Items.Strings = (
            'ROM'#12501#12449#12452#12523
            'Software'#12501#12449#12452#12523#65288#26410#20351#29992#65289
            #12469#12531#12503#12523
            'cfg'#12501#12449#12452#12523
            'nvram'#12501#12449#12452#12523
            'sta'#12501#12449#12452#12523
            #12473#12490#12483#12503#12471#12519#12483#12488
            'inp'#12501#12449#12452#12523
            'dat'#12501#12449#12452#12523
            'lang'#12501#12457#12523#12480
            'version.ini'#12501#12449#12452#12523)
          ExplicitWidth = 456
        end
        object btnAddDir: TButton
          Left = 586
          Top = 154
          Width = 76
          Height = 26
          Anchors = [akTop, akRight]
          Caption = #36861#21152'(&A)...'
          Enabled = False
          TabOrder = 3
          OnClick = btnAddDirClick
          ExplicitLeft = 473
        end
        object btnDelDir: TButton
          Left = 586
          Top = 184
          Width = 76
          Height = 26
          Anchors = [akTop, akRight]
          Caption = #21066#38500'(&R)'
          Enabled = False
          TabOrder = 4
          OnClick = btnDelDirClick
          ExplicitLeft = 473
        end
        object Button1: TButton
          Left = 586
          Top = 24
          Width = 76
          Height = 26
          Anchors = [akTop, akRight]
          Caption = #21442#29031'(&B)...'
          TabOrder = 2
          OnClick = Button1Click
          ExplicitLeft = 473
        end
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 'MAME'#23455#34892#12501#12449#12452#12523' (*.exe)|*.exe;'
    Options = [ofReadOnly, ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Title = 'MAME'#23455#34892#12501#12449#12452#12523#12434#36984#12435#12391#19979#12373#12356
    Left = 376
    Top = 7
  end
end
