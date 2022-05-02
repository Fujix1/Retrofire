unit unitHttp;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, common, Vcl.StdCtrls, Vcl.ExtCtrls,
  System.Net.URLClient, System.Net.HttpClient, System.Net.HttpClientComponent,
  Vcl.ComCtrls, System.Zip, System.IOUtils, ShellAPI;

const
  URL_MAME32J   = 'https://raw.githubusercontent.com/Fujix1/Retrofire/master/mame32j.lst'; // mame32j.lst �̎擾��
  URL_VERSION   = 'https://raw.githubusercontent.com/Fujix1/Retrofire/master/folders/Version.ini'; // version.ini �̎擾��
  URL_MAMEINFO  = 'http://www.e2j.net/files/mameinfo_utf8.zip'; // mameinfo.dat �̎擾��
  URL_HISTORY   = 'http://e2j.net/files/history+u.zip'; // history.dat �̎擾��
  URL_RETROFIRE = 'https://raw.githubusercontent.com/Fujix1/Retrofire/master/version.txt'; // retrofire�̃o�[�W�����ԍ��̎擾��
  URL_MESSFLT   = 'https://raw.githubusercontent.com/mamedev/mame/master/src/mame/mess.flt'; // mess.flt �̎擾��


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
    NetHTTPRequest6: TNetHTTPRequest;
    NetHTTPRequest7: TNetHTTPRequest;

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
    procedure NetHTTPRequest7RequestError(const Sender: TObject;
      const AError: string);
    procedure NetHTTPRequest6RequestError(const Sender: TObject;
      const AError: string);
    procedure NetHTTPRequest7RequestCompleted(const Sender: TObject;
      const AResponse: IHTTPResponse);

  private
    { Private �錾 }
    procedure WMStartup(var Msg: TMessage); message WM_STARTUP;
    procedure checkIfDownloadable;
    function MessageDlg(const AOwner: TForm; const Msg: string; DlgType: TMsgDlgType;
      Buttons: TMsgDlgButtons; HelpCtx: Integer = 0): Integer;

  public
    { Public �錾 }
    var wasMESSFltUpdated: boolean;
  end;

var
  frmHttp: TfrmHttp;

  HttpError: boolean; // ���炩�̃G���[���N�������H
  HttpAbort: boolean; // ���f���ꂽ��

  target_ETag_mame32j: string; // �_�E�����[�h�Ώۂ� Etag
  target_size_mame32j: integer; // �Ώۂ� Content-Length

  target_ETag_version: string; // �_�E�����[�h�Ώۂ� Etag
  target_size_version: integer; // �Ώۂ� Content-Length

  target_ETag_mameinfo: string; // �_�E�����[�h�Ώۂ� Etag
  target_size_mameinfo: integer; // �Ώۂ� Content-Length

  target_ETag_history: string; // �_�E�����[�h�Ώۂ� Etag
  target_size_history: integer; // �Ώۂ� Content-Length

  target_ETag_messflt: string; // �_�E�����[�h�Ώۂ� Etag
  target_size_messflt: integer;  // �Ώۂ� Content-Length

  isDownloadable: boolean; // �_�E�����[�h�\��
  numChecked: integer; // �_�E�����[�h�`�F�b�N������

implementation

{$R *.dfm}


function TfrmHttp.MessageDlg(const AOwner: TForm; const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Integer = 0): Integer;
begin
  with CreateMessageDialog(Msg, DlgType, Buttons) do
    try
      Left := AOwner.Left + (AOwner.Width - Width) div 2;
      Top := AOwner.Top + (AOwner.Height - Height) div 2;
      Result := ShowModal;
    finally
      Free;
    end
end;

procedure TfrmHttp.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  HttpAbort:=true;
end;

