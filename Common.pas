unit Common;

interface

uses Windows, Forms, SysUtils, Graphics, Classes, StrUtils, PngImage,
     CommCtrl, GR32, GR32_Image, GR32_Resamplers, ShellAPI, WSDLIntf,
     Controls, mmsystem, System.UITypes, System.Generics.Collections;

const

  APPNAME = 'Retrofire';
  RESNAME = 'retrofire.data';
  ININAME = 'retrofire.ini';
  BUILDNO = '265';
  LATESTRESVER = 264;

  MAXFAVORITES2 = 128;

  TEXT_MAKER_ALL    = '(製造元)';
  TEXT_YEAR_ALL     = '(年代)';
  TEXT_SOUND_ALL    = '(音源)';
  TEXT_CPU_ALL      = '(CPU)';
  TEXT_VERSION_ALL  = '(バージョン)';

  CRLF   = #13#10;
  CRLF2  = #13#10#13#10;
  MAKER  = 7; // メーカーリストの最低数

  // ステータスアイコンの表示間隔
  SB_LRMARGIN     = 18;
  SB_ITEMDISTANCE = 17;
  SB_MARKDISTANCE = 1;
  SB_NUMOFITEMS   = 6;

  // スクリーンショットの再サンプラー
  RF_NEAREST = 0;
  RF_LINEAR  = 2;
  RF_LANCZOS = 5;
  RF_CUBIC   = 1;

  // 最大ゲーム数
  MAXGAMES = 50000;

  // 1レコード当たりのセット数
  MAXSETS = 100;

  // ソフトリスト用
  SL_DIR          = 'softlists/'; // ソフトリストのディレクトリ
  SL_MASTER       = '_master.csv'; // システムとサポートするソフトリストの一覧
  SL_INI          = '_stats.ini';
  SL_DATA         = '_softlist.data'; // ソフトリスト全データ


// ゲームステータス
type TGameStatus = (gsGood, gsImperfect, gsPreliminary, gsUnknown);

// 検索モード
type TSearchMode = (srcAll, srcDesc, srcZip, srcSource, srcMaker);

// ジョイスティックの状態
type TJoyStickStatus = (jsNone, jsUp, jsDown);

// CreateProcessに渡すコマンド
type
	Commd = record
		App,
		Param: string;
end;

// version.ini 用
type
  TVersionINI = record
    Zip  : string;
    Index : integer;
end;

// hitory.dat用
type
  THistoryDat = record
    Zips : TStringList;
    Desc : string;
end;

// mameinfo.dat用
type
  TMameInfoDat = record
    Zips : TStringList;
    Desc : string;
end;

// ROMステータス用temp
type
  TROMTemp = record
    Zip  : string;
    ROM  : boolean;
end;

// Sampleステータス用temp
type
  TSampleTemp = record
    Zip  : string;
    Sample: boolean;
end;

// ジョイスティック用情報
type
  TMMJoyStick  = packed record
    Msg:     Cardinal;  // The message ID
    Buttons: Longint;   // The wParam
    XPos:    word;      // The lParam
    YPos:    word;
    Result:  Longint;
end;

// レコード保存用
type
  PRecordset = ^TRecordset;
  TRecordset = record

    ZipName   : string;     // Zip名
    DescE     : string;     // 英語名
    DescJ     : string;     // 日本語名
    Kana      : string;     // 読み仮名
    Maker     : string;     // メーカー
    Year      : string;     // 製造年

    Master    : boolean;    // マスタフラグ
    CloneOf   : string;     // マスタ名
    SampleOf  : string;     // サンプル名
    RomOf     : string;     // RomOf

    ID        : Word;       // 自分のindex (サブリストセットからの参照用)
    MasterID  : Word;       // マスタのindex

    Vector    : boolean;    // ベクター
    LightGun  : boolean;    // 光線銃
    Analog    : boolean;    // アナログ操作
    Status    : boolean;    // ステータス Good=True
    Vertical  : boolean;    // 縦画面
    Channels  : byte;       // サウンドチャンネル数

    Flag      : boolean;    // 更新チェック用

    CPUs      : string;     // CPUs
    Sounds    : string;     // Sound chips
    Screens   : string;     // Screens
    NumScreens: integer;    // Numofscreens
    Palettesize :integer;   // 色数
    ResX      : Word;       // 解像度
    ResY      : Word;       // 解像度

    Color       : TGameStatus;// 色ステータス
    Sound       : TGameStatus;// 音ステータス
    GFX         : TGameStatus;// 絵ステータス
    Protect     : TGameStatus;// プロテクトステータス
    Cocktail    : TGameStatus;// カクテルステータス
    SaveState   : TGameStatus;// セーブステート
    Source      : string;     // ソースファイル名
    CHD         : string;     // ディスクイメージ名
    CHDMerge    : boolean;    // CHDマージ
    CHDOnly     : boolean;    // CHDのみ
    ROM         : boolean;    // ROM有り
    Sample      : boolean;    // Sample有り
    LD          : boolean;    // レーザーディスク
    CHDNoDump   : boolean;    // chdが未ダンプ
    isMechanical: boolean;    // メカニカルゲーム

end;

type // mame本体用
  PMameExe = ^TMameExe;
  TMameExe = record
    Title   : string;
    ExePath : string;
    WorkDir : string;
    Option  : string;
    OptEnbld: boolean;
  end;

// ソフトウェアとソフトリスト用
type
  PSoftware = ^TSoftware;
  TSoftware = record
    name  :string;
    cloneof: string;
    desc  :string;
    alt   :string;
    year  :string;
    publisher: string;
    supported: string;
  end;

type
  PSoftlist = ^TSoftlist;
  TSoftlist = record
    softwares: array of TSoftware;
    desc: string;
    lastSelect: string;
  end;

type
  PSoftlist2 = ^TSoftlist2;
  TSoftlist2 = record
    softwares: TList;
    name: string;
    desc: string;
    lastSelect: string;
  end;


var
  // ini設定
  ListFont      : TFont;   // リストのフォント
  HistoryFont   : TFont;   // ヒストリーのフォント
  ListColor     : TColor;  // リスト背景色
  KeepAspect    : boolean; // ショットのアスペクト比保持
  SelZip        : String;  // 選択中のzip名
  SelDriver     : String;  // 選択中のドライバ名
  SearchWord    : string;  // 検索文字列
  En            : boolean; // 英語名表示
  SearchMode    : TSearchMode; // 検索モード
  UseJoyStick   : boolean; // ジョイスティック使う
  UsePOV        : boolean; // POV使う
  JoyRepeat     : Word;    // ジョイスティックのリピート速度 ms

  // 状態保持
  Booting       : boolean; // 起動処理中
  ExeDir        : string;  // ExeのPath (Dir)

  samplePath    : string;  // sampleのパス
  cfgDir        : string;  // cfgのパス
  nvramDir      : string;  // nvramのパス
  staDir        : string;  // staのパス

  snapDir       : string;  // snapのパス
  inpDir        : string;  // inpのパス
  datDir        : string;  // datのパス
  langDir       : string;  // langのパス
  versionDir    : string;  // version.iniのパス

  lastPath      : string;  // 保存したときの最終パス
  lastExePath   : string;  // exeの最終パス

  CurAspectX,
  CurAspectY    : integer; // 表示中のショットのアスペクト比
  OrgResX,
  OrgResY       : Word;    // 元々の解像度
  CurrentShot   : string;  // 表示中のショットのパス
  DoNotUpdate   : boolean; // 汎用
  DoNotUpdateLV : boolean; // リストビュー更新抑制
  DoNotUpdateSL : boolean; // サブリスト（右情報パネルの）更新抑制
  CurrentLB     : string;  // リストボックスの二重クリック防ぐ
  CurrentMaker  : string;  // メーカーの二重クリック防ぐ
  CurrentYear   : string;  //
  CurrentSound  : string;  //
  CurrentCpu    : string;  //
  CurrentVersion: integer; //
  CurrentAssort : integer; //
  CurrentFilter : integer; //
  CurrentIndex  : integer; //
  EditingIndex  : integer; // 編集対象項目のインデックス
  Edited        : boolean; // 編集済みか
  EditUpdating  : boolean; // EditBoxを外部から更新中
  CurrentProfile: Integer; // 現在のプロファイルIndex
  KeyboardDelay : Word;    // キーボードディレイ
  InfoPanel     : boolean; // 情報パネル表示
  PrevDat       : string;  // 直前のdat
  HideMechanical: boolean; // メカニカルを隠す
  HideGambling  : boolean; // ギャンブルを隠す

  UseAltExe     : boolean; // ShellExec

  // HTTPダウンロードデータ用
  ETag_mame32j  : string;  // mame32j.lst ファイル用の Etag
  ETag_version  : string;  // version.ini ファイル用の Etag
  ETag_mameinfo : string;  // mameinfo ファイル用の Etag
  ETag_history  : string;  // mameinfo ファイル用の Etag


  // コマンドビューア用
  ComViewerVisible    : boolean; // ウインドウの表示非表示
  ComViewerLeft       : integer; // ウインドウの左位置
  ComViewerTop        : integer; // ウインドウの上位置
  ComViewerWidth      : integer; // ウインドウの幅
  ComViewerHeight     : integer; // ウインドウの高さ
  ComViewerP2         : boolean; // P2用の反転表示するか
  ComViewerAutoResize : boolean; // ウィンドウを自動的にリサイズするか
  ComViewerZentoHan   : boolean; // 全角英数を半角に変換するか
  ComViewerIndex      : integer; // 選択中のインデックス　未選択は-1
  ComViewerAlwaysOnTop: boolean; // 常に手前に表示


  // ソフトウェアリスト用
  SoftwareListVisible     : boolean; // ウインドウの表示
  SoftwareListLeft        : integer;
  SoftwareListTop         : integer;
  SoftwareListWidth       : integer;
  SoftwareListHeight      : integer;
  SoftwareListAlwaysOnTop : boolean;
  SoftwareListColumnSort  : integer;
  SoftwareListSearch      : string;
  SoftwareListHistory     : TStringList;

  // データ用
  TLMaster      : TList;   // データ保持用TList
  TLSub         : TList;   // データソート検索用TList
  TLFamily      : TList;   // ファミリ保持用TList
  TLVersion     : TList;   // バージョン別サブセット
  liNonMech     : TList;   // 非メカニカルマスタセット
  liNonGambling : TList;   // 非ギャンブルマスタセット
  liNonMechGamb : TList;   // 非メカ兼ギャンブルセット

  TLManu        : array of TList; // 製造元検索結果キャッシュ

  SnapBitMap    : TPngImage;  // スナップショット用のバッファ
  StatusBarBuf  : TBitMap;    // ステータスバー用のバッファ
  SortHistory   : array [0..5] of Shortint; // ソートのヒストリー

  HistoryDat    : array of THistoryDat;
  MameInfoDat   : array of TMameInfoDat;
  MameExe       : array of TMameExe;
  ROMTemp       : array of TRomTemp;
  SampleTemp    : array of TSampleTemp;
  ROMDirs       : array of string; // ROMディレクトリ
  SoftDirs      : array of string; // softwareディレクトリ

  DatVersion    : string; // datのバージョン


  // バージョン用インデックス
  VersionName   : array of string; // バージョン名
  Versions      : array of array of String; // バージョン情報


  // 年代用インデックス
  YearIndex     : array of array of Integer;


  ZipIndex      : array of integer; // ZIP名のインデックス開始
  chars         : Array [ 0..35 ] of string;

  // お気に入り
  Favorites     : TStringList;
  Favorites2    : TStringList;

  // debug用
  Tick          : Cardinal;

  //
  LVUpdating : boolean; // リストビューの更新中
  LVTerminate: boolean; // リストビュー更新の停止

procedure ReadHistoryDat;
procedure ReadMameInfoDat;
function  ReadMame32jlst: boolean;
function  SaveMame32j: boolean;
function  WSaveMame32j: boolean;
procedure SaveMamelst;
procedure SetVersionINI;
procedure CreateZipIndex;
function  FindIndex(const ZipName: String): Integer;


function  GetHistory(const ZipName: String): string;
function  FindMameInfo(const ZipName: String): string;
procedure FindDat(const idx: integer);
function  ShowSnapshot(const ID: Integer): boolean;
procedure SetSnap;

