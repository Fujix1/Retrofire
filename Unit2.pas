  unit Unit2;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Variants, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Common, ExtCtrls;

type
  TForm2 = class(TForm)
    OpenDialog1: TOpenDialog;
    btnOK:      TButton;
    btnCancel:  TButton;
    GroupBox1:  TGroupBox;
    Edit2:      TEdit;
    Button3:    TButton;
    Label4:     TLabel;
    Timer1: TTimer;
    Label1: TLabel;
    chkSoftlist: TCheckBox;

    procedure FormShow(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    
  private
    { Private 宣言 }
  public
    { Public 宣言 }
  end;

  function ExtractListXML: boolean;
  function processSoftwareList(filePath:String): boolean;

  function ZenToHan( fromText: String ): string;

var
  Form2: TForm2;
  CancelFlag:boolean;
  second: integer;

implementation

uses Unit1;

{$R *.dfm}

procedure TForm2.FormShow(Sender: TObject);
begin

  CancelFlag:=False;
  second:=0;

  if CurrentProfile<>-1 then
  begin
    if FileExists(MameExe[CurrentProfile].ExePath) then
    begin
      Edit2.Text:=MameExe[CurrentProfile].ExePath;
      OpenDialog1.InitialDir:= ExtractFilePath( MameExe[CurrentProfile].ExePath );
    end;
  end;

end;

procedure TForm2.Timer1Timer(Sender: TObject);
var ss,mm:string;
begin

  inc(second);
  ss:= '0'+inttostr(second mod 60);
  ss:= copy( ss, length(ss)-1, 2 );

  mm:= inttostr( second div 60 );


  Label1.Caption:= mm+':'+ss;

end;

procedure TForm2.Button3Click(Sender: TObject);
begin

  if DirectoryExists(lastExePath) then
    OpenDialog1.InitialDir:=lastExePath;

  if OpenDialog1.Execute then
  begin
    Edit2.Text:=OpenDialog1.FileName;
  end;



end;

procedure TForm2.btnOKClick(Sender: TObject);
var
  Save_Cursor : TCursor;
  SI :TStartupInfo;
  PI :TProcessInformation;
  parameter: string;
  cmd: Commd;
begin

  Save_Cursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;    // Show hourglass cursor
  ModalResult:=mrOK;

  timer1.Enabled:=true;
  Edit2.Enabled:=False;
  Button3.Enabled:=False;
  BtnOK.Enabled:=False;
  chkSoftlist.Enabled:=False;
  LastExePath:=ExtractFilePath(OpenDialog1.FileName);


  // softwarelistの出力 --------------------------------------------------
  if chkSoftList.Checked then
  begin
    try
      Label4.Caption:='listsoftware出力中...';

      Application.ProcessMessages;

      if FileExists(ExeDir+'listsoftware.tmp') then
        DeleteFile(ExeDir+'listsoftware.tmp');

      cmd := SetCommand;
      parameter := '"'+cmd.App+ '" ' +cmd.Param + '""'+ Edit2.Text +'"'+
                    ' -listsoftware > "' + ExeDir +'listsoftware.tmp""';


      GetStartupInfo(SI);

      SetLength(parameter, Length(parameter));

      // コンソールを隠した状態で起動する
      SI.wShowWindow := SW_HIDE;

      UniqueString(parameter);  // 指定された文字列が 1 つの参照カウントを持つことを保証します

      if not CreateProcessW(
                          nil,
                          PWideChar(parameter),
                          nil,
                          nil,
                          False,
                          CREATE_DEFAULT_ERROR_MODE,
                          nil,
                          PWideChar(ExtractFilePath(Edit2.Text)),  // カレントディレクトリはmame本体じゃないと動かない
                          SI,
                          PI
                          )
      then
        Exit;

      // アプリケーションの終了待ち
      try
        while (WaitForSingleObject(PI.hProcess, 100) = WAIT_TIMEOUT) and
              (CancelFlag=False) do
        begin
          Application.ProcessMessages;
          Sleep(100);
        end;

      finally
        CloseHandle(PI.hThread);
        CloseHandle(PI.hProcess);
      end;

      if CancelFlag then
      begin
        ModalResult:=mrCancel;
        exit;
      end;

      /// listsoftware の解析 ---------------------------------------------------
      if processSoftwareList(ExeDir+'listsoftware.tmp') = False then
      begin
        MessageBox(Form2.Handle,'listsoftwareファイルが正しく出力されていません。',APPNAME,MB_OK or MB_ICONERROR);
        ModalResult:=mrCancel;
      end;
    finally
      Screen.Cursor := Save_Cursor;  // Always restore to normal
    end;


  end;


  try

    Label4.Caption:='listxml出力中...';

    Application.ProcessMessages;

    /// listxmlの出力 ---------------------------------------------------
    if FileExists(ExeDir+'listxml.tmp') then
      DeleteFile(ExeDir+'listxml.tmp');

    cmd := SetCommand;

    parameter := '"'+cmd.App+ '" ' +cmd.Param + '""'+ Edit2.Text +'"'+
           ' -listxml > "' + ExeDir +'listxml.tmp""';

    GetStartupInfo(SI);

    SetLength(parameter, Length(parameter));

    // コンソールを隠した状態で起動する
    SI.wShowWindow := SW_HIDE;

    UniqueString(parameter);  // 指定された文字列が 1 つの参照カウントを持つことを保証します

    if not CreateProcessW(
                        nil,
                        PWideChar(parameter),
                        nil,
                        nil,
                        False,
                        CREATE_DEFAULT_ERROR_MODE,
                        nil,
                        PWideChar(ExeDir),
                        SI,
                        PI
                        )
    then
      Exit;

    // アプリケーションの終了待ち
    try
      while (WaitForSingleObject(PI.hProcess, 100) = WAIT_TIMEOUT) and
            (CancelFlag=False) do
      begin
        Application.ProcessMessages;
        Sleep(50);
      end;

    finally
      CloseHandle(PI.hThread);
      CloseHandle(PI.hProcess);
    end;

    if CancelFlag then
    begin
      ModalResult:=mrCancel;
      exit;
    end;


    /// listxmlの解析 ---------------------------------------------------
    if ExtractListXML=False then
    begin
      MessageBox(Form2.Handle,'listxmlファイルが正しく出力されていません。',APPNAME,MB_OK or MB_ICONERROR);
      ModalResult:=mrCancel;
    end;

  finally
    Screen.Cursor := Save_Cursor;  // Always restore to normal
  end;

  // 成功した場合 listxmlのtempファイル削除
  if ModalResult=mrOK then
  begin
    if FileExists(ExeDir+'listxml.tmp') then
      DeleteFile(ExeDir+'listxml.tmp');

    if FileExists(ExeDir+'listsoftware.tmp') then
      DeleteFile(ExeDir+'listsoftware.tmp');
  end;


  timer1.Enabled:=False;
  Form2.Hide;

  Label1.Caption:='';
  Label4.Caption:='';
  Edit2.Enabled:=True;
  BtnOK.Enabled:=True;
  Button3.Enabled:=True;
  chkSoftlist.Enabled:=true;

end;


//------------------------------------------------------------------------------
// ソフトリストを解析してtsv書き出し
function processSoftwareList(FILEPATH :String): boolean;

type
  PSoftware = ^TSoftware;
  TSoftware = record
    name    :string;
    cloneof :string;
    desc    :string;
    year    :string;
    alt     :string;
    publisher: string;
    supported: string; // yes|partial|no
end;
var
  i,j,k: integer;
  softlist : TList;
  NewSoftware : PSoftware;

  Rec : TSearchRec; // ファイルサイズ取得用
  fs : single;
  F1, F2 : TextFile;
  St, temp, output, S: string;
  name, description: string;

  catalog: TStringList;

  allcatalog: TStringList;
  softlistEntry: string;

  alt: string;
  version: string;
  p1,p2: integer;


  function AscSort(Item1, Item2: Pointer): Integer;
  begin
    Result := CompareText(PSoftware(Item1).name, PSoftware(Item2).name);
  end;

  function escape(st: string):string;
  begin
    st := StringReplace( st, '&lt;','<', [rfReplaceAll]);
    st := StringReplace( st, '&gt;','>', [rfReplaceAll]);
    st := StringReplace( st, '&amp;','&', [rfReplaceAll]);
    st := StringReplace( st, '&quot;','"', [rfReplaceAll]);
    st := StringReplace( st, '　',' ', [rfReplaceAll]);
    st := ZenToHan(st);
    result:=st;
  end;

  function translate(st: string):string;
  begin

    st := StringReplace( st, 'Nintendo Entertainment System cartridges','任天堂ファミリーコンピュータカセット', [rfReplaceAll]);
    st := StringReplace( st, 'Nintendo Entertainment System','任天堂ファミリーコンピュータ', [rfReplaceAll]);
    st := StringReplace( st, 'Nintendo SNES cartridges','任天堂スーパーファミコンカセット', [rfReplaceAll]);
    st := StringReplace( st, 'Nintendo SNES - Sufami Turbo cartridges','任天堂スーパーファミコン - スーファミターボカセット', [rfReplaceAll]);
    st := StringReplace( st, 'Nintendo SNES Satellaview Memory Packs','任天堂スーパーファミコンサテラビューメモリパック', [rfReplaceAll]);
    st := StringReplace( st, 'Nintendo Virtual Boy cartridges','任天堂バーチャルボーイカセット', [rfReplaceAll]);
    st := StringReplace( st, 'Nintendo Entertainment System - Datach Joint ROM System mini-cartridges','任天堂ファミリーコンピュータ - データックジョイントROMシステムミニカセット', [rfReplaceAll]);

    st := StringReplace( st, 'Nantettatte!! Baseball mini-cartridges','なんてったってベースボール ミニカセット', [rfReplaceAll]);
    st := StringReplace( st, 'Karaoke Studio expansion cartridges','カラオケスタジオ拡張カセット', [rfReplaceAll]);

    st := StringReplace( st, 'Nintendo Famicom Family BASIC cassettes','任天堂ファミリーベーシックテープ', [rfReplaceAll]);
    st := StringReplace( st, 'Nintendo Famicom Disk images','任天堂ファミコンディスクシステムイメージ', [rfReplaceAll]);
    st := StringReplace( st, 'Nintendo Game Boy cartridges','任天堂ゲームボーイカセット', [rfReplaceAll]);
    st := StringReplace( st, 'Nintendo Game Boy Color cartridges','任天堂ゲームボーイカラーカセット', [rfReplaceAll]);
    st := StringReplace( st, 'Nintendo Game Boy Advance cartridges','任天堂ゲームボーイアドバンスカセット', [rfReplaceAll]);
    st := StringReplace( st, 'Sega Dreamcast GD-ROMs','セガドリームキャストGD-ROM', [rfReplaceAll]);
    st := StringReplace( st, 'Sega Game Gear cartridges','セガゲームギアカセット', [rfReplaceAll]);
    st := StringReplace( st, 'Sega Saturn cartridges','セガサターンカセット', [rfReplaceAll]);
    st := StringReplace( st, 'Sega Saturn CD-ROM','セガサターンCD-ROM', [rfReplaceAll]);
    st := StringReplace( st, 'Sega Mega CD (Euro) CD-ROMs','セガメガCD (Euro版) CD-ROM', [rfReplaceAll]);
    st := StringReplace( st, 'Sega Mega CD (Jpn) CD-ROMs','セガメガCD (日本版) CD-ROM', [rfReplaceAll]);
    st := StringReplace( st, 'Sega MegaDrive/Genesis cartridges','セガメガドライブ/Genesisカセット', [rfReplaceAll]);
    st := StringReplace( st, 'Sega Master System cartridges','セガマスターシステムカセット', [rfReplaceAll]);
    st := StringReplace( st, 'Sega SG-1000 and SG-1000 Mark II cartridges','セガSG-1000/SG-1000 Mark IIカセット', [rfReplaceAll]);

    st := StringReplace( st, 'Sony Playstation CD-ROMs','ソニープレイステーションCD-ROM', [rfReplaceAll]);
    st := StringReplace( st, 'Fujitsu FM-7 cassettes','富士通FM-7カセットテープ', [rfReplaceAll]);
    st := StringReplace( st, 'Fujitsu FM-7 disk images','富士通FM-7ディスク', [rfReplaceAll]);
    st := StringReplace( st, 'Fujitsu FM-77AV disk images','富士通FM-77AVディスク', [rfReplaceAll]);
    st := StringReplace( st, 'Fujitsu FM Towns CD-ROMs','富士通FM TOWNS CD-ROM', [rfReplaceAll]);
    st := StringReplace( st, 'Fujitsu FM Towns cracked floppy disk images','富士通FM TOWNSフロッピーディスク(クラック済み)', [rfReplaceAll]);
    st := StringReplace( st, 'Fujitsu FM Towns miscellaneous floppy disk images','富士通FM TOWNSフロッピーディスク(その他)', [rfReplaceAll]);
    st := StringReplace( st, 'Fujitsu FM Towns original floppy disk images','富士通FM TOWNSフロッピーディスク(オリジナル)', [rfReplaceAll]);
    st := StringReplace( st, 'SNK NeoGeo CD CD-ROMs','SNKネオジオCD CD-ROM', [rfReplaceAll]);
    st := StringReplace( st, 'SNK Neo-Geo cartridges','SNKネオジオカセット', [rfReplaceAll]);
    st := StringReplace( st, 'SNK Neo Geo Pocket cartridges','SNKネオジオポケットカセット', [rfReplaceAll]);
    st := StringReplace( st, 'SNK Neo Geo Pocket Color cartridges','SNKネオジオポケットカラーカセット', [rfReplaceAll]);

    st := StringReplace( st, 'Sharp X68k disk images','シャープX68000ディスク', [rfReplaceAll]);
    st := StringReplace( st, 'Sharp MZ-2200 cassettes','シャープMZ-2200カセットテープ', [rfReplaceAll]);
    st := StringReplace( st, 'Sharp MZ-700 cassettes','シャープMZ-700カセットテープ', [rfReplaceAll]);
    st := StringReplace( st, 'Sharp MZ-800 cassettes','シャープMZ-800カセットテープ', [rfReplaceAll]);
    st := StringReplace( st, 'Sharp X1 cassettes','シャープX1カセットテープ', [rfReplaceAll]);
    st := StringReplace( st, 'Sharp X1 disk images','シャープX1ディスク', [rfReplaceAll]);

    st := StringReplace( st, 'NEC PC-Engine / Turbografx 16 CD-ROMs','NEC PCエンジン / Turbografx 16 CD-ROM', [rfReplaceAll]);
    st := StringReplace( st, 'NEC PC-Engine cartridges','NEC PCエンジン Huカード', [rfReplaceAll]);

    st := StringReplace( st, 'CD-ROMs','CD-ROM', [rfReplaceAll]);
    st := StringReplace( st, 'ROMs','ROM', [rfReplaceAll]);
    st := StringReplace( st, 'tapes/cartridges','テープ/カセット', [rfReplaceAll]);
    st := StringReplace( st, 'cassettes','カセットテープ', [rfReplaceAll]);
    st := StringReplace( st, 'disk images','ディスク', [rfReplaceAll]);
    st := StringReplace( st, 'hard disks','ハードディスク', [rfReplaceAll]);
    st := StringReplace( st, 'floppy disks','フロッピー', [rfReplaceAll]);
    st := StringReplace( st, 'floppy images','フロッピー', [rfReplaceAll]);
    st := StringReplace( st, 'ROM images','ROMイメージ', [rfReplaceAll]);
    st := StringReplace( st, 'diskettes','ディスク', [rfReplaceAll]);
    st := StringReplace( st, 'cartridges','カセット', [rfReplaceAll]);
    st := StringReplace( st, 'floppy disk images','フロッピー', [rfReplaceAll]);
    st := StringReplace( st, 'discs','ディスク', [rfReplaceAll]);
    st := StringReplace( st, 'disks','ディスク', [rfReplaceAll]);
    st := StringReplace( st, 'floppies','フロッピー', [rfReplaceAll]);

    result:=st;
  end;

  //最後に見つかる文字列位置を調べる
  function LastPos(const substr, str: String) : Integer;
  begin
    result := Length(str) - Pos( ReverseString(substr) , ReverseString(str) ) - Length(substr) + 2;
  end;

begin

  if not DirectoryExists(ExeDir + SL_DIR) then MkDir(ExeDir + SL_DIR);

  // ファイルサイズチェック
  fs:=0;
  if FindFirst(FILEPATH, faAnyFile, Rec) = 0 then
  begin
    fs:= Rec.Size / 1024; // KBに変換
  end;
  FindClose(Rec);

  if fs<=20 then // 20kB以下なら
  begin
    result:=False;
    exit;
  end;

  FindClose(Rec);

  AssignFile(F1, FILEPATH, CP_UTF8);
  Reset(F1);

  catalog := TStringList.Create;
  catalog.Sorted := true;

  allcatalog := TStringList.Create;

  try

    ReadLn(F1, St);

    while not Eof(F1) do
    begin
      // softwarelist 始め
      if (Copy(St,1,14) = #9+'<softwarelist' ) then
      begin
        name := ExtractXML('name', St);
        description := ExtractXML('description', St);
        Form2.Label4.Caption:= name + ': ' + description;
        Application.ProcessMessages;

        description := escape(description);
        description := translate(description);

        catalog.Add( name + #9 + description + #9 );

        softlistEntry := name + #9 + description + #9;

        softlist := TList.Create;

        while (Copy(St,1,15) <> #9+'</softwarelist') do
        begin
          // software 取得
          while St <> #9#9+'</software>' do
          begin
            // software 始め
            if (Copy(St,1,12) = #9#9+'<software ' ) then
            begin
              New(NewSoftware);
              NewSoftware.name := ExtractXML('name', St);
              NewSoftware.cloneof := ExtractXML('cloneof', St);
              NewSoftware.supported := ExtractXML('supported', St);
              if NewSoftware.supported = '' then
                NewSoftware.supported := 'yes';
            end
            else
            /// Description
            if Copy(St,1,15)=#9#9#9+'<description' then
            begin
              i:=Pos('>',St)+1;
              NewSoftware.desc := Copy(St,i,PosEx('<',St,i)-i);
            end
            else
            /// Year
            if Copy(St,1,8)=#9#9#9+'<year' then
            begin
              i:=Pos('>',St)+1;
              NewSoftware.year := Copy(St,i,PosEx('<',St,i)-i);
            end
            else
            /// publisher
            if Copy(St,1,13)=#9#9#9+'<publisher' then
            begin
              i:=Pos('>',St)+1;
              NewSoftware.publisher := Copy(St,i,PosEx('<',St,i)-i);
            end
            else
            /// alt_title
            if Copy(St,1,25)=#9#9#9+'<info name="alt_title"' then
            begin
              NewSoftware.alt:=ExtractXML('value', St);
            end;
            ReadLn(F1, St);
          end;


          softlist.Add(NewSoftware);
          ReadLn(F1, St);
        end;

        // Zip名昇順で並べ替え
        softlist.Sort(@AscSort);

        // ソフトウェアリストエントリ
        allCatalog.Add(softlistEntry+inttostr(softlist.Count));

        for i:=0 to softlist.Count-1 do
        begin
          Application.ProcessMessages;

          // 括弧を日本語タイトルに移植
          {alt := PSoftware(softlist[i]).alt;
          if alt<>'' then
          begin
            if Pos(')',alt)<>0 then
            begin
              version:=PSoftware(softlist[i]).desc;
              p1:=LastPos(' (', version);
              p2:=LastPos(')', version);
              if (p1<>0) and (p2<>0) then
              begin
                version:=Copy(version,p1,p2-1);
                alt := alt+version;
              end;
            end;
          end;
           }

          output := PSoftware(softlist[i]).name + #9 +
                    PSoftware(softlist[i]).cloneof + #9 +
                    PSoftware(softlist[i]).desc + #9 +
                    PSoftware(softlist[i]).alt + #9 +
                    PSoftware(softlist[i]).year+ #9 +
                    PSoftware(softlist[i]).publisher+ #9+
                    PSoftware(softlist[i]).supported;

          output := escape(output);
          allCatalog.Add(output);
        end;


        softlist.Clear;
        softlist.free;

      end;
      ReadLn(F1, St);
    end;


    allCatalog.SaveToFile(ExeDir + SL_DIR + SL_DATA, TEncoding.UTF8);

  finally
    CloseFile(F1);
    catalog.Free;
    allCatalog.Free;
  end;

  result:= true;
  exit;

end;



// listxmlからのデータ抽出
function ExtractListXML : boolean;

  type //
    PListInfo = ^TListInfo;
    TListInfo = record

      ZipName : string;     // Zip名
      DescE   : string;     // 英語名
      Maker   : string;     // メーカー
      Year    : string;     // 製造年

      CloneOf : string;     // マスタ名
      MasterID: integer;    // マスタのID
      Master  : boolean;    // マスタ

      RomOf   : string;     //  RomOf

      SampleOf: string;     // サンプル名

      Vector  : boolean;    // ベクター
      LightGun: boolean;    // 光線銃
      Analog  : boolean;    // アナログ操作
      Status  : boolean;    // ステータス Good=True
      Channels: integer;    // サウンドチャンネル数
      Vertical: boolean;    // 縦画面

      CPUs    : string;     // CPUs
      Sounds  : string;     // Sound chips
      Screens : string;     // 画面情報
      NumScreens: integer;  // 画面数
      Palettesize :integer; // 色数
      ResX    : Word;       // 解像度X
      ResY    : Word;       // 解像度Y
      ScanRate: string;     // スキャンレート
      Color   : TGameStatus;// 色ステータス
      Sound   : TGameStatus;// 音ステータス
      GFX     : TGameStatus;// GFXステータス
      Protect : TGameStatus;// プロテクトステータス
      Cocktail: TGameStatus;// カクテルステータス
      SaveState:TGameStatus;// セーブステート
      Source  : string;     // ソースファイル
      CHD     : string;     // CHD
      CHDOnly : boolean;    // CHDのみのゲーム
      CHDMerge: boolean;    // CHDのマージ指定あり
      LD      : boolean;    // レーザーディスク
      CHDNoDump: boolean;   // CHD未吸い出し
      isMechanical: boolean;// メカニカルゲーム

      Flag    : boolean;    // 汎用
  end;

  type
    TMakerList = record
      Maker : string;  // 製造元
      Count : integer; // カウント
      Clone : boolean; //
  end;


  function AscSort(Item1, Item2: Pointer): Integer;
  begin
    Result := CompareText(PListInfo(Item1).ZipName, PListInfo(Item2).ZipName);
  end;

  var
    ListInfo : TList;
    NewItem : PListInfo;

    MakerList: array of TMakerList;
    F1 : TextFile;
    St,S,S2,Years,CPUs,Sounds: string;
    CPU   : array of string;
    Audio : array of string;
    Screen: array of string;
    w,h: string;
    r: real;
    i,j,ii: integer;
    StrList,SL: TStringList;
    CPUList,SoundList: TStringList;
    Clock,Count: integer;

    softlist: TStringList;

    Rec : TSearchRec; // ファイルサイズ取得用
    fs : Single;

    sltRes  :  TStringList;

    name, software: String;


begin

  Form2.Label4.Caption:='データ解析中...';
  Application.ProcessMessages;

  // ファイルがあるか
  if FileExists(ExeDir+'listxml.tmp')=False then
  begin
    result:=False;
    exit;
  end;

  // ファイルサイズチェック
  fs:=0;
  if FindFirst(ExeDir+'listxml.tmp', faAnyFile, Rec) = 0 then
  begin
    fs:= Rec.Size / 1024; // KBに変換
  end;
  FindClose(Rec);

  if fs<=10 then // 10kB以下なら
  begin
    result:=False;
    exit;
  end;

  AssignFile(F1, ExeDir+'listxml.tmp', CP_UTF8);
  Reset(F1);
  
  try
  
    ListInfo:=TList.Create;

    CPUList:=TStringList.Create;
    CPUList.Duplicates:=dupIgnore;
    CPUList.Sorted:=True;

    SoundList:=TStringList.Create;
    SoundList.Duplicates:=dupIgnore;
    SoundList.Sorted:=True;

    softlist := TStringList.Create;
    softlist.Sorted := true;
    softlist.Duplicates := dupIgnore;

    while not Eof(F1) do
    begin

      ReadLn(F1,St);

      // MAMEのバージョン
      if Pos('<mame build=',St)<>0 then
      begin
        DatVersion:=ExtractXML('build',St);

        // バージョンに括弧があれば削除
        if (Pos('(',DatVersion)<>0) then
        begin
          DatVersion := Copy( DatVersion, 1, Pos('(',DatVersion)-1 );
        end;

      end;

      // 始め
      if ( (Copy(St,1,6)=#9+'<game') and
           (Pos('runnable="no"',St)=0) and
           (Pos('isbios="yes"',St)=0) ) // biosじゃない (0.117u2)
         or (
           (Copy(St,1,7)=#9+'<machi') and
           (Pos('runnable="no"',St)=0) and
           (Pos('isbios="yes"',St)=0) ) // biosじゃない (0.117u2)

         then
      begin

        // 初期化
        New(NewItem);
        SetLength(CPU,0);
        SetLength(Audio,0);
        SetLength(Screen,0);

        NewItem.ZipName     :='';
        NewItem.DescE       :='';
        NewItem.Maker       :='';
        NewItem.Year        :='????';
        NewItem.CloneOf     :='';
        NewItem.RomOf       :='';
        NewItem.MasterID    :=-1;
        NewItem.Master      :=True;
        NewItem.SampleOf    :='';
        NewItem.Vector      :=False;
        NewItem.LightGun    :=False;
        NewItem.Analog      :=False;
        NewItem.Status      :=False;
        NewItem.Vertical    :=False;
        NewItem.Channels    :=0;
        NewItem.ResX        :=0;
        NewItem.ResY        :=0;
        NewItem.CPUs        :='';
        NewItem.Sounds      :='--';
        NewItem.Screens     :='--';
        NewItem.NumScreens  :=0;
        NewItem.Source      :='';
        NewItem.Palettesize :=0;
        NewItem.Sound       :=gsUnknown;
        NewItem.Color       :=gsUnknown;
        NewItem.GFX         :=gsUnknown;
        NewItem.Protect     :=gsUnknown;
        NewItem.Cocktail    :=gsUnknown;
        NewItem.SaveState   :=gsUnknown;
        NewItem.Flag        :=False;
        NewItem.CHD         :='';
        NewItem.CHDOnly     :=True;
        NewItem.CHDMerge    :=False;
        NewItem.LD          :=False;
        NewItem.CHDNoDump   :=False;
        NewItem.isMechanical:=False;

        software := '';


        /// ZIP name
        if pos('name=',St)<>0 then
        begin
          NewItem.ZipName:=ExtractXML('name',St);
        end;

        /// CloneOf
        if pos('cloneof=',St)<>0 then
        begin
          NewItem.CloneOf:=ExtractXML('cloneof',St);
          NewItem.Master:=False;
        end;

        /// RomOf
        if pos('romof=',St)<>0 then
        begin
          NewItem.RomOf:=ExtractXML('romof',St);
        end;

        /// SampleOf
        if pos('sampleof=',St)<>0 then
        begin
          NewItem.SampleOf:=ExtractXML('sampleof',St);
        end;

        /// Source File (new format from 0.85)
        if pos('sourcefile=',St)<>0 then
        begin
          NewItem.Source:=ExtractXML('sourcefile',St);
        end;

        /// isMechanical
        if pos('ismechanical="yes"',St)<>0 then
        begin
          NewItem.isMechanical:=True;
        end;


        ReadLn(F1,St);

        while ( (St<>#9+'</game>') and (St<>#9+'</machine>') ) do
        begin

          /// Description-E
          if Copy(St,1,7)=#9#9+'<desc' then
          begin
            i:=Pos('>',St)+1;
            NewItem.DescE:=NormalizeString(Copy(St,i,PosEx('<',St,i)-i));
            // update: TAB文字が入ってる場合取り除く

            NewItem.DescE := StringReplace(NewItem.DescE, #9, ' ', [ rfReplaceAll ]);

          end
          else
          /// Year
          if Copy(St,1,7)=#9#9+'<year' then
          begin
            i:=Pos('>',St)+1;
            NewItem.Year:=Copy(St,i,PosEx('<',St,i)-i);
          end
          else
          /// Maker
          if Copy(St,1,7)=#9#9+'<manu' then
          begin
            i:=Pos('>',St)+1;
            NewItem.Maker:=NormalizeString(Copy(St,i,PosEx('<',St,i)-i));
          end
          else
          /// ROM
          if (Copy(St,1,6)=#9#9+'<rom') and (NewItem.CHDOnly) then
          begin
            if (Pos('merge"=',St)<>0) then
              NewItem.CHDOnly:=False;
          end
          else
          /// Sound Channels
          if Copy(St,1,6)=#9#9+'<sou' then
          begin
            NewItem.Channels:=StrtoInt(ExtractXML('channels',St));
          end
          else
          /// CHD
          if Copy(St,1,7)=#9#9+'<disk' then
          begin
            NewItem.CHD:=ExtractXML('name',St);

            // CHDMerge
            if ExtractXML('merge',St)<>'' then
              NewItem.CHDMerge:=True;

            // LD
            if ExtractXML('region',St)='laserdisc' then
              NewItem.LD:=True;

            // CHDNoDump
            if ExtractXML('status',St)='nodump' then
              NewItem.CHDNoDump:=True;

          end
          else
          /// Control
          if Copy(St,1,11)=#9#9#9+'<control' then
          begin
            if pos('lightgun',St)<>0 then
              NewItem.LightGun:=True;

            if (pos('dial',St)<>0) or (pos('paddle',St)<>0) or
               (pos('stick',St)<>0) or (pos('trackball',St)<>0) then
              NewItem.Analog:=True;

          end
          else

          // 親セットのサンプルチェック
          if pos('sample name',St)<>0 then
          begin

            if NewItem.SampleOf='' then
              NewItem.SampleOf:=NewItem.ZipName;

          end
          else

          /// <driver>
          if Copy(St,1,5)=#9#9+'<dr' then
          begin

            if pos('emulation="good"',St)<>0 then
            begin
              NewItem.Status:=True;
            end;

            // Color
            if pos('color="good"',St)<>0 then
            begin
              NewItem.Color:=gsGood;
            end
            else
            if pos('color="preliminary"',St)<>0 then
            begin
              NewItem.Color:=gsPreliminary;
            end
            else
            if pos('color="imperfect"',St)<>0 then
            begin
              NewItem.Color:=gsImperfect;
            end;

            // Sound
            if pos('sound="good"',St)<>0 then
            begin
              NewItem.Sound:=gsGood;
            end
            else
            if pos('sound="preliminary"',St)<>0 then
            begin
              NewItem.Sound:=gsPreliminary;
            end
            else
            if pos('sound="imperfect"',St)<>0 then
            begin
              NewItem.Sound:=gsImperfect;
            end;

            // GFX
            if pos('graphic="good"',St)<>0 then
            begin
              NewItem.GFX:=gsGood;
            end
            else
            if pos('graphic="',St)<>0 then
            begin
              NewItem.GFX:=gsImperfect;
            end;

            // Protection
            if pos('protection="preliminary"',St)<>0 then
            begin
              NewItem.Protect:=gsPreliminary;
            end;

            // Cocktail
            if (pos('cocktail="preliminary"',St)<>0) then
            begin
              NewItem.Cocktail:=gsPreliminary;
            end;

            // Save State
            if pos('savestate="supported"',St)<>0 then
            begin
              NewItem.SaveState:=gsGood;
            end
            else
            if pos('savestate="unsupported"',St)<>0 then
            begin
              NewItem.SaveState:=gsPreliminary;
            end;

            // Palette Size
            if (pos('palettesize',St)<>0) then
            begin
              NewItem.Palettesize:=StrtoInt(ExtractXML('palettesize',St));
            end;

          end
          else
          /// <feature   // 新しい各種ステータスへの対応
          if Copy(St,1,10)=#9#9+'<feature' then
          begin

            // Sound
            if pos('"sound" status="unemulated"',St)<>0 then
            begin
              NewItem.Sound:=gsPreliminary;
            end
            else
            if pos('"sound" status="imperfect"',St)<>0 then
            begin
              NewItem.Sound:=gsImperfect;
            end
            else
            // GFX
            if pos('"graphics" status="imperfect"',St)<>0 then
            begin
              NewItem.GFX:=gsImperfect;
            end
            else
            if pos('"graphics" status="unemulated"',St)<>0 then
            begin
              NewItem.GFX:=gsPreliminary;
            end
            else
            // Protection
            if pos('"protection" status="unemulated"',St)<>0 then
            begin
              NewItem.Protect:=gsPreliminary;
            end
            else
            if pos('"protection" status="imperfect"',St)<>0 then
            begin
              NewItem.Protect:=gsImperfect;
            end
            else
            // Color
            if pos('"palette" status="unemulated"',St)<>0 then
            begin
              NewItem.Color:=gsPreliminary;
            end
            else
            if pos('"palette" status="imperfect"',St)<>0 then
            begin
              NewItem.Color:=gsImperfect;
            end


          end
          else

          /// <chip type="cpu">
          if Copy(St,1,18)=#9#9+'<chip type="cpu"' then
          begin

            S:=ExtractXML('name',St);
            S2:=ExtractXML('tag',St);

            SetLength(CPU, Length(CPU)+1);

            // CPUリスト
            CPUList.Add(S);

            Clock:=StrtoInt(ExtractXML('clock',St));

            if Clock < 1000000 then
              S := S+ FormatFloat(' @ #.### KHz', Clock / 1000)
            else
              S := S+ FormatFloat(' @ #.###### MHz', Clock / 1000000);


            // Sound用CPU
            if S2='soundcpu' then
              S:= S+' (sound)'
            else
            if S2='audiocpu' then
              S:= S+' (audio)'
            else
            // メインCPU
            if S2='maincpu' then
              S:= S+' (main)'
            else
            // その他のCPU
            if trim(S2)<>'' then
              S:= S+' ('+S2+')';


            CPU[Length(CPU)-1]:=S;


          end
          else
          // <chip type="audio">
          if Copy(St,1,18)=#9#9+'<chip type="audi' then
          begin

            S:=ExtractXML('name',St);

            // autioコンポーネントがSpeakerの場合を除く
            if S<>'Speaker' then
            begin

              SetLength(Audio, Length(Audio)+1);

              // Soundチップリストに追加
              SoundList.Add(S);

              if pos('clock',St)<>0 then  // clockがある場合
              begin

                Clock:=StrtoInt(ExtractXML('clock',St));

                if Clock < 1000000 then
                  S := S + FormatFloat(' @ #.### KHz', Clock / 1000)
                else
                  S := S + FormatFloat(' @ #.###### MHz', Clock / 1000000);

              end;

              Audio[Length(Audio)-1]:=S;
            end;

          end
          else

          // screens v0.106u12
          if (pos('<display ',St)<>0) then
          begin

            w:='';
            h:='';

            // Vector
            if pos('vector',St)<>0 then
            begin
              NewItem.Vector:=True;
            end;

            // Vertical Screen
            if (ExtractXML('rotate',St)='90') or (ExtractXML('rotate',St)='270') then
            begin
              NewItem.Vertical:=True;
              w:=ExtractXML('height',St);
              h:=ExtractXML('width',St);
            end
            else
            begin
              w:=ExtractXML('width',St);
              h:=ExtractXML('height',St);
            end;

            r:=StrtoFloat(ExtractXML('refresh',St));

            SetLength(Screen, Length(Screen)+1);

            if NewItem.Vector then
            begin
                Screen[Length(Screen)-1]:=FormatFloat('Vector @ #.###### Hz', r)
            end
            else
            begin
              Screen[Length(Screen)-1]:= w+'x'+h+FormatFloat(' @ #.###### Hz', r);

              if NewItem.ResX=0 then
              begin
                NewItem.ResX:=StrtoInt(w);
                NewItem.ResY:=StrtoInt(h);
              end;

            end;

            Inc(NewItem.NumScreens);

            //

          end
          else
          /// softwarelist
          if Copy(St,1,11)=#9#9+'<software' then
          begin
            name := ExtractXML('name',St);
            if software='' then
            begin
              software:=NewItem.ZipName;
            end;

            software:=software + #9 + name;

          end;

          ReadLn(F1,St);

        end;

        // ソフトリスト
        if software <> '' then
        begin
          softlist.Add(software);
          software:='';
        end;


        // CPUまとめ
        St:='';
        for ii:=1 to Length(CPU) do
        begin
          Count:=1;
          for j:=ii+1 to Length(CPU) do
          begin
            if CPU[ii-1] = CPU[j-1] then
            begin
              CPU[j-1]:='';
              Inc(Count);
            end;
          end;

          if CPU[ii-1]<>'' then
          begin
            if Count=1 then
              St:=St+','+ CPU[ii-1]
            else
              St:=St+','+ InttoStr(Count)+' x '+ CPU[ii-1];
          end;

        end;

        NewItem.CPUs := AnsiReplaceText( Copy(St,2,Length(St)),'__big_',' (big)');
        NewItem.CPUs := AnsiReplaceText( NewItem.CPUs, '__little_', ' (little)');
        NewItem.CPUs := AnsiReplaceText( NewItem.CPUs, '_', ' ');

        NewItem.CPUs := AnsiReplaceText( NewItem.CPUs , '&quot;', '"');
        NewItem.CPUs := AnsiReplaceText( NewItem.CPUs , '&amp;', '&');
        NewItem.CPUs := AnsiReplaceText( NewItem.CPUs , '&lt;', '<');
        NewItem.CPUs := AnsiReplaceText( NewItem.CPUs , '&gt;', '>');


        NewItem.Maker:=AnsiReplaceText(NewItem.Maker,'&#233;','e');

        if (NewItem.Maker='unknown') then
            NewItem.Maker:='<unknown>';
        if (NewItem.Maker='Unknown') then
            NewItem.Maker:='<unknown>';


        // Soundsまとめ
        St:='';
        for ii:=1 to Length(Audio) do
        begin
          Count:=1;
          // 重複を削除
          for j:=ii+1 to Length(Audio) do
          begin
            if Audio[ii-1] = Audio[j-1] then
            begin
              Audio[j-1]:='';
              Inc(Count);
            end;
          end;

          if Audio[ii-1]<>'' then
          begin
            if Count=1 then
              St:=St+','+ Audio[ii-1]
            else
              St:=St+','+ InttoStr(Count)+' x '+ Audio[ii-1];
          end;
        end;

        if st<>'' then
        begin
          NewItem.Sounds:=AnsiReplaceText(Copy(St,2,Length(St)),'_',' ');

          NewItem.Sounds := AnsiReplaceText( NewItem.Sounds , '&quot;', '"');
          NewItem.Sounds := AnsiReplaceText( NewItem.Sounds , '&amp;', '&');
          NewItem.Sounds := AnsiReplaceText( NewItem.Sounds , '&lt;', '<');
          NewItem.Sounds := AnsiReplaceText( NewItem.Sounds , '&gt;', '>');

        end;

        
        // Screenまとめ
        St:='';

        for ii:=1 to Length(Screen) do
        begin
          Count:=1;
          for j:=ii+1 to Length(Screen) do
          begin
            if Screen[ii-1] = Screen[j-1] then
            begin
              Screen[j-1]:='';
              Inc(Count);
            end;
          end;

          if Screen[ii-1]<>'' then
          begin
            if Count=1 then
              St:=St+','+ Screen[ii-1]
            else
              St:=St+','+ InttoStr(Count)+' x '+ Screen[ii-1];
          end;
        end;

        S:='';
        if NewItem.Vector then
          S:='ベクタ，'
        else
          S:='ラスタ，';

        if NewItem.Vertical then
          S:=S+'縦表示，'
        else
          S:=S+'横表示，';

        if (not NewItem.Vector) and (NewItem.Palettesize<>0) then
          S:=S+InttoStr(NewItem.Palettesize)+'色，';

        if NewItem.NumScreens>0 then
        begin
          S:=S+InttoStr(NewItem.NumScreens)+'画面';
          NewItem.Screens:=S+St;
        end
        else
        begin
          NewItem.Screens:='--';
        end;


        ListInfo.Add(NewItem);

      end;

      // 終わり
      Application.ProcessMessages;

    end;

    // ソフトリスト情報書き出し
    if Form2.chkSoftlist.Checked then
    begin
      if not DirectoryExists(ExeDir + SL_DIR) then MkDir(ExeDir + SL_DIR);
      softlist.SaveToFile(ExeDir + SL_DIR + SL_MASTER);

    end;


  finally
    CloseFile(F1);
    softlist.Free;
  end;

  // 項目がきちんと読み込まれたか
  if ListInfo.Count=0 then
  begin
    result:=False;
    exit;
  end;

  // Zip名昇順で並べ替え
  ListInfo.Sort(@AscSort);

  // マスタIDの検索
  Form2.Label4.Caption:='マスタ検索中...';
  Application.ProcessMessages;

  for i:=0 to ListInfo.Count-1 do
  begin
    Application.ProcessMessages;

    if PListInfo(ListInfo[i]).CloneOf<>'' then
    begin
      for j:=0 to ListInfo.Count-1 do
      begin
        if (PListInfo(ListInfo[j]).Master) and
           (PListInfo(ListInfo[i]).CloneOf=PListInfo(ListInfo[j]).ZipName) then
        begin
          PListInfo(ListInfo[i]).MasterID:=j;
          break;
        end;
      end;
    end
    else
    begin
      PListInfo(ListInfo[i]).MasterID:=i;
    end;
  end;


  ///
  Form2.Label4.Caption:='メーカー名の絞り込み...';
  Application.ProcessMessages;


  // 全部バラバラにする
  StrList:=TStringList.Create;
  SL:=TStringList.Create;

  for i:=0 to ListInfo.Count-1 do
  begin

    // licensed from取る
    St:=AnsiReplaceStr(St,'licensed from ','');
    // license取る
    St:=AnsiReplaceStr(PListInfo(ListInfo[i]).Maker,' license','');
    // licence取る
    St:=AnsiReplaceStr(St,' licence','');
    // ?を取る
    St:=AnsiReplaceStr(St,'?','');
    // , supported by
    St:=AnsiReplaceStr(St,', supported by ',#9);
    // , distributed by
    St:=AnsiReplaceStr(St,', distributed by ',#9);
    // 「+」を「tab」に
    //St:=AnsiReplaceStr(St,'+',#9);
    // 「[」を取る
    St:=AnsiReplaceStr(St,'[','');
    // 「)」を取る
    St:=AnsiReplaceStr(St,')','');
    // 「(」を「tab」に
    St:=AnsiReplaceStr(St,'(',#9);
    // 「]」を「tab」に
    St:=AnsiReplaceStr(St,']',#9);
    // 「 / 」を「tab」に
    St:=AnsiReplaceStr(St,' / ',#9);
    // 「/」を「tab」に
    St:=AnsiReplaceStr(St,'/',#9);
    // 「tab tab」を「tab」に
    St:=AnsiReplaceStr(St,#9+' '+#9,#9);

    // 「<unknown>」を「zzz<unknown>」に
    St:=AnsiReplaceStr(St,'<unknown>','zzz<unknown>');
    // 「????」を「zzz<unknown>」に
    St:=AnsiReplaceStr(St,'????','zzz<unknown>');


    SL.Clear;
    Application.ProcessMessages;


    for j:=0 to TsvSeparate(St,SL)-1 do
    begin
      if SL[j]='Ameri' then SL[j]:='Ameri_';
      if SL[j]='Soft' then SL[j]:='Soft_';

      StrList.Add(Trim(SL[j]));

    end;

  end;


  StrList.Sort;

  // 重複をカウント
  for i:=0 to StrList.Count-1 do
  begin
    if StrList[i]<>'' then
    begin

      ii:=1;
      for j:=i+1 to StrList.Count-1 do
      begin
        if StrList[i]=StrList[j] then
        begin
          inc(ii);
          StrList[j]:='';
        end;
      end;
      SetLength(MakerList,Length(MakerList)+1);
      MakerList[Length(MakerList)-1].Maker:=StrList[i];
      MakerList[Length(MakerList)-1].Count:=ii;
    end;
  end;

  // 畳み込み
  //Form2.memo1.Lines.Clear;
  for i:=0 to Length(MakerList)-1 do
  begin
    if MakerList[i].Clone=False then
    begin
      //Form2.Memo1.Lines.Add(MakerList[i].Maker);
      //Application.ProcessMessages;
      for j:=0 to Length(MakerList)-1 do
      begin
        if (i<>j) and
           (pos(MakerList[i].Maker+' ', MakerList[j].Maker+' ')<>0) then
        begin
          Inc(MakerList[i].Count,MakerList[j].Count);
          MakerList[j].Clone:=True;
        end;
      end;
    end;
  end;


  // 一行にまとめる
  St:='';
  for i:=1 to Length(MakerList)-1 do
  begin

    if (MakerList[i].Clone=false) and (MakerList[i].Count>=MAKER) then
    begin

      if MakerList[i].Maker='zzz<unknown>' then
        MakerList[i].Maker:='<unknown>';

      if MakerList[i].Maker.Length>1 then
        St:=St+MakerList[i].Maker+#9;
    end;
  end;

  St:=Trim(St);
  FreeAndNil(SL);
  FreeAndNil(StrList);
  SetLength(MakerList,0);


  /// 年代一覧
  StrList:=TStringList.Create;
  StrList.Duplicates:=dupIgnore; // 重複追加しない
  StrList.Sorted:=True;
  for i:=0 to ListInfo.Count-1 do
  begin
    StrList.Add(PListInfo(ListInfo[i]).Year);
  end;

  // ????を後ろに持っていく
  StrList.Sorted:=False;
  if StrList[0]='????' then
     StrList.Move(0,StrList.Count-1);

  Years:=StrList[0];
  for i:=1 to StrList.Count-1 do
  begin
    Years:=Years+#9+StrList[i];
  end;
  FreeAndNil(StrList);
  
  /// CPUs一覧
  CPUs:=CPUList[0];
  for i:=1 to CPUList.Count-1 do
  begin
    CPUs:=CPUs+#9+CPUList[i];
  end;
  FreeAndNil(CPUList);
  CPUs:=AnsiReplaceText(CPUs,'__big_',' (big)');
  CPUs:=AnsiReplaceText(CPUs,'__little_',' (little)');
  CPUs:=AnsiReplaceText(CPUs,'_',' ');

  CPUs := AnsiReplaceText( CPUs , '&quot;', '"');
  CPUs := AnsiReplaceText( CPUs , '&amp;', '&');
  CPUs := AnsiReplaceText( CPUs , '&lt;', '<');
  CPUs := AnsiReplaceText( CPUs , '&gt;', '>');

  /// Soundチップ一覧
  Sounds:=SoundList[0];
  for i:=1 to SoundList.Count-1 do
  begin
    Sounds:=Sounds+#9+SoundList[i];
  end;
  SoundList.Free;
  Sounds:=AnsiReplaceText(Sounds,'_',' ');

  ////
  /// 出力
  Form2.Label4.Caption:='リソースファイル出力中...';
  Application.ProcessMessages;

  sltRes := TStringList.Create;

  // バージョン
  sltRes.Add('ResVersion='+BUILDNO);

  if DatVersion<>'' then
    sltRes.Add('version='+DatVersion);

  // メーカー名
  sltRes.Add(St);

  // 年代
  sltRes.Add(Years);

  // CPUs
  sltRes.Add(CPUs);

  // Sounds
  sltRes.Add(Sounds);

  // ゲーム情報
  for i:=0 to ListInfo.Count-1 do
  begin
    St:=
      PListInfo(ListInfo[i]).ZipName+#9+                  // Zip名
      PListInfo(ListInfo[i]).DescE+#9+                    // 英語名
      PListInfo(ListInfo[i]).Maker+#9+                    // メーカー
      PListInfo(ListInfo[i]).Year+#9+                     // 製造年
      PListInfo(ListInfo[i]).CloneOf+#9+                  // マスタ名
      PListInfo(ListInfo[i]).RomOf+#9+                    // RomOf
      PListInfo(ListInfo[i]).SampleOf+#9+                 // サンプル名
      InttoStr(PListInfo(ListInfo[i]).MasterID)+#9+       // マスタのID
      BoolToStr(PListInfo(ListInfo[i]).Master)+#9+        // マスタ
      BoolToStr(PListInfo(ListInfo[i]).Vector)+#9+        // ベクター
      BoolToStr(PListInfo(ListInfo[i]).Lightgun)+#9+      // 光線銃
      BoolToStr(PListInfo(ListInfo[i]).Analog)+#9+        // アナログ入力
      BooltoStr(PListInfo(ListInfo[i]).Status)+#9+        // ステータス Good=True
      BooltoStr(PListInfo(ListInfo[i]).Vertical)+#9+      // 縦画面
      InttoStr(PListInfo(ListInfo[i]).Channels)+#9+       // サウンドチャンネル数
      PListInfo(ListInfo[i]).CPUs+#9+                     // CPUs
      PListInfo(ListInfo[i]).Sounds+#9+                   // Sound chips
      PListInfo(ListInfo[i]).Screens+#9+                  // 画面情報
      InttoStr(PListInfo(ListInfo[i]).NumScreens)+#9+     // 画面数
      InttoStr(PListInfo(ListInfo[i]).Palettesize)+#9+    // 色数
      InttoStr(PListInfo(ListInfo[i]).ResX)+#9+           // 解像度X
      InttoStr(PListInfo(ListInfo[i]).ResY)+#9+           // 解像度Y

      InttoStr(Ord(PListInfo(ListInfo[i]).Color))+#9+     // 色ステータス
      InttoStr(Ord(PListInfo(ListInfo[i]).Sound))+#9+     // 音ステータス
      InttoStr(Ord(PListInfo(ListInfo[i]).GFX))+#9+       // GFXステータス
      InttoStr(Ord(PListInfo(ListInfo[i]).Protect))+#9+   // プロテクトステータス
      InttoStr(Ord(PListInfo(ListInfo[i]).Cocktail))+#9+  // カクテルモードステータス
      InttoStr(Ord(PListInfo(ListInfo[i]).SaveState))+#9+ // セーブステート
      PListInfo(ListInfo[i]).Source+#9+                   // ソースファイル
      PListInfo(ListInfo[i]).CHD+#9+                      // CHD
      BoolToStr(PListInfo(ListInfo[i]).CHDOnly)+#9+       // CHDのみ
      BoolToStr(PListInfo(ListInfo[i]).CHDMerge)+#9+      // CHDマージ指定あり
      BoolToStr(PListInfo(ListInfo[i]).LD)+#9+            // レーザーディスク
      BoolToStr(PListInfo(ListInfo[i]).CHDNoDump)+#9+     // CHD未吸い出し
      BoolToStr(PListInfo(ListInfo[i]).isMechanical);     // メカニカルゲーム
      sltRes.Add(St);
  end;

  try
    sltRes.SaveToFile(ExeDir+RESNAME, TEncoding.UTF8);

  except
    on E: EFCreateError do
    begin
      ListInfo.Clear;
      ListInfo.Free;
      sltRes.Free;

      Application.MessageBox('リソースファイル書き込み失敗。',APPNAME, MB_ICONSTOP);
      exit;
    end;
  end;

  // TListの各項目のメモリ解放
  for i:= 0 to ListInfo.Count-1 do
    dispose(PListInfo(ListInfo[i]));

  ListInfo.Clear;
  ListInfo.Free;
  sltRes.Free;

  result:=True;

end;

procedure TForm2.Edit2Change(Sender: TObject);
begin

  btnOK.Enabled:=(FileExists(Edit2.Text));

end;


//---------------------------------------------------
// 全角半角変換
function ZenToHan( fromText: String ): string;
const
  Dis = $FEE0;
var
  Str   : String;
  i     : Integer;
  AChar : Cardinal;
begin
  Str := '';
  for i := 1 to Length( fromText ) do begin
    AChar := Ord(fromText[i]);
    if (AChar >= $FF01) and (AChar <= $FF5A) then
    begin
      Str := Str + Chr(AChar - Dis);
    end
    else
    begin
      Str := Str + fromText[i];
    end;
  end;
  Result := Str;
end;

end.
