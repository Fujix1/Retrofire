unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms, Graphics, StrUtils,
  Dialogs, ComCtrls, StdCtrls, ImgList, Buttons, ExtCtrls, Menus, ShellAPI,
  CommCtrl, Common, Unit2, unitSetting, unitAbout, ActnList, XPStyleActnCtrls, Clipbrd,
  ActnMan, ActnCtrls, ActnMenus, ActnColorMaps, mmSystem, GR32,
  GR32_Image, ToolWin, PngImage, AppEvnts,untUpdateChecker,
  ActnPopup, PlatformDefaultStyleActnCtrls, CategoryButtons, ButtonGroup, Tabs,
  DockTabSet, Unit3, unitScreenShotCleaner, unitCommandViewer,  System.Actions, comobj,
  Vcl.XPMan, System.ImageList, unitFavorites, Vcl.StdStyleActnCtrls,System.IOUtils, unitHttp;

const
  WM_SHOWED = WM_USER + 1;

type
  TForm1 = class(TForm)

    ApplicationEvents1: TApplicationEvents;
    StatusBar1:         TStatusBar;
    ImageList1:         TImageList;
    ImageList2:         TImageList;

    Timer1:             TTimer;
    FontDialog1:        TFontDialog;
    FontDialog2:        TFontDialog;
    SaveDialog1:        TSaveDialog;
    SaveDialog2:        TSaveDialog;
    OpenDialog1:        TOpenDialog;
    ColorDialog1:       TColorDialog;
    ActionManager1:     TActionManager;

    actOSelMAME:        TAction;
    actFReplay:         TAction;
    actBranch1:         TAction;
    actPlay:            TAction;
    actFRec:            TAction;
    actExit:            TAction;
    actListFont:        TAction;
    actListColor:       TAction;
    actHistoryFont:     TAction;
    actKeepAspect:      TAction;
    actDelScreenShot:   TAction;
    actJoySelect:       TAction;
    actSReset:          TAction;
    actSAll:            TAction;
    actSDesc:           TAction;
    actSZip:            TAction;
    actSFocus:          TAction;
    actSSource:         TAction;
    actRRefine:         TAction;
    actDel:             TAction;
    actDelCfg:          TAction;
    actDelAutosave: TAction;
    actDelNv:           TAction;
    actDelAllCfg:       TAction;
    actSearch:          TAction;
    actEng:             TAction;
    actORomDir:         TAction;
    actOUpdateRes:      TAction;
    actFROM:            TAction;
    actFRMarge:         TAction;
    actFRSplit:         TAction;
    actFSaveMame32j:    TAction;
    actFWSaveMame32j:   TAction;
    actFSearchSample:   TAction;
    actVSearchBar:      TAction;
    actVEditor:         TAction;
    actVFLinear:        TAction;
    actVFNearest:       TAction;
    actVFLanczos:       TAction;
    actVFCubic:         TAction;
    actVTakeOut:        TAction;
    actRCPlayEx:        TAction;
    actROpenSrc:        TAction;
    actOAbout:          TAction;
    actOpenTesters:     TAction;
    actBranch:          TAction;

    Action1:            TAction;
    Action2:            TAction;
    actHistory:         TAction;
    actSaveLst:         TAction;
    PopupActionBar1: TPopupActionBar;
    PopupActionBar2: TPopupActionBar;
    PopupActionBar3: TPopupActionBar;
    PopupActionBar4: TPopupActionBar;


    P3: TMenuItem;
    inpL1: TMenuItem;
    S3: TMenuItem;
    O1: TMenuItem;
    esters3: TMenuItem;
    cfg14: TMenuItem;
    nv22: TMenuItem;
    A3: TMenuItem;
    hi33: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N19: TMenuItem;
    N22: TMenuItem;
    N23: TMenuItem;
    N24: TMenuItem;
    N25: TMenuItem;
    N26: TMenuItem;
    N27: TMenuItem;
    N28: TMenuItem;
    N30: TMenuItem;
    N31: TMenuItem;
    N32: TMenuItem;
    N34: TMenuItem;
    N35: TMenuItem;
    A2: TMenuItem;
    D1: TMenuItem;
    T2: TMenuItem;
    M1: TMenuItem;
    ZIP1: TMenuItem;
    N21: TMenuItem;
    P1: TMenuItem;
    inpR2: TMenuItem;
    O2: TMenuItem;
    esters2: TMenuItem;
    cfg12: TMenuItem;
    hi32: TMenuItem;
    nv23: TMenuItem;
    A4: TMenuItem;
    ImageList3: TImageList;

    actShotSizeNormal: TAction;
    actShotSizeLarge: TAction;
    actBranch2: TAction;
    actShotSizeVertical: TAction;
    actSMaker: TAction;

    N320x2401: TMenuItem;
    N480x3601: TMenuItem;
    N240x3201: TMenuItem;
    Panel3: TPanel;
    Panel9: TPanel;
    Bevel5: TBevel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel4: TBevel;
    SpeedButton3: TSpeedButton;
    lblCPU: TLabel;
    lblSound: TLabel;
    lblDisp: TLabel;
    lblSource: TLabel;
    Label6: TLabel;
    Edit1: TEdit;
    edtDescJ: TEdit;
    edtKana: TEdit;
    edtZipName: TEdit;
    edtSource: TEdit;

    memCPU: TMemo;
    memSound: TMemo;
    memDisp: TMemo;
    memSub: TMemo;

    Panel10: TPanel;
    Panel11: TPanel;
    Panel1: TPanel;
    Panel12: TPanel;

    Splitter2: TSplitter;
    Splitter1: TSplitter;
    Panel7: TPanel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Bevel3: TBevel;
    SpeedButton2: TSpeedButton;


    Button1: TButton;
    ListView2: TListView;
    Bevel6: TBevel;
    SpeedButton4: TSpeedButton;
    GridPanel1: TGridPanel;
    cmbEtc: TComboBoxEx;
    cmbYear: TComboBox;
    cmbMaker: TComboBox;
    cmbCPU: TComboBox;
    cmbSound: TComboBox;
    cmbVersion: TComboBox;
    SpeedButton1: TSpeedButton;
    Panel2: TPanel;
    ActionMainMenuBar1: TActionMainMenuBar;
    Panel4: TPanel;
    sbtMAME: TSpeedButton;
    sbtEng: TSpeedButton;
    sbtFilter: TSpeedButton;
    Panel5: TPanel;
    Panel8: TPanel;
    Splitter3: TSplitter;
    Panel13: TPanel;
    ComboBox1: TComboBox;
    Panel14: TPanel;
    edtSearch: TButtonedEdit;
    ListView1: TListView;
    N9: TMenuItem;
    A1: TMenuItem;
    N14: TMenuItem;
    A5: TMenuItem;
    actVHideMechanical: TAction;
    Action3: TAction;
    actFCleanupSnaps: TAction;
    actFHttp: TAction;
    actHistory2: TAction;
    actVHideGambling: TAction;
    Button2: TButton;
    Button3: TButton;
    Action4: TAction;
    actVCommand: TAction;
    Label1: TLabel;
    actOUseAltExe: TAction;
    JoyTimer: TTimer;
    actVInfoPane: TAction;
    actOJoy: TAction;
    actOJoyPOV: TAction;
    Panel6: TPanel;
    Memo1: TMemo;
    Panel15: TPanel;
    Splitter4: TSplitter;
    Image32: TImage32;
    StandardColorMap1: TStandardColorMap;
    actFavOpen: TAction;
    actFavoriteAdd: TAction;
    JoyLaunchTimer: TTimer;
    S1: TMenuItem;
    actFEmma: TAction;
    EMMA1: TMenuItem;
    EMMA2: TMenuItem;
    sbtHTTP: TSpeedButton;


    procedure ListView1SelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure ListView1ColumnClick(Sender: TObject; Column: TListColumn);
    procedure ListView1Data(Sender: TObject; Item: TListItem);
    procedure ListView1KeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure Splitter2Moved(Sender: TObject);
    procedure actBranch1Execute(Sender: TObject);
    procedure edtSearchChange(Sender: TObject);
    procedure edtSearchKeyPress(Sender: TObject; var Key: Char);
    procedure actPlayExecute(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure actListFontExecute(Sender: TObject);
    procedure actHistoryFontExecute(Sender: TObject);
    procedure actHistoryExecute(Sender: TObject);
    procedure actDelScreenShotExecute(Sender: TObject);
    procedure actSearchExecute(Sender: TObject);
    procedure actDelCfgExecute(Sender: TObject);
    procedure actDelNvExecute(Sender: TObject);
    procedure actDelAutosaveExecute(Sender: TObject);
    procedure actDelAllCfgExecute(Sender: TObject);
    procedure actDelUpdate(Sender: TObject);
    procedure actDelExecute(Sender: TObject);
    procedure actEngExecute(Sender: TObject);
    procedure actFRMargeExecute(Sender: TObject);
    procedure actFRSplitExecute(Sender: TObject);
    procedure actFROMExecute(Sender: TObject);
    procedure actFSaveMame32jExecute(Sender: TObject);
    procedure actFRecExecute(Sender: TObject);
    procedure actFRecUpdate(Sender: TObject);
    procedure actFReplayExecute(Sender: TObject);
    procedure actFReplayUpdate(Sender: TObject);
    procedure actFSearchSampleExecute(Sender: TObject);
    procedure actSAllExecute(Sender: TObject);
    procedure actSDescExecute(Sender: TObject);
    procedure actSZipExecute(Sender: TObject);
    procedure actSResetExecute(Sender: TObject);
    procedure actSFocusExecute(Sender: TObject);
    procedure actSSourceExecute(Sender: TObject);
    procedure actRRefineExecute(Sender: TObject);
    procedure actORomDirExecute(Sender: TObject);
    procedure actOSelMAMEExecute(Sender: TObject);
    procedure actOAboutExecute(Sender: TObject);
    procedure actVSearchBarExecute(Sender: TObject);
    procedure actVEditorExecute(Sender: TObject);
    procedure actVEditorUpdate(Sender: TObject);
    procedure actVFNearestExecute(Sender: TObject);
    procedure actVFLinearExecute(Sender: TObject);
    procedure actVFCubicExecute(Sender: TObject);
    procedure actVFLanczosExecute(Sender: TObject);
    procedure actVSearchBarUpdate(Sender: TObject);

    procedure actKeepAspectExecute(Sender: TObject);
    procedure actPlayUpdate(Sender: TObject);
    procedure actROpenSrcExecute(Sender: TObject);
    procedure actROpenSrcUpdate(Sender: TObject);
    procedure actRRefineUpdate(Sender: TObject);
    procedure actRCPlayExExecute(Sender: TObject);
    procedure actOpenTestersUpdate(Sender: TObject);
    procedure actOpenTestersExecute(Sender: TObject);
    procedure actOUpdateResExecute(Sender: TObject);
    procedure actJoySelectExecute(Sender: TObject);
    procedure actJoySelectUpdate(Sender: TObject);
    procedure actListColorExecute(Sender: TObject);
    procedure actVTakeOutUpdate(Sender: TObject);
    procedure actVTakeOutExecute(Sender: TObject);
    procedure actFWSaveMame32jExecute(Sender: TObject);
    procedure PopupRunClick(Sender: TObject);
    procedure PopupRunClickSub(Sender: TObject);

    procedure Timer1Timer(Sender: TObject);
    procedure cmbMakerChange(Sender: TObject);
    procedure cmbYearChange(Sender: TObject);
    procedure cmbCPUChange(Sender: TObject);
    procedure cmbSoundChange(Sender: TObject);
    procedure cmbEtcChange(Sender: TObject);
    procedure Image32Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure StatusBar1DrawPanel(StatusBar: TStatusBar;
      Panel: TStatusPanel; const Rect: TRect);
    procedure StatusBar1Resize(Sender: TObject);
    procedure StatusBar1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    //procedure MMJoy1ButtonUp   (var LocMessage: TMMJoyStick); message MM_JOY1BUTTONUP;
    //procedure MMJoy1Move       (var LocMessage: TMMJoyStick); message MM_JOY1MOVE;

    procedure Splitter1CanResize(Sender: TObject; var NewSize: Integer;
      var Accept: Boolean);
    procedure Edit1DblClick(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure edtDescJEnter(Sender: TObject);
    procedure edtDescJExit(Sender: TObject);
    procedure edtDescJDblClick(Sender: TObject);
    procedure edtKanaDblClick(Sender: TObject);
    procedure edtKanaExit(Sender: TObject);
    procedure edtKanaChange(Sender: TObject);
    procedure edtDescJChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);

    procedure ListView2SelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure PopupActionBar4Popup(Sender: TObject);
    procedure ListView2KeyPress(Sender: TObject; var Key: Char);

    procedure ListView1Exit(Sender: TObject);
    procedure ListView2Exit(Sender: TObject);

    procedure memCPUChange(Sender: TObject);

    procedure SpeedButton3Click(Sender: TObject);
    procedure ApplicationEvents1SettingChange(Sender: TObject;
      Flag: Integer; const Section: String; var Result: Integer);
    procedure FormResize(Sender: TObject);

    procedure Memo1Change(Sender: TObject);

    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Action1Execute(Sender: TObject);
    procedure Action2Execute(Sender: TObject);
    procedure ApplicationEvents1Activate(Sender: TObject);

    procedure ListView1Enter(Sender: TObject);
    procedure cmbVersionChange(Sender: TObject);
    procedure ListView1DataFind(Sender: TObject; Find: TItemFind;
      const FindString: String; const FindPosition: TPoint;
      FindData: Pointer; StartIndex: Integer; Direction: TSearchDirection;
      Wrap: Boolean; var Index: Integer);
    procedure PopupActionBar1Popup(Sender: TObject);
    procedure ListView1AdvancedCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; Stage: TCustomDrawStage;
      var DefaultDraw: Boolean);
    procedure ListView2AdvancedCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; Stage: TCustomDrawStage;
      var DefaultDraw: Boolean);
    procedure actShotSizeNormalExecute(Sender: TObject);
    procedure actShotSizeLargeExecute(Sender: TObject);
    procedure actShotSizeVerticalExecute(Sender: TObject);
    procedure actSMakerExecute(Sender: TObject);
    procedure edtSearchExit(Sender: TObject);
    procedure edtSearchEnter(Sender: TObject);
    procedure actDelScreenShotUpdate(Sender: TObject);
    procedure actSaveLstExecute(Sender: TObject);
    procedure actBranchExecute(Sender: TObject);
    procedure actBranch2Execute(Sender: TObject);
    procedure actFAVAddUpdate(Sender: TObject);
    procedure actFAVManageExecute(Sender: TObject);
//    procedure actFAVAddExecute(Sender: TObject);
    procedure ActionMainMenuBar1Popup(Sender: TObject;
      Item: TCustomActionControl);

    procedure RunFavorite(Sender: TObject);
    procedure RunFavorite2(Sender: TObject);
    procedure Dummy(Sender: TObject); // アクションメニューを活性化させるためのダミー

    procedure actVHideMechanicalExecute(Sender: TObject);
    procedure actVHideMechanicalUpdate(Sender: TObject);
    procedure Action3Execute(Sender: TObject);
    procedure actFCleanupSnapsExecute(Sender: TObject);
    procedure actHistory2Execute(Sender: TObject);
    procedure edtKanaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtKanaKeyPress(Sender: TObject; var Key: Char);
    procedure actVHideGamblingUpdate(Sender: TObject);
    procedure actVHideGamblingExecute(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Action4Execute(Sender: TObject);
    procedure actVCommandExecute(Sender: TObject);
    procedure actVCommandUpdate(Sender: TObject);
    procedure actOUseAltExeUpdate(Sender: TObject);
    procedure actOUseAltExeExecute(Sender: TObject);
    procedure actVInfoPaneUpdate(Sender: TObject);
    procedure actVInfoPaneExecute(Sender: TObject);
    procedure JoyTimerTimer(Sender: TObject);
    procedure actOJoyExecute(Sender: TObject);
    procedure actOJoyPOVUpdate(Sender: TObject);
    procedure actOJoyPOVExecute(Sender: TObject);
    procedure actShotSizeXLExecute(Sender: TObject);
    procedure Splitter4Moved(Sender: TObject);
    procedure actFavOpenExecute(Sender: TObject);
    procedure actFavoriteAddExecute(Sender: TObject);
    procedure actFavoriteAddUpdate(Sender: TObject);
    procedure JoyLaunchTimerTimer(Sender: TObject);
    procedure actFEmmaUpdate(Sender: TObject);
    procedure actFEmmaExecute(Sender: TObject);
    procedure ListView2Data(Sender: TObject; Item: TListItem);
    procedure actFHttpExecute(Sender: TObject);

  private
    { Private 宣言 }

    EngExecuteFlag: Boolean;    // 英語→日本語変更時の終了チェック
    SB_HintText:  String;       // ステータスバーのヒント
//    JoyStick:     TJoyInfo;     // ジョイスティックの情報用
    OldDescJ, OldKana: String;  // ゲーム名編集Undo用
    EditUpdating     : boolean; // ゲーム名編集用
    SubListID  : Integer;       // サブリスト表示中のROMファミリマスタID

    JoyDelayTick: Cardinal;     // ジョイスティックリピート用、押されたTickCount
    JoyStatus: TJoyStickStatus; //

    ChangingMemo: boolean;      // Memo変更中(スクロールバーの変更)

    OriginProc: TWndMethod;     // 元のウィンドウ関数保持用

    bFormActivated: Boolean;        // AfterShow実装用

    procedure SubClassProc(var msg: TMessage); // 置き換えメッセージ処理関数


    procedure ExecuteMAME(const ZipName:String;const ExePath:String;
              const WorkDir:String; const Option:String);

    procedure UpdateStatus;
    procedure UpdateEditPanel(const idx: integer);
    procedure ToggleEditPanel(const Flag: boolean);
    procedure ShowGameInfo(const idx: integer);
    procedure SetFormTitle;

    procedure SetListViewColumnSortMark(LV: TListView; ColumnIndex: Integer);  // カラムソート矢印設定

    procedure CreateFavoriteActions;
    procedure RunMAME(const ZipName: string);
    function  FormatHistory( Item: PRecordSet ) : String;
    function  FormatSets( Item: PRecordSet ) : String;

  public
    { Public 宣言 }
    procedure ReadYearDat;
    procedure UpdateListView;
    function  LoadResource: Integer;
    function  ReadLang: boolean;
  end;

var
  Form1: TForm1;

//  FavActions: Array[0..MAXFAVORITES] of TAction;

  FavActions2: Array of TAction;

  function AscSort(Item1, Item2: Pointer): Integer;


implementation

{$R *.dfm}


//------------------------------------------------------------------------------
// お気に入り用アクション生成と追加
procedure TForm1.CreateFavoriteActions;
//var
//  i: integer;
//  AC  : TActionClientItem;
begin
  {
  // お気に入りがあるメニュー位置
  AC:=Form1.ActionManager1.ActionBars[5].Items[3];

  // アクション生成と追加
  for i:= 0 to MAXFAVORITES-1 do
  begin
    FavActions[i] := TAction.Create(Self);
    FavActions[i].Caption := '-';
    FavActions[i].Tag := i;
    FavActions[i].Visible:= True;
    FavActions[i].OnExecute:= RunFavorite;
    FavActions[i].ActionList:= ActionManager1;
    FavActions[i].ImageIndex:= 0;

    AC.Items.Add.Action := FavActions[i];
  end;
   }
end;


//------------------------------------------------------------------------------
// サブクラスウィンドウ関数
procedure TForm1.SubClassProc(var msg: TMessage);
begin

  OriginProc(msg); //本来のウィンドウ関数を実行

  // カラムサイズ変更完了時処理
  case msg.Msg of
    WM_NOTIFY:
    begin

      if TWMNotify(msg).NMHdr^.Code = HDN_ENDTRACK then
        SetListViewColumnSortMark( ListView1, SortHistory[0] );

    end;
  end;

end;

//------------------------------------------------------------------------------
// カラム矢印設定
procedure TForm1.SetListViewColumnSortMark(LV: TListView; ColumnIndex: Integer);
var i: Integer;
  hColumn: THandle;
  hi: THDItem;
  IsAsc: boolean;
begin

  // 向き
  IsAsc := ( ColumnIndex > 0);
  ColumnIndex:= abs(ColumnIndex)-1;

  //ヘッダのハンドル取得
  hColumn := SendMessage(LV.Handle, LVM_GETHEADER, 0, 0);
  for i := 0 to ListView1.Columns.Count-1 do
  begin
    hi.Mask := HDI_FORMAT;
    SendMessage(hColumn, HDM_GETITEMA, i, LPARAM(@hi));

    hi.fmt := hi.fmt and not HDF_SORTUP;
    hi.fmt := hi.fmt and not HDF_SORTDOWN;

    if i = ColumnIndex then
    begin
      if IsAsc then
        hi.fmt := hi.fmt or HDF_SORTUP
      else
        hi.fmt := hi.fmt or HDF_SORTDOWN;
    end;

    SendMessage(hColumn, HDM_SETITEMA, i, LPARAM(@hi));
  end;

end;

//------------------------------------------------------------------------------
procedure TForm1.ListView1AdvancedCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; Stage: TCustomDrawStage;
  var DefaultDraw: Boolean);
begin
  if Item.Index mod 2 = 1 then
    ListView1.Canvas.Brush.Color:=$f5f5f5;
end;

procedure TForm1.ListView1ColumnClick(Sender: TObject;
  Column: TListColumn);
var
  i,j : integer;
  st : string;
  ColIndex: integer;
  //
