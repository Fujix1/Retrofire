program Retrofire;

{$R *.dres}

uses
  Forms,
  Windows,
  SysUtils,
  Messages,
  Common in 'Common.pas',
  Unit1 in 'Unit1.pas' {Form1},
  Unit2 in 'Unit2.pas' {Form2},
  unitSetting in 'unitSetting.pas' {frmSetting},
  unitAbout in 'unitAbout.pas' {Form5},
  unitScreenShotCleaner in 'unitScreenShotCleaner.pas' {Form6},
  unitCommandViewer in 'unitCommandViewer.pas' {frmCommand},
  Vcl.Themes,
  Vcl.Styles,
  unitFavorites in 'unitFavorites.pas' {frmFavorites};

{$R *.res}

var
  hMutex: THandle;
  Wnd, AppWnd: HWnd;

begin

  // ��d�N���h�~
  hMutex := OpenMutex(MUTEX_ALL_ACCESS, False, APPNAME);
  if hMutex <> 0 then // ���Ɏ��s����Ă���
  begin

    Wnd := FindWindow('TForm1', nil);
    if Wnd <> 0 then // ��������
    begin
      SetForegroundWindow(Wnd); // �O�ʂɈړ����ăA�N�e�B�u��
      // TApplication �̃E�B���h�E�n���h�����擾
      AppWnd := GetWindowLong(Wnd, GWL_HWNDPARENT);
      if AppWnd <> 0 then Wnd := AppWnd;
      if IsIconic(Wnd) then // �A�C�R����ԂȂ猳�ɖ߂�
        SendMessage(AppWnd, WM_SYSCOMMAND, SC_RESTORE, -1);
    end;
    //�~���[�e�b�N�X�����
    CloseHandle(hMutex);
  end
  else
  begin
  //�~���[�e�b�N�X���쐬
  hMutex := CreateMutex(nil, False, APPNAME);
  // ��d�N���h�~�����܂�


  Application.Initialize;
  Application.Title := 'Retrofire';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TfrmSetting, frmSetting);
  Application.CreateForm(TForm5, Form5);
  Application.CreateForm(TForm6, Form6);
  Application.CreateForm(TfrmFavorites, frmFavorites);
  //  Application.CreateForm(TfrmUpdater, frmUpdater);
  Application.CreateForm(TfrmCommand, frmCommand);
  Application.Run;

  //�~���[�e�b�N�X���J��
  ReleaseMutex(hMutex);
end;
end.
