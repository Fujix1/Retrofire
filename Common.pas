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

  TEXT_MAKER_ALL    = '(������)';
  TEXT_YEAR_ALL     = '(�N��)';
  TEXT_SOUND_ALL    = '(����)';
  TEXT_CPU_ALL      = '(CPU)';
  TEXT_VERSION_ALL  = '(�o�[�W����)';

  CRLF   = #13#10;
  CRLF2  = #13#10#13#10;
  MAKER  = 7; // ���[�J�[���X�g�̍Œᐔ

  // �X�e�[�^�X�A�C�R���̕\���Ԋu
  SB_LRMARGIN     = 18;
  SB_ITEMDISTANCE = 17;
  SB_MARKDISTANCE = 1;
  SB_NUMOFITEMS   = 6;

  // �X�N���[���V���b�g�̍ăT���v���[
  RF_NEAREST = 0;
  RF_LINEAR  = 2;
  RF_LANCZOS = 5;
  RF_CUBIC   = 1;

  // �ő�Q�[����
  MAXGAMES = 50000;

  // 1���R�[�h������̃Z�b�g��
  MAXSETS = 100;

  // �\�t�g���X�g�p
  SL_DIR          = 'softlists/'; // �\�t�g���X�g�̃f�B���N�g��
  SL_MASTER       = '_master.csv'; // �V�X�e���ƃT�|�[�g����\�t�g���X�g�̈ꗗ
  SL_INI          = '_stats.ini';
  SL_DATA         = '_softlist.data'; // �\�t�g���X�g�S�f�[�^


// �Q�[���X�e�[�^�X
type TGameStatus = (gsGood, gsImperfect, gsPreliminary, gsUnknown);

// �������[�h
type TSearchMode = (srcAll, srcDesc, srcZip, srcSource, srcMaker);

// �W���C�X�e�B�b�N�̏��
type TJoyStickStatus = (jsNone, jsUp, jsDown);

// CreateProcess�ɓn���R�}���h
type
	Commd = record
		App,
		Param: string;
end;

// version.ini �p
type
  TVersionINI = record
    Zip  : string;
    Index : integer;
end;

// hitory.dat�p
type
  THistoryDat = record
    Zips : TStringList;
    Desc : string;
end;

// mameinfo.dat�p
type
  TMameInfoDat = record
    Zips : TStringList;
    Desc : string;
end;

// ROM�X�e�[�^�X�ptemp
type
  TROMTemp = record
    Zip  : string;
    ROM  : boolean;
end;

// Sample�X�e�[�^�X�ptemp
type
  TSampleTemp = record
    Zip  : string;
    Sample: boolean;
end;

// �W���C�X�e�B�b�N�p���
type
  TMMJoyStick  = packed record
    Msg:     Cardinal;  // The message ID
    Buttons: Longint;   // The wParam
    XPos:    word;      // The lParam
    YPos:    word;
    Result:  Longint;
end;

// ���R�[�h�ۑ��p
type
  PRecordset = ^TRecordset;
  TRecordset = record

    ZipName   : string;     // Zip��
    DescE     : string;     // �p�ꖼ
    DescJ     : string;     // ���{�ꖼ
    Kana      : string;     // �ǂ݉���
    Maker     : string;     // ���[�J�[
    Year      : string;     // �����N

    Master    : boolean;    // �}�X�^�t���O
    CloneOf   : string;     // �}�X�^��
    SampleOf  : string;     // �T���v����
    RomOf     : string;     // RomOf

    ID        : Word;       // ������index (�T�u���X�g�Z�b�g����̎Q�Ɨp)
    MasterID  : Word;       // �}�X�^��index

    Vector    : boolean;    // �x�N�^�[
    LightGun  : boolean;    // �����e
    Analog    : boolean;    // �A�i���O����
    Status    : boolean;    // �X�e�[�^�X Good=True
    Vertical  : boolean;    // �c���
    Channels  : byte;       // �T�E���h�`�����l����

    Flag      : boolean;    // �X�V�`�F�b�N�p

    CPUs      : string;     // CPUs
    Sounds    : string;     // Sound chips
    Screens   : string;     // Screens
    NumScreens: integer;    // Numofscreens
    Palettesize :integer;   // �F��
    ResX      : Word;       // �𑜓x
    ResY      : Word;       // �𑜓x

    Color       : TGameStatus;// �F�X�e�[�^�X
    Sound       : TGameStatus;// ���X�e�[�^�X
    GFX         : TGameStatus;// �G�X�e�[�^�X
    Protect     : TGameStatus;// �v���e�N�g�X�e�[�^�X
    Cocktail    : TGameStatus;// �J�N�e���X�e�[�^�X
    SaveState   : TGameStatus;// �Z�[�u�X�e�[�g
    Source      : string;     // �\�[�X�t�@�C����
    CHD         : string;     // �f�B�X�N�C���[�W��
    CHDMerge    : boolean;    // CHD�}�[�W
    CHDOnly     : boolean;    // CHD�̂�
    ROM         : boolean;    // ROM�L��
    Sample      : boolean;    // Sample�L��
    LD          : boolean;    // ���[�U�[�f�B�X�N
    CHDNoDump   : boolean;    // chd�����_���v
    isMechanical: boolean;    // ���J�j�J���Q�[��

end;

type // mame�{�̗p
  PMameExe = ^TMameExe;
  TMameExe = record
    Title   : string;
    ExePath : string;
    WorkDir : string;
    Option  : string;
    OptEnbld: boolean;
  end;