procedure TfrmHttp.FormShow(Sender: TObject);
begin

  // �t�H�[�������Z�b�g����
  HttpError := false;
  HttpAbort := false;
  isDownloadable := false; // �_�E�����[�h�\��
  numChecked := 0; // �`�F�b�N�ςݐ�

  lblStatus.Caption:='';
  Label2.Caption:='';
  Memo1.Lines.Clear;
  btnCancel.ModalResult := mrClose; // �f�t�H���g�̌��ʂ� mrClose
  ProgressBar1.Position :=0;

  target_size_mame32j := 0;
  target_ETag_mame32j := '';

  target_size_version := 0;
  target_ETag_version := '';

  target_size_mameinfo := 0;
  target_ETag_mameinfo := '';

  target_size_history := 0;
  target_ETag_history := '';

  target_size_messflt := 0;
  target_ETag_messflt := '';

  // �t�H�[��show�̂��Ƃɏ���������
  // https://stackoverflow.com/questions/14318807/what-is-the-best-way-to-autostart-an-action-after-onshow-event
  PostMessage(Handle, WM_STARTUP, 0, 0);

  //OnShow := nil;//only ever post the message once

  wasMESSFltUpdated := false; // MESS�t�B���^�X�V���ꂽ��

end;


// Form.show ��ɏ���������e
procedure TfrmHttp.WMStartup(var Msg: TMessage);
var
  ResponseContent: TMemoryStream;
  Reader: TStreamReader;
  St: String;
  flag: boolean;
