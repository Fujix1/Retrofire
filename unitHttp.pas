unit unitHttp;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, common, Vcl.StdCtrls, Vcl.ExtCtrls,
  System.Net.URLClient, System.Net.HttpClient, System.Net.HttpClientComponent,
  Vcl.ComCtrls, System.Zip, System.IOUtils;

const
  URL_MAME32J = 'https://raw.githubusercontent.com/Fujix1/Retrofire/master/mame32j.lst'; // mame32j.lst の取得元
  URL_VERSION = 'https://raw.githubusercontent.com/Fujix1/Retrofire/master/folders/Version.ini'; // version.ini の取得元
  URL_MAMEINFO = 'http://www.e2j.net/files/mameinfo_utf8.zip'; // mameinfo.dat の取得元
  URL_HISTORY = 'http://e2j.net/files/history+u.zip'; // history.dat の取得元

const
  WM_STARTUP = WM_USER;

type
  TfrmHttp = class(TForm)
    Bevel1: TBevel;
    btnCancel: TButton;
    NetHTTPClient1: TNetHTTPClient;
    NetHTTPRequest1: TNetHTTPRequest;
    NetHTTPRequest2: TNetHTTPRequest;
    NetHTTPRequest3: TNetHTTPRequest;
    NetHTTPRequest4: TNetHTTPRequest;
    Memo1: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    lblStatus: TLabel;
    btnDownload: TButton;
    Panel1: TPanel;
    ProgressBar1: TProgressBar;
    NetHTTPRequest5: TNetHTTPRequest;

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
    procedure NetHTTPRequest4RequestError(const Sender: TObject;
      const AError: string);
    procedure NetHTTPRequest4RequestCompleted(const Sender: TObject;
      const AResponse: IHTTPResponse);
    procedure NetHTTPRequest5RequestError(const Sender: TObject;
      const AError: string);
    procedure NetHTTPRequest5RequestCompleted(const Sender: TObject;
      const AResponse: IHTTPResponse);
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

  target_ETag_mameinfo: string; // ダウンロード対象の Etag
  target_size_mameinfo: integer; // 対象の Content-Length

  target_ETag_history: string; // ダウンロード対象の Etag
  target_size_history: integer; // 対象の Content-Length

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

  target_size_mameinfo := 0;
  target_ETag_mameinfo := '';

  target_size_history := 0;
  target_ETag_history := '';


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

  Application.ProcessMessages;

  // 更新ファイルがあるか確認
  if HttpError=false then
    NetHTTPRequest4.Head(URL_MAMEINFO);

  Application.ProcessMessages;

  // 更新ファイルがあるか確認
  if HttpError=false then
    NetHTTPRequest5.Head(URL_HISTORY);

end;


procedure TfrmHttp.NetHTTPRequest1RequestCompleted(const Sender: TObject;
  const AResponse: IHTTPResponse);
  var i: integer;
begin


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
  else if( target_size_mame32j = 0 ) then
  begin
    Memo1.Lines.Add('mame32j.lst: ファイル情報取得失敗');
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
  else if( target_size_version = 0 ) then
  begin
    Memo1.Lines.Add('version.ini: ファイル情報取得失敗');
  end
  else
  begin
    Memo1.Lines.Add('version.ini: たぶん最新版です');
  end;

  checkIfDownloadable();  // ダウンロードボタンの有効化

end;



procedure TfrmHttp.NetHTTPRequest4RequestCompleted(const Sender: TObject;
  const AResponse: IHTTPResponse);
  var i: integer;
