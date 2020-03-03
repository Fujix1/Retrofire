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

  // 二重起動防止
  hMutex := OpenMutex(MUTEX_ALL_ACCESS, False, APPNAME);
  if hMutex <> 0 then // 既に実行されている
  begin

    Wnd := FindWindow('TForm1', nil);
    if Wnd <> 0 then // 見つかった
    begin
      SetForegroundWindow(Wnd); // 前面に移動してアクティブ化
      // TApplication のウィンドウハンドルを取得
      AppWnd := GetWindowLong(Wnd, GWL_HWNDPARENT);
      if AppWnd <> 0 then Wnd := AppWnd;
      if IsIconic(Wnd) then // アイコン状態なら元に戻す
        SendMessage(AppWnd, WM_SYSCOMMAND, SC_RESTORE, -1);
    end;
    //ミューテックスを閉じる
    CloseHandle(hMutex);
  end
  else
  begin
  //ミューテックスを作成
  hMutex := CreateMutex(nil, False, APPNAME);
  // 二重起動防止ここまで


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

  //ミューテックスを開放
  ReleaseMutex(hMutex);
end;
end.