begin
  inherited;

  lblStatus.Caption:='���擾��...';
  Application.ProcessMessages;

  // �X�V�����邩�m�F
  if HttpError=false then
    NetHTTPRequest6.Head(URL_RETROFIRE);


  // �X�V�t�@�C�������邩�m�F
  NetHTTPRequest1.Head(URL_MAME32J);

  Application.ProcessMessages;

  // �X�V�t�@�C�������邩�m�F
  if HttpError=false then
    NetHTTPRequest3.Head(URL_VERSION);

  Application.ProcessMessages;

  // �X�V�t�@�C�������邩�m�F
  if HttpError=false then
    NetHTTPRequest4.Head(URL_MAMEINFO);

  Application.ProcessMessages;

  // �X�V�t�@�C�������邩�m�F
  if HttpError=false then
    NetHTTPRequest5.Head(URL_HISTORY);

  Application.ProcessMessages;

  // �X�V�t�@�C�������邩�m�F
  if HttpError=false then
    NetHTTPRequest7.Head(URL_MESSFLT);

  Application.ProcessMessages;


  // �{�̃o�[�W����
  Memo1.Lines.Add('�{�̍X�V�m�F��...');
  Application.ProcessMessages;

  //�擾�����f�[�^���i�[����Stream
  ResponseContent := TMemoryStream.Create;

  flag := false;

  try
    NetHTTPRequest2.Get(URL_RETROFIRE, ResponseContent);

    if ResponseContent.Size > 0 then // �_�E�����[�h�T�C�Y�m�F
    begin
      Reader := TStreamReader.Create(ResponseContent);
      St := trim(Reader.ReadLine);
      if ( strtoint(BUILDNO) = strtoint(St)) then
      begin
        Memo1.Lines.Add('�{�͍̂ŐV�łł� (�r���hNo.'+BUILDNO+')');
      end
      else if ( strtoint(BUILDNO) < strtoint(St)) then

        if (MessageDlg(Self, '�V�����{�̂��o�Ă���悤�ł��B'+#10#13+'�_�E�����[�h�y�[�W�Ɉړ����܂����H', mtConfirmation, mbOKCancel, 0) = mrOk) then
        begin
          flag := true;
        end;

      begin

      end;
    end
    else
    begin
      Memo1.Lines.Add('�{�̍X�V���̎擾�Ɏ��s���܂����B');
      lblStatus.Caption := '�{�̍X�V���̎擾�Ɏ��s���܂����B';
    end;

  finally
    ResponseContent.Free;
    Reader.Free;
  end;

  if flag then // �T�C�g�Ɉړ�
  begin
    ShellExecute(HInstance, 'open', PChar('https://www.e2j.net/downloads/?ret=1'), nil, nil, SW_NORMAL);
    Application.Terminate;
  end;

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

  // �t�@�C�������Ƃ�
  if not FileExists(IncludeTrailingPathDelimiter(GetCurrentDir)+'\mame32j.lst') then
    ETag_mame32j:='';

  // �X�V���邩����
  if (target_ETag_mame32j <> ETag_mame32j) and ( target_size_mame32j > 0) then
  begin
    Memo1.Lines.Add('mame32j.lst: �X�V���� ('+inttostr(target_size_mame32j)+' Bytes)');
    isDownloadable := true;
  end
  else if( target_size_mame32j = 0 ) then
  begin
    Memo1.Lines.Add('mame32j.lst: �t�@�C�����擾���s');
  end
  else
  begin
    Memo1.Lines.Add('mame32j.lst: �ŐV��');
  end;

  checkIfDownloadable();  // �_�E�����[�h�{�^���̗L����

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

  // �X�V���邩����
  if (target_ETag_version <> ETag_version) and ( target_size_version > 0) then
  begin
    Memo1.Lines.Add('version.ini: �X�V���� ('+inttostr(target_size_version)+' Bytes)');
    isDownloadable := true;
  end
  else if( target_size_version = 0 ) then
  begin
    Memo1.Lines.Add('version.ini: �t�@�C�����擾���s');
  end
  else
  begin
    Memo1.Lines.Add('version.ini: �ŐV��');
  end;

  checkIfDownloadable();  // �_�E�����[�h�{�^���̗L����

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

  // �X�V���邩����
  if (target_ETag_mameinfo <> ETag_mameinfo) and ( target_size_mameinfo > 0) then
  begin
    Memo1.Lines.Add('mameinfo.dat: �X�V���� ('+inttostr(target_size_mameinfo)+' Bytes)');
    isDownloadable := true;
  end
  else if( target_size_mameinfo = 0 ) then
  begin
    Memo1.Lines.Add('mameinfo.dat: �t�@�C�����擾���s');
  end
  else
  begin
    Memo1.Lines.Add('mameinfo.dat: �ŐV��');
  end;

  checkIfDownloadable();  // �_�E�����[�h�{�^���̗L����
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



  // �X�V���邩����
  if (target_ETag_history <> ETag_history) and ( target_size_history > 0) then
  begin
    Memo1.Lines.Add('history.dat: �X�V���� ('+inttostr(target_size_history)+' Bytes)');
    isDownloadable := true;
  end
  else if( target_size_history = 0 ) then
  begin
    Memo1.Lines.Add('history.dat: �t�@�C�����擾���s');
  end
  else
  begin
    Memo1.Lines.Add('history.dat: �ŐV��');
  end;

  checkIfDownloadable();  // �_�E�����[�h�{�^���̗L����
end;

procedure TfrmHttp.NetHTTPRequest7RequestCompleted(const Sender: TObject;
  const AResponse: IHTTPResponse);
  var i: integer;
begin
  inc(numChecked);

  for i := Low(AResponse.Headers) to High(AResponse.Headers) do
  begin
    //Memo1.Lines.Add( AResponse.Headers[i].Name + ': ' +  AResponse.Headers[i].Value );
    if AResponse.Headers[i].Name = 'Content-Length' then
    begin
      target_size_messflt := strtoint(AResponse.Headers[i].Value);
    end
    else
    if AResponse.Headers[i].Name = 'ETag' then
    begin
      target_ETag_messflt := AResponse.Headers[i].Value;
    end;
  end;

  // �X�V���邩����
  if not FileExists(IncludeTrailingPathDelimiter(GetCurrentDir)+'\mess.flt') then
    ETag_messflt:=''; // �t�@�C�������Ƃ�

  if ((target_ETag_messflt <> ETag_messflt)) and
     ( target_size_messflt > 0) then
  begin
    Memo1.Lines.Add('mess.flt: �X�V���� ('+inttostr(target_size_messflt)+' Bytes)');
    isDownloadable := true;
  end
  else if( target_size_mameinfo = 0 ) then
  begin
    Memo1.Lines.Add('mess.flt: �t�@�C�����擾���s');
  end
  else
  begin
    Memo1.Lines.Add('mess.flt: �ŐV��');
  end;

  checkIfDownloadable();  // �_�E�����[�h�{�^���̗L����
end;

procedure TfrmHttp.NetHTTPRequest1RequestError(const Sender: TObject;
  const AError: string);
begin
  lblStatus.Caption:='�ڑ����ɃG���[���N���܂����B';
  Memo1.Lines.Add( AError );
end;

procedure TfrmHttp.NetHTTPRequest3RequestError(const Sender: TObject;
  const AError: string);
begin
  lblStatus.Caption:='�ڑ����ɃG���[���N���܂����B';
  Memo1.Lines.Add( AError );
end;

procedure TfrmHttp.NetHTTPRequest4RequestError(const Sender: TObject;
  const AError: string);
begin
  lblStatus.Caption:='�ڑ����ɃG���[���N���܂����B';
  Memo1.Lines.Add( AError );
end;

procedure TfrmHttp.NetHTTPRequest5RequestError(const Sender: TObject;
  const AError: string);
begin
  lblStatus.Caption:='�ڑ����ɃG���[���N���܂����B';
  Memo1.Lines.Add( AError );
end;

procedure TfrmHttp.NetHTTPRequest6RequestError(const Sender: TObject;
  const AError: string);
begin
  lblStatus.Caption:='�ڑ����ɃG���[���N���܂����B';
  Memo1.Lines.Add( AError );
end;



procedure TfrmHttp.NetHTTPRequest7RequestError(const Sender: TObject;
  const AError: string);
begin
  lblStatus.Caption:='�ڑ����ɃG���[���N���܂����B';
  Memo1.Lines.Add( AError );
end;


procedure TfrmHttp.NetHTTPRequest2ReceiveData(const Sender: TObject;
  AContentLength, AReadCount: Int64; var Abort: Boolean);
begin
  // �f�[�^��M��
  ProgressBar1.Max:= AContentLength;
  ProgressBar1.Position:= AReadCount;

  Label2.Caption := inttostr( AReadCount ) + ' / ' +inttostr( AContentLength ) + ' Bytes';
  Application.ProcessMessages;

  // �A�{�[�g���f
  Abort := HttpAbort;
end;

procedure TfrmHttp.NetHTTPRequest2RequestError(const Sender: TObject;
  const AError: string);
begin
  HttpError := true;
  Memo1.Lines.Add(AError);
end;


// �L�����Z���{�^�����N���b�N
procedure TfrmHttp.btnCancelClick(Sender: TObject);
begin

  HttpAbort := true;

end;

// �_�E�����[�h�{�^�����N���b�N
procedure TfrmHttp.btnDownloadClick(Sender: TObject);
var
  ResponseContent: TMemoryStream;
  absPath: string;

begin

  HttpError := false;
  btnDownload.Enabled:=false;

  lblStatus.Caption:='�_�E�����[�h���Ă��܂�...';

  // mame32j.lst
  if (target_ETag_mame32j <> ETag_mame32j) and ( target_size_mame32j > 0) then
  begin

    Memo1.Lines.Add('mame32j.lst ���_�E�����[�h��...');
    Application.ProcessMessages;

    //�擾�����f�[�^���i�[����Stream
    ResponseContent := TMemoryStream.Create;

    try
      NetHTTPRequest2.Get(URL_MAME32J, ResponseContent);

      if ResponseContent.Size = target_size_mame32j then // �_�E�����[�h�T�C�Y�m�F
      begin
        try
          ResponseContent.SaveToFile( IncludeTrailingPathDelimiter(GetCurrentDir)+'\mame32j.lst');
          beep;

          Memo1.Lines.Add('mame32j.lst ��ۑ��B');

          ETag_mame32j := target_ETag_mame32j;
          btnCancel.ModalResult := mrOK;
        except
          on e:exception do
          begin
            lblStatus.Caption:='�t�@�C���̕ۑ��Ɏ��s���܂����B';
            Memo1.Lines.Add(e.Message);
            btnCancel.ModalResult := mrClose;
          end;
        end;
      end
      else
      begin

        Memo1.Lines.Add('mame32j.lst �̃_�E�����[�h�Ɏ��s���܂����B');
        lblStatus.Caption := 'mame32j.lst �t�@�C���̃_�E�����[�h�Ɏ��s���܂����B';
        btnCancel.ModalResult := mrClose;
      end;

    finally
      ResponseContent.Free;
    end;

  end;


  // version.ini
  if (target_ETag_version <> ETag_version) and ( target_size_version > 0) then
  begin

    Memo1.Lines.Add('version.ini ���_�E�����[�h��...');
    Application.ProcessMessages;

    //�擾�����f�[�^���i�[����Stream
    ResponseContent := TMemoryStream.Create;

    try
      NetHTTPRequest2.Get(URL_VERSION, ResponseContent);

      if ResponseContent.Size = target_size_version then // �_�E�����[�h�T�C�Y�m�F
      begin
        try
          // �ۑ���f�B���N�g�����Ȃ��ꍇ�͍��
          if not DirectoryExists(versionDir) then
          begin
            absPath := versionDir;

            if not System.IOUtils.TPath.IsPathRooted( absPath ) then // ���΃p�X�͐�΃p�X�ɕϊ�
              absPath:= RelToAbs( absPath, ExeDir );

            Memo1.Lines.Add('�f�B���N�g���쐬: '+absPath);
            ForceDirectories(absPath);
          end;

          ResponseContent.SaveToFile( IncludeTrailingPathDelimiter(versionDir) +'Version.ini');
          beep;

          Memo1.Lines.Add('Version.ini ��ۑ��B');

          ETag_version := target_ETag_version;
          btnCancel.ModalResult := mrOK;
        except
          on e:exception do
          begin
            lblStatus.Caption:='Version.ini �t�@�C���̕ۑ��Ɏ��s���܂����B';
            Memo1.Lines.Add(e.Message);
            btnCancel.ModalResult := mrClose;
          end;
        end;
      end
      else
      begin

        Memo1.Lines.Add('Version.ini �̃_�E�����[�h�Ɏ��s���܂����B');
        lblStatus.Caption := '�t�@�C���̃_�E�����[�h�Ɏ��s���܂����B';
        btnCancel.ModalResult := mrClose;
      end;

    finally
      ResponseContent.Free;
    end;

  end;


  // mameinfo.dat
  if (target_ETag_mameinfo <> ETag_mameinfo) and ( target_size_mameinfo > 0) then
  begin

    Memo1.Lines.Add('mameinfo.dat(zip) ���_�E�����[�h��...');
    Application.ProcessMessages;

    //�擾�����f�[�^���i�[����Stream
    ResponseContent := TMemoryStream.Create;

    try
      NetHTTPRequest2.Get(URL_MAMEINFO, ResponseContent);

      if ResponseContent.Size = target_size_mameinfo then // �_�E�����[�h�T�C�Y�m�F
      begin
        try
          // �ۑ���f�B���N�g�����Ȃ��ꍇ�͍��
          if not DirectoryExists(datDir) then
          begin
            absPath := datDir;

            if not System.IOUtils.TPath.IsPathRooted( absPath ) then // ���΃p�X�͐�΃p�X�ɕϊ�
              absPath:= RelToAbs( absPath, ExeDir );


            Memo1.Lines.Add('�f�B���N�g���쐬: '+absPath);
            ForceDirectories( absPath );
          end;

          ResponseContent.SaveToFile( IncludeTrailingPathDelimiter(datDir) +'mameinfo.zip');
          beep;

          Memo1.Lines.Add('mameinfo.dat(zip) ��ۑ��B');

          Application.ProcessMessages;

          TZipFile.ExtractZipFile(IncludeTrailingPathDelimiter(datDir) +'mameinfo.zip', IncludeTrailingPathDelimiter(datDir));
          DeleteFile(IncludeTrailingPathDelimiter(datDir) +'mameinfo.zip');
          Memo1.Lines.Add('mameinfo.dat ���𓀁B');
          ETag_mameinfo := target_ETag_mameinfo;
          btnCancel.ModalResult := mrOK;
        except
          on e:exception do
          begin
            lblStatus.Caption:='mameinfo.dat(zip) �t�@�C���̕ۑ��Ɏ��s���܂����B';
            Memo1.Lines.Add(e.Message);
            btnCancel.ModalResult := mrClose;
          end;
        end;
      end
      else
      begin
        Memo1.Lines.Add('mameinfo.dat(zip) �̃_�E�����[�h�Ɏ��s���܂����B');
        lblStatus.Caption := '�t�@�C���̃_�E�����[�h�Ɏ��s���܂����B';
        btnCancel.ModalResult := mrClose;
      end;

    finally
      ResponseContent.Free;
    end;

  end;


  // history.dat
  if (target_ETag_history <> ETag_history) and ( target_size_history > 0) then
  begin

    Memo1.Lines.Add('history.dat(zip) ���_�E�����[�h��...');
    Application.ProcessMessages;

    //�擾�����f�[�^���i�[����Stream
    ResponseContent := TMemoryStream.Create;

    try
      NetHTTPRequest2.Get(URL_HISTORY, ResponseContent);

      if ResponseContent.Size = target_size_history then // �_�E�����[�h�T�C�Y�m�F
      begin
        try
          // �ۑ���f�B���N�g�����Ȃ��ꍇ�͍��
          if not DirectoryExists(datDir) then
          begin
            absPath := datDir;

            if not System.IOUtils.TPath.IsPathRooted( absPath ) then // ���΃p�X�͐�΃p�X�ɕϊ�
              absPath:= RelToAbs( absPath, ExeDir );


            Memo1.Lines.Add('�f�B���N�g���쐬: '+absPath);
            ForceDirectories( absPath );
          end;

          ResponseContent.SaveToFile( IncludeTrailingPathDelimiter(datDir) +'history.zip');
          beep;

          Memo1.Lines.Add('history.dat(zip) ��ۑ��B');

          Application.ProcessMessages;

          TZipFile.ExtractZipFile(IncludeTrailingPathDelimiter(datDir) +'history.zip', IncludeTrailingPathDelimiter(datDir));
          DeleteFile(IncludeTrailingPathDelimiter(datDir) +'history.zip');
          Memo1.Lines.Add('history.dat ���𓀁B');
          ETag_history := target_ETag_history;
          btnCancel.ModalResult := mrOK;
        except
          on e:exception do
          begin
            lblStatus.Caption:='history.dat(zip) �t�@�C���̕ۑ��Ɏ��s���܂����B';
            Memo1.Lines.Add(e.Message);
            btnCancel.ModalResult := mrClose;
          end;
        end;
      end
      else
      begin
        Memo1.Lines.Add('history.dat(zip) �̃_�E�����[�h�Ɏ��s���܂����B');
        lblStatus.Caption := '�t�@�C���̃_�E�����[�h�Ɏ��s���܂����B';
        btnCancel.ModalResult := mrClose;
      end;

    finally
      ResponseContent.Free;
    end;
  end;


  // mess.flt
  if ( target_size_messflt > 0) and (target_ETag_messflt <> ETag_messflt) then
  begin

    Memo1.Lines.Add('mess.flt ���_�E�����[�h��...');
    Application.ProcessMessages;

    //�擾�����f�[�^���i�[����Stream
    ResponseContent := TMemoryStream.Create;

    try
      NetHTTPRequest7.Get(URL_MESSFLT, ResponseContent);

      if ResponseContent.Size = target_size_messflt then // �_�E�����[�h�T�C�Y�m�F
      begin
        try
          ResponseContent.SaveToFile( IncludeTrailingPathDelimiter(GetCurrentDir)+'\mess.flt');
          beep;

          Memo1.Lines.Add('mess.flt ��ۑ��B');

          ETag_messflt := target_ETag_messflt;
          btnCancel.ModalResult := mrOK;
          wasMESSFltUpdated := true;
        except
          on e:exception do
          begin
            lblStatus.Caption:='�t�@�C���̕ۑ��Ɏ��s���܂����B';
            Memo1.Lines.Add(e.Message);
            btnCancel.ModalResult := mrClose;
          end;
        end;
      end
      else
      begin

        Memo1.Lines.Add('mess.flt �̃_�E�����[�h�Ɏ��s���܂����B');
        lblStatus.Caption := 'mess.flt �t�@�C���̃_�E�����[�h�Ɏ��s���܂����B';
        btnCancel.ModalResult := mrClose;
      end;

    finally
      ResponseContent.Free;
    end;
  end;

  lblStatus.Caption:='��������';

end;

procedure TfrmHttp.checkIfDownloadable;
begin

  if numChecked <> 5 then Exit;

  if isDownloadable then
  begin
    beep;
    btnDownload.Enabled:=true;
    btnDownload.SetFocus;
    lblStatus.Caption:='�_�E�����[�h�ł���t�@�C��������܂��B';
  end
  else
  begin
    beep;
    lblStatus.Caption:='�X�V����t�@�C���͌�����܂���ł����B';
  end;


end;

end.