begin
  inc(numChecked);

  for i := Low(AResponse.Headers) to High(AResponse.Headers) do
  begin
    //Memo1.Lines.Add( AResponse.Headers[i].Name + ': ' +  AResponse.Headers[i].Value );
    if AResponse.Headers[i].Name = 'Content-Length' then
    begin
      target_size_mameinfo := strtoint(AResponse.Headers[i].Value);
    end
    else
    if AResponse.Headers[i].Name = 'ETag' then
    begin
      target_ETag_mameinfo := AResponse.Headers[i].Value;
    end;
  end;

  // 更新あるか判定
  if (target_ETag_mameinfo <> ETag_mameinfo) and ( target_size_mameinfo > 0) then
  begin
    Memo1.Lines.Add('mameinfo.dat: 更新あり ('+inttostr(target_size_mameinfo)+' Bytes)');
    isDownloadable := true;
  end
  else if( target_size_mameinfo = 0 ) then
  begin
    Memo1.Lines.Add('mameinfo.dat: ファイル情報取得失敗');
  end
  else
  begin
    Memo1.Lines.Add('mameinfo.dat: たぶん最新版です');
  end;

  checkIfDownloadable();  // ダウンロードボタンの有効化
end;



procedure TfrmHttp.NetHTTPRequest5RequestCompleted(const Sender: TObject;
  const AResponse: IHTTPResponse);
  var i: integer;
begin
  inc(numChecked);

  for i := Low(AResponse.Headers) to High(AResponse.Headers) do
  begin
    //Memo1.Lines.Add( AResponse.Headers[i].Name + ': ' +  AResponse.Headers[i].Value );
    if AResponse.Headers[i].Name = 'Content-Length' then
    begin
      target_size_history := strtoint(AResponse.Headers[i].Value);
    end
    else
    if AResponse.Headers[i].Name = 'ETag' then
    begin
      target_ETag_history := AResponse.Headers[i].Value;
    end;
  end;

  // 更新あるか判定
  if (target_ETag_history <> ETag_history) and ( target_size_history > 0) then
  begin
    Memo1.Lines.Add('history.dat: 更新あり ('+inttostr(target_size_history)+' Bytes)');
    isDownloadable := true;
  end
  else if( target_size_history = 0 ) then
  begin
    Memo1.Lines.Add('history.dat: ファイル情報取得失敗');
  end
  else
  begin
    Memo1.Lines.Add('history.dat: たぶん最新版です');
  end;

  checkIfDownloadable();  // ダウンロードボタンの有効化
end;



procedure TfrmHttp.NetHTTPRequest1RequestError(const Sender: TObject;
  const AError: string);
begin
  lblStatus.Caption:='接続中にエラーが起きました。';
  Memo1.Lines.Add( AError );
end;

procedure TfrmHttp.NetHTTPRequest3RequestError(const Sender: TObject;
  const AError: string);
begin
  lblStatus.Caption:='接続中にエラーが起きました。';
  Memo1.Lines.Add( AError );
end;

procedure TfrmHttp.NetHTTPRequest4RequestError(const Sender: TObject;
  const AError: string);
begin
  lblStatus.Caption:='接続中にエラーが起きました。';
  Memo1.Lines.Add( AError );
end;