begin

  if ListView1.Items.Count=0 then exit;

  // 本当のカラムインデックスを調べる(バグ対応ごり押し版)
  st:=Column.Caption;

  if st='ゲーム名' then ColIndex:=0
  else if st='ZIP名' then ColIndex:=1
  else if st='メーカー' then ColIndex:=2
  else if st='年度' then ColIndex:=3
  else if st='マスタ' then ColIndex:=4
  else if st='ドライバ' then ColIndex:=5
  else ColIndex:=0;

  // コラム履歴を調べる
  if Abs(SortHistory[0]) = ColIndex+1 then
  begin // 先頭にある場合逆順にする
    SortHistory[0]:=-SortHistory[0];
  end
  else
  begin

    // 後ろから持って来る
    for i:=0 to Length(SortHistory)-1 do
    begin
      if Abs(SortHistory[i])=ColIndex+1 then
      begin
        for j:=i downto 1 do
        begin
          SortHistory[j]:=SortHistory[j-1];
        end;
        SortHistory[0]:=ColIndex+1;
        break;
      end;
    end;

  end;

  // カラム矢印
  SetListViewColumnSortMark( ListView1, SortHistory[0] );
  TLSub.Sort(TListSortCompare(@AscSort));

  // 選択してた行を探すのと、ソート後のIndexの張り直し
  for i:=0 to TLMaster.Count-1 do
  begin
    if PRecordset(TLSub[i]).ZipName=SelZip then
      break;
  end;

  ListView1.Items.BeginUpdate;
  ListView1.Invalidate;
  ListView1.Items[i].MakeVisible(True);
  ListView1.ItemIndex:=i;
  ListView1.Selected.Focused:=True;
  ListView1.Items.EndUpdate;

end;

function AscSort(Item1, Item2: Pointer): Integer;
var i:integer;
begin

  Result:=0;

  if (Item1 = nil) or (Item2 = nil) then Exit;

  for i:=0 to Length(SortHistory)-1 do
  begin

    case SortHistory[i] of
      1,-1:
      begin
        if En then
          Result := CompareText(PRecordset(Item1).DescE, PRecordset(Item2).DescE)
        else
          Result := AnsiCompareText( PRecordset(Item1).Kana, PRecordset(Item2).Kana);
          //Result := AnsiStrIComp ( PChar(PRecordset(Item1).Kana), PChar( PRecordset(Item2).Kana));
          //Result := CompareText(PRecordset(Item1).Kana, PRecordset(Item2).Kana)
          //Result := StrComp(PChar(PRecordset(Item1).Kana), PChar(PRecordset(Item2).Kana));

      end;

      2,-2: Result := CompareText(PRecordset(Item1).ZipName, PRecordset(Item2).ZipName);
      3,-3: Result := AnsiCompareText(PRecordset(Item1).Maker,   PRecordset(Item2).Maker);
      4,-4: Result := CompareText(PRecordset(Item1).Year,    PRecordset(Item2).Year);
      5,-5: Result := CompareText(PRecordset(Item1).CloneOf, PRecordset(Item2).CloneOf);
      6,-6: Result := CompareText(PRecordset(Item1).Source,  PRecordset(Item2).Source);
    else
      Result:=0;
    end;
    
    if SortHistory[i] < 0 then Result:=-Result;
    
    if Result<>0 then break;

  end;

end;

//--------------------------------------------------------------------------------
// Reconstruct data and redraw ListView
// Temporal
procedure TForm1.UpdateListView;
var i,idx: integer;
    Maker, Year, CPU, Sound: String;
    Version: Integer;
    SW: String;
    j: integer;

begin

  if DoNotUpdateLV then exit;

  if LVUpdating then exit; // 安全弁

  LVUpdating:=True;

  SW      :=WideLowerCase(Trim(edtSearch.Text));
  Maker   :=cmbMaker.Text;
  Year    :=cmbYear.Text;
  Sound   :=cmbSound.Text;
  CPU     :=cmbCPU.Text;
  Version :=cmbVersion.ItemIndex;

  // バージョンは常に逆
  if Version<>0 then
  begin
    Version:=cmbVersion.Items.Count-Version;
  end;


  if Maker = TEXT_MAKER_ALL then Maker:='';
  if Year  = TEXT_YEAR_ALL then Year:='';
  if Sound = TEXT_SOUND_ALL then Sound:='';
  if CPU   = TEXT_CPU_ALL then CPU:='';

  // テキスト検索が無いとき
  if SW='' then
  begin

    TLSub.Clear;
    TLSub.Capacity:=TLMaster.Count;


    // 条件0
    // バージョン別
    TLVersion.Clear;
    if Version<>0 then
    begin

      for j:=0 to Length(Versions[Version-1])-1 do
      begin

        idx:=FindIndex(Versions[Version-1][j]);

        if idx<>-1 then
        begin

          // ギャンブル隠す場合
          if HideGambling then
          begin

            if (Copy( PRecordSet(TLMaster[idx]).Source, 0, 4) <>'mpu2') and
               (Copy( PRecordSet(TLMaster[idx]).Source, 0, 4) <>'mpu3') and
               (Copy( PRecordSet(TLMaster[idx]).Source, 0, 4) <>'mpu4') and
               (Copy( PRecordSet(TLMaster[idx]).Source, 0, 4) <>'mpu5') and
               (Copy( PRecordSet(TLMaster[idx]).Source, 0, 3) <>'bfm') and
               (Copy( PRecordSet(TLMaster[idx]).Source, 0, 3) <>'jpm') and
               (Copy( PRecordSet(TLMaster[idx]).Source, 0, 6) <>'maygay') and
               (Copy( PRecordSet(TLMaster[idx]).Source, 0, 6) <>'ecoinf') and
               (Copy( PRecordSet(TLMaster[idx]).Source, 0, 6) <>'aristm') and
               (Copy( PRecordSet(TLMaster[idx]).Source, 0, 6) <>'spoker') and
               (PRecordSet(TLMaster[idx]).Source<>'proconn.cpp') and
               (PRecordSet(TLMaster[idx]).Source<>'astrafr.cpp') and
               (PRecordSet(TLMaster[idx]).Source<>'pluto5.cpp') and
               (PRecordSet(TLMaster[idx]).Source<>'acesp.cpp') and
               (PRecordSet(TLMaster[idx]).Source<>'bingo.cpp') and
               (PRecordSet(TLMaster[idx]).Source<>'sumt8035.cpp') and
               (PRecordSet(TLMaster[idx]).Source<>'astropc.cpp') and
               (PRecordSet(TLMaster[idx]).Source<>'atronic.cpp') and
               (PRecordSet(TLMaster[idx]).Source<>'cupidon.cpp') and
               (PRecordSet(TLMaster[idx]).Source<>'extrema.c') and
               (PRecordSet(TLMaster[idx]).Source<>'gamtor.c') and
               (PRecordSet(TLMaster[idx]).Source<>'wms.c') and
               (PRecordSet(TLMaster[idx]).Source<>'konendev.c') and
               (PRecordSet(TLMaster[idx]).Source<>'belatra.c') and
               (PRecordSet(TLMaster[idx]).Source<>'kongambl.c') and
               (PRecordSet(TLMaster[idx]).Source<>'highvdeo.cpp')
            then
            begin

                // メカニカルも隠す場合
                if HideMechanical then
                begin
                  if PRecordset(TLMaster[idx]).isMechanical=false then
                    TLVersion.Add(TLMaster[idx]);
                end
                else
                  TLVersion.Add(TLMaster[idx]);
            end;

          end
          else
          // メカニカルだけ隠す場合
          if HideMechanical then
          begin
            if PRecordset(TLMaster[idx]).isMechanical=false then
              TLVersion.Add(TLMaster[idx]);

          end
          else
            TLVersion.Add(TLMaster[idx]);

        end;

      end;
    end
    else   // バージョン別じゃないとき
    begin

      // メカニカルとギャンブル隠すときの場合分け
      if HideMechanical and HideGambling then
        TLVersion.Assign(liNonMechGamb)
      else if HideMechanical then
        TLVersion.Assign(liNonMech)
      else if HideGambling then
        TLVersion.Assign(liNonGambling)
      else
        TLVersion.Assign(TLMaster);
    end;

    /// 条件１
    // 速度優先コード
    case cmbEtc.ItemIndex of
      1:begin // マスタセット
          for i:=0 to TLVersion.Count-1 do
          begin
            if PRecordset(TLVersion[i]).Master then
              TLSub.Add(TLVersion[i]);
          end;
        end;
      2:begin // クローンセット
          for i:=0 to TLVersion.Count-1 do
          begin
            if not PRecordset(TLVersion[i]).Master then
              TLSub.Add(TLVersion[i]);
          end;
        end;
      3:begin // 動作可能
          for i:=0 to TLVersion.Count-1 do
          begin
            if PRecordset(TLVersion[i]).Status then
              TLSub.Add(TLVersion[i]);
          end;
        end;
      4:begin // 動作不可
          for i:=0 to TLVersion.Count-1 do
          begin
            if not PRecordset(TLVersion[i]).Status then
              TLSub.Add(TLVersion[i]);
          end;
        end;
      5:begin // CHDゲーム
          for i:=0 to TLVersion.Count-1 do
          begin
            if PRecordset(TLVersion[i]).CHD<>'' then
              TLSub.Add(TLVersion[i]);
          end;
        end;
      6:begin // ベクター
          for i:=0 to TLVersion.Count-1 do
          begin
            if PRecordset(TLVersion[i]).Vector then
              TLSub.Add(TLVersion[i]);
          end;
        end;
      7:begin // 光線銃
          for i:=0 to TLVersion.Count-1 do
          begin
            if PRecordset(TLVersion[i]).LightGun then
              TLSub.Add(TLVersion[i]);
          end;
        end;

      8:begin // LD
          for i:=0 to TLVersion.Count-1 do
          begin
            if PRecordset(TLVersion[i]).LD then
              TLSub.Add(TLVersion[i]);
          end;
        end;

      9:begin // 縦画面
          for i:=0 to TLVersion.Count-1 do
          begin
            if PRecordset(TLVersion[i]).Vertical then
              TLSub.Add(TLVersion[i]);
          end;
        end;
      10:begin // 横画面
          for i:=0 to TLVersion.Count-1 do
          begin
            if not PRecordset(TLVersion[i]).Vertical then
              TLSub.Add(TLVersion[i]);
          end;
        end;
      11:begin // アナログ操作
          for i:=0 to TLVersion.Count-1 do
          begin
            if PRecordset(TLVersion[i]).Analog then
              TLSub.Add(TLVersion[i]);
          end;
        end;
      12:begin // サンプル
          for i:=0 to TLVersion.Count-1 do
          begin
            if PRecordset(TLVersion[i]).SampleOf<>'' then
              TLSub.Add(TLVersion[i]);
          end;
        end;
      13:begin // サンプル不明
          for i:=0 to TLVersion.Count-1 do
          begin
            if (PRecordset(TLVersion[i]).Sample=False) and
               (PRecordset(TLVersion[i]).SampleOf<>'') then
              TLSub.Add(TLVersion[i]);
          end;
        end;
      14:begin // ROM有り
          for i:=0 to TLVersion.Count-1 do
          begin
            if PRecordset(TLVersion[i]).ROM then
              TLSub.Add(TLVersion[i]);
          end;
        end;
      15:begin // ROM無し
          for i:=0 to TLVersion.Count-1 do
          begin
            if not PRecordset(TLVersion[i]).ROM then
              TLSub.Add(TLVersion[i]);
          end;
        end;
      else
        begin
          TLSub.Assign(TLVersion);
        end;
    end;

    // 年
    if Year<>'' then
    begin
      i:=0;
      while (i<=TLSub.Count-1) do
      begin
        if Year<>PRecordset(TLSub[i]).Year then
          TLSub.Delete(i)
        else
          Inc(i);
      end;
    end;


    // メーカー
    if Maker<>'' then
    begin
      i:=0;
      while (i<=TLSub.Count-1) do
      begin
        if Pos(Maker,PRecordset(TLSub[i]).Maker)=0 then
          TLSub.Delete(i)
        else
          Inc(i);
      end;
    end;

    // CPU
    if CPU<>'' then
    begin
      i:=0;
      while (i<=TLSub.Count-1) do
      begin
        if Pos(CPU,PRecordset(TLSub[i]).CPUs)<>0 then
          Inc(i)
        else
          TLSub.Delete(i);
      end;
    end;

    // Sound
    if Sound<>'' then
    begin
      i:=0;
      while (i<=TLSub.Count-1) do
      begin
        if Pos(Sound,PRecordset(TLSub[i]).Sounds)=0 then
          TLSub.Delete(i)
        else
          Inc(i);
      end;
    end;


  end
  else
  // テキスト検索のとき
  begin

    TLSub.Clear;
    TLSub.Capacity:=TLMaster.Count;

    TLVersion.Clear;// 一時用

    // メカニカルとギャンブル隠すときの場合分け
    if HideMechanical and HideGambling then
      TLVersion.Assign(liNonMechGamb)
    else if HideMechanical then
      TLVersion.Assign(liNonMech)
    else if HideGambling then
      TLVersion.Assign(liNonGambling)
    else
      TLVersion.Assign(TLMaster);

    // 検索処理
    if En then
    begin

      for i:=0 to TLVersion.Count-1 do
      begin

        if SW='' then
          TLSub.Add(TLVersion[i])
        else
        begin

          Case SearchMode of
          srcZip:
            if (Pos(SW, LowerCase(PRecordset(TLVersion[i]).ZipName))<>0) then
              TLSub.Add(TLVersion[i]);
          srcDesc:
            if (Pos(SW, LowerCase(PRecordset(TLVersion[i]).DescE))<>0) then
              TLSub.Add(TLVersion[i]);
          srcSource:
            if (Pos(SW, LowerCase(PRecordset(TLVersion[i]).Source))<>0) then
              TLSub.Add(TLVersion[i]);
          srcMaker:
            if (Pos(SW, LowerCase(PRecordset(TLVersion[i]).Maker))<>0) then
              TLSub.Add(TLVersion[i]);
          else
            if (Pos(SW, LowerCase(PRecordset(TLVersion[i]).ZipName))<>0) or
               (Pos(SW, LowerCase(PRecordset(TLVersion[i]).DescE))<>0) or
               (Pos(SW, LowerCase(PRecordset(TLVersion[i]).Source))<>0) or
               (Pos(SW, LowerCase(PRecordset(TLVersion[i]).Maker))<>0) then
            TLSub.Add(TLVersion[i]);
          end;

        end;
      end;

    end
    else
    begin

      if SW='' then
      begin
        TLSub.Assign(TLVersion);
      end
      else
      begin

        for i:=0 to TLVersion.Count-1 do
        begin

          Case SearchMode of
          srcZip:
            if (Pos(SW, LowerCase(PRecordset(TLVersion[i]).ZipName))<>0) then
              TLSub.Add(TLVersion[i]);
          srcDesc:
            if (Pos(SW, LowerCase(PRecordset(TLVersion[i]).DescJ))<>0) then
              TLSub.Add(TLVersion[i]);
          srcSource:
            if (Pos(SW, LowerCase(PRecordset(TLVersion[i]).Source))<>0) then
              TLSub.Add(TLVersion[i]);
          srcMaker:
            if (Pos(SW, LowerCase(PRecordset(TLVersion[i]).Maker))<>0) then
              TLSub.Add(TLVersion[i]);
          else
            if (Pos(SW, LowerCase(PRecordset(TLVersion[i]).ZipName))<>0) or
               (Pos(SW, LowerCase(PRecordset(TLVersion[i]).DescJ))<>0) or
               (Pos(SW, LowerCase(PRecordset(TLVersion[i]).Source))<>0) or
               (Pos(SW, LowerCase(PRecordset(TLVersion[i]).Maker))<>0) then
            TLSub.Add(TLVersion[i]);
          end;
        end;
      end;

    end;



  end;

  TLSub.Capacity:=TLSub.Count;

  TLSub.Sort(@AscSort);

  // Update ListView
  ListView1.Items.Count:=TLSub.Count;

  // 選択項目の復帰
  idx:=-1;
  for i:=0 to TLSub.Count-1 do
  begin
    if PRecordset(TLSub[i]).ZipName=SelZip then
    begin
      idx:=i;
      break;
    end;
  end;

  if TLSub.Count<>0 then  // リスト項目があるとき
  begin
    if idx=-1 then // マッチ無し
    begin
      ListView1.Selected:=nil; // have to be called to bring selected event
      ListView1.Items[0].Focused:=True;
      ListView1.Items[0].Selected:=True;
      ListView1.ItemFocused.MakeVisible(True);
    end
    else
    begin
      DoNotUpdate:=True;
      ListView1.Selected:=nil;
      ListView1.Items[idx].Focused:=True;
      ListView1.Items[idx].Selected:=True;
      ListView1.ItemFocused.MakeVisible(True);
      DoNotUpdate:=False;
    end;
  end
  else   // リスト項目が無いとき
  begin

    ListView1.Update;
    Memo1.Text:='';
    CurrentIndex:=-1;
    UpdateStatus;

    // 編集パネル
    ToggleEditPanel(False);
    
    // アクションの管理
    //actDelScreenShot.Enabled:=False;
    actRRefine.Hint:='';
    actROpenSrc.Hint:='';

    Image32.Bitmap.Delete;
    CurrentShot:='';
    SelZip:='';
    SelDriver:='';

    // ステータスバー
    StatusBar1.Panels[3].Text:='';

    // コマンドビューを空に
    frmCommand.LoadCommand('','');

  end;

  // これを有効にするとドロップダウンリストの更新に追いつかない
  //Application.ProcessMessages;

  ListView1.Repaint;
  ListView2.Repaint;
  StatusBar1.Panels[0].Text:=InttoStr(TLSub.Count)+ ' / ' + InttoStr(TLMaster.Count);

  LVUpdating:=False;

end;


//----------------------------------------------------------------------
// .resファイルの読み込み
//
function TForm1.LoadResource: Integer;
var
  i,n: integer;
  NewItem : PRecordset;
  StrList: TStringList;
  Flag:boolean;
  ResList: TStringList;
  Error : Boolean;
  ms: cardinal;
begin
//

  Result:=0;
  TLMaster.Clear;     // レコードのリセット
  liNonMech.Clear;    // 非メカニカルのリセット
  liNonGambling.Clear;
  liNonMechGamb.Clear;

  Error := false; // エラーフラグ

  StrList:=TStringList.Create;
  Flag:=False;

  ResList:=TStringList.Create;
  n:=0;

  try

    ResList.LoadFromFile(ExeDir+RESNAME, TEncoding.UTF8 );

    if ResList.Count < 10 then
    begin
      Result:=2;
      Exit;
    end;

    // resのバージョンチェック
    if AnsiPos('ResVersion=',ResList[n])=0 then
    begin
      Result:=1;
      Exit;
    end;

    if StrtoInt(Copy(ResList[n],Pos('=',ResList[n])+1,3)) < LATESTRESVER then
    begin
      Result:=1;
      Exit;
    end;
    Inc(n);

    // バージョン
    if AnsiPos('version=',ResList[n])<>0 then
    begin
      DatVersion:=Copy(ResList[n],pos('version=',ResList[n])+8,Length(ResList[n]));
      Flag:=True;
    end;

    // メーカー名
    if Flag then Inc(n);
    cmbMaker.Items.Clear;
    cmbMaker.Items.Add(TEXT_MAKER_ALL);
    cmbMaker.ItemIndex:=0;
    for i:=0 to TsvSeparate(ResList[n],StrList)-1 do
    begin
      cmbMaker.Items.Add(StrList[i]);
    end;

    // メーカー名検索キャッシュの初期化
    SetLength(TLManu, 0);
    SetLength(TLManu, cmbMaker.Items.Count);
    Inc(n);

    // 年代リスト
    cmbYear.Items.Clear;
    cmbYear.Items.Add(TEXT_YEAR_ALL);
    cmbYear.ItemIndex:=0;
    for i:=0 to TsvSeparate(ResList[n],StrList)-1 do
    begin
      cmbYear.Items.Add(StrList[i]);
    end;
    Inc(n);

    // CPUs
    cmbCPU.Items.Clear;
    cmbCPU.Items.Add(TEXT_CPU_ALL);
    cmbCPU.ItemIndex:=0;
    for i:=0 to TsvSeparate(ResList[n],StrList)-1 do
    begin
      cmbCPU.Items.Add(StrList[i]);
    end;
    Inc(n);

    // Sounds
    cmbSound.Items.Clear;
    cmbSound.Items.Add(TEXT_SOUND_ALL);
    cmbSound.ItemIndex:=0;
    for i:=0 to TsvSeparate(Trim(ResList[n]),StrList)-1 do
    begin
      cmbSound.Items.Add(StrList[i]);
    end;
    Inc(n);

    // Version
    cmbVersion.Items.Clear;
    cmbVersion.Items.Add(TEXT_VERSION_ALL);
    cmbVersion.ItemIndex:=0;
    SetVersionINI;
    ////

    // その他
    cmbEtc.ItemIndex:=0;

