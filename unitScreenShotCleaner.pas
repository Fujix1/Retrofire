unit unitScreenShotCleaner;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Common;

type
  TForm6 = class(TForm)
    Label1: TLabel;
    btnAnalyze: TButton;
    btnCleanup: TButton;
    GroupBox1: TGroupBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    ListView1: TListView;
    btnCancel: TButton;
    Label2: TLabel;
    CheckBox4: TCheckBox;
    procedure btnCancelClick(Sender: TObject);
    procedure btnAnalyzeClick(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure btnCleanupClick(Sender: TObject);
  private
    { Private 宣言 }
  public
    { Public 宣言 }
  end;

var
  Form6: TForm6;

implementation

{$R *.dfm}

procedure TForm6.btnAnalyzeClick(Sender: TObject);
var     folderPath :String;
        SearchRec  :TSearchRec;
        Res, Attri :Integer;
        NewItem: TListItem;
        filename   :String;

        filecount, foldcount: integer;
begin

  ListView1.Items.Clear;
  filecount := 0;
  foldcount := 0;
  label2.Caption := '';
  btnCleanup.Enabled:=False;

  Application.ProcessMessages;

  folderPath:=IncludeTrailingPathDelimiter(SnapDir); //パスの後ろに￥がなかったらつけてくれる

  // スナップフォルダの確認
  if DirectoryExists(folderPath)=false then
  begin
    Application.MessageBox('スクリーンショットのフォルダがありません。',
                          'エラー', MB_ICONERROR + MB_OK);
    exit;
  end;


  label2.Caption := '解析中..';
  Application.ProcessMessages;


  FindFirst( folderPath +'*', faAnyFile, SearchRec);

  //初期化
  Res := 0;


  /// 古い名前.PNGの削除
  try
    try
      while Res = 0 do
      begin
        Attri := SearchRec.Attr;
        if  (Attri <> faReadOnly) and (Attri <> faHidden) and
            (Attri <> faSysFile) then
        begin

          if (Attri <> faDirectory) then
          begin

            // 不明ZIPのPNGを探す
            if LowerCase(ExtractFileExt( SearchRec.Name )) = '.png' then
            begin
              if Checkbox1.Checked then
              begin
                filename := Copy( SearchRec.Name, 0, Length(SearchRec.Name)-4) ;

                if FindIndex(filename)=-1 then
                begin
                  NewItem := ListView1.Items.Add;
                  NewItem.Caption := '不明なZIP名ショット';
                  NewItem.SubItems.Add( SearchRec.Name );
                  inc( filecount );
                end;
              end;
            end
            else
            begin
            // PNG以外のファイル
              if Checkbox4.Checked then
              begin
                NewItem := ListView1.Items.Add;
                NewItem.Caption := 'PNG以外';
                NewItem.SubItems.Add( SearchRec.Name );
                inc( filecount );
              end;
            end;

          end
          else
          /// フォルダの処理
          begin


            if (SearchRec.Name<>'.') and (SearchRec.Name<>'..') then
            begin
              // 不明ZIPのフォルダを探す
              if FindIndex(SearchRec.Name)=-1 then
              begin
                if Checkbox3.Checked then
                begin
                  NewItem := ListView1.Items.Add;
                  NewItem.Caption := '不要フォルダ';
                  NewItem.SubItems.Add( SearchRec.Name );
                  inc( foldcount );
                end;
              end
              else
              begin
              // ZIP名とマッチするフォルダ発見時

                // ZIP.pngが無く、ZIP\0000.pngがあるとき
                if ( FileExists( folderPath + SearchRec.Name +'.png') = false ) and
                   ( FileExists( folderPath + SearchRec.Name +'\0000.png') ) then
                begin

                  if Checkbox2.Checked then
                  begin

                    NewItem := ListView1.Items.Add;
                    NewItem.Caption := 'フォルダ内から移動';
                    NewItem.SubItems.Add( SearchRec.Name + '\0000.png -> '+SearchRec.Name+'.png' );

                    NewItem := ListView1.Items.Add;
                    NewItem.Caption := 'フォルダを削除';
                    NewItem.SubItems.Add( SearchRec.Name );

                    inc( foldcount );
                  end;
                end
                else
                begin
                // ZIP.pngがあるとき
                  if Checkbox3.Checked then
                  begin
                    NewItem := ListView1.Items.Add;
                    NewItem.Caption := 'PNG重複フォルダ';
                    NewItem.SubItems.Add( SearchRec.Name );
                    inc( foldcount );
                  end;

                end;

              end;

            end;


          end;


        end;
        Res := FindNext(SearchRec);
      end;
    except
      Application.MessageBox('検索中にエラーが起きました。',
                             'エラー', MB_ICONERROR + MB_OK);
    end;
  finally
    FindClose(SearchRec);

  end;

  label2.Caption:='削除ファイル数 = '+inttostr(filecount)+
                  ',  削除フォルダ数 = '+inttostr(foldcount);
  btnCleanup.Enabled:=True;

end;

procedure TForm6.btnCancelClick(Sender: TObject);
begin

  Form6.Close;

end;

procedure TForm6.btnCleanupClick(Sender: TObject);
var     folderPath :String;
        SearchRec  :TSearchRec;
        Res, Attri :Integer;
        NewItem: TListItem;
        filename   :String;

        filecount, foldcount: integer;
begin

  ListView1.Items.Clear;
  filecount := 0;
  foldcount := 0;
  label2.Caption := '';
  btnCleanup.Enabled:=False;

  Application.ProcessMessages;

  folderPath:=IncludeTrailingPathDelimiter(SnapDir); //パスの後ろに￥がなかったらつけてくれる

  // スナップフォルダの確認
  if DirectoryExists(folderPath)=false then
  begin
    Application.MessageBox('スクリーンショットのフォルダがありません。',
                          'エラー', MB_ICONERROR + MB_OK);
    exit;
  end;


  label2.Caption := '処理中..';
  btnCancel.Enabled:=False;
  btnAnalyze.Enabled:=False;
  btnCleanup.Enabled:=False;

  Application.ProcessMessages;


  FindFirst( folderPath +'*', faAnyFile, SearchRec);

  //初期化
  Res := 0;


  /// 古い名前.PNGの削除
  try
    try
      while Res = 0 do
      begin
        Attri := SearchRec.Attr;
        if  (Attri <> faReadOnly) and (Attri <> faHidden) and
            (Attri <> faSysFile) then
        begin

          if (Attri <> faDirectory) then
          begin

            // 不明ZIPのPNGを探す
            if LowerCase(ExtractFileExt( SearchRec.Name )) = '.png' then
            begin
              if Checkbox1.Checked then
              begin
                filename := Copy( SearchRec.Name, 0, Length(SearchRec.Name)-4) ;

                if FindIndex(filename)=-1 then
                begin

                  label2.Caption := 'ゴミ箱に移動中: '+folderPath+SearchRec.Name;
                  Trasher( folderPath+SearchRec.Name );


                  inc( filecount );
                  NewItem := ListView1.Items.Add;
                  NewItem.Caption := '不明なZIP名ショット';
                  NewItem.SubItems.Add( SearchRec.Name );
                  ListView1.Selected  :=  ListView1.Items[ListView1.Items.Count - 1];
                  ListView1.Selected.MakeVisible(True);
                  Application.ProcessMessages;
                end;
              end;
            end
            else
            begin
            // PNG以外のファイル
              if Checkbox4.Checked then
              begin

                label2.Caption := 'ゴミ箱に移動中: '+folderPath+SearchRec.Name;
                Trasher( folderPath+SearchRec.Name );

                NewItem := ListView1.Items.Add;
                NewItem.Caption := 'PNG以外';
                NewItem.SubItems.Add( SearchRec.Name );
                inc( filecount );
                ListView1.Selected  :=  ListView1.Items[ListView1.Items.Count - 1];
                ListView1.Selected.MakeVisible(True);
                Application.ProcessMessages;

              end;
            end;

          end
          else
          /// フォルダの処理
          begin


            if (SearchRec.Name<>'.') and (SearchRec.Name<>'..') then
            begin
              // 不明ZIPのフォルダを探す
              if FindIndex(SearchRec.Name)=-1 then
              begin
                if Checkbox3.Checked then
                begin

                  label2.Caption := 'ゴミ箱に移動中: '+folderPath+SearchRec.Name;
                  Trasher( folderPath+SearchRec.Name );

                  NewItem := ListView1.Items.Add;
                  NewItem.Caption := '不要フォルダ';
                  NewItem.SubItems.Add( SearchRec.Name );
                  inc( foldcount );
                  ListView1.Selected  :=  ListView1.Items[ListView1.Items.Count - 1];
                  ListView1.Selected.MakeVisible(True);
                  Application.ProcessMessages;

                end;
              end
              else
              begin
              // ZIP名とマッチするフォルダ発見時

                // ZIP.pngが無く、ZIP\0000.pngがあるとき
                if ( FileExists( folderPath + SearchRec.Name +'.png') = false ) and
                   ( FileExists( folderPath + SearchRec.Name +'\0000.png') ) then
                begin

                  if Checkbox2.Checked then
                  begin

                    label2.Caption := 'フォルダ内から移動中: '+folderPath+SearchRec.Name;

                    try
                      if RenameFile(folderPath + SearchRec.Name +'\0000.png',
                                    folderPath + SearchRec.Name +'.png') then
                      begin
                        RemoveDir( folderPath + SearchRec.Name );

                      end;

                    except

                    end;

                    NewItem := ListView1.Items.Add;
                    NewItem.Caption := 'フォルダ内から移動';
                    NewItem.SubItems.Add( SearchRec.Name + '\0000.png -> '+SearchRec.Name+'.png' );

                    NewItem := ListView1.Items.Add;
                    NewItem.Caption := 'フォルダを削除';
                    NewItem.SubItems.Add( SearchRec.Name );

                    inc( foldcount );
                    ListView1.Selected  :=  ListView1.Items[ListView1.Items.Count - 1];
                    ListView1.Selected.MakeVisible(True);
                    Application.ProcessMessages;
                  end;
                end
                else
                begin
                // ZIP.pngがあるとき
                  if Checkbox3.Checked then
                  begin

                    label2.Caption := 'ゴミ箱に移動中: '+folderPath+SearchRec.Name;
                    Trasher( folderPath+SearchRec.Name );

                    NewItem := ListView1.Items.Add;
                    NewItem.Caption := 'PNG重複フォルダ';
                    NewItem.SubItems.Add( SearchRec.Name );
                    inc( foldcount );
                    ListView1.Selected  :=  ListView1.Items[ListView1.Items.Count - 1];
                    ListView1.Selected.MakeVisible(True);
                    Application.ProcessMessages;
                  end;

                end;

              end;

            end;


          end;


        end;
        Res := FindNext(SearchRec);
      end;
    except
      Application.MessageBox('削除中にエラーが起きました。',
                             'エラー', MB_ICONERROR + MB_OK);
    end;
  finally
    FindClose(SearchRec);

  end;

  label2.Caption:='削除したファイル数 = '+inttostr(filecount)+
                  ',  削除したフォルダ数 = '+inttostr(foldcount);
  btnCleanup.Enabled:=False;
  btnCancel.Enabled:=True;
  btnAnalyze.Enabled:=True;

  beep;

end;

procedure TForm6.FormHide(Sender: TObject);
begin

  ListView1.Items.Clear;
  btnCleanup.Enabled:=False;
  Label2.Caption:='';

end;

end.