procedure TfrmHttp.NetHTTPRequest5RequestError(const Sender: TObject;
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
  absPath: string;

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
          ResponseContent.SaveToFile( IncludeTrailingPathDelimiter(GetCurrentDir)+'\mame32j.lst');
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
          // 保存先ディレクトリがない場合は作る
          if not DirectoryExists(versionDir) then
          begin
            absPath := versionDir;

            if not System.IOUtils.TPath.IsPathRooted( absPath ) then // 相対パスは絶対パスに変換
              absPath:= RelToAbs( absPath, ExeDir );

            Memo1.Lines.Add('ディレクトリ作成: '+absPath);
            ForceDirectories(absPath);
          end;

          ResponseContent.SaveToFile( IncludeTrailingPathDelimiter(versionDir) +'Version.ini');
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


  // mameinfo.dat
  if (target_ETag_mameinfo <> ETag_mameinfo) and ( target_size_mameinfo > 0) then
  begin

    Memo1.Lines.Add('mameinfo.dat(zip) をダウンロード中...');
    Application.ProcessMessages;

    //取得したデータを格納するStream
    ResponseContent := TMemoryStream.Create;

    try
      NetHTTPRequest2.Get(URL_MAMEINFO, ResponseContent);

      if ResponseContent.Size = target_size_mameinfo then // ダウンロードサイズ確認
      begin
        try
          // 保存先ディレクトリがない場合は作る
          if not DirectoryExists(datDir) then
          begin
            absPath := datDir;

            if not System.IOUtils.TPath.IsPathRooted( absPath ) then // 相対パスは絶対パスに変換
              absPath:= RelToAbs( absPath, ExeDir );


            Memo1.Lines.Add('ディレクトリ作成: '+absPath);
            ForceDirectories( absPath );
          end;

          ResponseContent.SaveToFile( IncludeTrailingPathDelimiter(datDir) +'mameinfo.zip');
          beep;

          Memo1.Lines.Add('mameinfo.dat(zip) を保存。');

          Application.ProcessMessages;

          TZipFile.ExtractZipFile(IncludeTrailingPathDelimiter(datDir) +'mameinfo.zip', IncludeTrailingPathDelimiter(datDir));
          DeleteFile(IncludeTrailingPathDelimiter(datDir) +'mameinfo.zip');
          Memo1.Lines.Add('mameinfo.dat を解凍。');
          ETag_mameinfo := target_ETag_mameinfo;
          btnCancel.ModalResult := mrOK;
        except
          on e:exception do
          begin
            lblStatus.Caption:='mameinfo.dat(zip) ファイルの保存に失敗しました。';
            Memo1.Lines.Add(e.Message);
            btnCancel.ModalResult := mrClose;
          end;
        end;
      end
      else
      begin
        Memo1.Lines.Add('mameinfo.dat(zip) のダウンロードに失敗しました。');
        lblStatus.Caption := 'ファイルのダウンロードに失敗しました。';
        btnCancel.ModalResult := mrClose;
      end;

    finally
      ResponseContent.Free;
    end;

  end;


  // history.dat
  if (target_ETag_history <> ETag_history) and ( target_size_history > 0) then
  begin

    Memo1.Lines.Add('history.dat(zip) をダウンロード中...');
    Application.ProcessMessages;

    //取得したデータを格納するStream
    ResponseContent := TMemoryStream.Create;

    try
      NetHTTPRequest2.Get(URL_HISTORY, ResponseContent);

      if ResponseContent.Size = target_size_history then // ダウンロードサイズ確認
      begin
        try
          // 保存先ディレクトリがない場合は作る
          if not DirectoryExists(datDir) then
          begin
            absPath := datDir;

            if not System.IOUtils.TPath.IsPathRooted( absPath ) then // 相対パスは絶対パスに変換
              absPath:= RelToAbs( absPath, ExeDir );


            Memo1.Lines.Add('ディレクトリ作成: '+absPath);
            ForceDirectories( absPath );
          end;

          ResponseContent.SaveToFile( IncludeTrailingPathDelimiter(datDir) +'history.zip');
          beep;

          Memo1.Lines.Add('history.dat(zip) を保存。');

          Application.ProcessMessages;

          TZipFile.ExtractZipFile(IncludeTrailingPathDelimiter(datDir) +'history.zip', IncludeTrailingPathDelimiter(datDir));
          DeleteFile(IncludeTrailingPathDelimiter(datDir) +'history.zip');
          Memo1.Lines.Add('history.dat を解凍。');
          ETag_history := target_ETag_history;
          btnCancel.ModalResult := mrOK;
        except
          on e:exception do
          begin
            lblStatus.Caption:='history.dat(zip) ファイルの保存に失敗しました。';
            Memo1.Lines.Add(e.Message);
            btnCancel.ModalResult := mrClose;
          end;
        end;
      end
      else
      begin
        Memo1.Lines.Add('history.dat(zip) のダウンロードに失敗しました。');
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

  if numChecked <> 4 then Exit;

  if isDownloadable then
  begin
    beep;
    btnDownload.Enabled:=true;
    btnDownload.SetFocus;
    lblStatus.Caption:='ダウンロードできるファイルがあります。';
  end
  else
  begin
    beep;
    lblStatus.Caption:='更新するファイルは見つかりませんでした。';
  end;


end;

end.
