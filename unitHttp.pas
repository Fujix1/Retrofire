unit unitHttp;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, common, Vcl.StdCtrls, Vcl.ExtCtrls,
  System.Net.URLClient, System.Net.HttpClient, System.Net.HttpClientComponent,
  Vcl.ComCtrls;

const
  URL_MAME32J = 'https://raw.githubusercontent.com/Fujix1/Retrofire/master/mame32j.lst'; // mame32j.lst の取得元
  URL_VERSION = 'https://raw.githubusercontent.com/Fujix1/Retrofire/master/folders/Version.ini'; // version.ini の取得元



const
  WM_STARTUP = WM_USER;

type
  TfrmHttp = class(TForm)
    Bevel1: TBevel;
    btnCancel: TButton;
    NetHTTPClient1: TNetHTTPClient;
    NetHTTPRequest1: TNetHTTPRequest;
    NetHTTPRequest2: TNetHTTPRequest;
    lblStatus: TLabel;
    Memo1: TMemo;
    Label1: TLabel;
    btnDownload: TButton;
    NetHTTPRequest3: TNetHTTPRequest;
    Panel1: TPanel;
    ProgressBar1: TProgressBar;
    Label2: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure NetHTTPRequest1RequestCompleted(const Sender: TObject;
      const AResponse: IHTTPResponse);
    procedure NetHTTPRequest1RequestError(const Sender: TObject;
      const AError: string);
    procedure btnDownloadClick(Sender: TObject);
    procedure NetHTTPRequest2ReceiveData(const Sender: TObject; AContentLength,
      AReadCount: Int64; var Abort: Boolean);
    procedure NetHTTPRequest2RequestError(const Sender: TObject;
      const AError: string);
    procedure btnCancelClick(Sender: TObject);
    procedure NetHTTPRequest3RequestCompleted(const Sender: TObject;
      const AResponse: IHTTPResponse);
    procedure NetHTTPRequest3RequestError(const Sender: TObject;
      const AError: string);
  private
    { Private 宣言 }
    procedure WMStartup(var Msg: TMessage); message WM_STARTUP;
    procedure checkIfDownloadable;
  public
    { Public 宣言 }
  end;

var
  frmHttp: TfrmHttp;

  HttpError: boolean; // 何らかのエラーが起きたか？
  HttpAbort: boolean; // 中断されたか

  target_ETag_mame32j: string; // ダウンロード対象の Etag
  target_size_mame32j: integer; // 対象の Content-Length

  target_ETag_version: string; // ダウンロード対象の Etag
  target_size_version: integer; // 対象の Content-Length

  isDownloadable: boolean; // ダウンロード可能か
  numChecked: integer; // ダウンロードチェック完了数

implementation

{$R *.dfm}



procedure TfrmHttp.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  HttpAbort:=true;
end;

procedure TfrmHttp.FormShow(Sender: TObject);
begin

  // フォームをリセットする
  HttpError := false;
  HttpAbort := false;
  isDownloadable := false; // ダウンロード可能か
  numChecked := 0; // チェック済み数

  lblStatus.Caption:='';
  Label2.Caption:='';
  Memo1.Lines.Clear;
  btnCancel.ModalResult := mrClose; // デフォルトの結果は mrClose
  ProgressBar1.Position :=0;

  target_size_mame32j := 0;
  target_ETag_mame32j := '';

  target_size_version := 0;
  target_ETag_version := '';


  // フォームshowのあとに処理をする
  // https://stackoverflow.com/questions/14318807/what-is-the-best-way-to-autostart-an-action-after-onshow-event
  PostMessage(Handle, WM_STARTUP, 0, 0);

  //OnShow := nil;//only ever post the message once

end;


// Form.show 後に処理する内容
procedure TfrmHttp.WMStartup(var Msg: TMessage);
begin
  inherited;

  lblStatus.Caption:='情報取得中...';
  Application.ProcessMessages;

  // 更新ファイルがあるか確認
  NetHTTPRequest1.Head(URL_MAME32J);

  Application.ProcessMessages;

  // 更新ファイルがあるか確認
  if HttpError=false then
    NetHTTPRequest3.Head(URL_VERSION);

end;


procedure TfrmHttp.NetHTTPRequest1RequestCompleted(const Sender: TObject;
  const AResponse: IHTTPResponse);
  var i: integer;
begin

  lblStatus.Caption:='';
  inc(numChecked);

  for i := Low(AResponse.Headers) to High(AResponse.Headers) do
  begin
    //Memo1.Lines.Add( AResponse.Headers[i].Name + ': ' +  AResponse.Headers[i].Value );

    if AResponse.Headers[i].Name = 'Content-Length' then
    begin
      target_size_mame32j := strtoint(AResponse.Headers[i].Value);
    end
    else
    if AResponse.Headers[i].Name = 'ETag' then
    begin
      target_ETag_mame32j := AResponse.Headers[i].Value;
    end;
  end;

  // 更新あるか判定
  if (target_ETag_mame32j <> ETag_mame32j) and ( target_size_mame32j > 0) then
  begin
    Memo1.Lines.Add('mame32j.lst: 更新あり ('+inttostr(target_size_mame32j)+' Bytes)');
    isDownloadable := true;
  end
  else
  begin
    Memo1.Lines.Add('mame32j.lst: たぶん最新版です');
  end;

  checkIfDownloadable();  // ダウンロードボタンの有効化

end;


procedure TfrmHttp.NetHTTPRequest3RequestCompleted(const Sender: TObject;
  const AResponse: IHTTPResponse);
  var i: integer;