// �\�t�g�E�F�A�ƃ\�t�g���X�g�p
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
  // ini�ݒ�
  ListFont      : TFont;   // ���X�g�̃t�H���g
  HistoryFont   : TFont;   // �q�X�g���[�̃t�H���g
  ListColor     : TColor;  // ���X�g�w�i�F
  KeepAspect    : boolean; // �V���b�g�̃A�X�y�N�g��ێ�
  SelZip        : String;  // �I�𒆂�zip��
  SelDriver     : String;  // �I�𒆂̃h���C�o��
  SearchWord    : string;  // ����������
  En            : boolean; // �p�ꖼ�\��
  SearchMode    : TSearchMode; // �������[�h
  UseJoyStick   : boolean; // �W���C�X�e�B�b�N�g��
  UsePOV        : boolean; // POV�g��
  JoyRepeat     : Word;    // �W���C�X�e�B�b�N�̃��s�[�g���x ms

  // ��ԕێ�
  Booting       : boolean; // �N��������
  ExeDir        : string;  // Exe��Path (Dir)

  samplePath    : string;  // sample�̃p�X
  cfgDir        : string;  // cfg�̃p�X
  nvramDir      : string;  // nvram�̃p�X
  staDir        : string;  // sta�̃p�X

  snapDir       : string;  // snap�̃p�X
  inpDir        : string;  // inp�̃p�X
  datDir        : string;  // dat�̃p�X
  langDir       : string;  // lang�̃p�X
  versionDir    : string;  // version.ini�̃p�X

  lastPath      : string;  // �ۑ������Ƃ��̍ŏI�p�X
  lastExePath   : string;  // exe�̍ŏI�p�X

  CurAspectX,
  CurAspectY    : integer; // �\�����̃V���b�g�̃A�X�y�N�g��
  OrgResX,
  OrgResY       : Word;    // ���X�̉𑜓x
  CurrentShot   : string;  // �\�����̃V���b�g�̃p�X
  DoNotUpdate   : boolean; // �ėp
  DoNotUpdateLV : boolean; // ���X�g�r���[�X�V�}��
  DoNotUpdateSL : boolean; // �T�u���X�g�i�E���p�l���́j�X�V�}��
  CurrentLB     : string;  // ���X�g�{�b�N�X�̓�d�N���b�N�h��
  CurrentMaker  : string;  // ���[�J�[�̓�d�N���b�N�h��
  CurrentYear   : string;  //
  CurrentSound  : string;  //
  CurrentCpu    : string;  //
  CurrentVersion: integer; //
  CurrentAssort : integer; //
  CurrentFilter : integer; //
  CurrentIndex  : integer; //
  EditingIndex  : integer; // �ҏW�Ώۍ��ڂ̃C���f�b�N�X
  Edited        : boolean; // �ҏW�ς݂�
  EditUpdating  : boolean; // EditBox���O������X�V��
  CurrentProfile: Integer; // ���݂̃v���t�@�C��Index
  KeyboardDelay : Word;    // �L�[�{�[�h�f�B���C
  InfoPanel     : boolean; // ���p�l���\��
  PrevDat       : string;  // ���O��dat
  HideMechanical: boolean; // ���J�j�J�����B��
  HideGambling  : boolean; // �M�����u�����B��

  UseAltExe     : boolean; // ShellExec

  // HTTP�_�E�����[�h�f�[�^�p
  ETag_mame32j  : string;  // mame32j.lst �t�@�C���p�� Etag
  ETag_version  : string;  // version.ini �t�@�C���p�� Etag
  ETag_mameinfo : string;  // mameinfo �t�@�C���p�� Etag
  ETag_history  : string;  // mameinfo �t�@�C���p�� Etag


  // �R�}���h�r���[�A�p
  ComViewerVisible    : boolean; // �E�C���h�E�̕\����\��
  ComViewerLeft       : integer; // �E�C���h�E�̍��ʒu
  ComViewerTop        : integer; // �E�C���h�E�̏�ʒu
  ComViewerWidth      : integer; // �E�C���h�E�̕�
  ComViewerHeight     : integer; // �E�C���h�E�̍���
  ComViewerP2         : boolean; // P2�p�̔��]�\�����邩
  ComViewerAutoResize : boolean; // �E�B���h�E�������I�Ƀ��T�C�Y���邩
  ComViewerZentoHan   : boolean; // �S�p�p���𔼊p�ɕϊ����邩
  ComViewerIndex      : integer; // �I�𒆂̃C���f�b�N�X�@���I����-1
  ComViewerAlwaysOnTop: boolean; // ��Ɏ�O�ɕ\��


  // �\�t�g�E�F�A���X�g�p
  SoftwareListVisible     : boolean; // �E�C���h�E�̕\��
  SoftwareListLeft        : integer;
  SoftwareListTop         : integer;
  SoftwareListWidth       : integer;
  SoftwareListHeight      : integer;
  SoftwareListAlwaysOnTop : boolean;
  SoftwareListColumnSort  : integer;
  SoftwareListSearch      : string;
  SoftwareListHistory     : TStringList;

  // �f�[�^�p
  TLMaster      : TList;   // �f�[�^�ێ��pTList
  TLSub         : TList;   // �f�[�^�\�[�g�����pTList
  TLFamily      : TList;   // �t�@�~���ێ��pTList
  TLVersion     : TList;   // �o�[�W�����ʃT�u�Z�b�g
  liNonMech     : TList;   // �񃁃J�j�J���}�X�^�Z�b�g
  liNonGambling : TList;   // ��M�����u���}�X�^�Z�b�g
  liNonMechGamb : TList;   // �񃁃J���M�����u���Z�b�g

  TLManu        : array of TList; // �������������ʃL���b�V��

  SnapBitMap    : TPngImage;  // �X�i�b�v�V���b�g�p�̃o�b�t�@
  StatusBarBuf  : TBitMap;    // �X�e�[�^�X�o�[�p�̃o�b�t�@
  SortHistory   : array [0..5] of Shortint; // �\�[�g�̃q�X�g���[

  HistoryDat    : array of THistoryDat;
  MameInfoDat   : array of TMameInfoDat;
  MameExe       : array of TMameExe;
  ROMTemp       : array of TRomTemp;
  SampleTemp    : array of TSampleTemp;
  ROMDirs       : array of string; // ROM�f�B���N�g��
  SoftDirs      : array of string; // software�f�B���N�g��

  DatVersion    : string; // dat�̃o�[�W����


  // �o�[�W�����p�C���f�b�N�X
  VersionName   : array of string; // �o�[�W������
  Versions      : array of array of String; // �o�[�W�������


  // �N��p�C���f�b�N�X
  YearIndex     : array of array of Integer;


  ZipIndex      : array of integer; // ZIP���̃C���f�b�N�X�J�n
  chars         : Array [ 0..35 ] of string;

  // ���C�ɓ���
  Favorites     : TStringList;
  Favorites2    : TStringList;

  // debug�p
  Tick          : Cardinal;

  //
  LVUpdating : boolean; // ���X�g�r���[�̍X�V��
  LVTerminate: boolean; // ���X�g�r���[�X�V�̒�~

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
// zip���̌����C���f�b�N�X���쐬����
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

  SetLength(ZipIndex,0); // ���Z�b�g
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

// ZIP���ŃC���f�b�N�X����
function FindIndex(const ZipName: String): Integer;
var i, idx: integer;
    st: string;
    asc: integer;
begin

  Result:=-1;
  St:=LowerCase(Copy(Trim(ZipName),0,1));
  asc:= Ord(St[1]);

  Case asc of
    48..57: // ����
    begin
      idx:=asc-48;
    end;
    97..122: // �p��
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
// Mame32j.lst�ǂݍ���

function ReadMame32jlst :boolean;
type
  PMame32j = ^TMame32j;
  TMame32j = record
    Zip   : string;
    DescJ : string;
    Kana  : string;
  end;

  // Zip���ŏ����\�[�g
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

  // �����l�͉p�ꖼ
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
    // �t�@�C���ǂݍ���
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

    // Zip���ŕ��ёւ��i�}�X�^�ɍ��킹��j
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

    // ���������
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
// MAME.lst�ۑ�
procedure SaveMamelst;
var
  F1 : TextFile;
  i  : integer;