//  ms := GetTickCount;
    // ゲーム情報
    i:=0;

    try
      while (n < ResList.Count) do
      begin

        TsvSeparate(ResList[n], StrList);
        Inc(n);

        New(NewItem);
        NewItem.Flag:=False;

        With NewItem^ do
        begin
          ZipName     := StrList[0];              // Zip名
          DescE       := StrList[1];              // 英語名
          DescJ       := StrList[1];              // 日本語名（仮)
          Kana        := StrList[1];              // かな（仮)
          Maker       := StrList[2];              // メーカー
          Year        := StrList[3];              // 製造年
          CloneOf     := StrList[4];              // マスタ名
          RomOf       := StrList[5];              // RomOf
          SampleOf    := StrList[6];              // サンプル名
          ID          := i;                       // インデックス (サブリストから参照)
          MasterID    := StrtoInt(StrList[7]);    // マスタのID
          Master      := StrtoBool(StrList[8]);   // マスタ
          Vector      := StrtoBool(StrList[9]);   // ベクター
          Lightgun    := StrtoBool(StrList[10]);  // 光線銃
          Analog      := StrtoBool(StrList[11]);  // アナログ入力
          Status      := StrtoBool(StrList[12]);  // ステータス
          Vertical    := StrtoBool(StrList[13]);  // 縦画面
          Channels    := StrtoInt(StrList[14]);   // サウンドチャンネル数
          CPUs        := StrList[15];             // CPUs
          Sounds      := StrList[16];             // Sound chips
          Screens     := StrList[17];             // 画面情報
          NumScreens  := StrtoInt(StrList[18]);   // 画面数
          Palettesize := StrtoInt(StrList[19]);   // 色数
          ResX        := StrtoInt(StrList[20]);   // 解像度X
          ResY        := StrtoInt(StrList[21]);   // 解像度Y

          Color       := TGameStatus(StrtoInt(StrList[22]));
                                                  // 色ステータス
          Sound       := TGameStatus(StrtoInt(StrList[23]));
                                                  // 音ステータス
          GFX         := TGameStatus(StrtoInt(StrList[24]));
                                                  // GFXステータス
          Protect     := TGameStatus(StrtoInt(StrList[25]));
                                                  // プロテクトステータス
          Cocktail    := TGameStatus(StrtoInt(StrList[26]));
                                                  // カクテルテータス
          SaveState   := TGameStatus(StrtoInt(StrList[27]));
                                                  // セーブステート
          Source      := StrList[28];             // ソース
          CHD         := StrList[29];             // CHD
          CHDOnly     := StrtoBool(StrList[30]);  // CHDのみ
          CHDMerge    := StrtoBool(StrList[31]);  // CHDマージ
          LD          := StrtoBool(StrList[32]);  // レーザーディスク
          CHDNoDump   := StrtoBool(StrList[33]);  // CHD未吸い出し
          isMechanical:= StrtoBool(StrList[34]);  // メカニカルゲーム
          ROM         := False;                   // ROM有りか
          Sample      := False;                   // Sample有りか

        end;

        TLMaster.Add(NewItem);
        Inc(i);
      end;
    except
     // Result:=2;
    end;

  finally
    FreeAndNil(StrList);
    FreeAndNil(ResList);
  end;


  // 非メカニカルセットの抽出
  for i := 0 to TLMaster.Count - 1 do
  begin

    if not PRecordSet(TLMaster[i]).isMechanical then
      liNonMech.Add(TLMaster[i]);

  end;

  // 非ギャンブルセットの抽出
  for i := 0 to TLMaster.Count - 1 do
  begin

    if
       ( AnsiStartsStr( 'mpu2', PRecordSet(TLMaster[i]).Source ) <> TRUE ) and
       ( AnsiStartsStr( 'mpu3', PRecordSet(TLMaster[i]).Source ) <> TRUE ) and
       ( AnsiStartsStr( 'mpu4', PRecordSet(TLMaster[i]).Source ) <> TRUE ) and
       ( AnsiStartsStr( 'mpu5', PRecordSet(TLMaster[i]).Source ) <> TRUE ) and
       ( AnsiStartsStr( 'bfm', PRecordSet(TLMaster[i]).Source ) <> TRUE ) and
       ( AnsiStartsStr( 'jpm', PRecordSet(TLMaster[i]).Source ) <> TRUE ) and
       ( AnsiStartsStr( 'mayga', PRecordSet(TLMaster[i]).Source ) <> TRUE ) and
       ( AnsiStartsStr( 'ecoinf', PRecordSet(TLMaster[i]).Source ) <> TRUE ) and
       ( AnsiStartsStr( 'itgamb', PRecordSet(TLMaster[i]).Source ) <> TRUE ) and
       ( AnsiStartsStr( 'aristm', PRecordSet(TLMaster[i]).Source ) <> TRUE ) and
       ( AnsiStartsStr( 'magic', PRecordSet(TLMaster[i]).Source ) <> TRUE ) and
       ( AnsiStartsStr( 'procon', PRecordSet(TLMaster[i]).Source ) <> TRUE ) and
       ( AnsiStartsStr( 'astrafr', PRecordSet(TLMaster[i]).Source ) <> TRUE ) and
       ( AnsiStartsStr( 'pluto', PRecordSet(TLMaster[i]).Source ) <> TRUE ) and
       ( AnsiStartsStr( 'acesp', PRecordSet(TLMaster[i]).Source ) <> TRUE ) and
       ( AnsiStartsStr( 'bingo', PRecordSet(TLMaster[i]).Source ) <> TRUE ) and
       ( AnsiStartsStr( 'sumt', PRecordSet(TLMaster[i]).Source ) <> TRUE ) and
       ( AnsiStartsStr( 'astropc', PRecordSet(TLMaster[i]).Source ) <> TRUE ) and
       ( AnsiStartsStr( 'atronic', PRecordSet(TLMaster[i]).Source ) <> TRUE ) and
       ( AnsiStartsStr( 'cupi', PRecordSet(TLMaster[i]).Source ) <> TRUE ) and
       ( AnsiStartsStr( 'extre', PRecordSet(TLMaster[i]).Source ) <> TRUE ) and
       ( AnsiStartsStr( 'gamto', PRecordSet(TLMaster[i]).Source ) <> TRUE ) and
       ( AnsiStartsStr( 'wms', PRecordSet(TLMaster[i]).Source ) <> TRUE ) and
       ( AnsiStartsStr( 'konend', PRecordSet(TLMaster[i]).Source ) <> TRUE ) and
       ( AnsiStartsStr( 'belatr', PRecordSet(TLMaster[i]).Source ) <> TRUE ) and
       ( AnsiStartsStr( 'procon', PRecordSet(TLMaster[i]).Source ) <> TRUE ) and
       ( AnsiStartsStr( 'bingor', PRecordSet(TLMaster[i]).Source ) <> TRUE ) and
       ( AnsiStartsStr( 'calo', PRecordSet(TLMaster[i]).Source ) <> TRUE ) and
       ( AnsiStartsStr( 'funw', PRecordSet(TLMaster[i]).Source ) <> TRUE ) and
       ( AnsiStartsStr( 'global', PRecordSet(TLMaster[i]).Source ) <> TRUE ) and
       ( AnsiStartsStr( 'goldnp', PRecordSet(TLMaster[i]).Source ) <> TRUE ) and
       ( AnsiStartsStr( 'goldst', PRecordSet(TLMaster[i]).Source ) <> TRUE ) and
       ( AnsiStartsStr( 'norau', PRecordSet(TLMaster[i]).Source ) <> TRUE ) and
       ( AnsiStartsStr( 'peplus', PRecordSet(TLMaster[i]).Source ) <> TRUE ) and
       ( AnsiStartsStr( '4ros', PRecordSet(TLMaster[i]).Source ) <> TRUE ) and
       ( AnsiStartsStr( '5clo', PRecordSet(TLMaster[i]).Source ) <> TRUE ) and
       ( AnsiStartsStr( 'astrc', PRecordSet(TLMaster[i]).Source ) <> TRUE ) and
       ( AnsiStartsStr( 'chsup', PRecordSet(TLMaster[i]).Source ) <> TRUE ) and
       ( AnsiStartsStr( 'sigmab5', PRecordSet(TLMaster[i]).Source ) <> TRUE ) and
       ( AnsiStartsStr( 'adp', PRecordSet(TLMaster[i]).Source ) <> TRUE ) and
       ( AnsiStartsStr( 'statriv', PRecordSet(TLMaster[i]).Source ) <> TRUE ) and
       ( AnsiStartsStr( 'blitz68', PRecordSet(TLMaster[i]).Source ) <> TRUE ) and
       ( AnsiStartsStr( 'coinmst', PRecordSet(TLMaster[i]).Source ) <> TRUE ) and
       (Pos('poker',PRecordSet(TLMaster[i]).Source)=0)

    then
      liNonGambling.Add(TLMaster[i]);

  end;

  // 非ギャンブル＋非メカニカルセットの抽出
  for i := 0 to liNonGambling.Count - 1 do
  begin

    if not PRecordSet(liNonGambling[i]).isMechanical then
      liNonMechGamb.Add(liNonGambling[i]);
  end;
//showmessage(inttostr(GetTickCount-ms));
end;


/// ----------------------------------------------------------------------------
// mame32plusのlangファイルから読み込み
function TForm1.ReadLang: boolean;

type
  PMMOList = ^TMMOList;
  TMMOList = record
    DescE : string;
    DescJ : string;  //
    Kana  : string;  //
    Flag  : boolean; //
  end;
  
  // langの並び順に合わせる(英語名でソート)
  function LangSort(Item1, Item2: Pointer): Integer;
  begin
    Result := CompareText(PRecordset(Item1).DescE, PRecordset(Item2).DescE);
  end;

  // MMO(英語名でソート)
  function MMOSort(Item1, Item2: Pointer): Integer;
  begin
    Result := CompareText(PMMOList(Item1).DescE, PMMOList(Item2).DescE);
  end;


var
  NewItem:    PMMOList;
  mmo,mmo2:   TMemoryStream;
  StrStream:  TStringStream;
  Buf1,Buf2:  Byte;
  ST,DescE:   String;
  MMOList:    TList; // .mmoから読み込んだファイル用
  i,j,k:      Integer;
  p:          PByte;
  Flag:       boolean;
  TLSort:     TList;  // ソート用

begin

  Result:=True;

  //
  if FileExists(langDir+'\ja_JP\lst.mmo') and
     FileExists(langDir+'\ja_JP\readings.mmo') then
  else
  begin
    Result:=False;
    exit;
  end;

  mmo := TMemoryStream.Create;
  mmo2:= TMemoryStream.Create;
  StrStream := TStringStream.Create(St);
  MMOList:=TList.Create;
  
  try
    try
      mmo.LoadFromFile(langDir+'\ja_JP\lst.mmo');

      repeat
        mmo.Seek(2,soFromCurrent);
        mmo.Read(Buf1,1);
        mmo.Read(Buf2,1);
      until ((Buf2<>0) and (buf1>13)); // 完全じゃないかも

      mmo.Seek(-4,soFromCurrent);

      mmo2.CopyFrom(mmo,mmo.Size-mmo.Position);

      FreeAndNil(mmo);

      mmo2.Seek(0,soFromBeginning);
      p := mmo2.Memory;

      j:=0;
      Flag:=False;
      New(NewItem);
      for i:=0 to mmo2.Size-1 do
      begin

        if (p^)=0 then // Null文字
        begin
          StrStream.CopyFrom(mmo2,i-j);

          if Flag=False then
          begin
            Flag := True;
            New(NewItem);
            NewItem.DescE:= StrStream.DataString;
            NewItem.Kana := StrStream.DataString;
            NewItem.Flag := False;
          end
          else
          begin
            Flag:= False;
            NewItem.DescJ:= StrStream.DataString;
            MMOList.Add(NewItem);
          end;

          StrStream.Size:=0;

          mmo2.Seek(1,soFromCurrent);
          j:=i+1;

        end;
        Inc(p);

      end;

    except
      Application.MessageBox('lst.mmoの読み込み時にエラーが起きました。'+CRLF2+
                              'たぶんmmoファイル側に問題があります。 ',
                              'エラー', MB_ICONERROR + MB_OK);
      Result:=False;
    end;

  finally
    mmo2.Free;
    StrStream.Free;
  end;

  if Result=False then
    exit;

  MMOList.Sort(@MMOSort);

  ///

  mmo := TMemoryStream.Create;
  mmo2:= TMemoryStream.Create;
  StrStream:= TStringStream.Create(St);

  try

    try
      mmo.LoadFromFile(langDir+'\ja_JP\readings.mmo');

      repeat
        mmo.Seek(2,soFromCurrent);
        mmo.Read(Buf1,1);
        mmo.Read(Buf2,1);
      until ((Buf2<>0) and (buf1>13)); // 完全じゃないかも

      mmo.Seek(-4,soFromCurrent);

      mmo2.CopyFrom(mmo,mmo.Size-mmo.Position);
      mmo.Free;

      mmo2.Seek(0,soFromBeginning);
      p := mmo2.Memory;

      j:=0;
      Flag:=False;

      for i:=0 to mmo2.Size-1 do
      begin

        if (p^)=0 then // Null文字
        begin
          StrStream.CopyFrom(mmo2,i-j);

          if Flag=False then
          begin
            Flag:=True;
            DescE:=StrStream.DataString;
          end
          else
          begin
            Flag:=False;
            for k:=0 to MMOList.Count-1 do
            begin

              if (PMMOList(MMOList[k]).Flag=False) and
                 (PMMOList(MMOList[k]).DescE=DescE) then
              begin
                PMMOList(MMOList[k]).Kana:=StrStream.DataString;
                PMMOList(MMOList[k]).Flag:=True;

                break;
              end;

            end;
          end;

          StrStream.Size:=0;

          mmo2.Seek(1,soFromCurrent);
          j:=i+1;

        end;
        Inc(p);

      end;

    except
      Application.MessageBox('readings.mmoの読み込み時にエラーが起きました。'+
                             CRLF2+'たぶんファイルに問題があります。  ',
                             'エラー', MB_ICONERROR + MB_OK);
      Result:=False;
    end;

  finally
    mmo2.Free;
    StrStream.Free;
  end;

  if Result=False then
    exit;

  // 割り当て
  j:=0;
  TLSort:=TList.Create;
  for i:=0 to TLMaster.Count-1 do
    TLSort.Add(TLMaster[i]);

  TLSort.Sort(@LangSort);

  for k:=0 to MMOList.Count-1 do
  begin

    for i:=j to TLSort.Count-1 do
    begin

      if (PRecordSet(TLSort[i]).Flag=False) and
         (PRecordSet(TLSort[i]).DescE=PMMOList(MMOList[k]).DescE) then
      begin
        PRecordSet(TLSort[i]).DescJ:=PMMOList(MMOList[k]).DescJ;
        PRecordSet(TLSort[i]).Kana:= PMMOList(MMOList[k]).Kana;
        PRecordSet(TLSort[i]).Flag:= True;
        j:=i+1;
        Break;
      end;
    end;

  end;

  // メモリ解放
  for i:=0 to MMOList.Count-1 do
    dispose(PMMOList(MMOList[i]));

  TLSort.Free;
  MMOList.Free;

end;

//----------------------------------------------------------------------
procedure TForm1.ReadYearDat;
var
  F1: TextFile;
  ST,game,year: String;
  i: integer;
  YearDir : String;
