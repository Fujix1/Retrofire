unit unitHttp;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, common, Vcl.StdCtrls, Vcl.ExtCtrls,
  System.Net.URLClient, System.Net.HttpClient, System.Net.HttpClientComponent,
  Vcl.ComCtrls;

const
  URL_MAME32J = 'https://raw.githubusercontent.com/Fujix1/Retrofire/master/mame32j.lst'; // mame32j.lst �̎擾��
  URL_VERSION = 'https://raw.githubusercontent.com/Fujix1/Retrofire/master/folders/Version.ini'; // version.ini �̎擾��



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
    { Private �錾 }
    procedure WMStartup(var Msg: TMessage); message WM_STARTUP;
    procedure checkIfDownloadable;
  public
    { Public �錾 }
  end;

var
  frmHttp: TfrmHttp;

  HttpError: boolean; // ���炩�̃G���[���N�������H
  HttpAbort: boolean; // ���f���ꂽ��

  target_ETag_mame32j: string; // �_�E�����[�h�Ώۂ� Etag
  target_size_mame32j: integer; // �Ώۂ� Content-Length

  target_ETag_version: string; // �_�E�����[�h�Ώۂ� Etag
  target_size_version: integer; // �Ώۂ� Content-Length

  isDownloadable: boolean; // �_�E�����[�h�\��
  numChecked: integer; // �_�E�����[�h�`�F�b�N������

implementation

{$R *.dfm}



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


  // �t�H�[��show�̂��Ƃɏ���������
  // https://stackoverflow.com/questions/14318807/what-is-the-best-way-to-autostart-an-action-after-onshow-event
  PostMessage(Handle, WM_STARTUP, 0, 0);

  //OnShow := nil;//only ever post the message once

end;


// Form.show ��ɏ���������e
procedure TfrmHttp.WMStartup(var Msg: TMessage);
begin
  inherited;

  lblStatus.Caption:='���擾��...';
  Application.ProcessMessages;

  // �X�V�t�@�C�������邩�m�F
  NetHTTPRequest1.Head(URL_MAME32J);

  Application.ProcessMessages;

  // �X�V�t�@�C�������邩�m�F
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

  // �X�V���邩����
  if (target_ETag_mame32j <> ETag_mame32j) and ( target_size_mame32j > 0) then
  begin
    Memo1.Lines.Add('mame32j.lst: �X�V���� ('+inttostr(target_size_mame32j)+' Bytes)');
    isDownloadable := true;
  end
  else
  begin
    Memo1.Lines.Add('mame32j.lst: ���Ԃ�ŐV�łł�');
  end;

  checkIfDownloadable();  // �_�E�����[�h�{�^���̗L����

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

  // �X�V���邩����
  if (target_ETag_version <> ETag_version) and ( target_size_version > 0) then
  begin
    Memo1.Lines.Add('version.ini: �X�V���� ('+inttostr(target_size_version)+' Bytes)');
    isDownloadable := true;
  end
  else
  begin
    Memo1.Lines.Add('version.ini: ���Ԃ�ŐV�łł�');
  end;

  checkIfDownloadable();  // �_�E�����[�h�{�^���̗L����

end;

procedure TfrmHttp.NetHTTPRequest3RequestError(const Sender: TObject;
  const AError: string);
begin
  lblStatus.Caption:='�ڑ����ɃG���[���N���܂����B';
  Memo1.Lines.Add( AError );
end;

procedure TfrmHttp.NetHTTPRequest1RequestError(const Sender: TObject;
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
          ResponseContent.SaveToFile( GetCurrentDir+'\mame32j.lst');
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
          ResponseContent.SaveToFile( versionDir +'\Version.ini');
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

  lblStatus.Caption:='��������';


end;

procedure TfrmHttp.checkIfDownloadable;
begin
  if (numChecked = 2) and (isDownloadable) then
  begin
    beep;
    btnDownload.Enabled:=true;
    btnDownload.SetFocus;
    lblStatus.Caption:='�_�E�����[�h�ł���t�@�C��������܂��B';
  end
  else if (numChecked = 2) and (not isDownloadable) then
  begin
    beep;
    lblStatus.Caption:='�X�V����t�@�C���͌�����܂���ł����B';
  end;


end;

end.