begin

  lblStatus.Caption:='';
  inc(numChecked);

  for i := Low(AResponse.Headers) to High(AResponse.Headers) do
  begin

    if AResponse.Headers[i].Name = 'Content-Length' then
    begin
      target_size_version := strtoint(AResponse.Headers[i].Value);
    end
    else
    if AResponse.Headers[i].Name = 'ETag' then
    begin
      target_ETag_version := AResponse.Headers[i].Value;
    end;
  end;

  // 更新あるか判定
  if (target_ETag_version <> ETag_version) and ( target_size_version > 0) then
  begin
    Memo1.Lines.Add('version.ini: 更新あり ('+inttostr(target_size_version)+' Bytes)');
    isDownloadable := true;
  end
  else
  begin
    Memo1.Lines.Add('version.ini: たぶん最新版です');
  end;

  checkIfDownloadable();  // ダウンロードボタンの有効化

end;

procedure TfrmHttp.NetHTTPRequest3RequestError(const Sender: TObject;
  const AError: string);
begin
  lblStatus.Caption:='接続中にエラーが起きました。';
  Memo1.Lines.Add( AError );
end;

procedure TfrmHttp.NetHTTPRequest1RequestError(const Sender: TObject;
  const AError: string);
begin

  lblStatus.Caption:='接続中にエラーが起きました。';
  Memo1.Lines.Add( AError );

end;

procedure TfrmHttp.NetHTTPRequest2ReceiveData(const Sender: TObject;
  AContentLength, AReadCount: Int64; var Abort: Boolean);
begin
  // データ受信中
  ProgressBar1.Max:= AContentLength;
  ProgressBar1.Position:= AReadCount;

  Label2.Caption := inttostr( AReadCount ) + ' / ' +inttostr( AContentLength ) + ' Bytes';
  Application.ProcessMessages;

  // アボート反映
  Abort := HttpAbort;
end;

procedure TfrmHttp.NetHTTPRequest2RequestError(const Sender: TObject;
  const AError: string);
begin
  HttpError := true;
  Memo1.Lines.Add(AError);
end;


// キャンセルボタンをクリック
procedure TfrmHttp.btnCancelClick(Sender: TObject);
begin

  HttpAbort := true;

end;

// ダウンロードボタンをクリック
procedure TfrmHttp.btnDownloadClick(Sender: TObject);
var
  ResponseContent: TMemoryStream;

begin

  HttpError := false;
  btnDownload.Enabled:=false;

  lblStatus.Caption:='ダウンロードしています...';

  // mame32j.lst
  if (target_ETag_mame32j <> ETag_mame32j) and ( target_size_mame32j > 0) then
  begin

    Memo1.Lines.Add('mame32j.lst をダウンロード中...');
    Application.ProcessMessages;

    //取得したデータを格納するStream
    ResponseContent := TMemoryStream.Create;

    try
      NetHTTPRequest2.Get(URL_MAME32J, ResponseContent);

      if ResponseContent.Size = target_size_mame32j then // ダウンロードサイズ確認
      begin
        try
          ResponseContent.SaveToFile( GetCurrentDir+'\mame32j.lst');
          beep;

          Memo1.Lines.Add('mame32j.lst を保存。');

          ETag_mame32j := target_ETag_mame32j;
          btnCancel.ModalResult := mrOK;
        except
          on e:exception do
          begin
            lblStatus.Caption:='ファイルの保存に失敗しました。';
            Memo1.Lines.Add(e.Message);
            btnCancel.ModalResult := mrClose;
          end;
        end;
      end
      else
      begin

        Memo1.Lines.Add('mame32j.lst のダウンロードに失敗しました。');
        lblStatus.Caption := 'mame32j.lst ファイルのダウンロードに失敗しました。';
        btnCancel.ModalResult := mrClose;
      end;

    finally
      ResponseContent.Free;
    end;

  end;


  // version.ini
  if (target_ETag_version <> ETag_version) and ( target_size_version > 0) then
  begin

    Memo1.Lines.Add('version.ini をダウンロード中...');
    Application.ProcessMessages;

    //取得したデータを格納するStream
    ResponseContent := TMemoryStream.Create;

    try
      NetHTTPRequest2.Get(URL_VERSION, ResponseContent);

      if ResponseContent.Size = target_size_version then // ダウンロードサイズ確認
      begin
        try
          ResponseContent.SaveToFile( versionDir +'\Version.ini');
          beep;

          Memo1.Lines.Add('Version.ini を保存。');

          ETag_version := target_ETag_version;
          btnCancel.ModalResult := mrOK;
        except
          on e:exception do
          begin
            lblStatus.Caption:='Version.ini ファイルの保存に失敗しました。';
            Memo1.Lines.Add(e.Message);
            btnCancel.ModalResult := mrClose;
          end;
        end;
      end
      else
      begin

        Memo1.Lines.Add('Version.ini のダウンロードに失敗しました。');
        lblStatus.Caption := 'ファイルのダウンロードに失敗しました。';
        btnCancel.ModalResult := mrClose;
      end;

    finally
      ResponseContent.Free;
    end;

  end;

  lblStatus.Caption:='処理完了';


end;

procedure TfrmHttp.checkIfDownloadable;
begin
  if (numChecked = 2) and (isDownloadable) then
  begin
    beep;
    btnDownload.Enabled:=true;
    btnDownload.SetFocus;
    lblStatus.Caption:='ダウンロードできるファイルがあります。';
  end
  else if (numChecked = 2) and (not isDownloadable) then
  begin
    beep;
    lblStatus.Caption:='更新するファイルは見つかりませんでした。';
  end;


end;

end.