begin


  if FileExists(datDir+'\year.dat') then
    YearDir:=datDir+'\year.dat'
  else
  if ( FileExists( ExeDir+'year.dat') ) then
    YearDir:= ExeDir+'\year.dat'
  else
    exit;

  AssignFile(F1, YearDir );

  try
    Reset(F1);

    while not Eof(F1) do
    begin
      ReadLn(F1,ST);
      game:=Copy(St,1,Pos(#9,ST)-1);
      year:=Copy(St,Pos(#9,ST)+1,4);

      for i:=0 to TLMaster.Count-1 do
      begin
        if PRecordset(TLMaster[i]).ZipName=game then
        begin
          PRecordset(TLMaster[i]).Year:=year;
          break;
        end;
      end;

    end;
    
  finally
    CloseFile(F1);
  end;
  
end;


//----------------------------------------------------------------------
procedure TForm1.FormCreate(Sender: TObject);
//  myJoyCaps: TJoyCaps;

begin

  Application.Title := APPNAME;
  Application.HintPause := 250;
  Application.HintHidePause := 5000;

  // コントロールのウィンドウ関数を入れ替え
  // 元のウィンドウ関数は保存しておく
  OriginProc :=ListView1.WindowProc;
  ListView1.WindowProc :=SubClassProc;


  // スナップ用バッファ
  SnapBitMap:=TPngImage.Create;

  // ステータスバー用バッファ
  StatusBarBuf:=TBitMap.Create;
  StatusBarBuf.Width:= SB_LRMARGIN * 2 +
                       (32 + SB_MARKDISTANCE + SB_ITEMDISTANCE) *
                       SB_NUMOFITEMS -
                       SB_ITEMDISTANCE+3;

  StatusBarBuf.Height:=16;
  StatusBar1.Panels[4].Width:=StatusBarBuf.Width;

  // TrackList用TList
  TLMaster:=TList.Create;
  TLSub:=TList.Create;
  TLFamily:=TList.Create;
  TLVersion:=TList.Create;
  liNonMech:=TList.Create;
  liNonGambling:=TList.Create;
  liNonMechGamb:=TList.Create;


  // サブリストに表示中のROMセット
  SubListID:=-1;


  Edit1.Font.Style:=[fsBold];
  edtZipName.Font.Style:=[fsBold];
  Memo1.DoubleBuffered:=True;
  Edit1.DoubleBuffered:=True;
  edtDescJ.DoubleBuffered:=True;
  edtKana.DoubleBuffered:=True;
  Panel7.DoubleBuffered:=True;
  Panel9.DoubleBuffered:=True;
  memCPU.DoubleBuffered:=True;
  memSound.DoubleBuffered:=True;
  memDisp.DoubleBuffered:=True;
  edtSource.DoubleBuffered:=True;
  edtZipname.DoubleBuffered:=True;
  Panel12.DoubleBuffered:=True;
  Panel10.DoubleBuffered:=True;

  // お気に入り用アクション設定
  CreateFavoriteActions;

  // 最初にフォームがSHOWした後をActiveで確認するためのフラグ
  bFormActivated := False;

end;

//-----------------------------------------------------------------------
procedure TForm1.FormDestroy(Sender: TObject);
var i: integer;
begin

  // TListの各項目のメモリ解放
  for i:= 0 to TLMaster.count-1 do dispose(PRecordset(TLMaster[i]));

  TLMaster.Clear;
  FreeAndNil(TLMaster);
  FreeAndNil(TLSub);
  FreeAndNil(SnapBitMap);
  FreeAndNil(StatusBarBuf);
  FreeandNil(favorites);
  FreeAndNil(liNonMech);
  FreeAndNil(liNonGambling);
  FreeAndNil(liNonMechGamb);

end;

//----------------------------------------------------------------------
procedure TForm1.ListView1SelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
var
  i:integer;
  SelMasterID:Integer;
begin

  // 選択時に更新前と更新後の2回呼び出されるので前の方をはじく
  // 更新前: Selected=False, Item.Index=不定
  // 更新後: Selected=True,  Item.Index=あり
  if not Selected then exit;

  if DoNotUpdate and (booting=false) then exit;

  //
  if TLSub.Count=0 then exit;

  // 空リストのとき
  if (ListView1.Items.Count=0) or (Item.Index=-1) then
  begin

    CurrentIndex:=-1;
    Memo1.Text:='';
    CurrentShot:='';

    // アクションの管理
    //actDelScreenShot.Enabled:=False;

    // 編集ウィンドウ
    ToggleEditPanel(False);

    // ゲームステータスアイコン
    UpdateStatus;

    // コマンドビュー
    frmCommand.LoadCommand('','');

  end
  else
  // リスト項目あり
  begin

    CurrentIndex:=StrtoInt(Item.SubItems[5]);

    // コマンドビュー
    frmCommand.LoadCommand(
            PRecordSet(TLMaster[ CurrentIndex ]).ZipName,
            PRecordSet(TLMaster[ PRecordSet(TLMaster[currentIndex]).MasterID ]).ZipName );



    // 編集ウィンドウに情報表示
    EditingIndex:=CurrentIndex; // 編集対象のインデックス
    UpdateEditPanel(EditingIndex);

    // ステータスバー
    StatusBar1.Panels[3].Text:=PRecordSet(TLMaster[CurrentIndex]).DescE;


    /// サブリストにROMファミリ表示
    //  サブリストの更新が必要な場合
    SelMasterID:=PRecordSet(TLMaster[CurrentIndex]).MasterID;

    if SubListID <> SelMasterID then
    begin

      SubListID:=SelMasterID;

      TLFamily.Clear;

      // マスタ追加
      TLFamily.Add(TLMaster[SubListID]);

      // クローン追加
      for i:=0 to TLMaster.Count-1 do
      begin

        if (PRecordSet(TLMaster[i]).MasterID=SubListID) and
           (PRecordSet(TLMaster[i]).Master=False) then
        begin
          TLFamily.Add(TLMaster[i]);
        end;

      end;
      ListView2.Items.Count:=TLFamily.Count;
      ListView2.Repaint;

    end;



    // サブリスト項目の選択
    DoNotUpdateSL:=True;
    for i:=0 to ListView2.Items.Count-1 do
    begin
      if StrtoInt(ListView2.Items[i].SubItems[6])=CurrentIndex then
      begin
        ListView2.ItemIndex:=i;
        break;
      end;
    end;

    if ListView2.ItemIndex<>-1 then
    begin
      ListView2.Items[ListView2.ItemIndex].Focused:=True;
      ListView2.ItemFocused.Selected:=True;
      ListView2.ItemFocused.MakeVisible(False);
    end;

    DoNotUpdateSL:=False;


    // 表示中ならすぐ更新をかける
    if Panel7.Visible then
      Panel7.Update;

    // ゲームステータスアイコン表示
    UpdateStatus;

    // dat
    FindDat(CurrentIndex);

    // スナップショット
    ShowSnapshot(CurrentIndex);

    // アクション
    if ListView1.ItemIndex<>-1 then
    begin
      //actDelScreenShot.Enabled:=(CurrentShot<>'');
      actRRefine.Hint:=PRecordSet(TLSub[ListView1.ItemIndex]).Source;
      actROpenSrc.Hint:=PRecordSet(TLSub[ListView1.ItemIndex]).Source;
    end;

  end;

  SelZip:=Item.SubItems[0]; // 選択中のZip名
  SelDriver:=Item.SubItems[4]; // 選択中のドライバ名
  actDelUpdate(nil);

end;

//-------------------------------------------------------------------------
// MAME起動処理
procedure TForm1.RunMAME(const ZipName: string);
  var opt: string;
begin

  opt:= '';
  if MameExe[CurrentProfile].OptEnbld then
    opt:= MameExe[CurrentProfile].Option;

  ExecuteMAME(ZipName,
              MameExe[CurrentProfile].ExePath,
              MameExe[CurrentProfile].WorkDir,
              opt);
end;

//-----------------------------------------------------------------------
// MAME起動実処理
procedure TForm1.ExecuteMAME(
            const ZipName: String;
            const ExePath: String;
            const WorkDir: String;
            const Option: String );

  var WshShell , oExec : Variant;
  var Exe, Work: String;
begin

  if FileExists(ExePath)=False then exit;

  if UseAltExe=FALSE then
  begin
   ShellExecute(Form1.handle,'open',
               PChar(LongToShortFileName(ExePath)),
               PChar(ZipName + ' '+ Option),
               PChar(LongToShortFileName(WorkDir)),
               SW_SHOWDEFAULT );
  end
  else
  begin
    try
      WshShell := CreateOleObject('WScript.Shell');
      //oExec := WshShell.run('%comspec% /k "'+ExePath+'" '+ZipName+' '+Option);
      Exe := ExePath;
      Work:= WorkDir;
      
      if not System.IOUtils.TPath.IsPathRooted( Exe ) then
      begin
        Exe := RelToAbs( Exe, ExeDir );
      end;

      if not System.IOUtils.TPath.IsPathRooted( Work ) then
      begin
        Work := RelToAbs( Work, ExeDir );
      end;
      
      WshShell.CurrentDirectory := Work;      
      oExec := WshShell.run('%comspec% /k "'+ Exe+'" '+ZipName+' '+Option);

    except
      showMessage('起動失敗。通常の起動方法を試してください。');
    end;
  end;

end;

//------------------------------------------------------------------------------
procedure TForm1.ListView1Data(Sender: TObject; Item: TListItem);
var i : integer;
begin

  i:=Item.Index;

  if En then
    Item.Caption:=PRecordSet(TLSub[i]).DescE
  else
    Item.Caption:=PRecordSet(TLSub[i]).DescJ;
  Item.SubItems.Add(PRecordSet(TLSub[i]).ZipName);
  Item.Subitems.Add(PRecordSet(TLSub[i]).Maker);
  Item.Subitems.Add(PRecordSet(TLSub[i]).Year);
  Item.Subitems.Add(PRecordSet(TLSub[i]).CloneOf);
  Item.Subitems.Add(PRecordSet(TLSub[i]).Source);
  Item.Subitems.Add(InttoStr(PRecordSet(TLSub[i]).ID));

  // アイコン
  if PRecordSet(TLSub[i]).Status then
    if PRecordSet(TLSub[i]).Master then
      Item.ImageIndex:=0
    else
      Item.ImageIndex:=1
  else
    if PRecordSet(TLSub[i]).Master then
      Item.ImageIndex:=2
    else
      Item.ImageIndex:=3;

  if PRecordset(TLSub[i]).ROM=False then
    Item.ImageIndex:=Item.ImageIndex+4;

end;

procedure TForm1.ListView1KeyPress(Sender: TObject; var Key: Char);
begin

  if Key=#13 then
  begin
    Key:=#0;
    actPlayExecute(nil);
    exit;
  end;

end;

// データ検索要求（キー入力あり）
procedure TForm1.FormShow(Sender: TObject);
var
  i,j,k: Integer;
  result: Integer;
  // debug用
  ms          : Cardinal;
begin

  Tick:=GetTickCount;

  Form1.Caption:=APPNAME;

  // ExeDir
  ExeDir:=ExtractFilePath(Application.ExeName);

  // 設定初期化
  InitParams;


  // resファイル名の変更に伴う更新
  if ( FileExists(ExeDir+'retrofire.res') AND ( NOT FileExists( ExeDir+RESNAME ))) then
  begin
    try
      RenameFile(ExeDir+'retrofire.res', ExeDir+RESNAME);
    except
      PostMessage(Handle,WM_CLOSE,0,0);
       Application.MessageBox('データファイルのファイル名が変更されました。  '+CRLF2+
      '「retrofire.res」ファイルを「'+RESNAME+'」に改名して再起動して下さい。  ',APPNAME, MB_ICONWARNING  + MB_OK);
      Application.Terminate;
      exit;
    end;
  end;


  // 初回起動時の処理
  if FileExists(ExeDir+RESNAME)=False then
  begin

    if Form2.ShowModal=mrCancel then
    begin
      PostMessage(Handle,WM_CLOSE,0,0);
      Application.Terminate;
      Exit;
    end;

  end;

  result:= LoadResource;

  // リソース読み込み
  if result=1 then
  begin
    Application.MessageBox('データファイルのフォーマットが更新されました。  '+CRLF2+
          '「'+RESNAME+'」を削除して、再起動して下さい。  ',APPNAME, MB_ICONWARNING  + MB_OK);
    PostMessage(Handle,WM_CLOSE,0,0);
    Application.Terminate;
    Exit;
  end
  else
  if result=2 then
  begin
    Application.MessageBox('データファイル「'+RESNAME+'」の読み込みに失敗しました。  '+CRLF2+
          '（MAMEの更新に伴い、LIST.XMLフォーマットが変更された可能性があります。）',APPNAME, MB_ICONWARNING  + MB_OK);
    PostMessage(Handle,WM_CLOSE,0,0);
    Application.Terminate;
    Exit;
  end;


  // ini読み込み
  LoadIni;

  /// コマンドビューア
  // 一応値をチェック
  // 右端を超えていないか
  frmCommand.LoadCommandDat(datDir);
  if ComViewerLeft < Screen.Width-10 then
    frmCommand.Left := ComViewerLeft
  else
    frmCommand.Left := Screen.Width-ComViewerWidth;

  // 下端を超えていないか
  if ComViewerTop < Screen.WorkAreaRect.Bottom-10 then
    frmCommand.Top := ComViewerTop
  else
    frmCommand.Top := Form1.Top;

  frmCommand.Width := ComViewerWidth;
  frmCommand.Height := ComViewerHeight;

  // 常に手前とか
  frmCommand.chkP2.Checked          := ComViewerP2;
  frmCommand.chkZentoHan.Checked    := ComViewerZentoHan;
  frmCommand.chkAlwaysOnTop.Checked := ComViewerAlwaysOnTop;
  frmCommand.chkAutoResize.Checked  := ComViewerAutoResize;

  frmCommand.initialIndex := ComViewerIndex; // ドロップダウン初期値（候補）

  //
  if En then
  begin
    ActEng.ImageIndex:=2;
    ActionManager1.ActionBars[0].Items[1].Items[3].ImageIndex:=2;
  end
  else
  begin
    ActEng.ImageIndex:=1;
    ActionManager1.ActionBars[0].Items[1].Items[3].ImageIndex:=1;
  end;

  // バグ対応
  ActionMainMenuBar1.UseSystemFont:=True;

  //
  Booting:=True;


  // アスペクト比を保持のチェック
  actKeepAspect.Checked := KeepAspect;


  ReadMame32jlst;
  ReadHistoryDat;
  ReadMameInfoDat;

  CreateZipIndex; // ZIP名のインデックス作成


  ms:=gettickcount;

  // ROMステータス
  k:=0;

  for i:=0 to TLMaster.Count-1 do
  begin
    for j:=k to Length(ROMTemp)-1 do
    begin
      if PRecordset(TLMaster[i]).ZipName=ROMTemp[j].Zip then
      begin
        PRecordset(TLMaster[i]).ROM:=ROMTemp[j].ROM;
        k:=j+1;
        break;
      end;
    end;
  end;
  SetLength(ROMTemp,0);

  // Sampleステータス
  k:=0;
  for i:=0 to TLMaster.Count-1 do
  begin
    for j:=k to Length(SampleTemp)-1 do
    begin
      if PRecordset(TLMaster[i]).ZipName=SampleTemp[j].Zip then
      begin
        PRecordset(TLMaster[i]).Sample:=SampleTemp[j].Sample;
        k:=j+1;
        break;
      end;
    end;
  end;
  SetLength(SampleTemp,0);

  //showmessage(inttostr( gettickcount- ms )) ;

  // カラムソート矢印設定
  SetListViewColumnSortMark( ListView1, SortHistory[0] );
  CurrentMaker:= Form1.cmbMaker.Text;



  // プロファイル設定
  // ドロップダウンリスト
  for i:=0 to Length(MameExe)-1 do
  begin
    ComboBox1.Items.Add(MameExe[i].Title);
  end;

  if Length(MameExe)<>0 then
  begin

    if (CurrentProfile=-1) or (CurrentProfile > Length(MameExe)-1) then
    begin
      ComboBox1.ItemIndex:=0;
    end
    else
    begin
      ComboBox1.ItemIndex:=CurrentProfile;
    end;

    ComboBox1.OnChange(nil);

  end;

  edtSearch.Text:=SearchWord;
  UpdateListView;
  ListView1.SetFocus;

  //
  sbtMAME.Caption   := '';
  sbtEng.Caption    := '';
  sbtFilter.Caption := '';
  sbtHTTP.Caption   := '';


  // コマンドビューア表示
  if ComViewerVisible then
    frmCommand.Show;


  // 起動
  Booting:=False;

//  ShowMessage( inttostr(GetTickCount-Tick)+' ms' );

end;

procedure TForm1.Splitter2Moved(Sender: TObject);
begin

  SetSnap;
  Memo1Change(Nil);

end;


procedure TForm1.Splitter4Moved(Sender: TObject);
begin
  SetSnap;
  Memo1Change(Nil);
end;

//------------------------------------------------------------------------------
// ポップアップ時のプロファイル追加
procedure TForm1.PopupActionBar1Popup(Sender: TObject);
var
  NewItem: TMenuItem;
  i: Integer;

begin

  PopupActionBar1.Items[2].Clear;
  for i:=0 to Length(MameExe)-1 do
  begin
    NewItem := TMenuItem.Create(PopupActionBar1);
    NewItem.Caption:=MameExe[i].Title;
    NewItem.OnClick:=PopupRunClick;
    NewItem.Checked:=(i=CurrentProfile);
    NewItem.Enabled:=(FileExists(MameExe[i].ExePath)) and
         ((DirectoryExists(MameExe[i].WorkDir) or
          (MameExe[i].WorkDir='')));
    PopupActionBar1.Items[2].Add(NewItem);
  end;

end;

procedure TForm1.PopupActionBar4Popup(Sender: TObject);
var
  NewItem: TMenuItem;
  i: Integer;
begin

  PopupActionBar4.Items[2].Clear;
  for i:=0 to Length(MameExe)-1 do
  begin
    NewItem := TMenuItem.Create(PopupActionBar4);
    NewItem.Caption:=MameExe[i].Title;
    NewItem.OnClick:=PopupRunClickSub;
    NewItem.Checked:=(i=CurrentProfile);
    NewItem.Enabled:=(FileExists(MameExe[i].ExePath)) and
         ((DirectoryExists(MameExe[i].WorkDir) or
          (MameExe[i].WorkDir='')));

    PopupActionBar4.Items[2].Add(NewItem);
  end;

end;


procedure TForm1.PopupRunClick(Sender: TObject);
var
  SelItem : TMenuItem;
  TempProfile: Integer;
begin
//
  SelItem := (Sender as TmenuItem);
  TempProfile:= PopupActionBar1.Items[2].IndexOf(SelItem);

  if (ListView1.Items.Count<>0) then
    ExecuteMAME(SelZip,
                MameExe[TempProfile].ExePath, MameExe[TempProfile].WorkDir,
                MameExe[TempProfile].Option );
    
end;

procedure TForm1.PopupRunClickSub(Sender: TObject);
var
  SelItem : TMenuItem;
  TempProfile: Integer;
begin
//
  SelItem := (Sender as TmenuItem);
  TempProfile:= PopupActionBar4.Items[2].IndexOf(SelItem);

  if (ListView1.Items.Count<>0) then
    ExecuteMAME(SelZip,
                MameExe[TempProfile].ExePath, MameExe[TempProfile].WorkDir,
                MameExe[TempProfile].Option );
    
end;

// ----------------------------------------------------------------------------
// アクションマネージャ
procedure TForm1.actPlayExecute(Sender: TObject);
begin

  actPlayUpdate(nil);   // パス関係のチェック
  if actPlay.Enabled then
  begin

    RunMAME(SelZip);

  end;

end;


procedure TForm1.actPlayUpdate(Sender: TObject);
begin

  // 起動対象なし
  if SelZip='' then
  begin
    actPlay.Caption :='起動(&P)';
    actPlay.Enabled := False;
    actRCPlayEx.Enabled:=False;
    actRRefine.Enabled:=False;

  end
  else
  // あり
  begin
    actPlay.Caption :='「'+SelZip+'」を起動(&P)';

    if CurrentProfile=-1 then
    begin
      actPlay.Enabled:=False;

    end
    else
    begin
      actRRefine.Enabled:=True;

      if (FileExists(MameExe[CurrentProfile].ExePath)) and
         ((DirectoryExists(MameExe[CurrentProfile].WorkDir) or
          (MameExe[CurrentProfile].WorkDir='')))
      then
      begin
        actPlay.Enabled := True;
      end
      else
      begin
        actPlay.Enabled := False;
      end;
      
    end;

    actRCPlayEx.Enabled:=true;

  end;

end;

procedure TForm1.actExitExecute(Sender: TObject);
begin
  Form1.Close;
end;

procedure TForm1.actListFontExecute(Sender: TObject);
begin

  FontDialog1.Font:=ListView1.Font;
  if FontDialog1.Execute then
  begin
    ListFont:=FontDialog1.Font;
    ListFont.Charset:=DEFAULT_CHARSET;
    ListView1.Font:=ListFont;
    ListView2.Font:=ListFont;
    Panel12.Font:=ListFont;
  end;

end;

procedure TForm1.actListColorExecute(Sender: TObject);
begin

  ColorDialog1.Color:=ListColor;
  
  if ColorDialog1.Execute then
  begin
    ListColor:=ColorDialog1.Color;
    ListView1.Color:=ListColor;
    ListView2.Color:=ListColor;
  end;

end;


procedure TForm1.actHistoryFontExecute(Sender: TObject);
begin

  FontDialog2.Font:=Memo1.Font;
  if FontDialog2.Execute then
  begin
    HistoryFont:=FontDialog2.Font;
    HistoryFont.Charset:=DEFAULT_CHARSET;
    Memo1.Font:=FontDialog2.Font;
    Memo1Change(Nil);
  end;

end;

procedure TForm1.actDelScreenShotExecute(Sender: TObject);
var St:String;
begin

  SetCurrentDir(ExeDir);

  if IDYES=MessageBox(Form1.Handle,
                      PChar('このスクリーンショットを削除しますか？   '+CRLF2+St+'    '),
                      APPNAME, MB_YESNO or MB_ICONQUESTION) then
  begin

    try
      Trasher(CurrentShot);
      Image32.Bitmap.Delete;
      CurrentShot:='';

    except

      MessageBox(Form1.Handle,
                 PChar('エラーが起きました。'),
                 APPNAME, MB_OK or MB_ICONEXCLAMATION);
    end;
  end;

end;

procedure TForm1.actDelScreenShotUpdate(Sender: TObject);
begin
  actDelScreenShot.Enabled:=(CurrentShot<>'');
end;

procedure TForm1.actBranch1Execute(Sender: TObject);
begin
  // ダミーアクション
end;

procedure TForm1.actSearchExecute(Sender: TObject);
begin

  if (ListView1.Items.Count=TLMaster.Count) and (Trim(edtSearch.Text)='') then Exit;

  DoNotUpdateLV:=True;

  cmbMaker.ItemIndex:=0;
  CurrentMaker:= cmbMaker.Text;

  cmbYear.ItemIndex:=0;
  CurrentYear:= cmbYear.Text;

  cmbCPU.ItemIndex:=0;
  CurrentCPU:= cmbCPU.Text;

  cmbSound.ItemIndex:=0;
  CurrentCPU:= cmbSound.Text;

  cmbEtc.ItemIndex:=0;
  CurrentAssort:=0;

  cmbVersion.ItemIndex:=0;
  CurrentVersion:=0;

  DoNotUpdateLV:=False;

  UpdateListView;

end;

procedure TForm1.actEngExecute(Sender: TObject);
begin

  if EngExecuteFlag then Exit;

  EngExecuteFlag:=True;

  if En then
  begin
    En:=False;
    ActEng.ImageIndex:=1;
    ActionManager1.ActionBars[0].Items[1].Items[3].ImageIndex:=1;
  end
  else
  begin
    En:=True;
    ActEng.ImageIndex:=2;
    ActionManager1.ActionBars[0].Items[1].Items[3].ImageIndex:=2;
  end;

  UpdateListView;


  Application.ProcessMessages;
  EngExecuteFlag:=False;

end;

procedure TForm1.actDelCfgExecute(Sender: TObject);
begin

  SetCurrentDir(ExeDir);

  if IDYES=MessageBox(Form1.Handle,
             PChar('以下の.cfgファイルを削除しますか？   '+CRLF2+
             cfgDir+'\'+SelZip+'.cfg'+'    '),
             APPNAME, MB_YESNO or MB_ICONQUESTION) then
  begin
    try
      DeleteFile(cfgDir+'\'+SelZip+'.cfg');
    except
      MessageBox(Form1.Handle,
             PChar('削除できませんでした。   '),
             APPNAME, MB_OK or MB_ICONERROR);
    end;
  end;

end;

procedure TForm1.actDelNvExecute(Sender: TObject);
begin

  SetCurrentDir(ExeDir);

  // フォルダ入りnvファイル
  if DirectoryExists(nvramDir+'\'+SelZip) then
  begin

    if IDYES=MessageBox(Form1.Handle,
             PChar('以下のnvramフォルダを削除しますか？   '+CRLF2+
             nvramDir+'\'+SelZip+'\'+'    '),
             APPNAME, MB_YESNO or MB_ICONQUESTION) then
    begin
      try
        DeleteDirectory(nvramDir+'\'+SelZip);
      except
        MessageBox(Form1.Handle,
               PChar('削除できませんでした。   '),
               APPNAME, MB_OK or MB_ICONERROR);
      end;
    end;

  end

  else
  begin

    if IDYES=MessageBox(Form1.Handle,
             PChar('以下の.nvファイルを削除しますか？   '+CRLF2+
             nvramDir+'\'+SelZip+'.nv'+'    '),
             APPNAME, MB_YESNO or MB_ICONQUESTION) then
    begin
      try
        DeleteFile(nvramDir+'\'+SelZip+'.nv');
      except
        MessageBox(Form1.Handle,
               PChar('削除できませんでした。   '),
               APPNAME, MB_OK or MB_ICONERROR);
      end;
    end;

  end;

end;

procedure TForm1.actDelAutosaveExecute(Sender: TObject);
begin

  SetCurrentDir(ExeDir);
  
  if IDYES=MessageBox(Form1.Handle,
             PChar('以下のautosave.staファイルを削除しますか？   '+CRLF2+
             staDir+'\'+SelZip+'\auto.sta    '),
             APPNAME, MB_YESNO or MB_ICONQUESTION) then
  begin
    try
      DeleteFile(staDir+'\'+SelZip+'\auto.sta');
    except
      MessageBox(Form1.Handle,
             PChar('削除できませんでした。   '),
             APPNAME, MB_OK or MB_ICONERROR);
    end;
  end;
  
end;

procedure TForm1.actBranch2Execute(Sender: TObject);
begin
  // ダミー
end;

procedure TForm1.actBranchExecute(Sender: TObject);
begin
  // ダミー
end;

procedure TForm1.actDelAllCfgExecute(Sender: TObject);
var St:string;
begin

  if SelZip='' then exit;

  if not (ListView1.Focused or ListView2.Focused) then exit;

  SetCurrentDir(ExeDir);
  
  if FileExists(cfgDir+'\'+SelZip+'.cfg') then
    St:=cfgDir+'\'+SelZip+'.cfg' +CRLF;
  if FileExists(nvramDir+'\'+SelZip+'.nv') then
    St:=St+nvramDir+'\'+SelZip+'.nv' +CRLF;

  // フォルダ入りnvファイル
  if DirectoryExists(nvramDir+'\'+SelZip) then
    St:=St+nvramDir+'\'+SelZip+'\' +CRLF;

  if FileExists(staDir+'\'+SelZip+'\auto.sta') then
    St:=St+staDir+'\'+SelZip+'\auto.sta';

  St:=Trim(St);

  if IDYES=MessageBox(Form1.Handle,
             PChar('以下の設定ファイルを削除しますか？   '+CRLF2+St+'    '),
             APPNAME, MB_YESNO or MB_ICONQUESTION) then
  begin

    try
      if FileExists(cfgDir+'\'+SelZip+'.cfg') then
        DeleteFile(cfgDir+'\'+SelZip+'.cfg');

      if FileExists(nvramDir+'\'+SelZip+'.nv') then
        DeleteFile(nvramDir+'\'+SelZip+'.nv');

      // フォルダ入りnvファイル
      if DirectoryExists(nvramDir+'\'+SelZip) then
        DeleteDirectory(nvramDir+'\'+SelZip);

      if FileExists(staDir+'\'+SelZip+'\auto.sta') then
      begin
        DeleteFile(staDir+'\'+SelZip+'\auto.sta');
        // 空フォルダ削除
        RemoveDir(staDir+'\'+SelZip); // 失敗時に例外は出さない
      end;

    except
      MessageBox(Form1.Handle,
                 PChar('削除に失敗しました。   '),
                 APPNAME, MB_OK or MB_ICONERROR);
    end;
  end;

end;

procedure TForm1.edtSearchChange(Sender: TObject);
begin

  if DoNotUpdateLV then exit;

  Timer1.Enabled:=True;

end;

procedure TForm1.edtSearchEnter(Sender: TObject);
begin
  //edtSearch.Font.Style:=[];
  edtSearch.SelectAll;
end;

procedure TForm1.edtSearchExit(Sender: TObject);
begin
  {
  if edtSearch.Text='' then
  begin
    edtSearch.Font.Style:=[fsItalic];
  end
  else
  begin
    edtSearch.Font.Style:=[];
  end;
 }

end;

procedure TForm1.edtSearchKeyPress(Sender: TObject; var Key: Char);
begin

  if Key=#13 then
  begin
    Key:=#0;
    if TLSub.Count<>0 then ListView1.SetFocus;
  end;

end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin

  Timer1.Enabled:=False;
  actSearchExecute(nil);

end;



procedure TForm1.actSAllExecute(Sender: TObject);
begin
  SearchMode:=srcAll;
  actSAll.Checked:=True;
  actSearchExecute(nil);
end;

procedure TForm1.actSaveLstExecute(Sender: TObject);
begin
  // dummy
end;

procedure TForm1.actSDescExecute(Sender: TObject);
begin
  SearchMode:=srcDesc;
  actSDesc.Checked:=True;
  actSearchExecute(nil);
end;

procedure TForm1.actSZipExecute(Sender: TObject);
begin
  SearchMode:=srcZip;
  actSZip.Checked:=True;
  actSearchExecute(nil);
end;

procedure TForm1.actSSourceExecute(Sender: TObject);
begin
  SearchMode:=srcSource;
  actSSource.Checked:=True;
  actSearchExecute(nil);
end;

procedure TForm1.actSMakerExecute(Sender: TObject);
begin
  SearchMode:=srcMaker;
  actSMaker.Checked:=True;
  actSearchExecute(nil);
end;

procedure TForm1.actSResetExecute(Sender: TObject);
begin

  if (TLSub.Count=TLMaster.Count) then exit;

  DoNotUpdateLV:=True;

  edtSearch.Text:='';

  cmbMaker.ItemIndex:=0;
  CurrentMaker:= cmbMaker.Text;

  cmbYear.ItemIndex:=0;
  CurrentYear:= cmbYear.Text;

  cmbCPU.ItemIndex:=0;
  CurrentCPU:= cmbCPU.Text;

  cmbSound.ItemIndex:=0;
  CurrentSound:= cmbSound.Text;

  cmbVersion.ItemIndex:=0;
  CurrentVersion:= 0;

  cmbEtc.ItemIndex:=0;
  CurrentAssort:=0;

  DoNotUpdateLV:=False;

  UpdateListView;

end;

procedure TForm1.actSFocusExecute(Sender: TObject);
begin
  if edtSearch.Enabled then
    edtSearch.SetFocus;
end;

procedure TForm1.actShotSizeLargeExecute(Sender: TObject);
begin
//  actShotSizeLarge.Checked:=True;
  Panel3.Width:=411;
  Panel15.Height:=304;
  SetSnap;
end;

procedure TForm1.actShotSizeNormalExecute(Sender: TObject);
begin
//  actShotSizeNormal.Checked:=True;
  Panel3.Width:=331;
  Panel15.Height:=244;
  SetSnap;

end;

procedure TForm1.actShotSizeVerticalExecute(Sender: TObject);
begin
//  actShotSizeVertical.Checked:=True;
  Panel3.Width:=251;
  Panel15.Height:=324;
  SetSnap;
end;


procedure TForm1.actShotSizeXLExecute(Sender: TObject);
begin
//  actShotSizeLarge.Checked:=True;
  Panel3.Width:=651;
  Image32.Height:=480;
  SetSnap;
end;

procedure TForm1.actORomDirExecute(Sender: TObject);
begin
  frmSetting.PageControl1.ActivePage:=frmSetting.TabSheet2;
  frmSetting.ShowModal;
end;


procedure TForm1.actRRefineExecute(Sender: TObject);
begin

  edtSearch.Text:=actRRefine.Hint;

end;

procedure TForm1.actROpenSrcExecute(Sender: TObject);
var st:String;
begin

  if actROpenSrc.Hint='' then exit;
  //St:=SrcDir+'\'+actROpenSrc.Hint;
  //ShellExecute(Form1.handle,'open',PChar(St),nil,nil,SW_SHOWNORMAL);

  St:= actROpenSrc.Hint;

  ShellExecute( Form1.Handle,
                'open',
                PChar('https://github.com/mamedev/mame/blob/master/src/mame/drivers/'+St),
                nil,
                nil,
                SW_SHOW);

end;

procedure TForm1.actROpenSrcUpdate(Sender: TObject);
begin

  if actROpenSrc.Hint<>'' then
  begin
    actROpenSrc.Caption:='「'+actROpenSrc.Hint+'」をGitHubで開く(&O)';
    //actROpenSrc.Caption:='\drivers\'+actROpenSrc.Hint+'を開く(&O)';
    actROpenSrc.Enabled:=true;
    //actROpenSrc.Enabled:=FileExists(SrcDir+'\'+actROpenSrc.Hint);
  end
  else
  begin
    actROpenSrc.Caption:='GitHubを開く(&O)';
    actROpenSrc.Enabled:=False;
  end;
  
end;

procedure TForm1.actRRefineUpdate(Sender: TObject);
begin

  if actRRefine.Hint<>'' then
  begin
    actRRefine.Caption := '「'+actRRefine.Hint+'」で絞り込む(&S)';
    actRRefine.Enabled :=True;
  end
  else
  begin
    actRRefine.Caption := 'ソースで絞り込む(&S)';
    actRRefine.Enabled :=False;
  end;

end;



//------------------------------------------------------------------------------
procedure TForm1.cmbMakerChange(Sender: TObject);
begin

  if DoNotUpdateLV then exit;

  if (CurrentMaker=cmbMaker.Text) and
     (edtSearch.Text='') then exit;

  DoNotUpdateLV:=True;
  
  // サーチボックスリセット
  edtSearch.Text:='';

  DoNotUpdateLV:=False;
  UpdateListView;
  CurrentMaker:=cmbMaker.Text;
  Sleep(0);
  
end;

procedure TForm1.cmbYearChange(Sender: TObject);
begin

  if DoNotUpdateLV then exit;

  if (CurrentYear=cmbYear.Text) and
     (edtSearch.Text='') then exit;

  DoNotUpdateLV:=True;
  // サーチボックスリセット
  edtSearch.Text:='';

  DoNotUpdateLV:=False;
  UpdateListView;
  CurrentYear:=cmbYear.Text;

end;

procedure TForm1.cmbCPUChange(Sender: TObject);
begin

  if DoNotUpdateLV then exit;

  if (CurrentCPU=cmbCPU.Text) and
     (edtSearch.Text='') then exit;

  DoNotUpdateLV:=True;
  // サーチボックスリセット
  edtSearch.Text:='';

  DoNotUpdateLV:=False;

  UpdateListView;
  CurrentCPU:=cmbCPU.Text;
  
end;

procedure TForm1.cmbSoundChange(Sender: TObject);
begin

  if DoNotUpdateLV then exit;

  if (CurrentSound=cmbSound.Text) and
     (edtSearch.Text='') then exit;

  DoNotUpdateLV:=True;
  // サーチボックスリセット
  edtSearch.Text:='';

  DoNotUpdateLV:=False;

  UpdateListView;
  CurrentSound:=cmbSound.Text;

end;

procedure TForm1.cmbEtcChange(Sender: TObject);
begin


  if DoNotUpdateLV then exit;

  if (CurrentAssort=cmbEtc.ItemIndex) and
     (edtSearch.Text='') then begin beep;exit;end;


  DoNotUpdateLV:=True;
  // サーチボックスリセット
  edtSearch.Text:='';

  DoNotUpdateLV:=False;

  UpdateListView;

  CurrentAssort:=cmbEtc.ItemIndex;

end;


procedure TForm1.cmbVersionChange(Sender: TObject);
begin
  if DoNotUpdateLV then exit;

  if (CurrentVersion=cmbVersion.ItemIndex) and
     (edtSearch.Text='') then exit;

  DoNotUpdateLV:=True;
  // サーチボックスリセット
  edtSearch.Text:='';
  DoNotUpdateLV:=False;

  UpdateListView;
  CurrentVersion:=cmbVersion.ItemIndex;
end;


procedure TForm1.Image32Click(Sender: TObject);
begin
  KeepAspect := not KeepAspect;
  actKeepAspect.Checked := KeepAspect;
  SetSnap;
end;


procedure TForm1.actFROMExecute(Sender: TObject);
begin
  // dummy
end;

procedure TForm1.actOSelMAMEExecute(Sender: TObject);
begin

  frmSetting.PageControl1.ActivePage:=frmSetting.TabSheet1;
  frmSetting.ShowModal;
  //
end;

procedure TForm1.actVSearchBarExecute(Sender: TObject);
begin

  Panel12.Visible:=not Panel12.Visible;

  if Panel12.Visible then
  begin
    actVSearchBar.ImageIndex:=32;
  end
  else
  begin
    actVSearchBar.ImageIndex:=33;
  end;
  
end;

procedure TForm1.actVSearchBarUpdate(Sender: TObject);
begin

  if Panel12.Visible then
    actVSearchBar.Caption:='検索パネルを隠す'
  else
    actVSearchBar.Caption:='検索パネルを表示';

  
end;

procedure TForm1.actVEditorUpdate(Sender: TObject);
begin

  if Panel7.Visible then
    actVEditor.Caption:='編集パネルを隠す'
  else
    actVEditor.Caption:='編集パネルを表示';

end;

procedure TForm1.actVCommandExecute(Sender: TObject);
begin
  if frmCommand.Showing then
  begin
    frmCommand.Hide;
  end
  else
  begin
    frmCommand.Show;
  end;
end;

procedure TForm1.actVCommandUpdate(Sender: TObject);
begin

  if frmCommand.Showing then
  begin
    actVCommand.Caption:='コマンドビューアを閉じる';
  end
  else
  begin
    actVCommand.Caption:='コマンドビューアを開く';
  end;
end;

procedure TForm1.actVEditorExecute(Sender: TObject);
var i:integer;
begin

  // 閉じるときの処理
  // 編集パネルにフォーカスがある場合はListView1に移す
  if ListView2.Focused or edtDescJ.Focused or edtKana.Focused or Edit1.Focused or
     memCPU.Focused or memSound.Focused or memDisp.Focused or edtSource.Focused then
  begin
    ListView1.SetFocus;
  end;


  Splitter1.Visible:= not Splitter1.Visible;
  Panel7.Visible:= not Panel7.Visible;


  // 表示するときはSplitterの位置修正
  if Splitter1.Visible then
  begin
    Splitter1.Top:=Panel7.Top-5;
    if ListView1.Selected<>nil then
      ListView1.Selected.MakeVisible(True);
  end;

  // 閉じたときはListView1の項目を再選択
  // メインリストに無いものを選んでる場合のため
  if (Panel7.Visible=False) and (ListView1.ItemFocused<>nil) then
  begin
    i:=ListView1.ItemFocused.Index;
    //ListView1.ItemIndex;
    ListView1.Items[i].Selected:=False;
    ListView1.Items[i].Selected:=True;
  end;

end;



procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
var Re:Integer;

begin

  if Edited then
  begin

    Re:=MessageBox(Form1.Handle,PChar('ゲーム名が編集されています。'+CRLF2+
                   '変更をmame32j.lstに保存しますか?      '),PChar('確認'),
                    MB_YESNOCANCEL+MB_ICONEXCLAMATION);

    Case Re of
      mrYes:
      begin

        if WSaveMame32j then
        begin
          Action := caFree;
        end
        else
        begin  // MAME32j.lstの保存キャンセル時は戻る
          Action := TCloseAction(0);//=caNone
          Exit;
        end;
      end;

      mrNo:
        Action := caFree;

      mrCancel:
      begin
        Action := TCloseAction(0);//=caNone
        Exit;
      end;
    end;
  end;

  SaveIni;


end;


procedure TForm1.actVFNearestExecute(Sender: TObject);
begin
  CurrentFilter:=RF_NEAREST;
  SetSnap;
end;

procedure TForm1.actVHideGamblingExecute(Sender: TObject);
begin
  HideGambling:=(not HideGambling);
  UpdateListView;
end;

procedure TForm1.actVHideGamblingUpdate(Sender: TObject);
begin
    actVHideGambling.Checked:=HideGambling;
end;

procedure TForm1.actVHideMechanicalExecute(Sender: TObject);
begin

  HideMechanical:=(not HideMechanical);
  UpdateListView;

end;

procedure TForm1.actVHideMechanicalUpdate(Sender: TObject);
begin
    actVHideMechanical.Checked:=HideMechanical;
end;

procedure TForm1.actVInfoPaneExecute(Sender: TObject);
begin

  Panel3.Visible:=not Panel3.Visible;
  Splitter2.Visible:= Panel3.Visible;

end;

procedure TForm1.actVInfoPaneUpdate(Sender: TObject);
begin
  if Panel3.Visible then
    actVInfoPane.Caption:='情報パネルを隠す'
  else
    actVInfoPane.Caption:='情報パネルを表示';
end;

procedure TForm1.actVFLinearExecute(Sender: TObject);
begin
  CurrentFilter:=RF_LINEAR;
  SetSnap;
end;

procedure TForm1.actVFLanczosExecute(Sender: TObject);
begin
  CurrentFilter:=RF_LANCZOS;
  SetSnap;
end;

procedure TForm1.actVFCubicExecute(Sender: TObject);
begin
  CurrentFilter:=RF_CUBIC;
  SetSnap;
end;

procedure TForm1.actKeepAspectExecute(Sender: TObject);
begin
  KeepAspect:= not KeepAspect;
  actKeepAspect.Checked := KeepAspect;
  SetSnap;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin

  CurrentProfile:=ComboBox1.ItemIndex;
  SetFormTitle;

end;



procedure TForm1.actRCPlayExExecute(Sender: TObject);
begin
 // ダミー
end;


procedure TForm1.actJoySelectExecute(Sender: TObject);
begin

//  if not UseJoyStick then
//    joySetCapture(Self.Handle, JoyStickID1, JoyRepeat, False);

  UseJoyStick:=not UseJoyStick;

end;

procedure TForm1.actJoySelectUpdate(Sender: TObject);
begin

  actJoySelect.Checked:=UseJoyStick;


end;



procedure TForm1.actDelUpdate(Sender: TObject);
var i:integer;
begin

  SetCurrentDir(ExeDir);

  if ( SelZip = '' ) then begin
    actDelCfg.Enabled := false;
    actDelNv.Enabled := false;
    actDelAutosave.Enabled := false;

  end
  else begin

    actDelCfg.Enabled := FileExists(cfgDir+'\'+SelZip+'.cfg');
    actDelNv.Enabled := ( FileExists(nvramDir+'\'+SelZip+'.nv') OR
                          DirectoryExists(nvramDir+'\'+SelZip)
                        );
    actDelAutosave.Enabled :=FileExists(staDir+'\'+SelZip+'\auto.sta');

  end;

  i:=0;
  if actDelCfg.Enabled then inc(i);
  if actDelNv.Enabled then inc(i);
  if actDelAutosave.Enabled then inc(i);

  actDelAllCfg.Enabled :=(i>0);
  actDel.Enabled :=(i>0);

end;

procedure TForm1.actDelExecute(Sender: TObject);
begin
 // dummy
end;

// マージセットでROM検索
procedure TForm1.actFRMargeExecute(Sender: TObject);
var i,j:integer;
    CHD,ROM: Boolean;
    Save_Cursor: TCursor;

begin

  SetCurrentDir(ExeDir);
  Save_Cursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;    // Show hourglass cursor

  try
    // 親セットだけ調べる
    for i:=0 to TLMaster.Count-1 do
    begin
      PRecordset(TLMaster[i]).ROM:=False;
      CHD:=False;

      // CHDだけのセットの場合
      ROM:=PRecordset(TLMaster[i]).CHDOnly;

      if PRecordset(TLMaster[i]).Master then
      begin

        for j:=0 to Length(RomDirs)-1 do
        begin

          if PRecordset(TLMaster[i]).CHD='' then // CHDが無い場合
          begin
            CHD:=True;
            ROM:= ( FileExists(RomDirs[j]+'\'+PRecordset(TLMaster[i]).ZipName+'.zip') OR
                    FileExists(RomDirs[j]+'\'+PRecordset(TLMaster[i]).ZipName+'.7z')
                  );

            // 完全に別セットのROMを使う場合 (CloneOfがないのにRomOfがある)
            if (PRecordset(TLMaster[i]).CloneOf='') and (PRecordset(TLMaster[i]).RomOf<>'') then
            begin
              if PRecordset(TLMaster[i]).RomOf='gts1s' then
                PRecordset(TLMaster[i]).RomOf:='gts1'; // 取りあえず

              ROM:=( FileExists(RomDirs[j]+'\'+PRecordset(TLMaster[i]).RomOf+'.zip') OR
                     FileExists(RomDirs[j]+'\'+PRecordset(TLMaster[i]).RomOf+'.7z')
                    );
            end;


          end
          else  // CHDがある場合
          begin
            if ROM=False then // CHDのみセット
              ROM:= ( FileExists(RomDirs[j]+'\'+PRecordset(TLMaster[i]).ZipName+'.zip') OR
                      FileExists(RomDirs[j]+'\'+PRecordset(TLMaster[i]).ZipName+'.7z')
                    );
            if CHD=False then
              CHD:=FileExists(RomDirs[j]+'\'+PRecordset(TLMaster[PRecordset(TLMaster[i]).MasterID]).ZipName+'\'+
                 PRecordset(TLMaster[i]).CHD+'.chd');
            if CHD=False then
              CHD:=FileExists(RomDirs[j]+'\'+PRecordset(TLMaster[i]).ZipName+'\'+
                PRecordset(TLMaster[i]).CHD+'.chd');

            // マージCHDがある場合
            if PRecordset(TLMaster[i]).CHDMerge=True then
            begin
              CHD:=FileExists(RomDirs[j]+'\'+PRecordset(TLMaster[PRecordset(TLMaster[i]).MasterID]).ZipName+'\'+
                PRecordset(TLMaster[PRecordset(TLMaster[i]).MasterID]).CHD+'.chd');
            end;
          end;

          if (ROM and CHD) then
          begin
            PRecordset(TLMaster[i]).ROM:=True;
            break;
          end;

        end;
      end;
    end;

    // 子セットのROM状態を親に合わせる
    for i:=0 to TLMaster.Count-1 do
    begin
      if not PRecordset(TLMaster[i]).Master then
      begin
        PRecordset(TLMaster[i]).ROM:=PRecordset(TLMaster[PRecordset(TLMaster[i]).MasterID]).ROM;
      end;
    end;

    /// サンプルセットの検索も
    actFSearchSampleExecute(nil);

    // アイコンの再描画
    ListView1.Repaint;

    // サブリスト更新
    ListView2.Repaint;

  finally
    Screen.Cursor := Save_Cursor;
  end;
end;

// スプリットセットでROM検索
procedure TForm1.actFRSplitExecute(Sender: TObject);
var i, j:integer;
    CHD, ROM, SameROM: boolean;
    Save_Cursor: TCursor;
    blBIOS  : boolean;

begin

  Save_Cursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;    // Show hourglass cursor

  try
    SetCurrentDir(ExeDir);

    for i:=0 to TLMaster.Count-1 do
    begin
      PRecordset(TLMaster[i]).ROM:=False;
      CHD:=False;
      SameROM:=False;
      
      // CHDだけのセットの場合
      ROM:=PRecordset(TLMaster[i]).CHDOnly;

      // 親セットと子セットが同じ場合
      if (PRecordset(TLMaster[i]).ZipName = 'candance') or
         (PRecordset(TLMaster[i]).ZipName = 'galpanica') or
         (PRecordset(TLMaster[i]).ZipName = 'wotwc') or
         (PRecordset(TLMaster[i]).ZipName = 'natodefa') or
         (PRecordset(TLMaster[i]).ZipName = 'jojoalt') or
         (PRecordset(TLMaster[i]).ZipName = 'ddrja') or
         (PRecordset(TLMaster[i]).ZipName = 'ddrjb') or
         (PRecordset(TLMaster[i]).ZipName = 'trvwzha')
         then
        SameROM:=True;
      
      
      for j:=0 to Length(RomDirs)-1 do
      begin

        if (PRecordset(TLMaster[i]).CHD='') or
           (PRecordset(TLMaster[i]).CHDNoDump) then // CHDが無い場合/CHDがNoDumpの場合
        begin
        
          CHD:=True;

          if SameRom then
          begin
            ROM:=( FileExists(RomDirs[j]+'\'+PRecordset(TLMaster[i]).CloneOf+'.zip') OR
                   FileExists(RomDirs[j]+'\'+PRecordset(TLMaster[i]).CloneOf+'.7z')
                 );
          end
          else
          begin
            ROM:=( FileExists(RomDirs[j]+'\'+PRecordset(TLMaster[i]).ZipName+'.zip') OR
                   FileExists(RomDirs[j]+'\'+PRecordset(TLMaster[i]).ZipName+'.7z')
                 );
          end;

          // RomOfがある場合の処理
          if (PRecordset(TLMaster[i]).RomOf<>'') then
          begin

            // BIOSをチェック
            blBIOS := ( FileExists(RomDirs[j]+'\'+PRecordset(TLMaster[i]).RomOf+'.zip') OR
                        FileExists(RomDirs[j]+'\'+PRecordset(TLMaster[i]).RomOf+'.7z')
                        );

            // ROM本体もあればOKにする
            if blBIOS and ROM then
              ROM := True;

            // BIOSのみセット用の個別対応
            if (PRecordset(TLMaster[i]).RomOf='gp_110') or
               (PRecordset(TLMaster[i]).RomOf='allied') then
            begin

              ROM := blBIOS;

            end;

          end;


          // 完全に別セットのROMを使う場合 (CloneOfがないのにRomOfがある)
          {if (PRecordset(TLMaster[i]).CloneOf='') and (PRecordset(TLMaster[i]).RomOf<>'') then
          begin
            if PRecordset(TLMaster[i]).RomOf='gts1s' then
              PRecordset(TLMaster[i]).RomOf:='gts1'; // 取りあえず

            ROM:=FileExists(RomDirs[j]+'\'+PRecordset(TLMaster[i]).RomOf+'.zip');
          end;
          }


        end
        else  // CHDがある場合
        begin

          if ROM=False then // CHDのみセット
          begin
            if SameRom then
            begin
              ROM:=( FileExists(RomDirs[j]+'\'+PRecordset(TLMaster[i]).CloneOf+'.zip') OR
                     FileExists(RomDirs[j]+'\'+PRecordset(TLMaster[i]).CloneOf+'.7z')
                   );
            end
            else
            begin
              ROM:=( FileExists(RomDirs[j]+'\'+PRecordset(TLMaster[i]).ZipName+'.zip') OR
                     FileExists(RomDirs[j]+'\'+PRecordset(TLMaster[i]).ZipName+'.7z')
                   );
            end;
          end;
          
          if CHD=False then
            CHD:=FileExists(RomDirs[j]+'\'+PRecordset(TLMaster[PRecordset(TLMaster[i]).MasterID]).ZipName+'\'+
               PRecordset(TLMaster[i]).CHD+'.chd');
          if CHD=False then
            CHD:=FileExists(RomDirs[j]+'\'+PRecordset(TLMaster[i]).ZipName+'\'+
               PRecordset(TLMaster[i]).CHD+'.chd');

          // マージCHDがある場合
          if PRecordset(TLMaster[i]).CHDMerge=True then
          begin
            CHD:=FileExists(RomDirs[j]+'\'+PRecordset(TLMaster[PRecordset(TLMaster[i]).MasterID]).ZipName+'\'+
               PRecordset(TLMaster[PRecordset(TLMaster[i]).MasterID]).CHD+'.chd');
          end;
               
        end;

        if (ROM and CHD) then
        begin
          PRecordset(TLMaster[i]).ROM:=True;
          break;
        end;

      end;

    end;

    /// サンプルセットの検索も
    actFSearchSampleExecute(nil);

    // アイコンの再描画
    ListView1.Repaint;

    // サブリスト更新
    ListView2.Repaint;

  finally
    Screen.Cursor := Save_Cursor;
  end;

end;

// サンプルの検索
procedure TForm1.actFSearchSampleExecute(Sender: TObject);
var i:integer;
begin

  SetCurrentDir(ExeDir);

  for i:=0 to TLMaster.Count-1 do
  begin

    if PRecordset(TLMaster[i]).SampleOf<>'' then
    begin
      PRecordset(TLMaster[i]).Sample:=
        FileExists(samplePath+'\'+PRecordset(TLMaster[i]).SampleOf+'.zip');
    end;
  end;

end;

// クラウド更新
procedure TForm1.actFHttpExecute(Sender: TObject);
var response: integer;
begin

  response := frmHttp.ShowModal;

  // 更新結果が mrOK なら
  if response=mrOK then
  begin
    ReadMame32jlst;
    SetVersionINI;
    ReadMameInfoDat;
    UpdateListView;
    ReadHistoryDat;
    FindDat(CurrentIndex);
  end;

end;

procedure TForm1.actOAboutExecute(Sender: TObject);
begin
  Form5.ShowModal;
end;

procedure TForm1.actOJoyExecute(Sender: TObject);
begin
  //ダミー
end;

procedure TForm1.actOJoyPOVExecute(Sender: TObject);
begin
  UsePOV:=not UsePOV;
end;

procedure TForm1.actOJoyPOVUpdate(Sender: TObject);
begin
  actOJoyPOV.Checked:=UsePOV;
end;

//------------------------------------------------------------------------------
// ステータスバーのパネル更新
procedure TForm1.UpdateStatus;
var Idx:integer;
begin


  Idx:=CurrentIndex;
  
  StatusBarBuf.Canvas.Brush.Color:=clBtnFace;
  StatusBarBuf.Canvas.FillRect(Rect(0,0,StatusBarBuf.Width,StatusBarBuf.Height));
  SB_HintText:='';
  
  ImageList2.Draw(StatusBarBuf.Canvas, SB_LRMARGIN ,0,20); // 動作
  
  ImageList2.Draw(StatusBarBuf.Canvas, SB_LRMARGIN +
                  (32+SB_ITEMDISTANCE)*1,0,23);            // GFX
  ImageList2.Draw(StatusBarBuf.Canvas, SB_LRMARGIN +
                  (32+SB_ITEMDISTANCE)*2+SB_MARKDISTANCE,0,21); // 色
  ImageList2.Draw(StatusBarBuf.Canvas, SB_LRMARGIN +
                  (32+SB_ITEMDISTANCE)*3+SB_MARKDISTANCE,0,22); // 音
  ImageList2.Draw(StatusBarBuf.Canvas, SB_LRMARGIN +
                  (32+SB_ITEMDISTANCE)*4+SB_MARKDISTANCE,0,24); // プロテクト
  ImageList2.Draw(StatusBarBuf.Canvas, SB_LRMARGIN +
                  (32+SB_ITEMDISTANCE)*5+SB_MARKDISTANCE,0,34); // セーブステート

                  
  if Idx=-1 then
  begin
    ImageList2.Draw(StatusBarBuf.Canvas, SB_LRMARGIN+16,0,28); // 
    ImageList2.Draw(StatusBarBuf.Canvas, SB_LRMARGIN+(32+SB_ITEMDISTANCE+SB_MARKDISTANCE)*1+16,0,28); // GFX
    ImageList2.Draw(StatusBarBuf.Canvas, SB_LRMARGIN+(32+SB_ITEMDISTANCE+SB_MARKDISTANCE)*2+16,0,28); // 色
    ImageList2.Draw(StatusBarBuf.Canvas, SB_LRMARGIN+(32+SB_ITEMDISTANCE+SB_MARKDISTANCE)*3+16,0,28); // 音
    ImageList2.Draw(StatusBarBuf.Canvas, SB_LRMARGIN+(32+SB_ITEMDISTANCE+SB_MARKDISTANCE)*4+16,0,28); // プロテクト
    ImageList2.Draw(StatusBarBuf.Canvas, SB_LRMARGIN+(32+SB_ITEMDISTANCE+SB_MARKDISTANCE)*5+16,0,28); // セーブステート
  end
  else
  begin
    if PRecordSet(TLMaster[Idx]).Status then // 動作
      ImageList2.Draw(StatusBarBuf.Canvas, SB_LRMARGIN+16+SB_MARKDISTANCE, 0,25)
    else
      ImageList2.Draw(StatusBarBuf.Canvas, SB_LRMARGIN+16+SB_MARKDISTANCE, 0,27);

    ImageList2.Draw(StatusBarBuf.Canvas, SB_LRMARGIN+(32+SB_ITEMDISTANCE+SB_MARKDISTANCE)*1+16,
                    0,25+Ord(PRecordSet(TLMaster[Idx]).GFX)); // GFX
    ImageList2.Draw(StatusBarBuf.Canvas, SB_LRMARGIN+(32+SB_ITEMDISTANCE+SB_MARKDISTANCE)*2+16,
                    0,25+Ord(PRecordSet(TLMaster[Idx]).Color)); // 色
    ImageList2.Draw(StatusBarBuf.Canvas, SB_LRMARGIN+(32+SB_ITEMDISTANCE+SB_MARKDISTANCE)*3+16,
                    0,25+Ord(PRecordSet(TLMaster[Idx]).Sound)); // 音
    ImageList2.Draw(StatusBarBuf.Canvas, SB_LRMARGIN+(32+SB_ITEMDISTANCE+SB_MARKDISTANCE)*4+16,
                    0,25+Ord(PRecordSet(TLMaster[Idx]).Protect)); // プロテクト
    ImageList2.Draw(StatusBarBuf.Canvas, SB_LRMARGIN+(32+SB_ITEMDISTANCE+SB_MARKDISTANCE)*5+16,
                    0,25+Ord(PRecordSet(TLMaster[Idx]).SaveState)); // セーブステート

    if not PRecordSet(TLMaster[Idx]).Status then
      SB_HintText:='動作不可'+CRLF;

    if PRecordSet(TLMaster[Idx]).GFX=gsImperfect then
      SB_HintText:=SB_HintText+'グラフィック：不完全'+CRLF;

    if PRecordSet(TLMaster[Idx]).Color=gsImperfect then
      SB_HintText:=SB_HintText+'色：不完全'+CRLF
    else
    if PRecordSet(TLMaster[Idx]).Color=gsPreliminary then
      SB_HintText:=SB_HintText+'色：不良'+CRLF;

    if PRecordSet(TLMaster[Idx]).Sound=gsImperfect then
      SB_HintText:=SB_HintText+'サウンド：不完全'+CRLF
    else
    if PRecordSet(TLMaster[Idx]).Sound=gsPreliminary then
      SB_HintText:=SB_HintText+'サウンド：なし'+CRLF;

    if PRecordSet(TLMaster[Idx]).Protect=gsPreliminary then
      SB_HintText:=SB_HintText+'プロテクト：不完全'+CRLF;

    if PRecordSet(TLMaster[Idx]).Cocktail=gsPreliminary then
      SB_HintText:=SB_HintText+'画面反転：未実装'+CRLF;

    if PRecordSet(TLMaster[Idx]).SaveState=gsPreliminary then
      SB_HintText:=SB_HintText+'セーブステート：未サポート'+CRLF;

  end;

  StatusBar1.Repaint;
  StatusBar1.Hint:=Trim(SB_HintText);

end;

procedure TForm1.StatusBar1DrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
var Rct,DRct:TRect;
begin

  StatusBar1.Canvas.Font:=memCPU.Font;

  if (Panel.Index=0) or (Panel.Index=1) or (Panel.Index=2) or (Panel.Index=3) then
  begin
    Rct:=Rect;

    //StatusBar1.Canvas.TextOut(Rect.left, Rect.top, Panel.Text);
    DrawText( StatusBar1.Canvas.Handle,
              PChar(Panel.Text),
              -1,
              Rct,
              DT_CENTER);
  end
  else
  begin
    Rct.Left:=0;
    Rct.Top:=0;
    Rct.Right:=StatusBarBuf.Width;
    Rct.Bottom:=StatusBarBuf.Height;

    DRct:=Rect;
    DRct.Right:=DRct.Left+StatusBarBuf.Width;

    StatusBar1.Canvas.CopyRect(DRct,StatusBarBuf.Canvas,Rct);
  end;
  
end;


procedure TForm1.StatusBar1Resize(Sender: TObject);
const
  ResizePanelNumber=3;    //リサイズするStatusbarのパネル番号を指定
  MinSize=0;              //リサイズされても維持したい最小のWidthを指定
var
  BarWidth,i: Integer;
begin
  with StatusBar1 do
  begin
    BarWidth := 0;
    for i:=0 to Panels.Count-1 do
    begin
      if not(i=ResizePanelNumber) then
        BarWidth := BarWidth + Panels[i].Width;
    end;

    if (Width-BarWidth)<=MinSize then
      Panels[ResizePanelNumber].Width := MinSize
    else
      Panels[ResizePanelNumber].Width := Width - BarWidth;
  end;
end;

procedure TForm1.StatusBar1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  i: integer;
begin

  i:=StatusBar1.Panels[0].Width+StatusBar1.Panels[1].Width+
     StatusBar1.Panels[2].Width+StatusBar1.Panels[3].Width;

  if (X > i) and (X < i+StatusBar1.Panels[4].Width) then
  begin

    if StatusBar1.ShowHint=False then
      StatusBar1.ShowHint:=True;

  end
  else
  begin
    if StatusBar1.ShowHint then
      StatusBar1.ShowHint:=False;
  end;

end;

//------------------------------------------------------------------------------
// ジョイスティック
procedure TForm1.JoyLaunchTimerTimer(Sender: TObject);
begin
  TTimer(Sender).Enabled := false;
end;

procedure TForm1.JoyTimerTimer(Sender: TObject);
var JoyInfo : JOYINFOEX;
    Result : MMRESULT;
begin
  JoyInfo.dwSize := SizeOf(JoyInfo);
  JoyInfo.dwFlags := JOY_RETURNALL;
  Result := JoyGetPosEx(JOYSTICKID1, @JoyInfo);

  if (Result = JOYERR_NOERROR) AND (UseJoystick) AND (FindControl(GetForegroundWindow()) <> nil) then
  begin

    // ボタン1は起動
    if (JoyInfo.wButtons and JOY_BUTTON1)>0 then begin

      if JoyLaunchTimer.Enabled=false then begin

        JoyLaunchTimer.Enabled := True;
        actPlayExecute(nil);

      end;

    end;

    // ボタン3はPageDown
    if (JoyInfo.wButtons and JOY_BUTTON3)>0 then
        PostMessage(ListView1.Handle, WM_KEYDOWN, 33, 1 );

    // ボタン4はPageUp
    if (JoyInfo.wButtons and JOY_BUTTON4)>0 then
        PostMessage(ListView1.Handle, WM_KEYDOWN, 34, 1 );


    // 上ボタン
    if (JoyInfo.wYpos < 20000) OR ((UsePOV = true) and (JoyInfo.dwPOV = JOY_POVFORWARD)) then
    begin

      if ListView1.Items.Count=0 then exit;
      if ListView1.ItemFocused.Index <= 0 then exit;

      if (JoyDelayTick=0) or (JoyDelayTick + KeyBoardDelay < GetTickCount) then
      begin

        ListView1.ItemIndex:=ListView1.ItemFocused.Index; // Focusboder消し
        ListView1.ItemIndex:=ListView1.ItemFocused.Index-1;
        ListView1.Items[ListView1.ItemIndex].Selected:=True;
        ListView1.Items[ListView1.ItemIndex].Focused:=True;
        ListView1.Selected.MakeVisible(True);

      end;

      if JoyStatus<>jsUp then // キーリピート開始
      begin
        JoyStatus:=jsUp;
        JoyDelayTick:=GetTickCount;
      end;

    end
    else
    // 下ボタン
    if (JoyInfo.wYpos > 45535) or ((UsePOV = true) and (JoyInfo.dwPOV = JOY_POVBACKWARD)) then
    begin

      if ListView1.Items.Count=0 then exit;
      if ListView1.ItemFocused.Index = ListView1.Items.Count-1 then exit;

      if (JoyDelayTick=0) or (JoyDelayTick + KeyBoardDelay < GetTickCount) then
      begin

        ListView1.ItemIndex:=ListView1.ItemFocused.Index; // Focusboder消し
        ListView1.ItemIndex:=ListView1.ItemFocused.Index+1;
        ListView1.Items[ListView1.ItemIndex].Selected:=True;
        ListView1.Items[ListView1.ItemIndex].Focused:=True;
        ListView1.Selected.MakeVisible(True);

      end;

      if JoyStatus<>jsDown then // キーリピート開始
      begin
        JoyStatus:=jsDown;
        JoyDelayTick:=GetTickCount;
      end;

    end
    else // 押されていないとき
    begin
      JoyStatus:=jsNone;
      JoyDelayTick:=0;
    end;

    // 左ボタン
    if (JoyInfo.wXpos< 20000) or ((UsePOV = true) and (JoyInfo.dwPOV = JOY_POVLEFT))  then
    begin
      if ListView1.Focused then
        ListView1.Scroll(-20,0);
      if ListView2.Focused then
        ListView2.Scroll(-20,0);
    end
    else
    // 右ボタン
    if (JoyInfo.wXpos>45535) or ((UsePOV = true) and (JoyInfo.dwPOV = JOY_POVRIGHT)) then
    begin
      if ListView1.Focused then
        ListView1.Scroll(20,0);
      if ListView2.Focused then
        ListView2.Scroll(20,0);

    end;
  end;

end;

procedure TForm1.Splitter1CanResize(Sender: TObject; var NewSize: Integer;
  var Accept: Boolean);
begin

  // パネル自体の最大サイズ
  if NewSize > Panel7.Constraints.MaxHeight then
  begin
    NewSize:=Panel7.Constraints.MaxHeight;
    Accept:=False;
  end;

end;



//------------------------------------------------------------------------------
// ゲーム名編集パネル
// 全体の更新
procedure TForm1.UpdateEditPanel(const idx: integer);
begin

  ToggleEditPanel(True);
  EditUpdating:=True;
  edtDescJ.Text:=PRecordSet(TLMaster[idx]).DescJ;
  edtKana.Text:=PRecordSet(TLMaster[idx]).Kana;
  Edit1.Text:=PRecordSet(TLMaster[idx]).DescE; // Edit1を最後に更新
  
  ShowGameInfo(idx); // 右側部分更新

  EditUpdating:=False;

end;

// 右側のゲーム情報表示
procedure TForm1.ShowGameInfo(const idx: integer);
begin

  edtZipName.Text:=PRecordSet(TLMaster[idx]).ZipName;
  memCPU.Text:=AnsiReplaceStr(PRecordSet(TLMaster[idx]).CPUs,',',#13#10);
  memSound.Text:=AnsiReplaceStr(PRecordSet(TLMaster[idx]).Sounds,',',#13#10);
  memDisp.Text:=AnsiReplaceStr(PRecordSet(TLMaster[idx]).Screens,',',#13#10);
  edtSource.Text:=PRecordSet(TLMaster[idx]).Source;
  EditUpdating:=False;
  Panel9.Repaint;

end;

// オリジナル名ダブルクリックで選択
procedure TForm1.Edit1DblClick(Sender: TObject);
begin
  Edit1.SelStart:=0;
  Edit1.SelLength:=Length(Edit1.Text);
end;

// Undo用データの保持と未訳の判断
procedure TForm1.Edit1Change(Sender: TObject);
begin
  if Edit1.Text<>'' then
  begin

    if (edtDescJ.Text=Edit1.Text) and (edtKana.Text=Edit1.Text) then
      StatusBar1.Panels[2].Text:='未訳'
    else
      StatusBar1.Panels[2].Text:='';

    OldDescJ:=edtDescJ.Text;
    OldKana :=edtKana.Text;

  end;

  if ( Edit1.Text=edtDescJ.Text ) then
  begin
    label1.Caption:='';
  end
  else
  begin
    label1.Caption:='*';
  end;

end;

// 日本語名editboxの各処理
procedure TForm1.edtDescJChange(Sender: TObject);
var i:integer;
begin

  // 外部からの更新でないとき
  if (EditUpdating=False) and (Edit1.Text<>'') then
  begin

    PRecordset(TLMaster[EditingIndex]).DescJ:=edtDescJ.Text;

    // メインリストの更新
    // 表示領域内にある場合のみ
    for i:=ListView1.TopItem.Index to
           ListView1.TopItem.Index+ ListView1.VisibleRowCount do
    begin
      if i=ListView1.Items.Count then break;

      if StrtoInt(ListView1.Items[i].SubItems[5])=EditingIndex then
      begin
        ListView1.UpdateItems(i,i);
        break;
      end;
    end;

    // サブリストの更新
    ListView2.ItemFocused.Caption:=edtDescJ.Text;
    
    if (edtDescJ.Text=Edit1.Text) and (edtKana.Text=Edit1.Text) then
    begin
      ListView2.ItemFocused.SubItems[5]:='×';
      StatusBar1.Panels[2].Text:='未訳'
    end
    else
    begin
      ListView2.ItemFocused.SubItems[5]:='○';
      StatusBar1.Panels[2].Text:='';
    end;

    ListView2.UpdateItems(ListView2.ItemFocused.Index,ListView2.ItemFocused.Index);

    //
    Edited:=True;
    StatusBar1.Panels[1].Text:='変更あり';

  end;

  if ( Edit1.Text=edtDescJ.Text ) then
  begin
    label1.Caption:='';
  end
  else
  begin
    label1.Caption:='*';
  end;

end;

procedure TForm1.edtDescJEnter(Sender: TObject);
begin
  edtDescJ.SelStart:=0;

  if Pos(' (',edtDescJ.Text)<>0 then
    edtDescJ.SelLength:=Pos(' (',edtDescJ.Text)-1
  else
    edtDescJ.SelectAll;
end;

procedure TForm1.edtDescJExit(Sender: TObject);
begin
  if edtDescJ.Enabled=False then exit;

  if edtDescJ.Text='' then
    edtDescJ.Text:=PRecordset(TLMaster[EditingIndex]).DescE;
end;

procedure TForm1.edtDescJDblClick(Sender: TObject);
begin

  edtDescJ.SelStart:=0;

  if Pos(' (',edtDescJ.Text)<>0 then
    edtDescJ.SelLength:=PosEx(' (',edtDescJ.Text)-1
  else
    edtDescJ.SelectAll;

end;

// よみがなEditBoxの各処理
procedure TForm1.edtKanaDblClick(Sender: TObject);
begin
  edtKana.SelectAll;
end;

procedure TForm1.edtKanaExit(Sender: TObject);
begin
  if edtKana.Text='' then
    edtKana.Text:=PRecordset(TLMaster[EditingIndex]).DescE;
end;

procedure TForm1.edtKanaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if (Key=VK_RETURN) and (ssShift in Shift) then
  begin

    if ListView1.ItemIndex < ListView1.Items.Count-1 then
    begin
      ListView1.Items[ListView1.ItemIndex +1].Focused:=True;
      ListView1.ItemFocused.Selected:=True;
      ListView1.ItemFocused.MakeVisible(False);
      edtKana.SetFocus;
      edtKana.SelectAll;
    end;

    exit;
  end;

  if (Key=VK_RETURN) then
  begin

    edtDescJ.SetFocus;
  end;

end;

procedure TForm1.edtKanaKeyPress(Sender: TObject; var Key: Char);
begin

  if Key=#13 then
    Key:=#0;

end;

procedure TForm1.edtKanaChange(Sender: TObject);
begin

  // 外部からの更新でないとき
  if (EditUpdating=False) and (Edit1.Text<>'') then
  begin
    PRecordset(TLMaster[EditingIndex]).Kana:=edtKana.Text;

    Edited:=True;
    Form1.StatusBar1.Panels[1].Text:='変更あり';


    // サブリストの更新
    
    if (edtDescJ.Text=Edit1.Text) and (edtKana.Text=Edit1.Text) then
    begin
      ListView2.ItemFocused.SubItems[5]:='×';
      StatusBar1.Panels[2].Text:='未訳'
    end
    else
    begin
      ListView2.ItemFocused.SubItems[5]:='○';
      StatusBar1.Panels[2].Text:='';
    end;

    ListView2.UpdateItems(ListView2.ItemFocused.Index,ListView2.ItemFocused.Index);

  end;

end;


procedure TForm1.Button1Click(Sender: TObject);
begin
  edtDescJ.Text:=OldDescJ;
  edtKana.Text:=OldKana;
end;

procedure TForm1.Button2Click(Sender: TObject);

  function IsNumeric(S : string) : boolean;
  var
    E : integer;
    R : integer;
  begin
    Val(S, R, E);
    Result  :=  (E = 0);
  end;


var SelMasterID: Integer;
    masterkana, st, desc: string;
    i: integer;
begin

  SelMasterID:=PRecordSet(TLMaster[CurrentIndex]).MasterID;
  masterkana:=PRecordSet(TLMaster[SelMasterID]).Kana;

  if IDYES=MessageBox(Form1.Handle,
                      PChar('マスタセットの読み仮名「'+masterkana+'」を元に自動処理します。'),
                      APPNAME, MB_YESNO or MB_ICONQUESTION) then
  begin

      // クローンセット
      for i:=0 to TLMaster.Count-1 do
      begin
        if (PRecordSet(TLMaster[i]).MasterID=SubListID) and
           (PRecordSet(TLMaster[i]).Master=False) then
        begin

          // ゲーム名に set ##がある場合は処理する
          desc:=PRecordSet(TLMaster[i]).DescE;

          if pos('set ', desc ) <>0 then
          begin

            // 二桁の場合
            st := copy( desc, pos('set ', desc)+4, 2);
            if IsNumeric(st) then
            begin
              PRecordSet(TLMaster[i]).Kana := masterkana+st;
            end
            else
            begin
              // 一桁の場合
              st := copy( desc, pos('set ', desc)+4, 1);
              if IsNumeric(st) then
              begin
                PRecordSet(TLMaster[i]).Kana := masterkana+'0'+st;
              end;

            end;

          end
          else
          begin
            // setがない場合は元の説明部分をそのまま追加
            st:= copy( desc, pos('(',desc), length(desc));
            PRecordSet(TLMaster[i]).Kana := masterkana+st;

          end;
        end;
      end;

      // 親セットも処理する

      // ゲーム名に set ##がある場合は処理する
          desc:=PRecordSet(TLMaster[SelMasterID]).DescE;

          if pos('set ', desc ) <>0 then
          begin

            // 二桁の場合
            st := copy( desc, pos('set ', desc)+4, 2);
            if IsNumeric(st) then
            begin
             PRecordSet(TLMaster[SelMasterID]).Kana := masterkana+st;
            end
            else
            begin
              // 一桁の場合
              st := copy( desc, pos('set ', desc)+4, 1);
              if IsNumeric(st) then
              begin
                PRecordSet(TLMaster[SelMasterID]).Kana := masterkana+'0'+st;
              end;

            end;

          end
          else
          begin
            // setがない場合はそのまま追加
            PRecordSet(TLMaster[SelMasterID]).Kana := masterkana;

          end;

  end;

  // 編集ウィンドウに情報表示
  UpdateEditPanel(CurrentIndex);

end;


procedure TForm1.Button3Click(Sender: TObject);
  function IsNumeric(S : string) : boolean;
  var
    E : integer;
    R : integer;
  begin
    Val(S, R, E);
    Result  :=  (E = 0);
  end;


var SelMasterID: Integer;
    masterkana: string;
    i: integer;
begin

  SelMasterID:=PRecordSet(TLMaster[CurrentIndex]).MasterID;
  masterkana:=PRecordSet(TLMaster[SelMasterID]).Kana;

  if IDYES=MessageBox(Form1.Handle,
                      PChar('このセットファミリのゲーム名をリセットします。'),
                      APPNAME, MB_YESNO or MB_ICONQUESTION) then
  begin

      // クローンセット
      for i:=0 to TLMaster.Count-1 do
      begin
        if (PRecordSet(TLMaster[i]).MasterID=SubListID) and
           (PRecordSet(TLMaster[i]).Master=False) then
        begin

          PRecordSet(TLMaster[i]).DescJ := PRecordSet(TLMaster[i]).DescE;

        end;
      end;

      // 親セットも処理する

      PRecordSet(TLMaster[SelMasterID]).DescJ := PRecordSet(TLMaster[SelMasterID]).DescE;

      updatelistview;

  end;

end;

procedure TForm1.ToggleEditPanel(const Flag: boolean);
begin

  Edit1.Enabled:=Flag;
  edtDescJ.Enabled:=Flag;
  edtKana.Enabled:=Flag;
  Button1.Enabled:=Flag;
  Button2.Enabled:=Flag;
  Button3.Enabled:=Flag;

  ListView2.Enabled:=Flag;
  edtZipName.Enabled:=Flag;

  if Flag then
  begin
    edtDescJ.Color:=clWindow;
    edtKana.Color:=clWindow;
  end
  else
  begin
    edtDescJ.Color:=clBtnFace;
    edtKana.Color:=clBtnFace;
    StatusBar1.Panels[2].Text:='';

    EditUpdating:=True;
    edtDescJ.Text:='';
    edtKana.Text:='';
    Edit1.Text:='';
    memCPU.Text:='';
    memSound.Text:='';
    memDisp.Text:='';
    edtSource.Text:='';
    edtZipName.Text:='';
    EditUpdating:=False;
    ListView2.Items.Clear;
    SubListID:=-1;
  end;

end;


procedure TForm1.ListView2SelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);

begin

  // 選択時に更新前と更新後の2回呼び出されるので前の方をはじく
  // 更新前: Selected=False, Item.Index=不定
  // 更新後: Selected=True,  Item.Index=あり
  if not Selected then exit;

  // 外部から更新している場合は抜ける
  if DoNotUpdateSL then exit;

  // 選択中のインデックス
  EditingIndex:=StrtoInt(Item.SubItems[6]);
  CurrentIndex:=EditingIndex;


  // コマンドビュー
  frmCommand.LoadCommand(
          PRecordSet(TLMaster[ CurrentIndex ]).ZipName,
          PRecordSet(TLMaster[ PRecordSet(TLMaster[CurrentIndex]).MasterID ]).ZipName );


  // 編集ウィンドウに情報表示
  UpdateEditPanel(EditingIndex);

  // ステータスバー
  StatusBar1.Panels[3].Text:=PRecordSet(TLMaster[EditingIndex]).DescE;

  // ゲームステータスアイコン表示
  UpdateStatus;

  // アクション
  actROpenSrc.Hint:=PRecordSet(TLMaster[EditingIndex]).Source;
  SelZip:=Item.SubItems[0]; // 選択中のZip名

  // スナップショット
  ShowSnapshot(EditingIndex);

  // dat
  FindDat(CurrentIndex);

  actDelUpdate(nil);

end;

// Enterキーで起動
procedure TForm1.ListView2KeyPress(Sender: TObject; var Key: Char);
begin

  if Key=#13 then
  begin
    Key:=#0;
    actPlayExecute(nil);
  end;

end;


procedure TForm1.actFSaveMame32jExecute(Sender: TObject);
begin
  SaveMame32j;
end;

procedure TForm1.actFWSaveMame32jExecute(Sender: TObject);
begin
  WSaveMame32j;
end;


// INP記録起動
procedure TForm1.actFRecUpdate(Sender: TObject);
begin

  actPlayUpdate(nil);   // パス関係のチェック

  actFRec.Enabled:= actPlay.Enabled;

end;

// お気に入り追加
{procedure TForm1.actFAVAddExecute(Sender: TObject);
var
  i: integer;
begin

  // 数チェック
  if favorites.Count >= MAXFAVORITES then
  begin
    Application.MessageBox(PWideChar('お気に入りの最大数は '+InttoStr(MAXFAVORITES)+' 件です。'), APPNAME, MB_ICONSTOP );
    exit;
  end;

  // 重複チェック
  for i := 0 to favorites.Count - 1 do
  begin
    if favorites[i]=SelZip then
    begin
      Application.MessageBox(PWideChar(SelZip+' はお気に入りに登録済みです。'), APPNAME, MB_ICONSTOP );
      exit;
    end;
  end;

  favorites.Add(SelZip);

  beep;

end;
 }
procedure TForm1.actFAVAddUpdate(Sender: TObject);
begin

//  actFAVAdd.Enabled := ListView1.Items.Count<>0;

end;

procedure TForm1.actFRecExecute(Sender: TObject);
var opt: string;
begin

  SaveDialog1.Filter:='リプレイファイル(*.inp, *.zip)|*.inp;*.zip';
  SaveDialog1.Title:='記録するinpファイル名';

  if DirectoryExists(inpDir) then
    SaveDialog1.FileName:=inpDir+'\'+SelZip+'@'+MameExe[CurrentProfile].Title+'.inp'
  else
  begin
    SaveDialog1.InitialDir:=ExeDir;
    SaveDialog1.FileName:=SelZip+'@'+MameExe[CurrentProfile].Title+'.inp'
  end;

  //
  opt:= '';
  if MameExe[CurrentProfile].OptEnbld then
    opt:= MameExe[CurrentProfile].Option;

  if SaveDialog1.Execute then
  begin

    ExecuteMAME(SelZip,
                MameExe[CurrentProfile].ExePath, MameExe[CurrentProfile].WorkDir,
                opt+
                ' -record '+ ExtractFileName(SaveDialog1.FileName)+
                ' -input_directory "'+ LongToShortFileName(ExtractFileDir(SaveDialog1.FileName))+'"' );
  end;

end;

// inp再生
procedure TForm1.actFReplayUpdate(Sender: TObject);
begin

  actPlayUpdate(nil);   // パス関係のチェック
  actFReplay.Enabled:= actPlay.Enabled;

end;

procedure TForm1.actFReplayExecute(Sender: TObject);
var i, TempProfile: integer;
    st: string;
    opt: string;
    zip: string;
begin

  OpenDialog1.Filter:='リプレイファイル(*.inp)|*.inp';
  OpenDialog1.Title:='再生するinpファイルを選択';

  if DirectoryExists(inpDir) then
    OpenDialog1.InitialDir:=inpDir
  else
    OpenDialog1.InitialDir:=ExeDir;

  if OpenDialog1.Execute then
  begin

    // 実行ファイルを探す
    TempProfile:=CurrentProfile;
    st:=ExtractFileName(OpenDialog1.FileName);
    st:=Copy(st,pos('@',st)+1,pos('.inp',st)-pos('@',st)-1);
    for i:=0 to Length(MameExe)-1 do
    begin
      if st=MameExe[i].Title then
      begin
        TempProfile:=i;
        break;
      end;
    end;

    // 起動対象のゲーム名を取得する
    zip:=GetInpGame(OpenDialog1.FileName);

    if zip='' then
    begin
      Windows.MessageBox(Form1.Handle,'INPファイルが正しくありません。','エラー', MB_ICONERROR);
      exit;
    end;

    opt:= '';
    if MameExe[CurrentProfile].OptEnbld then
      opt:= MameExe[CurrentProfile].Option;

    ExecuteMAME(zip,
                MameExe[TempProfile].ExePath, MameExe[TempProfile].WorkDir,
                opt+
                ' -playback '+ ExtractFileName(OpenDialog1.FileName)+
                ' -input_directory "'+ LongToShortFileName(ExtractFileDir(OpenDialog1.FileName))+'"' );

  end;

end;

procedure TForm1.actOUpdateResExecute(Sender: TObject);
var i,j,k:integer;
    result:integer;
begin
  //
  
  if Form2.ShowModal=mrCancel then
  begin
    exit;
  end;

  // ROMステータスの一時待避
  SetLength(ROMTemp,TLMaster.Count);
  for i:=0 to TLMaster.Count-1 do
  begin
    ROMTemp[i].Zip:=PRecordset(TLMaster[i]).ZipName;
    ROMTemp[i].ROM:=PRecordset(TLMaster[i]).ROM;
  end;

  // Sampleステータスの一時待避
  SetLength(SampleTemp,TLMaster.Count);
  for i:=0 to TLMaster.Count-1 do
  begin
    SampleTemp[i].Zip:=PRecordset(TLMaster[i]).ZipName;
    SampleTemp[i].Sample:=PRecordset(TLMaster[i]).Sample;
  end;

  result:= LoadResource;

  if result=1 then
  begin
    if FileExists(ExeDir+'listxml.tmp') then
      DeleteFile(ExeDir+'listxml.tmp');

    Application.MessageBox('データファイルの読み込みに失敗しました。'+CRLF+
          '正しいMAME本体を選択してください。',APPNAME, MB_ICONERROR + MB_OK);
    Application.Terminate;
    Exit;
  end
  else
  if result=2 then
  begin
    if FileExists(ExeDir+'listxml.tmp') then
      DeleteFile(ExeDir+'listxml.tmp');

    Application.MessageBox('データファイルの読み込みに失敗しました。'+CRLF+
          'MAME側のLIST.XMLフォーマットが変更された可能性があります。',APPNAME, MB_ICONERROR + MB_OK);
    Application.Terminate;
    Exit;
  end;

  CreateZipIndex; // ZIP名のインデックス作成

  //

  if ReadMame32jlst=False then
    ReadLang;

  // ROMステータス復旧
  k:=0;
  for i:=0 to TLMaster.Count-1 do
  begin
    for j:=k to Length(ROMTemp)-1 do
    begin
      if PRecordset(TLMaster[i]).ZipName=ROMTemp[j].Zip then
      begin
        PRecordset(TLMaster[i]).ROM:=ROMTemp[j].ROM;
        k:=j+1;
        break;
      end;
    end;
  end;

  Finalize( ROMTemp );

  // Sampleステータス復旧
  k:=0;
  for i:=0 to TLMaster.Count-1 do
  begin
    for j:=k to Length(SampleTemp)-1 do
    begin
      if PRecordset(TLMaster[i]).ZipName=SampleTemp[j].Zip then
      begin
        PRecordset(TLMaster[i]).Sample:=SampleTemp[j].Sample;
        k:=j+1;
        break;
      end;
    end;
  end;
//  SetLength(SampleTemp,0);
  Finalize( SampleTemp );

  // 各データの再読み込み
  ReadHistoryDat;
  ReadMameInfoDat;
  SetVersionINI;

  // Form Title更新
  SetFormTitle;

  // 絞り込みリセット
  CurrentAssort:=0;


  UpdateListView;
  
end;



procedure TForm1.actOUseAltExeExecute(Sender: TObject);
begin
  UseAltExe := (not UseAltExe);
end;

procedure TForm1.actOUseAltExeUpdate(Sender: TObject);
begin
  actOUseAltExe.Checked:=UseAltExe;
end;

// フォームのタイトル設定
procedure TForm1.SetFormTitle;
var st: string;
begin

  st:=APPNAME;

  if (MameExe[CurrentProfile].ExePath<>'') then
  begin
    st:=st+ ' - '+MameExe[CurrentProfile].Title+' (' + MameExe[CurrentProfile].ExePath;

    if ((MameExe[CurrentProfile].Option<>'') and (MameExe[CurrentProfile].OptEnbld)) then
    begin
      st:=st+ ' '+MameExe[CurrentProfile].Option;      
    end;

    st:=st+')';
    
  end;

  if DatVersion<>'' then
    st:=st+' - '+DatVersion;
    
  {
  if (MameExe[CurrentProfile].ExePath<>'') and
     (MameExe[CurrentProfile].Option<>'') then
    Form1.Caption:=APPNAME+' - '+MameExe[CurrentProfile].Title+' ('+
                 MameExe[CurrentProfile].ExePath+' '+
                 MameExe[CurrentProfile].Option+')'
  else
  if MameExe[CurrentProfile].ExePath<>'' then
    Form1.Caption:=APPNAME+' - '+MameExe[CurrentProfile].Title+' ('+
                 MameExe[CurrentProfile].ExePath+')'
  else
    Form1.Caption:=APPNAME;

  if DatVersion<>'' then
    Form1.Caption:=Form1.Caption+' - '+DatVersion;
  }
  
  Form1.Caption := st;

end;


procedure TForm1.ListView1Exit(Sender: TObject);
begin

  actDelAllCfg.Enabled:=False;

end;

procedure TForm1.ListView2AdvancedCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; Stage: TCustomDrawStage;
  var DefaultDraw: Boolean);
begin
  if Item.Index mod 2 = 1 then
    ListView2.Canvas.Brush.Color:=$f5f5f5;
end;

procedure TForm1.ListView2Data(Sender: TObject; Item: TListItem);
  var i: integer;
begin
  i:=Item.Index;

  if En then
    Item.Caption:=PRecordSet(TLFamily[i]).DescE
  else
    Item.Caption:=PRecordSet(TLFamily[i]).DescJ;
  Item.SubItems.Add(PRecordSet(TLFamily[i]).ZipName);
  Item.Subitems.Add(PRecordSet(TLFamily[i]).Maker);
  Item.Subitems.Add(PRecordSet(TLFamily[i]).Year);
  Item.Subitems.Add(PRecordSet(TLFamily[i]).CloneOf);
  Item.Subitems.Add(PRecordSet(TLFamily[i]).Source);

  if (PRecordSet(TLFamily[i]).DescJ=PRecordSet(TLFamily[i]).DescE) and
    (PRecordSet(TLFamily[i]).Kana=PRecordSet(TLFamily[i]).DescE) then
    Item.Subitems.Add('×')
  else
    Item.Subitems.Add('○');

  Item.Subitems.Add(InttoStr(PRecordSet(TLFamily[i]).ID));

  // アイコン
  if PRecordSet(TLFamily[i]).Status then
    if PRecordSet(TLFamily[i]).Master then
      Item.ImageIndex:=0
    else
      Item.ImageIndex:=1
  else
    if PRecordSet(TLFamily[i]).Master then
      Item.ImageIndex:=2
    else
      Item.ImageIndex:=3;

  if PRecordset(TLFamily[i]).ROM=False then
    Item.ImageIndex:=Item.ImageIndex+4;

end;

procedure TForm1.ListView2Exit(Sender: TObject);
begin

  actDelAllCfg.Enabled:=False;
  
end;

procedure TForm1.Action1Execute(Sender: TObject);
begin

  Application.Minimize;

end;

procedure TForm1.memCPUChange(Sender: TObject);
begin

  if memCPU.Lines.Count>8 then
    memCPU.ScrollBars:=ssVertical
  else
    memCPU.ScrollBars:=ssNone;
                             
end;

                             
procedure TForm1.SpeedButton3Click(Sender: TObject);
begin

  if InfoPanel then
  begin
    InfoPanel:=False;
    Bevel5.Visible:=False;
    Panel9.Height:=25;
    SpeedButton3.Glyph:=nil;
    ImageList2.GetBitmap(32,SpeedButton3.Glyph);
    Memo1Change(Nil);
    Panel9.Repaint;
  end
  else
  begin
    InfoPanel:=True;
    Bevel5.Visible:=True;
    Panel9.Height:=300;
    SpeedButton3.Glyph:=nil;
    ImageList2.GetBitmap(33,SpeedButton3.Glyph);
    Memo1Change(Nil);
  end;

end;

procedure TForm1.ApplicationEvents1SettingChange(Sender: TObject;
  Flag: Integer; const Section: String; var Result: Integer);
begin

  UpdateStatus;

  // ListView用アイコンの背景色
  ImageList1.BkColor:=clBtnFace;

end;

procedure TForm1.FormResize(Sender: TObject);
begin
  Memo1Change(Nil);
end;


procedure TForm1.Memo1Change(Sender: TObject);
var BMP: TBitmap;
var lineHeight: Integer;
begin

  if ChangingMemo then exit;

  Memo1.Lines.BeginUpdate;

  memSub.Font:=Memo1.Font;
  memSub.Text:=Memo1.Text;
  memSub.Width:=Memo1.Width;

  BMP:=TBitMap.Create;
  TRY
    BMP.Canvas.Font.Assign(Memo1.Font);
    lineHeight:= BMP.Canvas.TextHeight('Hj');
  FINALLY
    FreeAndNIL(BMP)
  END;

  if ((lineHeight * (memSub.Lines.Count +1)) > Memo1.ClientHeight)
    and (Memo1.ScrollBars = ssNone) then
  begin
    ChangingMemo:=True;
    Memo1.ScrollBars := ssVertical;
  end
  else
  if ((lineHeight * (memSub.Lines.Count +1)) <= Memo1.ClientHeight)
    and (Memo1.ScrollBars = ssVertical) then
  begin
    ChangingMemo:=True;
    Memo1.ScrollBars := ssNone;
  end;

  ChangingMemo:=False;
  Memo1.Lines.EndUpdate;

end;

procedure ListView1DataFind(Sender: TObject; Find: TItemFind;
      const FindString: WideString; const FindPosition: TPoint;
      FindData: Pointer; StartIndex: Integer; Direction: TSearchDirection;
      Wrap: Boolean; var Index: Integer);
var
  i: Integer;
  Found: Boolean;
begin

  i := StartIndex;

  if (Find = ifExactString) or (Find = ifPartialString) then
  begin
    repeat

      // 一番下まで行ったら先頭から検索を続ける
      if (i = TLSub.Count) then
        if Wrap then i := 0 else Exit;

      if En then
        Found := Pos(WideLowerCase(FindString), WideLowerCase(PRecordset(TLSub[i]).DescE)) = 1
      else
        Found := Pos(WideLowerCase(FindString), WideLowerCase(PRecordset(TLSub[i]).DescJ)) = 1;

      if not Found then Inc(i);

    until Found or (i = StartIndex);

    if Found then Index := i;

  end;

end;

procedure TForm1.FormKeyPress(Sender: TObject; var Key: Char);
begin

  if edtDescJ.Focused or edtKana.Focused then
    exit;

  if Key=#8 then
  begin
    actSFocusExecute(nil);
    exit;
  end;

end;

procedure TForm1.actVTakeOutUpdate(Sender: TObject);
begin

  actVTakeOut.Enabled:= ( Pos('0000.png',CurrentShot)<>0 );

end;

// フォルダから取り出す
//
procedure TForm1.actVTakeOutExecute(Sender: TObject);
var
  ZipName: String;

begin

  if Pos('0000.png',CurrentShot)<>0 then
  begin

    ZipName:=Copy(CurrentShot,Length(SnapDir)+2,Length(CurrentShot));
    ZipName:=Copy(ZipName,1,Pos('\',ZipName)-1);

    try
      if RenameFile(SnapDir+'\'+ZipName+'\0000.png',
                    SnapDir+'\'+ZipName+'.png') then
      begin
        RemoveDir(SnapDir+'\'+ZipName);

        CurrentShot:=SnapDir+'\'+ZipName+'.png';
      end;

    except
      
    end;


  end;

end;

// 英語のリスト出力
procedure TForm1.Action2Execute(Sender: TObject);
begin
  SaveMamelst;
end;


procedure TForm1.Action3Execute(Sender: TObject);
var s, st, cpu, sound, maker, output: string;
var i, Idx:integer;
var SelMasterID, count: integer;
begin

  //
  // "ゲーム名","開発元","販売元","年度","ジャンル",
  // "コントローラ","システムボード","CPU","サウンド",
  // "解像度","色数","","サポート","説明","セット1",
  // "セット2","セット3","セット4","セット5","セット6",
  // "セット7","セット8","セット9","セット10",
  // "分類1","分類2","分類3","分類4","分類5","分類6","分類7","分類8","分類9","分類10"

  output:='';

for Idx := 0 to TlMaster.Count - 1 do
begin

  if (PRecordset(TLMaster[idx]).isMechanical=True) and (PRecordset(TLMaster[idx]).Kana = PRecordset(TLMaster[idx]).DescE) and
     (PRecordset(TLMaster[idx]).Master=True) then
  begin
	  s:='';
	  cpu:='';
	  sound:='';
    st:='';

	  // desc
	  st:=PRecordSet(TLMaster[idx]).DescE;
	  if pos('(', st)<>0 then
	  begin
	    s:=copy(st,pos('(',st)+1, pos(')',st)-pos('(',st)-1);
	    st:= trim(copy(st,1,pos('(',st)-1));
	  end;

	  // manu
	  maker:=PRecordSet(TLMaster[idx]).Maker;

    if (maker = 'Data East') then
    begin
	    st:=st+#9+'データイースト';
	    st:=st+#9+'データイースト';
    end
    else
    if (maker = 'Sega') then
    begin
	    st:=st+#9+'セガ';
	    st:=st+#9+'セガ';
    end
    else
    if (maker = 'Taito') then
    begin
	    st:=st+#9+'タイトー';
	    st:=st+#9+'タイトー';
    end
    else
    if (maker = 'Capcom') then
    begin
	    st:=st+#9+'カプコン';
	    st:=st+#9+'カプコン';
    end
    else
    begin

  	  if (maker = 'Unknown') then
	      maker:= 'メーカー不明';

	    st:=st+#9+'※海外製品（'+maker+'）';

      st:=st+#9+'';

    end;


	  // dist
//	  st:=st+#9+'';

	  // year
	  st:=st+#9+PRecordSet(TLMaster[idx]).Year;

	  // genre
	  st:=st+#9+'※ピンボール';

	  // genre2
	  st:=st+#9+'';

	  // ctrler
	  st:=st+#9+'';

	  // sys
	  st:=st+#9;

	  // CPU
	  cpu:=AnsiReplaceStr( PRecordSet(TLMaster[idx]).CPUs,',',', ');
	  if pos('@',cpu)<>0 then
	  begin
	    cpu:=copy(cpu,1,pos('@',cpu)-2)+copy(cpu,pos('Hz',cpu)+2,length(cpu));
	  end;

	  if pos('@',cpu)<>0 then
	  begin
	    cpu:=copy(cpu,1,pos('@',cpu)-2)+copy(cpu,pos('Hz',cpu)+2,length(cpu));
	  end;

	  if pos('@',cpu)<>0 then
	  begin
	    cpu:=copy(cpu,1,pos('@',cpu)-2)+copy(cpu,pos('Hz',cpu)+2,length(cpu));
	  end;

	  st:=st+#9+cpu;

	  // Sound
	  sound:=AnsiReplaceStr( PRecordSet(TLMaster[idx]).Sounds,',',', ');
	  if pos('@',sound)<>0 then
	  begin
	    sound:=copy(sound,1,pos('@',sound)-2)+copy(sound,pos('Hz',sound)+2,length(sound));
	  end;
	  if pos('@',sound)<>0 then
	  begin
	    sound:=copy(sound,1,pos('@',sound)-2)+copy(sound,pos('Hz',sound)+2,length(sound));
	  end;
	  if pos('@',sound)<>0 then
	  begin
	    sound:=copy(sound,1,pos('@',sound)-2)+copy(sound,pos('Hz',sound)+2,length(sound));
	  end;
	  st:=st+#9+sound;

	  // Reso
	  st:=st+#9+ '';

	  // Col
	  st:=st+#9+ InttoStr(PRecordSet(TLMaster[idx]).Palettesize);

	  //
	  st:=st+#9+ '●';

	  // ver
	  //st:=st+#9+ 'v'+Copy(DatVersion, 1, Pos(' (',DatVersion)-1);
	  st:=st+#9+ 'v'+DatVersion; // 日付は無くなった

	  // desc
	  st:=st+#9;


	  // 全セット追加
	  count:=0;
	  SelMasterID:=PRecordSet(TLMaster[idx]).MasterID;
	  for i:=0 to TLMaster.Count-1 do
	  begin
	    if (PRecordSet(TLMaster[i]).MasterID=SelMasterID) then
	    begin
	      st:=st+#9+PRecordSet(TLMaster[i]).ZipName;
	      inc(Count);
	    end;

	    if Count=12 then
	      break;
	  end;

	  for i := Count+1 to 12 do
	  begin
	    st:=st+#9;
	  end;

	  st:=st+#9+#9+#9+#9+#9+#9+#9+#9+#9+#9+#9+#9+#13#10;

    output:=output+st;

  end;

end;

  Clipboard.AsText := output;
  beep;
end;

procedure TForm1.Action4Execute(Sender: TObject);
begin
  Button2.Click;
end;

procedure TForm1.actFAVManageExecute(Sender: TObject);
begin

  Form3.ShowModal;

end;


procedure TForm1.actFavOpenExecute(Sender: TObject);
begin

  frmFavorites.ShowModal;

end;

procedure TForm1.actFavoriteAddExecute(Sender: TObject);
var i: Integer;
    zip,kind: String;
begin

  // 数チェック
  if favorites2.Count >= MAXFAVORITES2 then
  begin
    Application.MessageBox(PWideChar('お気に入りの最大数は '+InttoStr(MAXFAVORITES2)+' 件です。'), APPNAME, MB_ICONSTOP );
    exit;
  end;

  // 重複チェック
  for i := 0 to favorites2.Count - 1 do
  begin

    kind := copy(favorites2[i], 1, pos( #9, favorites2[i] ) -1 );
    zip := copy(favorites2[i], pos( #9, favorites2[i] )+1, favorites2[i].Length);

    if (kind<>'f') AND ( zip=SelZip ) then
    begin
      Application.MessageBox( PWideChar(SelZip+' はお気に入りに登録済みです。'), APPNAME, MB_ICONSTOP );
      exit;
    end;

  end;

  favorites2.Add( '-1'+ #9 + SelZip );

  beep;

end;

procedure TForm1.actFavoriteAddUpdate(Sender: TObject);
begin

  actFavoriteAdd.Enabled := ListView1.Items.Count<>0;

end;

procedure TForm1.actFCleanupSnapsExecute(Sender: TObject);
begin

  Form6.ShowModal;

end;



procedure TForm1.actFEmmaExecute(Sender: TObject);
begin
  if (SelZip<>'') // 選択項目
  then
    ShellExecute( Form1.Handle,
                  'open',
                  PChar('http://www.progettoemma.net/gioco.php?game='+SelZip),
                  nil,
                  nil,
                  SW_SHOW);
end;

procedure TForm1.actFEmmaUpdate(Sender: TObject);
begin
  // 対象なし
  if SelZip='' then
  begin
    actFEmma.Caption :='&EMMAで検索...';
    actFEmma.Enabled := False;
  end
  else
  // あり
  begin
    actFEmma.Caption := '「'+SelZip+'」を&EMMAで検索...';
    actFEmma.Enabled := True;
  end;
end;

// お気に入りの起動
procedure TForm1.RunFavorite(Sender: TObject);
begin

  // プロファイル未選択
  if CurrentProfile=-1 then exit;

  // 実行ファイル確認
  if (FileExists(MameExe[CurrentProfile].ExePath)) and
     ((DirectoryExists(MameExe[CurrentProfile].WorkDir) or
      (MameExe[CurrentProfile].WorkDir='')))
  then
  begin

    RunMAME( favorites[(Sender as TAction).Tag] );

  end;

end;

// お気に入りの起動新型
procedure TForm1.RunFavorite2(Sender: TObject);
var zip: String;
    tag: Integer;
begin

  // プロファイル未選択
  if CurrentProfile=-1 then exit;

  // 実行ファイル確認
  if (FileExists(MameExe[CurrentProfile].ExePath)) and
     ((DirectoryExists(MameExe[CurrentProfile].WorkDir) or
      (MameExe[CurrentProfile].WorkDir='')))
  then
  begin

    tag := (Sender as TAction).Tag;
    zip := copy(Favorites2[tag], pos( #9, Favorites2[tag] )+1, Favorites2[tag].Length);

    RunMAME( zip );

  end;

end;

procedure TForm1.Dummy(Sender: TObject);
begin
  // ダミー
  // アクションメニュー内のフォルダ用
end;

procedure TForm1.ActionMainMenuBar1Popup(Sender: TObject;
  Item: TCustomActionControl);
var
  i, idx, icoidx  :integer;
  st: string;
  AC  : TActionClientItem;
  n  :integer;
  kind,zip: String;
  folderIdx: Integer;

begin

  if (Item.Caption = ActionManager1.ActionBars[5].Items[3].caption) then begin

    // まず消す
    for i:=0 to Length(FavActions2)-1 do
    begin
      FavActions2[i].Free;
    end;

    if Favorites2.Count = 0 then begin
      setlength( FavActions2, 0 );
      exit;
    end;

    // お気に入りがあるメニュー位置
    AC:= ActionManager1.ActionBars[5].Items[3];

    n := 0;
    folderIdx := -1; //フォルダ未登録

    try
      for i:=0 to Favorites2.Count-1 do begin

        if (trim( Favorites2[i] ) <> '') AND ( Favorites2[i].Substring(1,1) <> '#' ) then begin

          setlength( FavActions2, n+1 );

          kind := copy(Favorites2[i], 1, pos( #9, Favorites2[i] ) -1 );
          zip := copy(Favorites2[i], pos( #9, Favorites2[i] )+1, Favorites2[i].Length);

          // フォルダ追加
          if ( kind = 'f' ) then begin
            if Length(zip)>40 then
            begin
              st:=copy(zip,0,40)+'...';
            end;

            FavActions2[n] := TAction.Create( self );
            FavActions2[n].Caption := zip;
            FavActions2[n].ImageIndex := 12;
            FavActions2[n].tag := i;
            FavActions2[n].ActionList:= ActionManager1;
            FavActions2[n].OnExecute := Dummy;

            AC.Items.Add.Action := FavActions2[n];
            Inc( folderIdx );
            AC.Items[0].CommandStyle := csMenu;
          end
          else
          // タイトル項目
          begin

            // zipから情報を取得する
            idx:= FindIndex( zip );

            /// 不明なゲーム
            if idx=-1 then
            begin
              st := zip + ' - <不明なゲーム>';
              icoidx := 8+39;
            end
            else
            /// 存在するゲーム
            begin
              if En then
                st := zip + ' - '+ PRecordSet(TLMaster[idx]).DescE
              else
                st := zip + ' - '+ PRecordSet(TLMaster[idx]).DescJ;

              if Length(st)>40 then
              begin
                st:=copy(st,0,40)+'...';
              end;

              // アイコン
              if PRecordSet(TLMaster[idx]).Status then
              begin
                if PRecordSet(TLMaster[idx]).Master then
                  icoidx:=39
                else
                  icoidx:=39+1;
              end
              else
              begin
                if PRecordSet(TLMaster[idx]).Master then
                  icoidx:=39+2
                else
                  icoidx:=39+3;
              end;

              if PRecordset(TLMaster[idx]).ROM=False then
                icoidx:=icoidx+3;
            end;

            FavActions2[n] := TAction.Create( self );
            FavActions2[n].Caption := st;
            FavActions2[n].ImageIndex := icoidx;
            FavActions2[n].tag := i;
            FavActions2[n].OnExecute := RunFavorite2;

            // ルート階層のタイトル
            if ( kind = '-1' ) then begin
              AC.Items.Add.Action := FavActions2[n];
              Inc(folderIdx);
            end
            else begin
              // 下階層のタイトル
              AC.Items[3+folderIdx].Items.Add.Action:=FavActions2[n];
            end;

          end;

          inc(n);
        end;
      end;

    except
      Application.MessageBox(PWideChar('お気に入りの読み込み時にエラーが起きました。'+#13#10+'設定ファイルを削除してやり直してください。'), APPNAME, MB_ICONSTOP );
      for i:=0 to Length(FavActions2)-1 do
      begin
        FavActions2[i].Free;
      end;

    end;

  end;

end;

procedure TForm1.ApplicationEvents1Activate(Sender: TObject);
begin

  if ListView1.Focused then
  begin

    if ListView1.ItemIndex=-1 then exit;

    // スナップショット
    ShowSnapshot(CurrentIndex);

    // アクション
    //actDelScreenShot.Enabled:=(CurrentShot<>'');
    actRRefine.Hint:=PRecordSet(TLSub[ListView1.ItemIndex]).Source;
    actROpenSrc.Hint:=PRecordSet(TLSub[ListView1.ItemIndex]).Source;

  end
  else
  if ListView2.Focused then
  begin

    if ListView2.ItemIndex=-1 then exit;

    actDelUpdate(nil); // 削除メニューの更新

    // スナップショット
    ShowSnapshot(EditingIndex);

  end;

end;

procedure TForm1.actOpenTestersUpdate(Sender: TObject);
begin

  // 対象なし
  if SelDriver='' then
  begin
    actOpenTesters.Caption :='&Testersで検索...';
    actOpenTesters.Enabled := False;
  end
  else
  // あり
  begin
    actOpenTesters.Caption := '「'+SelDriver+'」を&Testersで検索...';
    actOpenTesters.Enabled := True;
  end;

end;

procedure TForm1.actOpenTestersExecute(Sender: TObject);
begin
  if (SelDriver<>'') // 選択項目
  then
    ShellExecute( Form1.Handle,
                  'open',
                  PChar('http://mametesters.org/search.php?project_id=1&sticky_issues=on&sortby=last_updated&dir=DESC&hide_status_id=0&driver='+SelDriver),
                  nil,
                  nil,
                  SW_SHOW);
end;

procedure TForm1.actHistory2Execute(Sender: TObject);
begin

  Clipboard.AsText := FormatSets(TLMaster[CurrentIndex]);
  beep;

end;

procedure TForm1.actHistoryExecute(Sender: TObject);
begin

  Clipboard.AsText := FormatHistory(TLMaster[CurrentIndex]);
  beep;
  
end;

procedure TForm1.ListView1Enter(Sender: TObject);
begin

  ListView1SelectItem(Form1, ListView1.ItemFocused, True);

end;


procedure TForm1.ListView1DataFind(Sender: TObject; Find: TItemFind;
  const FindString: String; const FindPosition: TPoint; FindData: Pointer;
  StartIndex: Integer; Direction: TSearchDirection; Wrap: Boolean;
  var Index: Integer);
var
  i: Integer;
  Found: Boolean;
begin

  i := StartIndex;
  
  if (Find = ifExactString) or (Find = ifPartialString) then
  begin
    repeat

      // 一番下まで行ったら先頭から検索を続ける
      if (i = TLSub.Count) then
        if Wrap then i := 0 else Exit;

      if En then
        Found := Pos(LowerCase(FindString), LowerCase(PRecordset(TLSub[i]).DescE)) = 1
      else
        Found := Pos(LowerCase(FindString), LowerCase(PRecordset(TLSub[i]).DescJ)) = 1;

      if not Found then Inc(i);

    until Found or (i = StartIndex);

    if Found then Index := i;

  end;

end;


function TForm1.FormatHistory( Item: PRecordSet ) : String;
var s, st, cpu, sound, maker: string;
var SelMasterID, i, count: integer;
begin

  //
  // "ゲーム名","開発元","販売元","年度","ジャンル1","ジャンル2","コントローラ","システムボード","海外フラグ","サポート","説明",
  // "セット1","セット2","セット3","セット4","セット5","セット6","セット7","セット8","セット9","セット10","セット11","セット12",  .... "セット100"

  st:='';
  s:='';
  cpu:='';
  sound:='';

  // desc
  if PRecordSet(Item).DescE <> PRecordSet(Item).DescJ then
    st:=PRecordSet(Item).DescJ
  else
    st:=PRecordSet(Item).DescE;

  if pos('(', st)<>0 then
  begin
    s:=copy(st,pos('(',st)+1, pos(')',st)-pos('(',st)-1);
    st:= trim(copy(st,1,pos('(',st)-1));
  end;

  // manu
  maker:=PRecordSet(Item).Maker;
  if (maker = '<unknown>') then
    maker:= 'メーカー不明';


  if (maker = 'bootleg') then
  begin
    st:=st+#9+'※海賊版';
    st:=st+#9+'※海賊版';
  end
  else
  begin
    st:=st+#9+'※海外製品（'+maker+'）';
    st:=st+#9+'※国内販売なし';
  end;

  // year
  st:=st+#9+PRecordSet(Item).Year;

  // genre
  st:=st+#9+'※未分類';

  // genre2
  st:=st+#9+'';

  // ctrler
  st:=st+#9+'※未分類';

  // sys
  st:=st+#9;

  //
  st:=st+#9+ '●';

  // ver
//  st:=st+#9+ 'v'+Copy(DatVersion, 1, Pos(' (',DatVersion)-1);
  st:=st+#9+ trim('v'+DatVersion);

  // desc
  st:=st+#9;


  // 全セット追加
  count:=0;

  SelMasterID:=PRecordSet(TLMaster[PRecordset(Item).MasterID]).MasterID;
  for i:=0 to TLMaster.Count-1 do
  begin
    if (PRecordSet(TLMaster[i]).MasterID=SelMasterID) then
    begin
      st:=st+#9+PRecordSet(TLMaster[i]).ZipName;
      inc(Count);
    end;

    if Count=MAXSETS then
      break;
  end;

  Result:=St;

end;


function TForm1.FormatSets( Item: PRecordSet ) : String;
var s, st, cpu, sound: string;
var SelMasterID, i, count: integer;
begin

  //
  // "ゲーム名","開発元","販売元","年度","ジャンル1","ジャンル2","コントローラ","システムボード","海外フラグ","サポート","説明",
  // "セット1","セット2","セット3","セット4","セット5","セット6","セット7","セット8","セット9","セット10","セット11","セット12",  .... "セット100"

  st:='';
  s:='';
  cpu:='';
  sound:='';

  // 全セット追加
  count:=0;

  SelMasterID:=PRecordSet(TLMaster[PRecordset(Item).MasterID]).MasterID;
  for i:=0 to TLMaster.Count-1 do
  begin
    if (PRecordSet(TLMaster[i]).MasterID=SelMasterID) then
    begin
      st:=st+#9+PRecordSet(TLMaster[i]).ZipName;
      inc(Count);
    end;

    if Count=MAXSETS then
      break;
  end;

  Result:=trim(St);

end;

end.