function CsvSeparate(const Str: string; StrList: TStrings): Integer;
function TsvSeparate(const Str: string; StrList: TStrings): Integer;

function LongToShortFileName(const LongName: string):string;
function MoveThe(const Str: string):string;
function NormalizeString(const Str: string):string;

function LoadPNGFile(const filename: string; bitmap: TPngImage): boolean;
//function LoadPNGFileFromSnapZip(const Zip: string; bitmap: TPngImage): boolean;

//function SavePNGFile(const filename: string; bitmap32: TBitmap32): boolean;

function SetCommand: Commd;
function ExtractXML(const element: string; const xml:string):string;

procedure InitParams;
procedure LoadIni;
procedure SaveIni;
procedure Trasher(FileName: string);
function  GetInpGame(FileName: string): string;
procedure DeleteDirectory(path: String);
function  RelToAbs(const RelPath, BasePath: string): string;

implementation

uses Unit1, unitCommandViewer, unitSoftwareList;

//------------------------------------------------------------------------------
// zip名の検索インデックスを作成する
procedure CreateZipIndex;
var i,j: integer;
    flag: boolean;

begin

  chars[0]:='0'; chars[1]:='1'; chars[2]:='2'; chars[3]:='3'; chars[4]:='4';
  chars[5]:='5'; chars[6]:='6'; chars[7]:='7'; chars[8]:='8'; chars[9]:='9';
  chars[10]:='a'; chars[11]:='b'; chars[12]:='c'; chars[13]:='d'; chars[14]:='e';
  chars[15]:='f'; chars[16]:='g'; chars[17]:='h'; chars[18]:='i'; chars[19]:='j';
  chars[20]:='k'; chars[21]:='l'; chars[22]:='m'; chars[23]:='n'; chars[24]:='o';
  chars[25]:='p'; chars[26]:='q'; chars[27]:='r'; chars[28]:='s'; chars[29]:='t';
  chars[30]:='u'; chars[31]:='v'; chars[32]:='w'; chars[33]:='x'; chars[34]:='y';
  chars[35]:='z';

  SetLength(ZipIndex,0); // リセット
  SetLength(ZipIndex,37);

  for j:=0 to 35 do
  begin
    flag:=False;
    for i:=0 to TLMaster.Count-1 do
    begin
      if (copy(PRecordset(TLMaster[i]).ZipName, 0, 1) = chars[j]) and
         (flag=False) then
      begin
        flag:=true;
        ZipIndex[j]:=i;
      end;
    end;
  end;

  ZipIndex[36]:=TLMaster.Count;

end;

// ZIP名でインデックス検索
function FindIndex(const ZipName: String): Integer;
var i, idx: integer;
    st: string;
    asc: integer;
begin

  Result:=-1;
  St:=LowerCase(Copy(Trim(ZipName),0,1));
  asc:= Ord(St[1]);

  Case asc of
    48..57: // 数字
    begin
      idx:=asc-48;
    end;
    97..122: // 英字
    begin
      idx:=asc-87;
    end;
    else
      exit;
  end;

  for i:=ZipIndex[idx] to ZipIndex[idx+1]-1 do
  begin

    if PRecordset(TLMaster[i]).ZipName=ZipName then
    begin

      Result:=i;
      Exit;

    end;

  end;

end;

//------------------------------------------------------------------------------
// Mame32j.lst読み込み

function ReadMame32jlst :boolean;
type
  PMame32j = ^TMame32j;
  TMame32j = record
    Zip   : string;
    DescJ : string;
    Kana  : string;
  end;

  // Zip名で昇順ソート
  function ZipSort(Item1, Item2: Pointer): Integer;
  begin
    Result := CompareText(PMame32j(Item1).Zip, PMame32j(Item2).Zip);
  end;
var

  i,j,s: integer;
  targetfile: String;
  StrList: TStringList;

  Mame32j: TList;
  NewItem: PMame32j;

  //
  m32List: TStringList;

begin

  Result:=False;

  // 初期値は英語名
  for i:=0 to TLMaster.Count-1 do
  begin
    PRecordSet(TLMaster[i]).DescJ:= PRecordSet(TLMaster[i]).DescE;
    PRecordSet(TLMaster[i]).Kana := PRecordSet(TLMaster[i]).DescE;
    PRecordSet(TLMaster[i]).Flag := False;
  end;

  if FileExists(ExeDir+'mame32j.lst') then
    targetfile:=ExeDir+'mame32j.lst'
  else
  if FileExists(ExeDir+'mame32jp.lst') then
    targetfile:=ExeDir+'mame32jp.lst'
  else
    exit;


  try
    // ファイル読み込み
    StrList:=TStringList.Create;
    Mame32j:=TList.Create;

    m32List:=TStringList.Create;
    m32List.LoadFromFile( targetfile );

    for i:= 0 to m32List.count-1 do
    begin

      if TsvSeparate(m32List[i],StrList)>=2 then
      begin
        New(NewItem);
        NewItem.Zip:=  StrList[0];
        NewItem.DescJ:=StrList[1];
        NewItem.Kana:= StrList[2];
        Mame32j.Add(NewItem);
      end;

    end;

    // Zip名で並び替え（マスタに合わせる）
    Mame32j.Sort(@ZipSort);

    s:=0;
    for i:=0 to TLMaster.Count-1 do
    begin
      for j:=s to Mame32j.Count-1 do
      begin
        if PRecordset(TLMaster[i]).ZipName=PMame32j(Mame32j[j]).Zip then
        begin
          PRecordset(TLMaster[i]).DescJ:=PMame32j(Mame32j[j]).DescJ;
          PRecordset(TLMaster[i]).Kana :=PMame32j(Mame32j[j]).Kana;
          s:=j+1;
          break;
        end;
      end;
    end;

    // メモリ解放
    for i:=0 to Mame32j.Count-1 do
      dispose(PMame32j(Mame32j[i]));

  finally
    FreeAndNil(Mame32j);
    FreeAndNil(StrList);
    FreeAndNil(m32List);
  end;

  Result:=True;

end;

//------------------------------------------------------------------------------
// MAME.lst保存
procedure SaveMamelst;
var
  F1 : TextFile;
  i  : integer;
begin
    //

  Form1.SaveDialog1.FileName:='mame.lst';
  Form1.SaveDialog1.Filter:='英語ゲーム名ファイル(mame.lst)|mame.lst';
  Form1.SaveDialog1.Title:='mame.lst出力';

  //
  if Form1.SaveDialog1.Execute then
  begin

    try
      AssignFile(F1, Form1.SaveDialog1.FileName);
      ReWrite(F1);

      for i:=0 to TLMaster.Count-1 do
      begin
        WriteLn(F1,PRecordset(TLMaster[i]).ZipName+#9+
                   PRecordset(TLMaster[i]).DescE+#9+
                   PRecordset(TLMaster[i]).Source+#9+
                   PRecordset(TLMaster[i]).CloneOf);
      end;

    finally
      CloseFile(F1);
    end;
    
  end;

end;


//------------------------------------------------------------------------------
// MAME32j.lst保存　(Shift-JIS)
function SaveMame32j: boolean;
var
  F1 : TextFile;
  i  : integer;
  Save_Cursor: TCursor;

begin

  Result:=False;
  if DirectoryExists(lastPath) then
    Form1.SaveDialog1.InitialDir:=lastPath;
    
  Form1.SaveDialog1.FileName:='mame32j.lst';
  Form1.SaveDialog1.Filter:='日本語ゲーム名ファイル(mame32j.lst, mame32jp.lst)|mame32j.lst;mame32jp.lst';
  Form1.SaveDialog1.Title:='mame32j.lst出力 (Shift_JIS)';

  //
  if Form1.SaveDialog1.Execute then
  begin

    Save_Cursor := Screen.Cursor;
    Screen.Cursor := crHourGlass;    // Show hourglass cursor

    try
      AssignFile(F1, Form1.SaveDialog1.FileName);
      ReWrite(F1);

      for i:=0 to TLMaster.Count-1 do
      begin

        if (PRecordset(TLMaster[i]).DescE<>PRecordset(TLMaster[i]).Kana) then //PRecordset(TL[i]).Translated then
        begin
          WriteLn(F1,PRecordset(TLMaster[i]).ZipName+#9+
                     PRecordset(TLMaster[i]).DescJ+#9+
                     PRecordset(TLMaster[i]).Kana);
        end;
      end;
      Result:=True;

      Form1.StatusBar1.Panels[1].Text:='';
      Edited:=False;
      lastPath:=ExtractFilePath(Form1.SaveDialog1.FileName);

    finally
      CloseFile(F1);
      Screen.Cursor := Save_Cursor;
    end;
    
  end;

end;


//------------------------------------------------------------------------------
// MAME32j.lst保存　(UTF-8)

function WSaveMame32j: boolean;
var
  F1 : TextFile;
  i  : integer;
  Save_Cursor: TCursor;

  //
  m32List: TStringList;

begin

  Result:=False;
  if DirectoryExists(lastPath) then
    Form1.SaveDialog1.InitialDir:=lastPath;

  Form1.SaveDialog1.FileName:='mame32j.lst';
  Form1.SaveDialog1.Filter:='日本語ゲーム名ファイル(mame32j.lst, mame32jp.lst)|mame32j.lst;mame32jp.lst';
  Form1.SaveDialog1.Title:='mame32j.lst出力 (UTF-8)';

  //
  if Form1.SaveDialog1.Execute then
  begin

    Save_Cursor := Screen.Cursor;
    Screen.Cursor := crHourGlass;    // Show hourglass cursor

    m32List := TStringList.Create;

    try
      for i:=0 to TLMaster.Count-1 do
      begin
        if (PRecordset(TLMaster[i]).DescE<>PRecordset(TLMaster[i]).Kana) then
        begin

          m32List.Add( PRecordset(TLMaster[i]).ZipName + #9 +
                       PRecordset(TLMaster[i]).DescJ + #9 +
                       PRecordset(TLMaster[i]).Kana );
        end;
      end;

      m32List.SaveToFile( Form1.SaveDialog1.FileName, TEncoding.UTF8 );
      Result:=True;

    finally
      m32List.Free;
      Screen.Cursor := Save_Cursor;

      Form1.StatusBar1.Panels[1].Text:='';
      Edited:=False;
      lastPath:=ExtractFilePath(Form1.SaveDialog1.FileName);
    end;

  end;

end;

//------------------------------------------------------------------------------
// history.dat読み込み

procedure ReadHistoryDat;
var
  St,S: String;
  zipname: String;
  i,j,n,m: integer;
  HistoryDir : String;

  // 新処理
  hisList: TStringList;
  hisFlag: boolean;

  entryStarted: boolean;
  StrList: TStringList;

