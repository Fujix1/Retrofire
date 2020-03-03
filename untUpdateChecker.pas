unit untUpdateChecker;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Common, StdCtrls, WinInet;

type
  TfrmUpdater = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private �錾 }
  public
    { Public �錾 }
  end;

var
  frmUpdater: TfrmUpdater;

implementation

{$R *.dfm}

procedure TfrmUpdater.Button1Click(Sender: TObject);
const
  URL ='http://www.e2j.net/files/retrofire.txt';
var
  hSession, hReqUrl :hInternet;
  Buffer : array [0..3] of AnsiChar;
  ReadCount :Cardinal;
  HtmlStr : AnsiString;
begin

  //�ڑ��̊m��
  hSession :=InternetOpen(nil, INTERNET_OPEN_TYPE_PRECONFIG,
                          nil, nil, 0);
  try
  if Assigned(hSession) then
  begin
    //URL�̃n���h�����擾
    hReqUrl :=InternetOpenUrl(hSession,PChar(URL),
                              nil, 0,INTERNET_FLAG_RELOAD, 0);
    try
    if Assigned(hReqUrl) then
    begin

      InternetReadFile(hReqUrl, @Buffer, 3, ReadCount);
      HtmlStr :=  Ansistring(Buffer);

    end;
    finally
      InternetCloseHandle(hReqUrl);
    end;

  end;
  finally
    InternetCloseHandle(hSession);
  end;

  if Trim(HtmlStr) = '' then
    Application.MessageBox(PWideChar('�X�V���̎擾�Ɏ��s���܂����B'), APPNAME, MB_ICONSTOP)

end;


procedure TfrmUpdater.Button2Click(Sender: TObject);
begin

  frmUpdater.Close;

end;

end.