begin
    //

  Form1.SaveDialog1.FileName:='mame.lst';
  Form1.SaveDialog1.Filter:='�p��Q�[�����t�@�C��(mame.lst)|mame.lst';
  Form1.SaveDialog1.Title:='mame.lst�o��';

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
// MAME32j.lst�ۑ��@(Shift-JIS)
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
  Form1.SaveDialog1.Filter:='���{��Q�[�����t�@�C��(mame32j.lst, mame32jp.lst)|mame32j.lst;mame32jp.lst';
  Form1.SaveDialog1.Title:='mame32j.lst�o�� (Shift_JIS)';

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
// MAME32j.lst�ۑ��@(UTF-8)

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
  Form1.SaveDialog1.Filter:='���{��Q�[�����t�@�C��(mame32j.lst, mame32jp.lst)|mame32j.lst;mame32jp.lst';
  Form1.SaveDialog1.Title:='mame32j.lst�o�� (UTF-8)';

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
// history.dat�ǂݍ���

procedure ReadHistoryDat;
var
  St,S: String;
  zipname: String;
  i,j,n,m: integer;
  HistoryDir : String;

  // �V����
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


  // UTF8�Œ�
  hisList:=TStringList.Create;

  hisList.LoadFromFile( HistoryDir+'\history.dat', TEncoding.UTF8 );

  SetLength(HistoryDat,25000);
  n:=0;


  entryStarted := false;

  for i := 0 to hisList.Count-1 do
  begin

    ST:=hisList[i];

    // �G���g���O�Ȃ�
    if entryStarted=false then
    begin

      // �G���g������
      if Copy(ST, 1, 4)='$inf' then
      begin
        // zip��
        Delete(ST,1,Pos('=',ST));
        ZipName:=ST;

        // zip�����ǔŁiStringList���j
        StrList:=TStringList.Create;
        m:=CSVSeparate(ZipName,StrList);

        entryStarted := true;
      end;
    end
    else
    begin // �G���g���J�n��Ȃ�

      if (Copy(ST, 1, 4)='$bio') then
      begin
        S:='';
        St:='';
      end
      else
      if (Copy(St,1,4)<>'$end') then // bio�{���p����
      begin
        S:=S+St+#17;
      end
      else
      if (Copy(St,1,4) = '$end') then // bio�{���I��
      begin

      S:=StringReplace(S,#$11,#13#10, [ rfReplaceAll ]);  // �C�O��history.dat�̉��s
      S:=S+#13#10;

      HistoryDat[n].Desc:=S;
      HistoryDat[n].Zips:=StrList;
      for j := 0 to HistoryDat[n].Zips.Count-1 do
      begin
        HistoryDat[n].Zips[j]:= HistoryDat[n].Zips[j].Trim;
      end;

      entryStarted:=false; // �G���g���I��
      inc(n);
      end;
    end;

  end;

  SetLength(HistoryDat,n);

  hisList.Free;


end;

//------------------------------------------------------------------------------
// mameinfo.dat�ǂݍ���

procedure ReadMameInfoDat;
var
  St, S: String;
  i,j,n,m : integer;
  MAMEInfoDir : String;

  // �V�^����
  mameList: TStringList;
  mameFlag: boolean;

  StrList: TStringList;

begin

  SetLength(MameInfoDat,0);

  if (datDir='') and (FileExists('mameinfo.dat')) then
    MAMEInfoDir:='.'     // datdir�����w��̏ꍇ�͖{�̂̏ꏊ
  else
  if FileExists(datDir+'\mameinfo.dat') then
    MAMEInfoDir:=datDir  // datdir����
  else
  if FileExists(langDir+'\ja_jp\mameinfo.dat') then
    MAMEInfoDir:=langDir+'\ja_jp' // langdir\ja_jp����
  else
    exit;


  // �V�^����
  // UTF8�Œ�
  mameList:=TStringList.Create;

  mameList.LoadFromFile( MAMEInfoDir+'\mameinfo.dat', TEncoding.UTF8 );

  SetLength(MameInfoDat,15000);
  n:=0;
  mameFlag:= false;

  for i := 0 to mameList.Count-1 do
  begin

    ST:=mameList[i];

    // �{���O�Ȃ�
    if mameFlag=false then
    begin

      // �G���g������
      if Copy(ST, 1, 4)='$inf' then
      begin
        // zip��
        Delete(ST,1,Pos('=',ST));

        // zip�����ǔŁiStringList���j
        StrList:=TStringList.Create;
        m:=CSVSeparate( ST, StrList );

      end
      else
      if (Copy(ST, 1, 4)='$mam') then
      begin
        mameFlag:=true; // �G���g���J�n
        S:='';
        St:='';
      end;

    end
    else
    if (Copy(St,1,4)<>'$end') then // �G���g���{���p����
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
      mameFlag:=false; // �G���g���I��
      inc(n);
    end;
  end;

  SetLength(MameInfoDat,n);
  mameList.Free;


end;


// -----------------------------------------------------------------------------
// History����
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


// Mameinfo����
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

// history+mameinfo����
procedure FindDat(const idx: integer);
var St,S: String;
begin

  if idx = -1 then Exit;
  
  St:='';
  S:='';

  if PRecordSet(TLMaster[idx]).Master then
  begin
    // �}�X�^�Z�b�g�̂Ƃ���
    St:=GetHistory(PRecordSet(TLMaster[idx]).ZipName);
    St:=trim(St)+#13#10#13#10#13#10+FindMameInfo(PRecordSet(TLMaster[idx]).ZipName);
  end
  else
  begin

    // �N���[���Z�b�g�̂Ƃ���
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


// Snapshot����
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

  // �}�X�^
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

  if (ci<>-1) then  // �q�̃V���b�g��T��
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
  begin // �e�̃V���b�g�T��
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


    // ��3��ʂ�2��� (�M���b�v�Ή�)
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
    else // �c2���
    if (NumScreens=2) and (SnapBitMap.Width=OrgResX) and
       ((SnapBitMap.Height=OrgResY*2) or (SnapBitMap.Height=OrgResY*2 +2)) then
    begin
      CurAspectX:=2;
      CurAspectY:=3;
    end
    else // �t���p�l��
    if (NumScreens=3) and
       (SnapBitMap.Width=512) and
       ( (SnapBitMap.Height=704) or  (SnapBitMap.Height=368)) then
    begin
      CurAspectX:=28;
      CurAspectY:=33;
    end
    else // 2��ʉ��ėp
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

    //  �A�X�y�N�g��ێ��̂Ƃ�
    if KeepAspect then
    begin

      with Form1.Image32 do
      begin

        BeginUpdate;
        try
        
          Src:=TBitmap32.Create;
          Src.Assign(SnapBitMap);

          // �g��k��
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

          // ����
          if (Src.Width<=Width) and (Src.Height<=Height) then
          begin
            DestRect.Right := Src.Width;
            DestRect.Bottom := Src.Height;
          end
          else // �����̏ꍇ
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
// �ݒ�̏�����
procedure InitParams;
begin

  ListFont    := Form1.ListView1.Font;
  HistoryFont := Form1.Memo1.Font;
  ListColor   := clWindow;
  KeepAspect  := True;  // �A�X�y�N�g��ێ�
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
  Form1.Panel12.Visible:=False; // �����p�l��
  Form1.Panel3.Visible:=True; // ���p�l��

  SetCurrentDir(ExeDir);
  JoyRepeat := 45; // �W���C�X�e�B�b�N�̃��s�[�g���x 45ms

  // �L�[�{�[�h�f�B���C�̎擾
  SystemParametersInfo(SPI_GETKEYBOARDDELAY,0,@KeyBoardDelay ,0);
  KeyBoardDelay:=KeyBoardDelay* 250 + 250; // 0�`3��250ms����

  // �ҏW�p�l���͕\�����Ȃ�
  Form1.Splitter1.Visible:=False;
  Form1.Panel7.Visible:=False;

  // ���p�l���\��
  InfoPanel:=True;

  // �������̏����ݒ�
  Form1.actSAllExecute(nil);

  // ���C�ɓ��胊�X�g
  favorites:=TStringList.Create;
  Favorites2 := TStringList.Create;

  // ���J�j�J���B��
  HideMechanical:=False;

  // �M�����u���B��
  HideGambling:=False;

  // �N���֐��̎��
  UseAltExe := False;

  // �R�}���h�r���[�A�p
  ComViewerVisible    :=true; // : boolean; // �E�C���h�E�̕\����\��
  ComViewerTop        :=30;   // : integer; // �E�C���h�E�̏�ʒu
  ComViewerWidth      :=366;  // : integer; // �E�C���h�E�̕�
  ComViewerLeft       :=Screen.Width-ComViewerWidth;//       : integer; // �E�C���h�E�̍��ʒu
  ComViewerHeight     :=600;  //: integer; // �E�C���h�E�̍���

  ComViewerP2         := false; //: boolean; // P2�p�̔��]�\�����邩
  ComViewerAutoResize := false; //: boolean; // �E�B���h�E�������I�Ƀ��T�C�Y���邩
  ComViewerZentoHan   := false; //: boolean; // �S�p�p���𔼊p�ɕϊ����邩
  ComViewerIndex      := -1;    //: integer; // �I�𒆂̃C���f�b�N�X�@���I����-1
  ComViewerAlwaysOnTop:= true;  //: boolean; // ��Ɏ�O�ɕ\��

  // �\�t�g�E�F�A���X�g�p
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

  // HTTP�_�E�����[�h�f�[�^�p
  ETag_mame32j  := '';
  ETag_version  := '';
  Etag_mameinfo := '';
  Etag_history  := '';

end;


//------------------------------------------------------------------------------
// ini�̏�������
procedure SaveIni;
var

  St: string;
  i: integer;

  piOrderArray: Pinteger;
  iOrderArray: array of integer;

  sltIni  :  TStringList;

begin

  // FAV2 �ۑ�
  try
    Favorites2.SaveToFile( 'favorites.ini', TEncoding.UTF8 );
  finally
    //sl.Free;
  end;

  sltIni  :=  TStringList.Create;


  sltIni.Add('### profiles and directories ###');
  sltIni.Add('');

  // �v���t�@�C��
  for i:=0 to Length(MameExe)-1 do
  begin
    sltIni.Add('profile '+ MameExe[i].Title+#9+MameExe[i].ExePath+#9+
                                      MameExe[i].WorkDir+#9+MameExe[i].Option+#9+
                                      BooltoStr(MameExe[i].OptEnbld));
  end;

	// �I�𒆂̃v���t�@�C��
	sltIni.Add('profile_no '+InttoStr(CurrentProfile));

	// �ǉ�ROM�f�B���N�g��
	St:='';
	for i:=0 to Length(ROMDirs)-1 do
	begin
		St:=St+ROMDirs[i]+#9;
	end;
	St:=Trim(St); // ��ԐK��#9��������
	sltIni.Add('rompath '+St);

	// software�f�B���N�g��
	St:='';
	for i:=0 to Length(SoftDirs)-1 do
	begin
		St:=St+SoftDirs[i]+#9;
	end;
	St:=Trim(St); // ��ԐK��#9��������
	sltIni.Add('swpath '+St);


	// Sample�p�X
	sltIni.Add('samplepath '+SamplePath);
	// cfg�p�X
	sltIni.Add('cfg_directory '+cfgDir);
	// nvram�p�X
	sltIni.Add('nvram_directory '+nvramDir);
	// inp�p�X
	sltIni.Add('input_directory '+inpDir);
	// status�p�X
	sltIni.Add('status_directory '+staDir);
	// Snap�p�X
	sltIni.Add('snapshot_directory '+snapDir);
	// Src�p�X
//	sltIni.Add('src_directory '+SrcDir);
	// dat�p�X
	sltIni.Add('dat_directory '+datDir);
	// lang�p�X
	sltIni.Add('lang_directory '+langDir);
	// last�p�X
	sltIni.Add('last_path '+lastPath);
	// last exe�p�X
	sltIni.Add('last_exe_path '+lastExePath);
	// version.ini�p�X
	sltIni.Add('version_ini_directory '+versionDir);

	sltIni.Add('');
	sltIni.Add('### interface ###');
	sltIni.Add('');

	// �f�t�H���g�Q�[��
	sltIni.Add('default_game '+SelZip);

	// �������[�h
	if Trim(Form1.edtSearch.Text)<>'' then
		sltIni.Add('search_word '+ Form1.edtSearch.Text);

	// �������[�h
	case SearchMode of
	  srcAll:  ;
	  srcDesc:    sltIni.Add('search_mode 1');
	  srcZip:     sltIni.Add('search_mode 2');
	  srcSource:  sltIni.Add('search_mode 3');
	  srcMaker:   sltIni.Add('search_mode 4');
	end;

	/// �������
	// ���낢�댟�� CurrentAssort
	if (CurrentAssort<>0) then
	begin
		sltIni.Add( 'search_etc '+ InttoStr(CurrentAssort));
	end;

	// �N��
	if (Form1.cmbYear.ItemIndex<>0) then
	begin
		sltIni.Add('search_yer '+ Form1.cmbYear.Text);
	end;

	// ������
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


  // �\�[�g�q�X�g���[
  St:=InttoStr(SortHistory[0]);
  for i:=1 to Length(SortHistory)-1 do
  begin
    St:=St+','+InttoStr(SortHistory[i]);
  end;
  sltIni.Add('sort_history '+St);

  // �E�B���h�E�̏��
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

  // �ҏW�p�l���̏��
  sltIni.Add('edit_visible '+BooltoStr(Form1.Panel7.Visible));
  // �ҏW�p�l���̍���
  sltIni.Add('edit_hight '+InttoStr(Form1.Panel7.Height));

  // �e�̏��p�l��
  St:=BooltoStr(Form1.Panel3.Visible);
  sltIni.Add('info_panel '+St);

  // ���̏��p�l���̏��
  sltIni.Add('info_visible '+BooltoStr(InfoPanel));

  // �����o�[
  St:=BooltoStr(Form1.Panel12.Visible);
  sltIni.Add('search_bar '+St);

  // �����o�[��
  St:=InttoStr(Form1.Panel13.Width);
  sltIni.Add('search_bar_width '+St);

  // ���J�j�J���B��
  St:=BooltoStr(HideMechanical);
  sltIni.Add('hide_mechanical '+St);

  // �M�����u���B��
  St:=BooltoStr(HideGambling);
  sltIni.Add('hide_gambling '+St);

  // �W���C�X�e�B�b�N
  if UseJoyStick then St:='1' else St:='0';
  sltIni.Add('joystick_in_interface '+St);

  // POV�g�p
  if UsePOV then St:='1' else St:='0';
  sltIni.Add('use_pov '+St);

  // �W���C�X�e�B�b�N�̃��s�[�g���x
  sltIni.Add('joy_repeat '+InttoStr(JoyRepeat));

  // �V���b�g�̃A�X�y�N�g��ێ�
  if KeepAspect then St:='1' else St:='0';
  sltIni.Add('keep_aspect '+St);

  // �V���b�g�̃t�B���^
  sltIni.Add('shot_filter '+InttoStr(CurrentFilter));

  // �V���b�g�����̕�
  sltIni.Add('subpane_width '+InttoStr(Form1.Panel3.Width));

  // �V���b�g�����̍���
  sltIni.Add('shot_height '+InttoStr(Form1.Panel15.Height));


  // �p�ꖼ
  if En then St:='1' else St:='0';
  sltIni.Add('english_desc '+St);

  // ���X�g�t�H���g
  St:='"'+InttoStr(ListFont.Charset)+','+
      InttoStr(ListFont.Color)+','+
      InttoStr(ListFont.Size)+',';

  if fsBold  in ListFont.Style    then St:=St+'1,' else St:=St+'0,';
  if fsItalic  in ListFont.Style    then St:=St+'1,' else St:=St+'0,';
  if fsUnderline in ListFont.Style then St:=St+'1,' else St:=St+'0,';
  if fsStrikeOut in ListFont.Style then St:=St+'1,' else St:=St+'0,';
  St:=St+ListFont.Name+'"';
  sltIni.Add('list_font '+St);


  // ���X�g�w�i�F
  if ListColor<>clWindow then
  begin
    sltIni.Add( 'list_color '+InttoStr(ListColor));
  end;

  // �q�X�g���[�t�H���g
  St:='"'+InttoStr(HistoryFont.Charset)+','+
      InttoStr(HistoryFont.Color)+','+
      InttoStr(HistoryFont.Size)+',';

  if fsBold  in HistoryFont.Style     then St:=St+'1,' else St:=St+'0,';
  if fsItalic  in HistoryFont.Style   then St:=St+'1,' else St:=St+'0,';
  if fsUnderline in HistoryFont.Style then St:=St+'1,' else St:=St+'0,';
  if fsStrikeOut in HistoryFont.Style then St:=St+'1,' else St:=St+'0,';
  St:=St+HistoryFont.Name+'"';
  sltIni.Add('history_font '+St);


  /// ���C�����X�g
  // �J������
  St:=Inttostr(ListView_GetColumnWidth(Form1.ListView1.Handle,0));

  for i:=1 to Form1.ListView1.Columns.Count-1 do
  begin
    St:=St+','+Inttostr(ListView_GetColumnWidth(Form1.ListView1.Handle,i));
  end;
  sltIni.Add('column_widths '+St);

  // �J������
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


  /// �T�u���X�g
  // �J������
  St:=Inttostr(ListView_GetColumnWidth(Form1.ListView2.Handle,0));

  for i:=1 to Form1.ListView2.Columns.Count-1 do
  begin
    St:=St+','+Inttostr(ListView_GetColumnWidth(Form1.ListView2.Handle,i));
  end;
  sltIni.Add('sl_column_widths '+St);

  // �J������
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

  // HTTP�_�E�����[�h�f�[�^�p
  sltIni.Add('ETag_mame32j '+ ETag_mame32j );
  sltIni.Add('ETag_version '+ ETag_version );
  sltIni.Add('ETag_mameinfo '+ ETag_mameinfo );
  sltIni.Add('ETag_history '+ ETag_history );


  // �N���֐�
  sltIni.Add( 'user_alt_exe ' + BooltoStr(UseAltExe) );


  ///  ------------------------------------------
  /// Command.dat�r���[�A
  sltIni.Add('');
  sltIni.Add('### command.dat viewer ###');
  sltIni.Add('');


  // �E�C���h�E�̕\��
  ComViewerVisible := frmCommand.Showing;
  St:=BooltoStr(ComViewerVisible);
  sltIni.Add('cv_visible '+St);

  // �E�C���h�E�����ʒu
  sltIni.Add('cv_top '+ InttoStr(frmCommand.Top));
  sltIni.Add('cv_left '+ InttoStr(frmCommand.Left));
  sltIni.Add('cv_width '+ InttoStr(frmCommand.Width));
  sltIni.Add('cv_height '+ InttoStr(frmCommand.Height));

  // �I�v�V����
  sltIni.Add('cv_p2 '+ BooltoStr( frmCommand.chkP2.Checked  ));
  sltIni.Add('cv_autoresize '+ BooltoStr( frmCommand.chkAutoResize.Checked ));
  sltIni.Add('cv_zentohan '+ BooltoStr( frmCommand.chkZentoHan.Checked ));
  sltIni.Add('cv_alwaysontop '+ BooltoStr( frmCommand.chkAlwaysOnTop.Checked ));
  sltIni.Add('cv_index '+ InttoStr( frmCommand.cmbCommandType.ItemIndex ));


  /// ------------------------------------------
  /// �\�t�g�E�F�A���X�g
  sltIni.Add('');
  sltIni.Add('### Software List ###');
  sltIni.Add('');

  // �E�C���h�E�̕\��
  SoftwareListVisible := frmSoftwareList.Showing;
  St:=BooltoStr(SoftwareListVisible);
  sltIni.Add('sw_visible '+St);

  // �E�C���h�E�����ʒu
  sltIni.Add('sw_top '+ InttoStr(frmSoftwareList.Top));
  sltIni.Add('sw_left '+ InttoStr(frmSoftwareList.Left));
  sltIni.Add('sw_width '+ InttoStr(frmSoftwareList.Width));
  sltIni.Add('sw_height '+ InttoStr(frmSoftwareList.Height));

  sltIni.Add('sw_alwaysontop '+ BooltoStr( frmSoftwareList.chkAlwaysOnTop.Checked ));

  // �J����
  St:=Inttostr(ListView_GetColumnWidth(frmSoftwareList.ListView1.Handle,0));

  for i:=1 to frmSoftwareList.ListView1.Columns.Count-1 do
  begin
    St:=St+','+Inttostr(ListView_GetColumnWidth(frmSoftwareList.ListView1.Handle,i));
  end;
  sltIni.Add('sw_column_widths '+St);

  // �J������
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

  // �\�t�g�E�F�A���X�g�q�X�g���[
  St:='';
  for i:=0 to frmSoftwareList.softlistHistory.Count-1 do
  begin
    St:=St + #9 + frmSoftwareList.softlistHistory[i];
  end;
  sltIni.Add('sw_history '+St);


  //// --------------------------------------------
  /// ROM�̏��
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
    // �s���S��Ԃ̂Ƃ���ini�ۑ����Ȃ�
    if (TLMaster.Count > 0) then
    begin
      sltIni.SaveToFile(ExeDir+ININAME, TEncoding.UTF8);
    end;
  except
    on E: EFCreateError do
    begin
      Application.MessageBox('�ݒ�t�@�C���������ݎ��s�B',APPNAME, MB_ICONSTOP);
      sltIni.Free;
      exit;
    end;
  end;

  sltIni.Free;

end;

// -----------------------------------------------------------------------------
// ini�̓ǂݍ���
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
  // ���C�ɓ���t�@�C���̑���
  if FileExists( 'favorites.ini' ) then begin
    Favorites2 := TStringList.Create;
    try
      Favorites2.LoadFromFile('favorites.ini', TEncoding.UTF8 );

      // ���`�F�b�N
      if favorites2.Count > MAXFAVORITES2 then
      begin
        Application.MessageBox(PWideChar('���C�ɓ���̍ő吔�� '+InttoStr(MAXFAVORITES2)+' ���ł��B'+#13#10+'����ȏ�̍��ڂ͍폜����܂��B'), APPNAME, MB_ICONSTOP );
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


  // �v���t�@�C���ƃp�X
  while ((sltIni[intLine] <> '### interface ###') and (sltIni.Count > intLine)) do
  begin

    St:=sltIni[intLine];

    // �v���t�@�C��
    if Copy(St,1,8)='profile ' then
    begin
      St:=Copy(St,pos(' ',St)+1,Length(St));
      i:=Length(MameExe);
      SetLength(MameExe, i+1);

      StrList:=TStringList.Create;

      // �Â��v���t�@�C���̏ꍇ�AEnabled��True

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
    // �v���t�@�C���ԍ�
    if AnsiStartsStr( 'profile_no', St ) then
    begin
      CurrentProfile:=StrtoInt(Copy(St,pos(' ',St),Length(St)));
    end
    else
    // sample�p�X
    if AnsiStartsStr( 'samplepath', St ) then
    begin
      SamplePath:=Copy(St,pos(' ',St)+1,Length(St));
    end
    else
    // cfg�p�X
    if AnsiStartsStr( 'cfg_directory', St ) then
    begin
      cfgDir:=Copy(St,pos(' ',St)+1,Length(St));
    end
    else
    // nvram�p�X
    if AnsiStartsStr( 'nvram_directory', St ) then
    begin
      nvramDir:=Copy(St,pos(' ',St)+1,Length(St));
    end
    else
    // inp�p�X
    if AnsiStartsStr( 'input_directory', St ) then
    begin
      inpDir:=Copy(St,pos(' ',St)+1,Length(St));
    end
    else
    // status�p�X
    if AnsiStartsStr( 'status_directory', St ) then
    begin
      staDir:=Copy(St,pos(' ',St)+1,Length(St));
    end
    else
    // snap�p�X
    if AnsiStartsStr( 'snapshot_directory', St ) then
    begin
      SnapDir:=Copy(St,pos(' ',St)+1,Length(St));
    end
    else
    // dat�p�X
    if Copy(St,1,14)='dat_directory ' then
    begin
      datDir:=Copy(St,pos(' ',St)+1,Length(St));
    end
    else
    // lang�p�X
    if AnsiStartsStr( 'lang_directory', St ) then
    begin
      langDir:=Copy(St,pos(' ',St)+1,Length(St));
    end
    else
    // version.ini�p�X
    if AnsiStartsStr( 'version_ini_directory', St ) then
    begin
      versionDir:=Copy(St,pos(' ',St)+1,Length(St));
    end
    else
    // �ŏI�g�p�p�X
    if AnsiStartsStr( 'last_path', St ) then
    begin
      lastPath:=Copy(St,pos(' ',St)+1,Length(St));
    end
    else
    // �ŏI�g�p�p�X
    if AnsiStartsStr( 'last_exe_path', St ) then
    begin
      lastExePath:=Copy(St,pos(' ',St)+1,Length(St));
    end
    else
    // ROM�p�X
    if AnsiStartsStr( 'rompath', St ) then
    begin

      St:=Copy(St,pos(' ',St)+1,Length(St));
      if St<>'' then
      begin
        StrList:=TStringList.Create;
        SetLength(ROMDirs, TsvSeparate(St,StrList));

        for i:=0 to Length(ROMDirs)-1 do
        begin
          // �ꉞ�`�F�b�N
          if StrList[i]<>'' then
            ROMDirs[i]:=StrList[i]
          else
            SetLength(ROMDirs,Length(ROMDirs)-1);

        end;
        StrList.Free;
      end;
    end
    else
    // SOFT�p�X
    if AnsiStartsStr( 'swpath', St ) then
    begin

      St:=Copy(St,pos(' ',St)+1,Length(St));
      if St<>'' then
      begin
        StrList:=TStringList.Create;
        SetLength(SoftDirs, TsvSeparate(St,StrList));

        for i:=0 to Length(SoftDirs)-1 do
        begin
          // �ꉞ�`�F�b�N
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


  // �ݒ�
  while ((sltIni[intLine] <> '### game variables ###') and (sltIni.Count  > intLine)) do
  begin

    St:=sltIni[intLine];

    // �A�X�y�N�g��
    if AnsiStartsStr( 'keep_aspect', St ) then
    begin
      KeepAspect:=(StrToInt(Copy(St,pos(' ',St),Length(St)))=1);
    end
    else
    // �V���b�g�̃t�B���^
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

    // �T�u�p�l���̕�
    else
    if AnsiStartsStr( 'subpane_width', St ) then
    begin
      Form1.Panel3.Width:= strtoint(Copy(St,pos(' ',St)+1,Length(St)));
    end
    // �V���b�g�����̍���
    else
    if AnsiStartsStr( 'shot_height', St ) then
    begin
      Form1.Panel15.Height:= strtoint(Copy(St,pos(' ',St)+1,Length(St)));
    end
    else
    // �p�ꖼ
    if AnsiStartsStr( 'english_desc', St ) then
    begin
      En:=(StrToInt(Copy(St,pos(' ',St),Length(St)))=1);
    end
    else
    // �W���C�X�e�B�b�N�̃��s�[�g���x
    if AnsiStartsStr( 'joy_repeat', St ) then
    begin
      JoyRepeat:=StrToInt(Copy(St,pos(' ',St),Length(St)));
      if JoyRepeat<1 then JoyRepeat:=45;
    end
    else
    // �f�t�H���g�Q�[��
    if AnsiStartsStr( 'default_game ', St ) then
    begin
      SelZip:=Copy(St,pos(' ',St)+1,Length(St));
    end
    // �������[�h
    else
    if AnsiStartsStr( 'search_word ', St ) then
    begin
      SearchWord:=Copy(St,pos(' ',St)+1,Length(St));
    end

    /// �������낢��
    else
    if AnsiStartsStr( 'search_etc ', St ) then
    begin
      CurrentAssort:=StrtoInt(Copy(St,pos(' ',St)+1,Length(St)));
      if (Form1.cmbEtc.Items.Count)>CurrentAssort then
        Form1.cmbEtc.ItemIndex:=CurrentAssort
      else
        CurrentAssort:=0;
    end
    // �N��
    else
    if AnsiStartsStr( 'search_yer ', St ) then
    begin
      s:= Copy(St,pos(' ',St)+1,Length(St));
      i:= Form1.cmbYear.Items.IndexOf(s);
      if i<>-1 then
        Form1.cmbYear.ItemIndex:=i;
    end
    // ������
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

    // �������[�h
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
    // �E�B���h�E
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
    // �ҏW�E�B���h�E
    if AnsiStartsStr( 'edit_visible ', St ) then
    begin
      St:=Copy(St,pos(' ',St)+1,Length(St));
      Form1.Panel7.Visible:=StrtoBool(St);
      Form1.Splitter1.Visible:=StrtoBool(St);
    end
    else
    // �ҏW�p�l���̍���
    if AnsiStartsStr( 'edit_hight ', St ) then
    begin
      St:=Copy(St,pos(' ',St)+1,Length(St));
      Form1.Panel7.Height:=StrtoInt(St);
    end
    else
    // �e���p�l���̏��
    if AnsiStartsStr( 'info_panel ', St ) then
    begin
      St:=Copy(St,pos(' ',St)+1,Length(St));
      Form1.Panel3.Visible:=StrtoBool(St);
      Form1.Splitter2.Visible:=Form1.Panel3.Visible;
    end
    else
    // �������p�l���̏��
    if AnsiStartsStr( 'info_visible ', St ) then
    begin
      St:=Copy(St,pos(' ',St)+1,Length(St));
      InfoPanel:=not StrtoBool(St);
      Form1.SpeedButton3.Click;
    end
    else
    // ���J�j�J���B��
    if AnsiStartsStr( 'hide_mechanical ', St ) then
    begin
      St:=Copy(St,pos(' ',St)+1,Length(St));
      HideMechanical:=StrtoBool(St);
    end
    else
    // �M�����u���B��
    if AnsiStartsStr( 'hide_gambling ', St ) then
    begin
      St:=Copy(St,pos(' ',St)+1,Length(St));
      HideGambling:=StrtoBool(St);
    end
    else
    // �\�[�g����
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
    // �����o�[�\��
    if AnsiStartsStr( 'search_bar ', St ) then
    begin
      St:=Copy(St,pos(' ',St)+1,Length(St));
      Form1.Panel12.Visible:=StrtoBool(St);
      if Form1.Panel12.Visible then
        Form1.actVSearchBar.ImageIndex:=32;
    end
    // �����o�[��
    else
    if AnsiStartsStr( 'search_bar_width ', St ) then
    begin
      St:=Copy(St,pos(' ',St)+1,Length(St));
      i:=StrtoInt(St);
      if i > 0 then
        Form1.Panel13.Width:=StrtoInt(St);
    end
    else
    // �W���C�X�e�B�b�N
    if AnsiStartsStr( 'joystick_in_interface ', St ) then
    begin
      St:=Copy(St,pos(' ',St)+1,Length(St));
      UseJoyStick:=StrtoBool(St);
    end
    else
    // POV�g�p
    if AnsiStartsStr( 'use_pov ', St ) then
    begin
      St:=Copy(St,pos(' ',St)+1,Length(St));
      UsePOV:=StrtoBool(St);
    end
    else
    // ���X�g�t�H���g
    if AnsiStartsStr( 'list_color ', St ) then
    begin
      St:=Copy(St,pos(' ',St)+1,Length(St));
      ListColor:=StrtoInt(St);
      Form1.ListView1.Color:=ListColor;
      Form1.ListView2.Color:=ListColor;
    end
    else
    // ���X�g�t�H���g
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
    // �q�X�g���[�t�H���g
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
    // �R������
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
    // �R������
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
    // �T�u���X�g
    // �R������
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
    // �R������
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
    // HTTP�_�E�����[�h�f�[�^
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
    // �N���֐�
    if AnsiStartsStr( 'user_alt_exe ', St ) then
    begin
      St:=Copy(St,pos(' ',St)+1,Length(St));
      UseAltExe:=StrtoBool(St);
    end

    else
    /// -------------------
    ///  �R�}���h�r���[�A�p
    // �E�B���h�E
    if Copy(St,1,11)='cv_visible ' then
    begin
      St:=Copy(St,pos(' ',St)+1,Length(St));
      ComViewerVisible:=StrtoBool(St);
    end
    else
    // ��
    if Copy(St,1,7)='cv_top ' then
    begin
      St:=Copy(St,pos(' ',St)+1,Length(St));
      ComViewerTop:=StrtoInt(St);
    end
    else
    // ��
    if Copy(St,1,8)='cv_left ' then
    begin
      St:=Copy(St,pos(' ',St)+1,Length(St));
      ComViewerLeft:=StrtoInt(St);
    end
    else
    // ��
    if Copy(St,1,9)='cv_width ' then
    begin
      St:=Copy(St,pos(' ',St)+1,Length(St));
      ComViewerWidth:=StrtoInt(St);
    end
    else
    // ����
    if Copy(St,1,10)='cv_height ' then
    begin
      St:=Copy(St,pos(' ',St)+1,Length(St));
      ComViewerHeight:=StrtoInt(St);
    end
    else
    if Copy(St,1,6)='cv_p2 ' then // P2���]
    begin
      St:=Copy(St,pos(' ',St)+1,Length(St));
      ComViewerP2:=StrtoBool(St);
    end
    else
    if Copy(St,1,13)='cv_autoresize' then // �������T�C�Y
    begin
      St:=Copy(St,pos(' ',St)+1,Length(St));
      ComViewerAutoResize:=StrtoBool(St);
    end
    else
    if Copy(St,1,12)='cv_zentohan ' then // �S�p�����p
    begin
      St:=Copy(St,pos(' ',St)+1,Length(St));
      ComViewerZentoHan:=StrtoBool(St);
    end
    else
    if Copy(St,1,15)='cv_alwaysontop ' then // ��Ɏ�O
    begin
      St:=Copy(St,pos(' ',St)+1,Length(St));
      ComViewerAlwaysOnTop:=StrtoBool(St);
    end
    else
    if Copy(St,1,9)='cv_index ' then
    begin
      St:=Copy(St,pos(' ',St)+1,Length(St));
      ComViewerIndex:=StrtoInt(St);
      frmCommand.initialIndex:= ComViewerIndex; // �����I��l
    end
    else
    /// -------------------
    ///  �\�t�g���X�g�p
    // �E�B���h�E
    if Copy(St,1,11)='sw_visible ' then
    begin
      St:=Copy(St,pos(' ',St)+1,Length(St));
      SoftwareListVisible:=StrtoBool(St);
    end
    else
    // ��
    if Copy(St,1,7)='sw_top ' then
    begin
      St:=Copy(St,pos(' ',St)+1,Length(St));
      SoftwareListTop:=StrtoInt(St);
    end
    else
    // ��
    if Copy(St,1,8)='sw_left ' then
    begin
      St:=Copy(St,pos(' ',St)+1,Length(St));
      SoftwareListLeft:=StrtoInt(St);
    end
    else
    // ��
    if Copy(St,1,9)='sw_width ' then
    begin
      St:=Copy(St,pos(' ',St)+1,Length(St));
      SoftwareListWidth:=StrtoInt(St);
    end
    else
    // ����
    if Copy(St,1,10)='sw_height ' then
    begin
      St:=Copy(St,pos(' ',St)+1,Length(St));
      SoftwareListHeight:=StrtoInt(St);
    end
    else
    if Copy(St,1,15)='sw_alwaysontop ' then // ��Ɏ�O
    begin
      St:=Copy(St,pos(' ',St)+1,Length(St));
      SoftwareListAlwaysOnTop:=StrtoBool(St);
    end
    else
    // �R������
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
    // �R������
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

  // �Q�[���X�e�[�^�X�iROM��Sample�j
  i:=0;
  j:=0;
  SetLength(RomTemp, MAXGAMES);
  SetLength(SampleTemp,10000);


  while (sltIni.Count > intLine) do
  begin

    St:=sltIni[intLine];

    if AnsiStartsStr( 'r*', St ) then
    begin
      //SetLength(RomTemp,i+1); //����������ƒx��
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

  // �I�𒆂̃v���t�@�C�������邩�ǂ���
  //
  if CurrentProfile > (Length( MameExe )-1) then
  begin
    CurrentProfile := -1;
  end;



end;


//------------------------------------------------------------------------------
// Version.ini�̓ǂݍ��݂Ɛݒ�
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


  // version.ini�ǂݍ���
  StrList:=TStringList.Create;
  StrList.LoadFromFile(versionDir+'\version.ini', TEncoding.UTF8);
  intLine:=0;


  while ( StrList.Count > intLine ) do
  begin

    St:=StrList[intLine];

    // �t�H���_�ݒ�͖���
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

    // Root Folder������
    if Pos('[ROOT_FOLDER]',ST)<>0 then
    begin

      while ( StrList.Count > intLine ) and (St<>'') do
      begin

        inc(intLine);
        St:=StrList[intLine];

      end;
    end;

    // �o�[�W�������
    while ( StrList.Count > intLine ) do
    begin
      St:=StrList[intLine];
      St:=Trim(St);

      // �o�[�W������
      if AnsiStartsStr( '[', St ) and AnsiEndsStr( ']', St ) then
      begin
        j:=0;
        // �o�[�W�������s���I�h�Ŏn�܂�Ƃ���
        S:=Copy(St,2,Length(St)-2);
        if Copy(S,1,1)='.' then
          S:='0'+S;

        SetLength(VersionName, i+1);
        SetLength(Versions, i+1);
        VersionName[i]:=S;
        inc(i);

      end
      else
      // �Q�[����
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


  // �t�H�[���ɐݒ�
  for i:=0 to Length(VersionName)-1 do
  begin
    Form1.cmbVersion.Items.Add(VersionName[Length(VersionName)-1-i])
  end;

end;



// -----------------------------------------------------------------------------
// CSV����
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
// TSV����
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
// PNG�ǂݍ��݁i�t�@�C������j
function LoadPNGFile(const filename: string; bitmap: TPngImage): boolean;
begin

  result:=true;

  if FileExists(filename)=False then
  begin
    result:=False;
    exit;
  end;

  try
    // PNG �t�@�C����ǂݍ���
    bitmap.LoadFromFile(filename);
  except
    result:=False;
  end;

end;

{// -----------------------------------------------------------------------------
// PNG�ǂݍ��݁isnap.zip����j
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

      // �t�@�C�����ŒT��
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
    // PNG �t�@�C����ǂݍ���
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
      dib.PixelFormat:=nkPf8Bit; // 8bit�Ɍ��F
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
// INP���Ŏw�肳��Ă���Q�[�������擾����
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
// ���ɉ������R�}���h���Z�b�g����
// 95/98�n��NT�n
function SetCommand: Commd;
var
  sysdir: array[0..260] of char;
begin
  GetSystemDirectory(sysdir, 260);
  Result.App   := sysdir +'\CMD.EXE';
  Result.Param := '/C ';
end;

//------------------------------------------------------------------------------
// 8.3�̃p�X��
function LongToShortFileName(const LongName: String):String;
var
  Len: integer;
  LN: string;
begin

  if Trim(LongName)='' then    // ��ƃt�H���_����̏ꍇ
    LN:=ExpandFileName('.')
  else
    LN:=ExpandFileName(LongName);

  Len := GetShortPathName(PChar(LN), PChar(result), 0);
  SetLength(result, len);

  if GetShortPathName(PChar(LN), PChar(result), Len) = 0 then
    Raise EConvertError.Create('�t�@�C����������܂���B');

  result:=Trim(result);
end;

//------------------------------------------------------------------------------
// The�̈ړ�
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
// �G�X�P�[�v��������
function NormalizeString(const Str: string):string;
begin

  Result:=AnsiReplaceText(Str,'&quot;','"');
  Result:=AnsiReplaceText(Result,'&lt;','<');
  Result:=AnsiReplaceText(Result,'&gt;','>');
  Result:=AnsiReplaceText(Result,'&amp;','&');
  
end;

//------------------------------------------------------------------------------
// xml�̗v�f���o��
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
// ���ݔ��ֈړ�
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
//  �f�B���N�g���Ƀt�@�C���������Ă��폜���܂��i�S�~���Ɉڂ��܂��j
// ------------------------------------------------------------------

procedure DeleteDirectory(path: String);
var
  op: TSHFileOpStruct;

begin

  // �����̋�؂蕶���Ȃ��Ńp�X����Ԃ��܂��B
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
// ���΃p�X�����΃p�X�ɕϊ�
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