begin

  SetLength(HistoryDat,0);

  if (datDir='') and (FileExists('history.dat')) then
    HistoryDir:='.'
  else
  if FileExists(datDir+'\history.dat') then
    HistoryDir:=datDir
  else
  if FileExists(langDir+'\ja_jp\history.dat') then
    HistoryDir:=langDir+'\ja_jp'
  else
    exit;


  // UTF8固定
  hisList:=TStringList.Create;

  hisList.LoadFromFile( HistoryDir+'\history.dat', TEncoding.UTF8 );

  SetLength(HistoryDat,25000);
  n:=0;


  entryStarted := false;

  for i := 0 to hisList.Count-1 do
  begin

    ST:=hisList[i];

    // エントリ前なら
    if entryStarted=false then
    begin

      // エントリ発見
      if Copy(ST, 1, 4)='$inf' then
      begin
        // zip名
        Delete(ST,1,Pos('=',ST));
        ZipName:=ST;

        // zip名改良版（StringList化）
        StrList:=TStringList.Create;
        m:=CSVSeparate(ZipName,StrList);

        entryStarted := true;
      end;
    end
    else
    begin // エントリ開始後なら

      if (Copy(ST, 1, 4)='$bio') then
      begin
        S:='';
        St:='';
      end
      else
      if (Copy(St,1,4)<>'$end') then // bio本文継続中
      begin
        S:=S+St+#17;
      end
      else
      if (Copy(St,1,4) = '$end') then // bio本文終了
      begin

      S:=StringReplace(S,#$11,#13#10, [ rfReplaceAll ]);  // 海外版history.datの改行
      S:=S+#13#10;

      HistoryDat[n].Desc:=S;
      HistoryDat[n].Zips:=StrList;
      for j := 0 to HistoryDat[n].Zips.Count-1 do
      begin
        HistoryDat[n].Zips[j]:= HistoryDat[n].Zips[j].Trim;
      end;

      entryStarted:=false; // エントリ終了
      inc(n);
      end;
    end;

  end;

  SetLength(HistoryDat,n);

  hisList.Free;


end;

//------------------------------------------------------------------------------
// mameinfo.dat読み込み

procedure ReadMameInfoDat;
var
  St, S: String;
  i,j,n,m : integer;
  MAMEInfoDir : String;

  // 新型処理
  mameList: TStringList;
  mameFlag: boolean;

  StrList: TStringList;

begin

  SetLength(MameInfoDat,0);

  if (datDir='') and (FileExists('mameinfo.dat')) then
    MAMEInfoDir:='.'     // datdirが未指定の場合は本体の場所
  else
  if FileExists(datDir+'\mameinfo.dat') then
    MAMEInfoDir:=datDir  // datdirから
  else
  if FileExists(langDir+'\ja_jp\mameinfo.dat') then
    MAMEInfoDir:=langDir+'\ja_jp' // langdir\ja_jpから
  else
    exit;


  // 新型処理
  // UTF8固定
  mameList:=TStringList.Create;

  mameList.LoadFromFile( MAMEInfoDir+'\mameinfo.dat', TEncoding.UTF8 );

  SetLength(MameInfoDat,15000);
  n:=0;
  mameFlag:= false;

  for i := 0 to mameList.Count-1 do
  begin

    ST:=mameList[i];

    // 本文前なら
    if mameFlag=false then
    begin

      // エントリ発見
      if Copy(ST, 1, 4)='$inf' then
      begin
        // zip名
        Delete(ST,1,Pos('=',ST));

        // zip名改良版（StringList化）
        StrList:=TStringList.Create;
        m:=CSVSeparate( ST, StrList );

      end
      else
      if (Copy(ST, 1, 4)='$mam') then
      begin
        mameFlag:=true; // エントリ開始
        S:='';
        St:='';
      end;

    end
    else
    if (Copy(St,1,4)<>'$end') then // エントリ本文継続中
    begin
      S:=S+St+#17;
    end
    else
    begin
      S:=StringReplace(S,#17#17#17#17, #13#10#13#10#13#10, [ rfReplaceAll ]);
      S:=StringReplace(S,#17#17#17,#13#10#13#10, [ rfReplaceAll ]);
      S:=StringReplace(S,#17#17,#13#10, [ rfReplaceAll ]);
      S:=StringReplace(S,#17,'', [ rfReplaceAll ]);
      MameInfoDat[n].Zips:=StrList;
      for j := 0 to MameInfoDat[n].Zips.Count-1 do
      begin
        MameInfoDat[n].Zips[j]:= MameInfoDat[n].Zips[j].Trim;
      end;

      MameInfoDat[n].Desc:=S;
      mameFlag:=false; // エントリ終了
      inc(n);
    end;
  end;

  SetLength(MameInfoDat,n);
  mameList.Free;


end;


// -----------------------------------------------------------------------------
// History検索
function GetHistory(const ZipName: String): String;
var i:Integer;

begin

  result:='';

  for i:=0 to Length(HistoryDat)-1 do
  begin

    if HistoryDat[i].Zips.IndexOf(ZipName)<>-1 then
    begin
      result:=HistoryDat[i].Desc;
      break;
    end;

  end;

end;


// Mameinfo検索
function FindMameInfo(const ZipName: String): String;
var i:Integer;
begin

  result:='';

  for i:=0 to Length(MameInfoDat)-1 do
  begin

    if MameInfoDat[i].Zips.IndexOf(ZipName)<>-1 then
    begin
      result:=MameInfoDat[i].Desc;
      break;
    end;
  end;

end;

// history+mameinfo検索
procedure FindDat(const idx: integer);
var St,S: String;
begin

  if idx = -1 then Exit;
  
  St:='';
  S:='';

  if PRecordSet(TLMaster[idx]).Master then
  begin
    // マスタセットのときは
    St:=GetHistory(PRecordSet(TLMaster[idx]).ZipName);
    St:=trim(St)+#13#10#13#10#13#10+FindMameInfo(PRecordSet(TLMaster[idx]).ZipName);
  end
  else
  begin

    // クローンセットのときは
    St:=GetHistory(PRecordSet(TLMaster[idx]).ZipName);
    if St='' then
      St:=GetHistory(PRecordSet(TLMaster[idx]).CloneOf);

    S:=FindMameInfo(PRecordSet(TLMaster[idx]).ZipName);
    if S='' then
    begin
      S:=FindMameInfo(PRecordSet(TLMaster[idx]).CloneOf);
    end;
    St:=trim(St)+#13#10#13#10#13#10+S;

  end;

 if Form1.Memo1.Text<>St then
    Form1.Memo1.Text:=St;
  
end;


// Snapshot検索
function ShowSnapshot(const ID: Integer): boolean;
var mi,ci:integer;
    PreviousShot:string;
    NumScreens:integer;
    Vertical:boolean;
begin

  result:=True;
  SetCurrentDir(ExeDir);
  NumScreens:=1;
  Vertical:=False;

  PreviousShot:=CurrentShot;

  // マスタ
  if PRecordSet(TLMaster[ID]).Master then
  begin
    mi:=ID;
    ci:=-1;
  end
  else
  begin
    ci:=ID;
    mi:=PRecordSet(TLMaster[ID]).MasterID;
  end;

  //
  CurrentShot:='';

  if (ci<>-1) then  // 子のショットを探す
  begin
    if (PreviousShot = SnapDir+'\'+PRecordSet(TLMaster[ci]).ZipName+'.png') or
       (PreviousShot = SnapDir+'\'+PRecordSet(TLMaster[ci]).ZipName+'\0000.png') or
       (PreviousShot = '*'+PRecordSet(TLMaster[ci]).ZipName) then
    begin
      CurrentShot:=PreviousShot;
    end
    else
    if (PreviousShot <> SnapDir+'\'+PRecordSet(TLMaster[ci]).ZipName+'.png') then
    begin
    
      if LoadPNGFile(SnapDir+'\'+PRecordSet(TLMaster[ci]).ZipName+'.png',SnapBitMap) then
      begin
        CurrentShot:=SnapDir+'\'+PRecordSet(TLMaster[ci]).ZipName+'.png';
        OrgResX   :=PRecordset(TLMaster[ci]).ResX;
        OrgResY   :=PRecordset(TLMaster[ci]).ResY;
        NumScreens:=PRecordset(TLMaster[ci]).NumScreens;
        Vertical  :=PRecordset(TLMaster[ci]).Vertical;
      end
      else
      if LoadPNGFile(SnapDir+'\'+PRecordSet(TLMaster[ci]).ZipName+'\0000.png',SnapBitMap) then
      begin
        CurrentShot:=SnapDir+'\'+PRecordSet(TLMaster[ci]).ZipName+'\0000.png';
        OrgResX   :=PRecordset(TLMaster[ci]).ResX;
        OrgResY   :=PRecordset(TLMaster[ci]).ResY;
        NumScreens:=PRecordset(TLMaster[ci]).NumScreens;
        Vertical  :=PRecordset(TLMaster[ci]).Vertical;
      end;

    end;
  end;

  
  if CurrentShot='' then
  begin // 親のショット探す
    if (PreviousShot = SnapDir+'\'+PRecordSet(TLMaster[mi]).ZipName+'.png') or
       (PreviousShot = SnapDir+'\'+PRecordSet(TLMaster[mi]).ZipName+'\0000.png') or
       (PreviousShot = '*'+PRecordSet(TLMaster[mi]).ZipName) then
    begin
      CurrentShot:=PreviousShot;
    end
    else
    if (PreviousShot <> SnapDir+'\'+PRecordSet(TLMaster[mi]).ZipName+'.png') then
    begin
      if LoadPNGFile(SnapDir+'\'+PRecordSet(TLMaster[mi]).ZipName+'.png',SnapBitMap) then
      begin
        CurrentShot:=SnapDir+'\'+PRecordSet(TLMaster[mi]).ZipName+'.png';
        OrgResX   :=PRecordset(TLMaster[mi]).ResX;
        OrgResY   :=PRecordset(TLMaster[mi]).ResY;
        NumScreens:=PRecordset(TLMaster[mi]).NumScreens;
        Vertical  :=PRecordset(TLMaster[mi]).Vertical;
      end
      else
      if LoadPNGFile(SnapDir+'\'+PRecordSet(TLMaster[mi]).ZipName+'\0000.png',SnapBitMap) then
      begin
        CurrentShot:=SnapDir+'\'+PRecordSet(TLMaster[mi]).ZipName+'\0000.png';
        OrgResX   :=PRecordset(TLMaster[mi]).ResX;
        OrgResY   :=PRecordset(TLMaster[mi]).ResY;
        NumScreens:=PRecordset(TLMaster[mi]).NumScreens;
        Vertical  :=PRecordset(TLMaster[mi]).Vertical;
      end;
    end
  end;

  if PreviousShot<>CurrentShot then
  begin

    if Vertical then
    begin
      CurAspectX:=3;
      CurAspectY:=4;
    end
    else
    begin
      CurAspectX:=4;
      CurAspectY:=3;
    end;


    // 横3画面と2画面 (ギャップ対応)
    if (NumScreens=3) and (SnapBitMap.Height=OrgResY) and
       ((SnapBitMap.Width=OrgResX*3) or (SnapBitMap.Width=OrgResX*3 + 4))
        then
    begin
      CurAspectX:=12;
      CurAspectY:=3;
    end
    else
    if (NumScreens=2) and (SnapBitMap.Height=OrgResY) and
       ((SnapBitMap.Width=OrgResX*2) or (SnapBitMap.Width=OrgResX*2 + 2) or
        (SnapBitMap.Width=OrgResX*2 + 3)) then
    begin
      CurAspectX:=8;
      CurAspectY:=3;
    end
    else // 縦2画面
    if (NumScreens=2) and (SnapBitMap.Width=OrgResX) and
       ((SnapBitMap.Height=OrgResY*2) or (SnapBitMap.Height=OrgResY*2 +2)) then
    begin
      CurAspectX:=2;
      CurAspectY:=3;
    end
    else // 液晶パネル
    if (NumScreens=3) and
       (SnapBitMap.Width=512) and
       ( (SnapBitMap.Height=704) or  (SnapBitMap.Height=368)) then
    begin
      CurAspectX:=28;
      CurAspectY:=33;
    end
    else // 2画面横汎用
    if ( SnapBitMap.Width >= 620 ) and ( SnapBitMap.Width <= 1156 ) and
       ( SnapBitMap.Height >= 220 ) and ( SnapBitMap.Height <= 256 ) and
       (NumScreens=2) then
    begin
      CurAspectX:=8;
      CurAspectY:=3;
     end
    else // vsnetscoocer
    if (SnapBitMap.Width=1156) and (SnapBitMap.Height=224) and
       (NumScreens=2) then
    begin
      CurAspectX:=8;
      CurAspectY:=3;
    end
    else //    racedrivpan
    if (SnapBitMap.Width=1544) and (SnapBitMap.Height=384) and
       (NumScreens=3) then
    begin
      CurAspectX:=12;
      CurAspectY:=3;
    end
    else // pinball
    if (SnapBitMap.Width=512) and (SnapBitMap.Height=128) then
    begin
      CurAspectX:=4;
      CurAspectY:=1;
    end
    else // game watch
    if (SnapBitMap.Width=950) and (SnapBitMap.Height=1243) then
    begin
      CurAspectX:=950;
      CurAspectY:=1243;
    end
    else // game watch
    if (SnapBitMap.Width=906) and (SnapBitMap.Height=1197) then
    begin
      CurAspectX:=906;
      CurAspectY:=1197;
    end
            {
    else //
    if (SnapBitMap.Width=642) and (SnapBitMap.Height=224) and
       (NumScreens=2) then
    begin
      CurAspectX:=8;
      CurAspectY:=3;
    end     }
    else //
    if (SnapBitMap.Width=320) and (SnapBitMap.Height=416) and
       (NumScreens=2) then
    begin
      CurAspectX:=4;
      CurAspectY:=6;
    end;

    SetSnap;

  end;

end;

procedure SetSnap;
var
  Src: TBitmap32;
  DestRect: TRect;
  R: TKernelResampler;
  
begin


  if CurrentShot<>'' then
  begin

    //  アスペクト比保持のとき
    if KeepAspect then
    begin

      with Form1.Image32 do
      begin

        BeginUpdate;
        try
        
          Src:=TBitmap32.Create;
          Src.Assign(SnapBitMap);

          // 拡大縮小
          if (Height * CurAspectX / CurAspectY) <= Width then
          begin
            DestRect.Right := Trunc (Height * (CurAspectX / CurAspectY));
            DestRect.Bottom:= Height;
          end
          else
          begin
            DestRect.Right := Width;
            DestRect.Bottom:= Trunc (Width * (CurAspectY / CurAspectX));
          end;

          DestRect.Left:=0;
          DestRect.Top:=0;
          Bitmap.Width:=DestRect.Right;
          Bitmap.Height:=DestRect.Bottom;

          R := TKernelResampler.Create(Src);

          Case CurrentFilter of
            RF_NEAREST: R.Kernel := TBoxKernel.Create;
            RF_LINEAR : R.Kernel := TLinearKernel.Create;
            RF_LANCZOS: R.Kernel := TLanczosKernel.Create;
            RF_CUBIC  : R.Kernel := TCubicKernel.Create;
          end;

          ScaleMode:=smNormal;
          Bitmap.Draw(DestRect, Src.BoundsRect, Src);

        finally
          EndUpdate;
        end;

        Refresh;
        Src.Free;
      end;

    end
    else
    begin

      with Form1.Image32 do
      begin

        BeginUpdate;
        try

          Src:=TBitmap32.Create;
          Src.Assign(SnapBitMap);

          DestRect.Left:=0;
          DestRect.Top:=0;

          // 原寸
          if (Src.Width<=Width) and (Src.Height<=Height) then
          begin
            DestRect.Right := Src.Width;
            DestRect.Bottom := Src.Height;
          end
          else // 横長の場合
          if (Src.Width / Src.Height > Width/Height) then
          begin
            DestRect.Right := Width;
            DestRect.Bottom := Trunc( Width * ( Src.Height / Src.Width));
          end
          else
          begin
            DestRect.Right := Trunc( Height * ( Src.Width / Src.Height));
            DestRect.Bottom := Height;
          end;

          Bitmap.Width:=DestRect.Right;
          Bitmap.Height:=DestRect.Bottom;

          R := TKernelResampler.Create(Src);

          Case CurrentFilter of
            RF_NEAREST: R.Kernel := TBoxKernel.Create;
            RF_LINEAR : R.Kernel := TLinearKernel.Create;
            RF_LANCZOS: R.Kernel := TLanczosKernel.Create;
            RF_CUBIC  : R.Kernel := TCubicKernel.Create;
          end;

          ScaleMode:=smNormal;
          Bitmap.Draw(DestRect, Src.BoundsRect, Src);

        finally
          EndUpdate;
        end;

        Refresh;
        Src.Free;
      end;

    end;

  end
  else
  begin
    //SnapBitMap.
    Form1.Image32.Bitmap.Delete;
  end;

end;

//------------------------------------------------------------------------------
// 設定の初期化
procedure InitParams;
begin

  ListFont    := Form1.ListView1.Font;
  HistoryFont := Form1.Memo1.Font;
  ListColor   := clWindow;
  KeepAspect  := True;  // アスペクト比保持
  UseJoyStick := True;
  UsePOV      := False;

  SortHistory[0]:=1;
  SortHistory[1]:=2;
  SortHistory[2]:=3;
  SortHistory[3]:=4;
  SortHistory[4]:=5;
  SortHistory[5]:=6;

  En          := False;
  Form1.Left  := 20;
  Form1.Top   := 20;
  Edited      := False;
  samplePath  := 'samples';
  cfgDir      := 'cfg';
  nvramDir    := 'nvram';
  staDir      := 'sta';
  inpDir      := 'inp';
  snapDir     := 'snap';
  datDir      := 'dats';
  langDir     := 'lang';
  SetLength(RomDirs,1);
  RomDirs[0]  := 'roms';

  SetLength(SoftDirs,1);
  SoftDirs[0] := 'software';

  versionDir  := 'folders';

  SearchMode  := srcAll;

  CurrentFilter:= RF_CUBIC;
  CurrentProfile:= -1;
  Form1.Panel12.Visible:=False; // 検索パネル
  Form1.Panel3.Visible:=True; // 情報パネル

  SetCurrentDir(ExeDir);
  JoyRepeat := 45; // ジョイスティックのリピート速度 45ms

  // キーボードディレイの取得
  SystemParametersInfo(SPI_GETKEYBOARDDELAY,0,@KeyBoardDelay ,0);
  KeyBoardDelay:=KeyBoardDelay* 250 + 250; // 0～3で250ms刻み

  // 編集パネルは表示しない
  Form1.Splitter1.Visible:=False;
  Form1.Panel7.Visible:=False;

  // 情報パネル表示
  InfoPanel:=True;

  // 検索欄の初期設定
  Form1.actSAllExecute(nil);

  // お気に入りリスト
  favorites:=TStringList.Create;
  Favorites2 := TStringList.Create;

  // メカニカル隠す
  HideMechanical:=False;

  // ギャンブル隠す
  HideGambling:=False;

  // 起動関数の種類
  UseAltExe := False;

  // コマンドビューア用
  ComViewerVisible    :=true; // : boolean; // ウインドウの表示非表示
  ComViewerTop        :=30;   // : integer; // ウインドウの上位置
  ComViewerWidth      :=366;  // : integer; // ウインドウの幅
  ComViewerLeft       :=Screen.Width-ComViewerWidth;//       : integer; // ウインドウの左位置
  ComViewerHeight     :=600;  //: integer; // ウインドウの高さ

  ComViewerP2         := false; //: boolean; // P2用の反転表示するか
  ComViewerAutoResize := false; //: boolean; // ウィンドウを自動的にリサイズするか
  ComViewerZentoHan   := false; //: boolean; // 全角英数を半角に変換するか
  ComViewerIndex      := -1;    //: integer; // 選択中のインデックス　未選択は-1
  ComViewerAlwaysOnTop:= true;  //: boolean; // 常に手前に表示

  // ソフトウェアリスト用
  SoftwareListVisible     := false;
  SoftwareListLeft        := Form1.Left + Form1.Width;
  SoftwareListTop         := Form1.Top;
  SoftwareListWidth       := 600;
  SoftwareListHeight      := 800;
  SoftwareListAlwaysOnTop := true;
  SoftwareListColumnSort  := 1;
  SoftwareListSearch      := '';
  SoftwareListHistory                 := TStringList.Create;
  SoftwareListHistory.Delimiter       :=#9;
  SoftwareListHistory.StrictDelimiter :=true;

  // HTTPダウンロードデータ用
  ETag_mame32j  := '';
  ETag_version  := '';
  Etag_mameinfo := '';
  Etag_history  := '';

end;


//------------------------------------------------------------------------------
// iniの書き込み
procedure SaveIni;
var

  St: string;
  i: integer;

  piOrderArray: Pinteger;
  iOrderArray: array of integer;

  sltIni  :  TStringList;

begin

  // FAV2 保存
  try
    Favorites2.SaveToFile( 'favorites.ini', TEncoding.UTF8 );
  finally
    //sl.Free;
  end;

  sltIni  :=  TStringList.Create;


  sltIni.Add('### profiles and directories ###');
  sltIni.Add('');

  // プロファイル
  for i:=0 to Length(MameExe)-1 do
  begin
    sltIni.Add('profile '+ MameExe[i].Title+#9+MameExe[i].ExePath+#9+
                                      MameExe[i].WorkDir+#9+MameExe[i].Option+#9+
                                      BooltoStr(MameExe[i].OptEnbld));
  end;

	// 選択中のプロファイル
	sltIni.Add('profile_no '+InttoStr(CurrentProfile));

	// 追加ROMディレクトリ
	St:='';
	for i:=0 to Length(ROMDirs)-1 do
	begin
		St:=St+ROMDirs[i]+#9;
	end;
	St:=Trim(St); // 一番尻の#9をけずる
	sltIni.Add('rompath '+St);

	// softwareディレクトリ
	St:='';
	for i:=0 to Length(SoftDirs)-1 do
	begin
		St:=St+SoftDirs[i]+#9;
	end;
	St:=Trim(St); // 一番尻の#9をけずる
	sltIni.Add('swpath '+St);


	// Sampleパス
	sltIni.Add('samplepath '+SamplePath);
	// cfgパス
	sltIni.Add('cfg_directory '+cfgDir);
	// nvramパス
	sltIni.Add('nvram_directory '+nvramDir);
	// inpパス
	sltIni.Add('input_directory '+inpDir);
	// statusパス
	sltIni.Add('status_directory '+staDir);
	// Snapパス
	sltIni.Add('snapshot_directory '+snapDir);
	// Srcパス
//	sltIni.Add('src_directory '+SrcDir);
	// datパス
	sltIni.Add('dat_directory '+datDir);
	// langパス
	sltIni.Add('lang_directory '+langDir);
	// lastパス
	sltIni.Add('last_path '+lastPath);
	// last exeパス
	sltIni.Add('last_exe_path '+lastExePath);
	// version.iniパス
	sltIni.Add('version_ini_directory '+versionDir);

	sltIni.Add('');
	sltIni.Add('### interface ###');
	sltIni.Add('');

	// デフォルトゲーム
	sltIni.Add('default_game '+SelZip);

	// 検索ワード
	if Trim(Form1.edtSearch.Text)<>'' then
		sltIni.Add('search_word '+ Form1.edtSearch.Text);

	// 検索モード
	case SearchMode of
	  srcAll:  ;
	  srcDesc:    sltIni.Add('search_mode 1');
	  srcZip:     sltIni.Add('search_mode 2');
	  srcSource:  sltIni.Add('search_mode 3');
	  srcMaker:   sltIni.Add('search_mode 4');
	end;

	/// 検索状態
	// いろいろ検索 CurrentAssort
	if (CurrentAssort<>0) then
	begin
		sltIni.Add( 'search_etc '+ InttoStr(CurrentAssort));
	end;

	// 年代
	if (Form1.cmbYear.ItemIndex<>0) then
	begin
		sltIni.Add('search_yer '+ Form1.cmbYear.Text);
	end;

	// 製造元
	if (Form1.cmbMaker.ItemIndex<>0) then
	begin
		sltIni.Add('search_mkr '+ Form1.cmbMaker.Text);
	end;

	// CPU
	if (Form1.cmbCPU.ItemIndex<>0) then
	begin
		sltIni.Add('search_cpu '+ Form1.cmbCPU.Text);
	end;

	// Sount
	if (Form1.cmbSound.ItemIndex<>0) then
	begin
		sltIni.Add('search_snd '+ Form1.cmbSound.Text);
	end;

	// Version
	if (Form1.cmbVersion.ItemIndex<>0) then
	begin
		sltIni.Add('search_ver '+ Form1.cmbVersion.Text);
	end;


  // ソートヒストリー
  St:=InttoStr(SortHistory[0]);
  for i:=1 to Length(SortHistory)-1 do
  begin
    St:=St+','+InttoStr(SortHistory[i]);
  end;
  sltIni.Add('sort_history '+St);

  // ウィンドウの状態
  sltIni.Add('window_x '+InttoStr(Form1.Left));
  sltIni.Add('window_y '+InttoStr(Form1.Top));
  sltIni.Add('window_width '+InttoStr(Form1.Width));
  sltIni.Add('window_height '+InttoStr(Form1.Height));
  Case Form1.WindowState of
    wsMinimized: St:='0';
    wsNormal   : St:='1';
    wsMaximized: St:='2';
  end;
  sltIni.Add('window_state '+St);

  // 編集パネルの状態
  sltIni.Add('edit_visible '+BooltoStr(Form1.Panel7.Visible));
  // 編集パネルの高さ
  sltIni.Add('edit_hight '+InttoStr(Form1.Panel7.Height));

  // 親の情報パネル
  St:=BooltoStr(Form1.Panel3.Visible);
  sltIni.Add('info_panel '+St);

  // 下の情報パネルの状態
  sltIni.Add('info_visible '+BooltoStr(InfoPanel));

  // 検索バー
  St:=BooltoStr(Form1.Panel12.Visible);
  sltIni.Add('search_bar '+St);

  // 検索バー幅
  St:=InttoStr(Form1.Panel13.Width);
  sltIni.Add('search_bar_width '+St);

  // メカニカル隠す
  St:=BooltoStr(HideMechanical);
  sltIni.Add('hide_mechanical '+St);

  // ギャンブル隠す
  St:=BooltoStr(HideGambling);
  sltIni.Add('hide_gambling '+St);

  // ジョイスティック
  if UseJoyStick then St:='1' else St:='0';
  sltIni.Add('joystick_in_interface '+St);

  // POV使用
  if UsePOV then St:='1' else St:='0';
  sltIni.Add('use_pov '+St);

  // ジョイスティックのリピート速度
  sltIni.Add('joy_repeat '+InttoStr(JoyRepeat));

  // ショットのアスペクト比保持
  if KeepAspect then St:='1' else St:='0';
  sltIni.Add('keep_aspect '+St);

  // ショットのフィルタ
  sltIni.Add('shot_filter '+InttoStr(CurrentFilter));

  // ショット部分の幅
  sltIni.Add('subpane_width '+InttoStr(Form1.Panel3.Width));

  // ショット部分の高さ
  sltIni.Add('shot_height '+InttoStr(Form1.Panel15.Height));


  // 英語名
  if En then St:='1' else St:='0';
  sltIni.Add('english_desc '+St);

  // リストフォント
  St:='"'+InttoStr(ListFont.Charset)+','+
      InttoStr(ListFont.Color)+','+
      InttoStr(ListFont.Size)+',';

  if fsBold  in ListFont.Style    then St:=St+'1,' else St:=St+'0,';
  if fsItalic  in ListFont.Style    then St:=St+'1,' else St:=St+'0,';
  if fsUnderline in ListFont.Style then St:=St+'1,' else St:=St+'0,';
  if fsStrikeOut in ListFont.Style then St:=St+'1,' else St:=St+'0,';
  St:=St+ListFont.Name+'"';
  sltIni.Add('list_font '+St);


  // リスト背景色
  if ListColor<>clWindow then
  begin
    sltIni.Add( 'list_color '+InttoStr(ListColor));
  end;

  // ヒストリーフォント
  St:='"'+InttoStr(HistoryFont.Charset)+','+
      InttoStr(HistoryFont.Color)+','+
      InttoStr(HistoryFont.Size)+',';

  if fsBold  in HistoryFont.Style     then St:=St+'1,' else St:=St+'0,';
  if fsItalic  in HistoryFont.Style   then St:=St+'1,' else St:=St+'0,';
  if fsUnderline in HistoryFont.Style then St:=St+'1,' else St:=St+'0,';
  if fsStrikeOut in HistoryFont.Style then St:=St+'1,' else St:=St+'0,';
  St:=St+HistoryFont.Name+'"';
  sltIni.Add('history_font '+St);


  /// メインリスト
  // カラム幅
  St:=Inttostr(ListView_GetColumnWidth(Form1.ListView1.Handle,0));

  for i:=1 to Form1.ListView1.Columns.Count-1 do
  begin
    St:=St+','+Inttostr(ListView_GetColumnWidth(Form1.ListView1.Handle,i));
  end;
  sltIni.Add('column_widths '+St);

  // カラム順
  SetLength(iOrderArray,Form1.ListView1.Columns.Count);
  piOrderArray:=@iOrderArray[0];
  ListView_GetColumnOrderArray(Form1.ListView1.Handle,
                       Form1.ListView1.Columns.Count,
                       piOrderArray);

  St:=Inttostr(iOrderArray[0]);

  for i:=1 to Length(iOrderArray)-1 do
  begin
    St:=St+','+Inttostr(iOrderArray[i]);
  end;
  sltIni.Add('column_order '+St);


  /// サブリスト
  // カラム幅
  St:=Inttostr(ListView_GetColumnWidth(Form1.ListView2.Handle,0));

  for i:=1 to Form1.ListView2.Columns.Count-1 do
  begin
    St:=St+','+Inttostr(ListView_GetColumnWidth(Form1.ListView2.Handle,i));
  end;
  sltIni.Add('sl_column_widths '+St);

  // カラム順
  SetLength(iOrderArray,Form1.ListView2.Columns.Count);
  piOrderArray:=@iOrderArray[0];
  ListView_GetColumnOrderArray(Form1.ListView2.Handle,
                       Form1.ListView2.Columns.Count,
                       piOrderArray);

  St:=Inttostr(iOrderArray[0]);

  for i:=1 to Length(iOrderArray)-1 do
  begin
    St:=St+','+Inttostr(iOrderArray[i]);
  end;
  sltIni.Add('sl_column_order '+St);

  // HTTPダウンロードデータ用
  sltIni.Add('ETag_mame32j '+ ETag_mame32j );
  sltIni.Add('ETag_version '+ ETag_version );
  sltIni.Add('ETag_mameinfo '+ ETag_mameinfo );
  sltIni.Add('ETag_history '+ ETag_history );


  // 起動関数
  sltIni.Add( 'user_alt_exe ' + BooltoStr(UseAltExe) );


  ///  ------------------------------------------
  /// Command.datビューア
  sltIni.Add('');
  sltIni.Add('### command.dat viewer ###');
  sltIni.Add('');


  // ウインドウの表示
  ComViewerVisible := frmCommand.Showing;
  St:=BooltoStr(ComViewerVisible);
  sltIni.Add('cv_visible '+St);

  // ウインドウ幅高位置
  sltIni.Add('cv_top '+ InttoStr(frmCommand.Top));
  sltIni.Add('cv_left '+ InttoStr(frmCommand.Left));
  sltIni.Add('cv_width '+ InttoStr(frmCommand.Width));
  sltIni.Add('cv_height '+ InttoStr(frmCommand.Height));

  // オプション
  sltIni.Add('cv_p2 '+ BooltoStr( frmCommand.chkP2.Checked  ));
  sltIni.Add('cv_autoresize '+ BooltoStr( frmCommand.chkAutoResize.Checked ));
  sltIni.Add('cv_zentohan '+ BooltoStr( frmCommand.chkZentoHan.Checked ));
  sltIni.Add('cv_alwaysontop '+ BooltoStr( frmCommand.chkAlwaysOnTop.Checked ));
  sltIni.Add('cv_index '+ InttoStr( frmCommand.cmbCommandType.ItemIndex ));


  /// ------------------------------------------
  /// ソフトウェアリスト
  sltIni.Add('');
  sltIni.Add('### Software List ###');
  sltIni.Add('');

  // ウインドウの表示
  SoftwareListVisible := frmSoftwareList.Showing;
  St:=BooltoStr(SoftwareListVisible);
  sltIni.Add('sw_visible '+St);

  // ウインドウ幅高位置
  sltIni.Add('sw_top '+ InttoStr(frmSoftwareList.Top));
  sltIni.Add('sw_left '+ InttoStr(frmSoftwareList.Left));
  sltIni.Add('sw_width '+ InttoStr(frmSoftwareList.Width));
  sltIni.Add('sw_height '+ InttoStr(frmSoftwareList.Height));

  sltIni.Add('sw_alwaysontop '+ BooltoStr( frmSoftwareList.chkAlwaysOnTop.Checked ));

  // カラム
  St:=Inttostr(ListView_GetColumnWidth(frmSoftwareList.ListView1.Handle,0));

  for i:=1 to frmSoftwareList.ListView1.Columns.Count-1 do
  begin
    St:=St+','+Inttostr(ListView_GetColumnWidth(frmSoftwareList.ListView1.Handle,i));
  end;
  sltIni.Add('sw_column_widths '+St);

  // カラム順
  SetLength(iOrderArray,frmSoftwareList.ListView1.Columns.Count);
  piOrderArray:=@iOrderArray[0];
  ListView_GetColumnOrderArray(frmSoftwareList.ListView1.Handle,
                       frmSoftwareList.ListView1.Columns.Count,
                       piOrderArray);

  St:=Inttostr(iOrderArray[0]);

  for i:=1 to Length(iOrderArray)-1 do
  begin
    St:=St+','+Inttostr(iOrderArray[i]);
  end;
  sltIni.Add('sw_column_order '+St);

  sltIni.Add('sw_column_sort '+ inttostr(frmSoftwareList.columnSort));
  sltIni.Add('sw_search '+trim(frmSoftwareList.SearchBox1.Text));

  // ソフトウェアリストヒストリー
  St:='';
  for i:=0 to frmSoftwareList.softlistHistory.Count-1 do
  begin
    St:=St + #9 + frmSoftwareList.softlistHistory[i];
  end;
  sltIni.Add('sw_history '+St);


  //// --------------------------------------------
  /// ROMの状態
  sltIni.Add('');
  sltIni.Add('### game variables ###');
  sltIni.Add('');

  for i:=0 to TLMaster.Count-1 do
  begin
    // ROM
    sltIni.Add('r*'+PRecordset(TLMaster[i]).ZipName+' '+BooltoStr(PRecordSet(TLMaster[i]).ROM));

    // Sample
    if PRecordset(TLMaster[i]).SampleOf<>'' then
      sltIni.Add('s*'+PRecordset(TLMaster[i]).ZipName+' '+BooltoStr(PRecordSet(TLMaster[i]).Sample));
  end;


  try
    // 不完全状態のときはini保存しない
    if (TLMaster.Count > 0) then
    begin
      sltIni.SaveToFile(ExeDir+ININAME, TEncoding.UTF8);
    end;
  except
    on E: EFCreateError do
    begin
      Application.MessageBox('設定ファイル書き込み失敗。',APPNAME, MB_ICONSTOP);
      sltIni.Free;
      exit;
    end;
  end;

  sltIni.Free;

end;

// -----------------------------------------------------------------------------
// iniの読み込み
procedure LoadIni;
var
  F1: TextFile;
  St,S: String;
  StrList: TStringList;
  i,j: integer;
  uSt: Utf8String;

  piOrderArray: Pinteger;
  iOrderArray: array of integer;

  sltIni  :  TStringList;
  intLine :  integer;
  ms: cardinal;

begin

  // FAV2
  // お気に入りファイルの存在
  if FileExists( 'favorites.ini' ) then begin
    Favorites2 := TStringList.Create;
    try
      Favorites2.LoadFromFile('favorites.ini', TEncoding.UTF8 );

      // 数チェック
      if favorites2.Count > MAXFAVORITES2 then
      begin
        Application.MessageBox(PWideChar('お気に入りの最大数は '+InttoStr(MAXFAVORITES2)+' 件です。'+#13#10+'それ以上の項目は削除されます。'), APPNAME, MB_ICONSTOP );
        for i := Favorites2.Count - 1 downto MAXFAVORITES2 do
          Favorites2.Delete(i);
      end;

    finally

    end;
  end;


  sltIni  :=  TStringList.Create;

  if FileExists(ExeDir+ININAME)=False then
    exit;

  sltIni.LoadFromFile(ExeDir+ININAME, TEncoding.UTF8);
  intLine:=0;


  // プロファイルとパス
  while ((sltIni[intLine] <> '### interface ###') and (sltIni.Count > intLine)) do
  begin

    St:=sltIni[intLine];

    // プロファイル
    if Copy(St,1,8)='profile ' then
    begin
      St:=Copy(St,pos(' ',St)+1,Length(St));
      i:=Length(MameExe);
      SetLength(MameExe, i+1);

      StrList:=TStringList.Create;

      // 古いプロファイルの場合、EnabledはTrue

      if (TsvSeparate(St,StrList)=5) then
      begin
        MameExe[i].OptEnbld:=StrtoBool(StrList[4]);
      end
      else
      begin
        MameExe[i].OptEnbld:=True;
      end;

      MameExe[i].Title:=StrList[0];
      MameExe[i].ExePath:=StrList[1];
      MameExe[i].WorkDir:=StrList[2];
      MameExe[i].Option:=StrList[3];
      StrList.Free;

    end
    else
    // プロファイル番号
    if AnsiStartsStr( 'profile_no', St ) then
    begin
      CurrentProfile:=StrtoInt(Copy(St,pos(' ',St),Length(St)));
    end
    else
    // sampleパス
    if AnsiStartsStr( 'samplepath', St ) then
    begin
      SamplePath:=Copy(St,pos(' ',St)+1,Length(St));
    end
    else
    // cfgパス
    if AnsiStartsStr( 'cfg_directory', St ) then
    begin
      cfgDir:=Copy(St,pos(' ',St)+1,Length(St));
    end
    else
    // nvramパス
    if AnsiStartsStr( 'nvram_directory', St ) then
    begin
      nvramDir:=Copy(St,pos(' ',St)+1,Length(St));
    end
    else
    // inpパス
    if AnsiStartsStr( 'input_directory', St ) then
    begin
      inpDir:=Copy(St,pos(' ',St)+1,Length(St));
    end
    else
    // statusパス
    if AnsiStartsStr( 'status_directory', St ) then
    begin
      staDir:=Copy(St,pos(' ',St)+1,Length(St));
    end
    else
    // snapパス
    if AnsiStartsStr( 'snapshot_directory', St ) then
    begin
      SnapDir:=Copy(St,pos(' ',St)+1,Length(St));
    end
    else
    // datパス
    if Copy(St,1,14)='dat_directory ' then
    begin
      datDir:=Copy(St,pos(' ',St)+1,Length(St));
    end
    else
    // langパス
    if AnsiStartsStr( 'lang_directory', St ) then
    begin
      langDir:=Copy(St,pos(' ',St)+1,Length(St));
    end
    else
    // version.iniパス
    if AnsiStartsStr( 'version_ini_directory', St ) then
    begin
      versionDir:=Copy(St,pos(' ',St)+1,Length(St));
    end
    else
    // 最終使用パス
    if AnsiStartsStr( 'last_path', St ) then
    begin
      lastPath:=Copy(St,pos(' ',St)+1,Length(St));
    end
    else
    // 最終使用パス
    if AnsiStartsStr( 'last_exe_path', St ) then
    begin
      lastExePath:=Copy(St,pos(' ',St)+1,Length(St));
    end
    else
    // ROMパス
    if AnsiStartsStr( 'rompath', St ) then
    begin

      St:=Copy(St,pos(' ',St)+1,Length(St));
      if St<>'' then
      begin
        StrList:=TStringList.Create;
        SetLength(ROMDirs, TsvSeparate(St,StrList));

        for i:=0 to Length(ROMDirs)-1 do
        begin
          // 一応チェック
          if StrList[i]<>'' then
            ROMDirs[i]:=StrList[i]
          else
            SetLength(ROMDirs,Length(ROMDirs)-1);

        end;
        StrList.Free;
      end;
    end
    else
    // SOFTパス
    if AnsiStartsStr( 'swpath', St ) then
    begin

      St:=Copy(St,pos(' ',St)+1,Length(St));
      if St<>'' then
      begin
        StrList:=TStringList.Create;
        SetLength(SoftDirs, TsvSeparate(St,StrList));

        for i:=0 to Length(SoftDirs)-1 do
        begin
          // 一応チェック
          if StrList[i]<>'' then
            SoftDirs[i]:=StrList[i]
          else
            SetLength(SoftDirs,Length(SoftDirs)-1);

        end;
        StrList.Free;
      end;
    end;

    inc(intLine);

  end;


  // 設定
  while ((sltIni[intLine] <> '### game variables ###') and (sltIni.Count  > intLine)) do
  begin

    St:=sltIni[intLine];

    // アスペクト比
    if AnsiStartsStr( 'keep_aspect', St ) then
    begin
      KeepAspect:=(StrToInt(Copy(St,pos(' ',St),Length(St)))=1);
    end
    else
    // ショットのフィルタ
    if AnsiStartsStr( 'shot_filter', St ) then
    begin
      CurrentFilter:=StrToInt(Copy(St,pos(' ',St),Length(St)));

      case CurrentFilter of
        RF_NEAREST: Form1.actVFNearest.Checked:=True;
        RF_LINEAR:  Form1.actVFLinear.Checked :=True;
        RF_LANCZOS: Form1.actVFLanczos.Checked:=True;
        RF_CUBIC:   Form1.actVFCubic.Checked  :=True;
      else
        begin
          CurrentFilter:=RF_CUBIC;
          Form1.actVFCubic.Checked  :=True;
        end;
      end;

    end

    // サブパネルの幅
    else
    if AnsiStartsStr( 'subpane_width', St ) then
    begin
      Form1.Panel3.Width:= strtoint(Copy(St,pos(' ',St)+1,Length(St)));
    end
    // ショット部分の高さ
    else
    if AnsiStartsStr( 'shot_height', St ) then
    begin
      Form1.Panel15.Height:= strtoint(Copy(St,pos(' ',St)+1,Length(St)));
    end
    else
    // 英語名
    if AnsiStartsStr( 'english_desc', St ) then
    begin
      En:=(StrToInt(Copy(St,pos(' ',St),Length(St)))=1);
    end
    else
    // ジョイスティックのリピート速度
    if AnsiStartsStr( 'joy_repeat', St ) then
    begin
      JoyRepeat:=StrToInt(Copy(St,pos(' ',St),Length(St)));
      if JoyRepeat<1 then JoyRepeat:=45;
    end
    else
    // デフォルトゲーム
    if AnsiStartsStr( 'default_game ', St ) then
    begin
      SelZip:=Copy(St,pos(' ',St)+1,Length(St));
    end
    // 検索ワード
    else
    if AnsiStartsStr( 'search_word ', St ) then
    begin
      SearchWord:=Copy(St,pos(' ',St)+1,Length(St));
    end

    /// 検索いろいろ
    else
    if AnsiStartsStr( 'search_etc ', St ) then
    begin
      CurrentAssort:=StrtoInt(Copy(St,pos(' ',St)+1,Length(St)));
      if (Form1.cmbEtc.Items.Count)>CurrentAssort then
        Form1.cmbEtc.ItemIndex:=CurrentAssort
      else
        CurrentAssort:=0;
    end
    // 年代
    else
    if AnsiStartsStr( 'search_yer ', St ) then
    begin
      s:= Copy(St,pos(' ',St)+1,Length(St));
      i:= Form1.cmbYear.Items.IndexOf(s);
      if i<>-1 then
        Form1.cmbYear.ItemIndex:=i;
    end
    // 製造元
    else
    if AnsiStartsStr( 'search_mkr ', St ) then
    begin
      s:= Copy(St,pos(' ',St)+1,Length(St));
      i:= Form1.cmbMaker.Items.IndexOf(s);
      if i<>-1 then
        Form1.cmbMaker.ItemIndex:=i;
    end
    // CPU
    else
    if AnsiStartsStr( 'search_cpu ', St ) then
    begin
      s:= Copy(St,pos(' ',St)+1,Length(St));
      i:= Form1.cmbCPU.Items.IndexOf(s);
      if i<>-1 then
        Form1.cmbCPU.ItemIndex:=i;
    end
    // Sound
    else
    if AnsiStartsStr( 'search_snd ', St ) then
    begin
      s:= Copy(St,pos(' ',St)+1,Length(St));
      i:= Form1.cmbSound.Items.IndexOf(s);
      if i<>-1 then
        Form1.cmbSound.ItemIndex:=i;
    end
    // Version
    else
    if AnsiStartsStr( 'search_ver ', St ) then
    begin
      s:= Copy(St,pos(' ',St)+1,Length(St));
      i:= Form1.cmbVersion.Items.IndexOf(s);
      if i<>-1 then
        Form1.cmbVersion.ItemIndex:=i;
    end

    // 検索モード
    else
    if AnsiStartsStr( 'search_mode ', St ) then
    begin
      S:=Copy(St,pos(' ',St)+1,Length(St));

      if S='1' then
      begin
        SearchMode:=srcDesc;
        Form1.actSDescExecute(nil);
      end
      else if S='2' then
      begin
        SearchMode:=srcZip;
        Form1.actSZipExecute(nil);
      end
      else if S='3' then
      begin
        SearchMode:=srcSource;
        Form1.actSSourceExecute(nil);
      end
      else if S='4' then
      begin
        SearchMode:=srcMaker;
        Form1.actSMakerExecute(nil);
      end;
    end


    else
    // ウィンドウ
    if AnsiStartsStr( 'window_x ', St ) then
    begin
      Form1.Left:=StrToInt(Copy(St,pos(' ',St),Length(St)));
    end
    else
    if AnsiStartsStr( 'window_y ', St ) then
    begin
      Form1.Top:=StrToInt(Copy(St,pos(' ',St),Length(St)));
    end
    else
    if AnsiStartsStr( 'window_width ', St ) then
    begin
      Form1.Width:=StrToInt(Copy(St,pos(' ',St),Length(St)));
    end
    else
    if AnsiStartsStr( 'window_height ', St ) then
    begin
      Form1.Height:=StrToInt(Copy(St,pos(' ',St),Length(St)));
    end
    else
    if AnsiStartsStr( 'window_state ', St ) then
    begin
      i:=StrToInt(Copy(St,pos(' ',St),Length(St)));
      case i of
        0:Form1.WindowState:=wsMinimized;
        1:Form1.WindowState:=wsNormal;
        2:
        begin
          Form1.Left:=0;
          Form1.Top:=0;
          Form1.WindowState:=wsMaximized;
        end;
      end;
    end
    else
    // 編集ウィンドウ
    if AnsiStartsStr( 'edit_visible ', St ) then
    begin
      St:=Copy(St,pos(' ',St)+1,Length(St));
      Form1.Panel7.Visible:=StrtoBool(St);
      Form1.Splitter1.Visible:=StrtoBool(St);
    end
    else
    // 編集パネルの高さ
    if AnsiStartsStr( 'edit_hight ', St ) then
    begin
      St:=Copy(St,pos(' ',St)+1,Length(St));
      Form1.Panel7.Height:=StrtoInt(St);
    end
    else
    // 親情報パネルの状態
    if AnsiStartsStr( 'info_panel ', St ) then
    begin
      St:=Copy(St,pos(' ',St)+1,Length(St));
      Form1.Panel3.Visible:=StrtoBool(St);
      Form1.Splitter2.Visible:=Form1.Panel3.Visible;
    end
    else
    // 下側情報パネルの状態
    if AnsiStartsStr( 'info_visible ', St ) then
    begin
      St:=Copy(St,pos(' ',St)+1,Length(St));
      InfoPanel:=not StrtoBool(St);
      Form1.SpeedButton3.Click;
    end
    else
    // メカニカル隠す
    if AnsiStartsStr( 'hide_mechanical ', St ) then
    begin
      St:=Copy(St,pos(' ',St)+1,Length(St));
      HideMechanical:=StrtoBool(St);
    end
    else
    // ギャンブル隠す
    if AnsiStartsStr( 'hide_gambling ', St ) then
    begin
      St:=Copy(St,pos(' ',St)+1,Length(St));
      HideGambling:=StrtoBool(St);
    end
    else
    // ソート履歴
    if AnsiStartsStr( 'sort_history ', St ) then
    begin
      St:=Copy(St,pos(' ',St)+1,Length(St));
      StrList:=TStringList.Create;
      CsvSeparate(St,StrList);

      for i:=0 to StrList.Count-1 do
      begin
        SortHistory[i]:=StrtoInt(StrList[i]);
      end;
      StrList.Free;
    end
    else
    // 検索バー表示
    if AnsiStartsStr( 'search_bar ', St ) then
    begin
      St:=Copy(St,pos(' ',St)+1,Length(St));
      Form1.Panel12.Visible:=StrtoBool(St);
      if Form1.Panel12.Visible then
        Form1.actVSearchBar.ImageIndex:=32;
    end
    // 検索バー幅
    else
    if AnsiStartsStr( 'search_bar_width ', St ) then
    begin
      St:=Copy(St,pos(' ',St)+1,Length(St));
      i:=StrtoInt(St);
      if i > 0 then
        Form1.Panel13.Width:=StrtoInt(St);
    end
    else
    // ジョイスティック
    if AnsiStartsStr( 'joystick_in_interface ', St ) then
    begin
      St:=Copy(St,pos(' ',St)+1,Length(St));
      UseJoyStick:=StrtoBool(St);
    end
    else
    // POV使用
    if AnsiStartsStr( 'use_pov ', St ) then
    begin
      St:=Copy(St,pos(' ',St)+1,Length(St));
      UsePOV:=StrtoBool(St);
    end
    else
    // リストフォント
    if AnsiStartsStr( 'list_color ', St ) then
    begin
      St:=Copy(St,pos(' ',St)+1,Length(St));
      ListColor:=StrtoInt(St);
      Form1.ListView1.Color:=ListColor;
      Form1.ListView2.Color:=ListColor;
    end
    else
    // リストフォント
    if AnsiStartsStr( 'list_font ', St ) then
    begin
      St:=Copy(St,Pos('"',St)+1,PosEx('"',St,Pos('"',St)+1)-Pos('"',St)-1);
      StrList:=TStringList.Create;
      CsvSeparate(St,StrList);
      ListFont.Charset:=DEFAULT_CHARSET;
      ListFont.Color:=StrtoInt(StrList[1]);
      ListFont.Size:=StrtoInt(StrList[2]);
      if StrList[3]<>'0' then ListFont.Style:=ListFont.Style+[fsBold];
      if StrList[4]<>'0' then ListFont.Style:=ListFont.Style+[fsItalic];
      if StrList[5]<>'0' then ListFont.Style:=ListFont.Style+[fsUnderline];
      if StrList[6]<>'0' then ListFont.Style:=ListFont.Style+[fsStrikeOut];
      ListFont.Name:=StrList[7];
      StrList.Free;
      Form1.ListView1.Font:=ListFont;
      Form1.ListView2.Font:=ListFont;
      Form1.Panel12.Font:=ListFont;
    end
    else
    // ヒストリーフォント
    if AnsiStartsStr( 'history_font ', St ) then
    begin
      St:=Copy(St,Pos('"',St)+1,PosEx('"',St,Pos('"',St)+1)-Pos('"',St)-1);
      StrList:=TStringList.Create;
      CsvSeparate(St,StrList);
      HistoryFont.Charset:=DEFAULT_CHARSET;
      HistoryFont.Color:=StrtoInt(StrList[1]);
      HistoryFont.Size:=StrtoInt(StrList[2]);
      if StrList[3]<>'0' then HistoryFont.Style:=HistoryFont.Style+[fsBold];
      if StrList[4]<>'0' then HistoryFont.Style:=HistoryFont.Style+[fsItalic];
      if StrList[5]<>'0' then HistoryFont.Style:=HistoryFont.Style+[fsUnderline];
      if StrList[6]<>'0' then HistoryFont.Style:=HistoryFont.Style+[fsStrikeOut];
      HistoryFont.Name:=StrList[7];
      StrList.Free;

    end
    else
    // コラム幅
    if AnsiStartsStr( 'column_widths ', St ) then
    begin
      St:=Copy(St,pos(' ',St)+1,Length(St));
      StrList:=TStringList.Create;
      CsvSeparate(St,StrList);
      for i:=0 to StrList.Count-1 do
      begin
        ListView_SetColumnWidth(Form1.ListView1.Handle,i,StrtoInt(StrList[i]));
      end;
      StrList.Free;
    end
    else
    // コラム順
    if AnsiStartsStr( 'column_order ', St ) then
    begin
      St:=Copy(St,pos(' ',St)+1,Length(St));
      StrList:=TStringList.Create;
      CsvSeparate(St,StrList);

      SetLength(iOrderArray,Form1.ListView1.Columns.Count);
      piOrderArray:=@iOrderArray[0];

      for i:=0 to Form1.ListView1.Columns.Count-1 do
      begin
        iOrderArray[i]:=StrtoInt(StrList[i]);
      end;

      ListView_SetColumnOrderArray(Form1.ListView1.Handle,
                                   Form1.ListView1.Columns.Count,
                                   piOrderArray);
      StrList.Free;
    end
    else
    // サブリスト
    // コラム幅
    if AnsiStartsStr( 'sl_column_widths ', St ) then
    begin
      St:=Copy(St,pos(' ',St)+1,Length(St));
      StrList:=TStringList.Create;
      CsvSeparate(St,StrList);
      for i:=0 to StrList.Count-1 do
      begin
        ListView_SetColumnWidth(Form1.ListView2.Handle,i,StrtoInt(StrList[i]));
      end;
      StrList.Free;
    end
    else
    // コラム順
    if AnsiStartsStr( 'sl_column_order ', St ) then
    begin
      St:=Copy(St,pos(' ',St)+1,Length(St));
      StrList:=TStringList.Create;
      CsvSeparate(St,StrList);

      SetLength(iOrderArray,Form1.ListView2.Columns.Count);
      piOrderArray:=@iOrderArray[0];

      for i:=0 to Form1.ListView2.Columns.Count-1 do
      begin
        iOrderArray[i]:=StrtoInt(StrList[i]);
      end;
      ListView_SetColumnOrderArray(Form1.ListView2.Handle,
                                   Form1.ListView2.Columns.Count,
                                   piOrderArray);
      StrList.Free;
    end
    // HTTPダウンロードデータ
    else
    if AnsiStartsStr( 'ETag_mame32j ', St ) then
    begin
      ETag_mame32j := Copy(St,pos(' ',St)+1,Length(St));
    end
    else
    if AnsiStartsStr( 'ETag_version ', St ) then
    begin
      ETag_version := Copy(St,pos(' ',St)+1,Length(St));
    end
    else
    if AnsiStartsStr( 'ETag_mameinfo ', St ) then
    begin
      ETag_mameinfo := Copy(St,pos(' ',St)+1,Length(St));
    end
    else
    if AnsiStartsStr( 'ETag_history ', St ) then
    begin
      ETag_history := Copy(St,pos(' ',St)+1,Length(St));
    end
    else
    // 起動関数
    if AnsiStartsStr( 'user_alt_exe ', St ) then
    begin
      St:=Copy(St,pos(' ',St)+1,Length(St));
      UseAltExe:=StrtoBool(St);
    end

    else
    /// -------------------
    ///  コマンドビューア用
    // ウィンドウ
    if Copy(St,1,11)='cv_visible ' then
    begin
      St:=Copy(St,pos(' ',St)+1,Length(St));
      ComViewerVisible:=StrtoBool(St);
    end
    else
    // 上
    if Copy(St,1,7)='cv_top ' then
    begin
      St:=Copy(St,pos(' ',St)+1,Length(St));
      ComViewerTop:=StrtoInt(St);
    end
    else
    // 左
    if Copy(St,1,8)='cv_left ' then
    begin
      St:=Copy(St,pos(' ',St)+1,Length(St));
      ComViewerLeft:=StrtoInt(St);
    end
    else
    // 幅
    if Copy(St,1,9)='cv_width ' then
    begin
      St:=Copy(St,pos(' ',St)+1,Length(St));
      ComViewerWidth:=StrtoInt(St);
    end
    else
    // 高さ
    if Copy(St,1,10)='cv_height ' then
    begin
      St:=Copy(St,pos(' ',St)+1,Length(St));
      ComViewerHeight:=StrtoInt(St);
    end
    else
    if Copy(St,1,6)='cv_p2 ' then // P2反転
    begin
      St:=Copy(St,pos(' ',St)+1,Length(St));
      ComViewerP2:=StrtoBool(St);
    end
    else
    if Copy(St,1,13)='cv_autoresize' then // 自動リサイズ
    begin
      St:=Copy(St,pos(' ',St)+1,Length(St));
      ComViewerAutoResize:=StrtoBool(St);
    end
    else
    if Copy(St,1,12)='cv_zentohan ' then // 全角→半角
    begin
      St:=Copy(St,pos(' ',St)+1,Length(St));
      ComViewerZentoHan:=StrtoBool(St);
    end
    else
    if Copy(St,1,15)='cv_alwaysontop ' then // 常に手前
    begin
      St:=Copy(St,pos(' ',St)+1,Length(St));
      ComViewerAlwaysOnTop:=StrtoBool(St);
    end
    else
    if Copy(St,1,9)='cv_index ' then
    begin
      St:=Copy(St,pos(' ',St)+1,Length(St));
      ComViewerIndex:=StrtoInt(St);
      frmCommand.initialIndex:= ComViewerIndex; // 初期選択値
    end
    else
    /// -------------------
    ///  ソフトリスト用
    // ウィンドウ
    if Copy(St,1,11)='sw_visible ' then
    begin
      St:=Copy(St,pos(' ',St)+1,Length(St));
      SoftwareListVisible:=StrtoBool(St);
    end
    else
    // 上
    if Copy(St,1,7)='sw_top ' then
    begin
      St:=Copy(St,pos(' ',St)+1,Length(St));
      SoftwareListTop:=StrtoInt(St);
    end
    else
    // 左
    if Copy(St,1,8)='sw_left ' then
    begin
      St:=Copy(St,pos(' ',St)+1,Length(St));
      SoftwareListLeft:=StrtoInt(St);
    end
    else
    // 幅
    if Copy(St,1,9)='sw_width ' then
    begin
      St:=Copy(St,pos(' ',St)+1,Length(St));
      SoftwareListWidth:=StrtoInt(St);
    end
    else
    // 高さ
    if Copy(St,1,10)='sw_height ' then
    begin
      St:=Copy(St,pos(' ',St)+1,Length(St));
      SoftwareListHeight:=StrtoInt(St);
    end
    else
    if Copy(St,1,15)='sw_alwaysontop ' then // 常に手前
    begin
      St:=Copy(St,pos(' ',St)+1,Length(St));
      SoftwareListAlwaysOnTop:=StrtoBool(St);
    end
    else
    // コラム幅
    if AnsiStartsStr( 'sw_column_widths ', St ) then
    begin
      St:=Copy(St,pos(' ',St)+1,Length(St));
      StrList:=TStringList.Create;
      CsvSeparate(St,StrList);
      for i:=0 to StrList.Count-1 do
      begin
        ListView_SetColumnWidth(frmSoftwareList.ListView1.Handle,i,StrtoInt(StrList[i]));
      end;
      StrList.Free;
    end
    else
    // コラム順
    if AnsiStartsStr( 'sw_column_order ', St ) then
    begin
      St:=Copy(St,pos(' ',St)+1,Length(St));
      StrList:=TStringList.Create;
      CsvSeparate(St,StrList);

      SetLength(iOrderArray,frmSoftwareList.ListView1.Columns.Count);
      piOrderArray:=@iOrderArray[0];

      for i:=0 to frmSoftwareList.ListView1.Columns.Count-1 do
      begin
        iOrderArray[i]:=StrtoInt(StrList[i]);
      end;

      ListView_SetColumnOrderArray(frmSoftwareList.ListView1.Handle,
                                   frmSoftwareList.ListView1.Columns.Count,
                                   piOrderArray);
      StrList.Free;
    end
    else
    if Copy(St,1,15)='sw_column_sort ' then
    begin
      St:=Copy(St,pos(' ',St)+1,Length(St));
      SoftwareListColumnSort := strtoint(st);
    end
    else
    if Copy(St,1,10)='sw_search ' then
    begin
      St:=Copy(St,pos(' ',St)+1,Length(St));
      SoftwareListSearch := trim(St);
    end
    else
    if Copy(St,1,11)='sw_history ' then
    begin
      St:=Copy(St,pos(' ',St)+1,Length(St));
      SoftwareListHistory.DelimitedText := trim(St);
    end;

    inc(intLine);

  end;

  // ゲームステータス（ROMとSample）
  i:=0;
  j:=0;
  SetLength(RomTemp, MAXGAMES);
  SetLength(SampleTemp,10000);


  while (sltIni.Count > intLine) do
  begin

    St:=sltIni[intLine];

    if AnsiStartsStr( 'r*', St ) then
    begin
      //SetLength(RomTemp,i+1); //←こうすると遅い
      RomTemp[i].Zip:=Copy(St, 3, pos(' ',St)-3);
      RomTemp[i].ROM:=StrtoBool(Copy(St,pos(' ',St)+1,2));
      Inc(i);
    end
    else
    if AnsiStartsStr( 's*', St ) then
    begin
      SampleTemp[j].Zip:=Copy(St, 3, pos(' ',St)-3);
      SampleTemp[j].Sample:=StrtoBool(Copy(St,pos(' ',St)+1,2));
      Inc(j);
    end;

    inc(intLine);

  end;

  SetLength(RomTemp,i);
  SetLength(SampleTemp,j);

  // 選択中のプロファイルがあるかどうか
  //
  if CurrentProfile > (Length( MameExe )-1) then
  begin
    CurrentProfile := -1;
  end;



end;


//------------------------------------------------------------------------------
// Version.iniの読み込みと設定
//
procedure SetVersionINI;
var
  St,S: String;
  i, j: integer;

  StrList: TStringList;
  intLine :  integer;

begin

  SetLength(VersionName, 0);
  SetLength(Versions, 0);

  Form1.cmbVersion.Items.Clear;
  Form1.cmbVersion.Items.Add(TEXT_VERSION_ALL);
  Form1.cmbVersion.ItemIndex:=0;
  i:=0;
  j:=0;

  if (FileExists(versionDir+'\version.ini')=False) then
    exit;


  // version.ini読み込み
  StrList:=TStringList.Create;
  StrList.LoadFromFile(versionDir+'\version.ini', TEncoding.UTF8);
  intLine:=0;


  while ( StrList.Count > intLine ) do
  begin

    St:=StrList[intLine];

    // フォルダ設定は無視
    if Pos('[FOLDER_SETTINGS]',St)<>0 then
    begin

      while ( StrList.Count > intLine ) and (St<>'') do
      begin

        inc(intLine);
        St:=StrList[intLine];

      end;

    end;

    inc(intLine);
    St:=StrList[intLine];

    // Root Folderも無視
    if Pos('[ROOT_FOLDER]',ST)<>0 then
    begin

      while ( StrList.Count > intLine ) and (St<>'') do
      begin

        inc(intLine);
        St:=StrList[intLine];

      end;
    end;

    // バージョン情報
    while ( StrList.Count > intLine ) do
    begin
      St:=StrList[intLine];
      St:=Trim(St);

      // バージョン名
      if AnsiStartsStr( '[', St ) and AnsiEndsStr( ']', St ) then
      begin
        j:=0;
        // バージョンがピリオドで始まるときは
        S:=Copy(St,2,Length(St)-2);
        if Copy(S,1,1)='.' then
          S:='0'+S;

        SetLength(VersionName, i+1);
        SetLength(Versions, i+1);
        VersionName[i]:=S;
        inc(i);

      end
      else
      // ゲーム名
      if (St<>'') then
      begin
        SetLength(Versions[i-1], j+1);
        Versions[i-1][j]:=St;
        inc(j);
      end;

      inc(intLine);

    end;

    inc(intLine);

  end;


  // フォームに設定
  for i:=0 to Length(VersionName)-1 do
  begin
    Form1.cmbVersion.Items.Add(VersionName[Length(VersionName)-1-i])
  end;

end;



// -----------------------------------------------------------------------------
// CSV分割
function CsvSeparate(const Str: string; StrList: TStrings): Integer;
  procedure Split(Delimiter: Char; Str: string; ListOfStrings: TStrings) ;
  begin
     ListOfStrings.Clear;
     ListOfStrings.Delimiter       := Delimiter;
     ListOfStrings.StrictDelimiter := True; // Requires D2006 or newer.
     ListOfStrings.DelimitedText   := Str;
  end;
//var
//  Head, Tail: PChar;
//  Len: Integer;
begin
  {StrList.Clear;
  Head := PChar(Str);
  while True do
    if Head^ = '"' then begin
      StrList.Append(AnsiExtractQuotedStr(Head, '"'));
      if Head^ <> #0 then Inc(Head)
    end else begin
      Tail := AnsiStrPos(Head, ',');
      if Tail = nil then begin
        StrList.Append(Head);
        Break
      end else begin
        Len := Tail - Head;
        StrList.Append(Copy(Head, 1, Len));
        Inc(Head, Len + 1)
      end
    end;
  Result := StrList.Count
  }
  StrList.Clear;
  Split(',', Str, StrList) ;
  Result := StrList.Count;
end;



// -----------------------------------------------------------------------------
// TSV分割
function TsvSeparate(const Str: string; StrList: TStrings): Integer;
  procedure Split(Delimiter: Char; Str: string; ListOfStrings: TStrings) ;
  begin
     ListOfStrings.Clear;
     ListOfStrings.Delimiter       := Delimiter;
     ListOfStrings.StrictDelimiter := True; // Requires D2006 or newer.
     ListOfStrings.DelimitedText   := Str;
  end;
begin

  StrList.Clear;
  Split(#9, Str, StrList) ;
  Result := StrList.Count;

 end;



// -----------------------------------------------------------------------------
// PNG読み込み（ファイルから）
function LoadPNGFile(const filename: string; bitmap: TPngImage): boolean;
begin

  result:=true;

  if FileExists(filename)=False then
  begin
    result:=False;
    exit;
  end;

  try
    // PNG ファイルを読み込み
    bitmap.LoadFromFile(filename);
  except
    result:=False;
  end;

end;

{// -----------------------------------------------------------------------------
// PNG読み込み（snap.zipから）
function LoadPNGFileFromSnapZip(const Zip: string; bitmap: TPngImage): boolean;
var
  ZipPath: String;
  ArchiveItem: TZFArchiveItem;

  pngMStream: TMemoryStream;

begin

  Result:=true;
  SetCurrentDir(ExeDir);
  ZipPath:=SnapDir+'\snap.zip';

  if FileExists(ZipPath)=False then
  begin
    Result:=False;
    exit;
  end;

  pngMStream:=TMemoryStream.Create;

  With Form1.ZipForge1 do
  begin

    FileName:=ZipPath;
    try
      OpenArchive(fmOpenRead);

      // ファイル名で探す
      if FindFirst(Zip+'.png',ArchiveItem,faAnyFile-faDirectory) then
      begin
        ExtracttoStream(Zip+'.png',pngMStream);
        pngMStream.Position:=0;

      end
      else
      begin
        CloseArchive;
        result:=False;
        exit;
      end;

    except
      result:=False;
      exit;
    end;
    CloseArchive;
  end;

  try
    // PNG ファイルを読み込み
    bitmap.LoadFromStream(pngMStream);
  except
    result:=False;
    exit;
  end;

  pngMStream.Free;

end;
}
// -----------------------------------------------------------------------------
//
//function SavePNGFile(const filename: string; bitmap32: TBitmap32): boolean;
//var png: TPngImage;
//      dib: TNkDIB;
//      bmp: TBitmap;
{
begin

  result:=true;

  png:=TPngImage.Create;
  dib:=TNkDIB.Create;
  bmp:=TBitmap.Create;

  try
    try
      bmp.Assign(bitmap32);
      dib.Assign(bmp);
      dib.PixelFormat:=nkPf8Bit; // 8bitに減色
      bmp.Assign(dib);
      png.Assign(bmp);
      png.SaveToFile(filename);

    except
      result:=False;
    end;

  finally
    png.Free;
    dib.Free;
    bmp.Free;

  end;

end;
}
// -----------------------------------------------------------------------------
// INP内で指定されているゲーム名を取得する
//
function GetInpGame(FileName: string): string;
type
    TMyBuffer = array[0..12] of AnsiChar;
    TMyBufferPointer = ^TMyBuffer;

var
    fs: TFileStream;
    buffer: TMyBufferPointer;
    st: string;

begin

  result:='';

  if FileExists(FileName)=false then exit;

  fs := TFileStream.Create(FileName, fmOpenRead);
  New(buffer);

  try

    fs.Position := 20;
    fs.Read(buffer^,12);
    st:=Trim(String(buffer^));

  finally
    Dispose(buffer);
    fs.Free;
  end;

  result:=st;

end;


//------------------------------------------------------------------------------
// 環境に応じたコマンドをセットする
// 95/98系とNT系
function SetCommand: Commd;
var
  sysdir: array[0..260] of char;
begin
  GetSystemDirectory(sysdir, 260);
  Result.App   := sysdir +'\CMD.EXE';
  Result.Param := '/C ';
end;

//------------------------------------------------------------------------------
// 8.3のパス名
function LongToShortFileName(const LongName: String):String;
var
  Len: integer;
  LN: string;
begin

  if Trim(LongName)='' then    // 作業フォルダが空の場合
    LN:=ExpandFileName('.')
  else
    LN:=ExpandFileName(LongName);

  Len := GetShortPathName(PChar(LN), PChar(result), 0);
  SetLength(result, len);

  if GetShortPathName(PChar(LN), PChar(result), Len) = 0 then
    Raise EConvertError.Create('ファイルが見つかりません。');

  result:=Trim(result);
end;

//------------------------------------------------------------------------------
// Theの移動
function MoveThe(const Str: string):string;
var S2,S:String;
begin

  S:=Str;
  if Copy(S,1,4)='The ' then
  begin
    if Pos(' (',S)<>0 then
    begin
      S2:=Copy(S,Pos(' (',S),Length(S));
      S:=Copy(Str,5,Pos(' (',S)-5)+', The'+S2;
    end
    else
    S:=Copy(S,5,Length(S))+', The';
  end;

  Result:=S;

end;

//------------------------------------------------------------------------------
// エスケープ文字処理
function NormalizeString(const Str: string):string;
begin

  Result:=AnsiReplaceText(Str,'&quot;','"');
  Result:=AnsiReplaceText(Result,'&lt;','<');
  Result:=AnsiReplaceText(Result,'&gt;','>');
  Result:=AnsiReplaceText(Result,'&amp;','&');
  
end;

//------------------------------------------------------------------------------
// xmlの要素取り出し
function ExtractXML(const element: string; const xml:string): string;
var S:string;
    i:integer;
begin

  Result:='';
  if (Pos( ' '+element+'=', xml) = 0) and (Pos( '<'+element+'=', xml) = 0) then exit;

  S:= element+'=';
  i:= pos(S, xml) + length(S) + 1;
  Result:=Copy(xml, i, PosEx('"', xml, i) -i);

end;

//------------------------------------------------------------------------------
// ごみ箱へ移動
procedure Trasher(FileName: string);
var FileOp: TSHFileOpStruct;
begin

  FileName:=ExpandFileName(FileName)+#0#0;

  FileOp.Wnd   := Application.Handle;
  FileOp.wFunc := FO_DELETE;
  FileOp.pFrom := PChar(FileName);
  FileOp.pTo   := Nil;
  FileOp.fFlags:= FOF_ALLOWUNDO Or FOF_SILENT Or FOF_NOCONFIRMATION;

  SHFileOperation(FileOp);

end;




// ------------------------------------------------------------------
//  ディレクトリにファイルがあっても削除します（ゴミ箱に移します）
// ------------------------------------------------------------------

procedure DeleteDirectory(path: String);
var
  op: TSHFileOpStruct;

begin

  // 末尾の区切り文字なしでパス名を返します。
  path := ExcludeTrailingPathDelimiter(path);
  if not DirectoryExists(path) then
  begin
    Exit;
  end;

  try
    path := path + #0#0;
    FillChar(op, SizeOf(op), #0);
    op.Wnd := Application.Handle;
    op.wFunc := FO_DELETE;
    op.pFrom := PChar(path);
    op.pTo := nil;
    op.fFlags := FOF_SILENT or FOF_NOCONFIRMATION or FOF_NOERRORUI;
    op.fAnyOperationsAborted := False;
    SHFileOperation(op);
  except

  end;

end;

// ------------------------------------------------------------------
// 相対パスから絶対パスに変換
function PathRelativePathTo(pszPath: PChar; pszFrom: PChar; dwAttrFrom: DWORD;
  pszTo: PChar; dwAtrTo: DWORD): LongBool; stdcall; external 'shlwapi.dll' name 'PathRelativePathToW';

function AbsToRel(const AbsPath, BasePath: string): string;
var
  Path: array[0..MAX_PATH-1] of char;
begin
  PathRelativePathTo(@Path[0], PChar(BasePath), FILE_ATTRIBUTE_DIRECTORY, PChar(AbsPath), 0);
  result := Path;
end;

function PathCanonicalize(lpszDst: PChar; lpszSrc: PChar): LongBool; stdcall;
  external 'shlwapi.dll' name 'PathCanonicalizeW';

function RelToAbs(const RelPath, BasePath: string): string;
var
  Dst: array[0..MAX_PATH-1] of char;
begin
  PathCanonicalize(@Dst[0], PChar(IncludeTrailingBackslash(BasePath) + RelPath));
  result := Dst;
end;


end.

