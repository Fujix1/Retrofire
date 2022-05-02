object frmHttp: TfrmHttp
  Left = 0
  Top = 0
  BorderIcons = [biMinimize, biMaximize]
  BorderStyle = bsDialog
  Caption = #12463#12521#12454#12489#12501#12449#12452#12523#26356#26032
  ClientHeight = 334
  ClientWidth = 629
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  Scaled = False
  OnClose = FormClose
  OnShow = FormShow
  DesignSize = (
    629
    334)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 24
    Top = 280
    Width = 580
    Height = 2
    Anchors = [akLeft, akRight, akBottom]
  end
  object lblStatus: TLabel
    Left = 24
    Top = 24
    Width = 40
    Height = 13
    Caption = 'Status.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label1: TLabel
    Left = 24
    Top = 53
    Width = 67
    Height = 13
    Caption = #12525#12464#12513#12483#12475#12540#12472':'
  end
  object btnCancel: TButton
    Left = 475
    Top = 291
    Width = 129
    Height = 33
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #38281#12376#12427
    ModalResult = 8
    TabOrder = 0
    OnClick = btnCancelClick
  end
  object Memo1: TMemo
    Left = 24
    Top = 72
    Width = 580
    Height = 126
    Anchors = [akLeft, akTop, akRight, akBottom]
    Color = clBtnFace
    Lines.Strings = (
      'Memo1')
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object btnDownload: TButton
    Left = 435
    Top = 204
    Width = 169
    Height = 57
    Anchors = [akRight, akBottom]
    Caption = #12480#12454#12531#12525#12540#12489#12377#12427
    Default = True
    Enabled = False
    TabOrder = 2
    OnClick = btnDownloadClick
  end
  object Panel1: TPanel
    Left = 24
    Top = 208
    Width = 393
    Height = 57
    Anchors = [akLeft, akRight, akBottom]
    BevelOuter = bvLowered
    TabOrder = 3
    DesignSize = (
      393
      57)
    object Label2: TLabel
      Left = 8
      Top = 31
      Width = 3
      Height = 13
    end
    object ProgressBar1: TProgressBar
      Left = 8
      Top = 8
      Width = 377
      Height = 17
      Anchors = [akLeft, akBottom]
      TabOrder = 0
    end
  end
  object NetHTTPClient1: TNetHTTPClient
    ConnectionTimeout = 100000
    ResponseTimeout = 10000
    UserAgent = 'Embarcadero URI Client/1.0'
    Left = 56
    Top = 104
  end
  object NetHTTPRequest1: TNetHTTPRequest
    ConnectionTimeout = 100000
    ResponseTimeout = 10000
    Client = NetHTTPClient1
    OnRequestCompleted = NetHTTPRequest1RequestCompleted
    OnRequestError = NetHTTPRequest1RequestError
    Left = 104
    Top = 24
  end
  object NetHTTPRequest2: TNetHTTPRequest
    ConnectionTimeout = 100000
    ResponseTimeout = 10000
    Client = NetHTTPClient1
    OnRequestError = NetHTTPRequest2RequestError
    OnReceiveData = NetHTTPRequest2ReceiveData
    Left = 197
    Top = 24
  end
  object NetHTTPRequest3: TNetHTTPRequest
    ConnectionTimeout = 100000
    ResponseTimeout = 10000
    Client = NetHTTPClient1
    OnRequestCompleted = NetHTTPRequest3RequestCompleted
    OnRequestError = NetHTTPRequest3RequestError
    Left = 296
    Top = 24
  end
  object NetHTTPRequest4: TNetHTTPRequest
    ConnectionTimeout = 100000
    ResponseTimeout = 10000
    Client = NetHTTPClient1
    OnRequestCompleted = NetHTTPRequest4RequestCompleted
    OnRequestError = NetHTTPRequest4RequestError
    Left = 392
    Top = 24
  end
  object NetHTTPRequest5: TNetHTTPRequest
    ConnectionTimeout = 100000
    ResponseTimeout = 10000
    Client = NetHTTPClient1
    OnRequestCompleted = NetHTTPRequest5RequestCompleted
    OnRequestError = NetHTTPRequest5RequestError
    Left = 488
    Top = 24
  end
  object NetHTTPRequest6: TNetHTTPRequest
    ConnectionTimeout = 100000
    ResponseTimeout = 10000
    Client = NetHTTPClient1
    OnRequestError = NetHTTPRequest6RequestError
    Left = 32
    Top = 288
  end
  object NetHTTPRequest7: TNetHTTPRequest
    ConnectionTimeout = 100000
    ResponseTimeout = 10000
    Client = NetHTTPClient1
    OnRequestCompleted = NetHTTPRequest7RequestCompleted
    OnRequestError = NetHTTPRequest7RequestError
    Left = 136
    Top = 288
  end
end
