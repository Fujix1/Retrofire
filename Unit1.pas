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
    procedure Dummy(Sender: TObject); // �A�N�V�������j���[�������������邽�߂̃_�~�[

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
    { Private �錾 }

    EngExecuteFlag: Boolean;    // �p�ꁨ���{��ύX���̏I���`�F�b�N
    SB_HintText:  String;       // �X�e�[�^�X�o�[�̃q���g
//    JoyStick:     TJoyInfo;     // �W���C�X�e�B�b�N�̏��p
    OldDescJ, OldKana: String;  // �Q�[�����ҏWUndo�p
    EditUpdating     : boolean; // �Q�[�����ҏW�p
    SubListID  : Integer;       // �T�u���X�g�\������ROM�t�@�~���}�X�^ID

    JoyDelayTick: Cardinal;     // �W���C�X�e�B�b�N���s�[�g�p�A�����ꂽTickCount
    JoyStatus: TJoyStickStatus; //

    ChangingMemo: boolean;      // Memo�ύX��(�X�N���[���o�[�̕ύX)

    OriginProc: TWndMethod;     // ���̃E�B���h�E�֐��ێ��p

    bFormActivated: Boolean;        // AfterShow�����p

    procedure SubClassProc(var msg: TMessage); // �u���������b�Z�[�W�����֐�


    procedure ExecuteMAME(const ZipName:String;const ExePath:String;
              const WorkDir:String; const Option:String);

    procedure UpdateStatus;
    procedure UpdateEditPanel(const idx: integer);
    procedure ToggleEditPanel(const Flag: boolean);
    procedure ShowGameInfo(const idx: integer);
    procedure SetFormTitle;

    procedure SetListViewColumnSortMark(LV: TListView; ColumnIndex: Integer);  // �J�����\�[�g���ݒ�

    procedure CreateFavoriteActions;
    procedure RunMAME(const ZipName: string);
    function  FormatHistory( Item: PRecordSet ) : String;
    function  FormatSets( Item: PRecordSet ) : String;

  public
    { Public �錾 }
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
// ���C�ɓ���p�A�N�V���������ƒǉ�
procedure TForm1.CreateFavoriteActions;
//var
//  i: integer;
//  AC  : TActionClientItem;
begin
  {
  // ���C�ɓ��肪���郁�j���[�ʒu
  AC:=Form1.ActionManager1.ActionBars[5].Items[3];

  // �A�N�V���������ƒǉ�
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
// �T�u�N���X�E�B���h�E�֐�
procedure TForm1.SubClassProc(var msg: TMessage);
begin

  OriginProc(msg); //�{���̃E�B���h�E�֐������s

  // �J�����T�C�Y�ύX����������
  case msg.Msg of
    WM_NOTIFY:
    begin

      if TWMNotify(msg).NMHdr^.Code = HDN_ENDTRACK then
        SetListViewColumnSortMark( ListView1, SortHistory[0] );

    end;
  end;

end;

//------------------------------------------------------------------------------
// �J�������ݒ�
procedure TForm1.SetListViewColumnSortMark(LV: TListView; ColumnIndex: Integer);
var i: Integer;
  hColumn: THandle;
  hi: THDItem;
  IsAsc: boolean;
begin

  // ����
  IsAsc := ( ColumnIndex > 0);
  ColumnIndex:= abs(ColumnIndex)-1;

  //�w�b�_�̃n���h���擾
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

  // �{���̃J�����C���f�b�N�X�𒲂ׂ�(�o�O�Ή����艟����)
  st:=Column.Caption;

  if st='�Q�[����' then ColIndex:=0
  else if st='ZIP��' then ColIndex:=1
  else if st='���[�J�[' then ColIndex:=2
  else if st='�N�x' then ColIndex:=3
  else if st='�}�X�^' then ColIndex:=4
  else if st='�h���C�o' then ColIndex:=5
  else ColIndex:=0;

  // �R���������𒲂ׂ�
  if Abs(SortHistory[0]) = ColIndex+1 then
  begin // �擪�ɂ���ꍇ�t���ɂ���
    SortHistory[0]:=-SortHistory[0];
  end
  else
  begin

    // ��납�玝���ė���
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

  // �J�������
  SetListViewColumnSortMark( ListView1, SortHistory[0] );
  TLSub.Sort(TListSortCompare(@AscSort));

  // �I�����Ă��s��T���̂ƁA�\�[�g���Index�̒��蒼��
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

  if LVUpdating then exit; // ���S��

  LVUpdating:=True;

  SW      :=WideLowerCase(Trim(edtSearch.Text));
  Maker   :=cmbMaker.Text;
  Year    :=cmbYear.Text;
  Sound   :=cmbSound.Text;
  CPU     :=cmbCPU.Text;
  Version :=cmbVersion.ItemIndex;

  // �o�[�W�����͏�ɋt
  if Version<>0 then
  begin
    Version:=cmbVersion.Items.Count-Version;
  end;


  if Maker = TEXT_MAKER_ALL then Maker:='';
  if Year  = TEXT_YEAR_ALL then Year:='';
  if Sound = TEXT_SOUND_ALL then Sound:='';
  if CPU   = TEXT_CPU_ALL then CPU:='';

  // �e�L�X�g�����������Ƃ�
  if SW='' then
  begin

    TLSub.Clear;
    TLSub.Capacity:=TLMaster.Count;


    // ����0
    // �o�[�W������
    TLVersion.Clear;
    if Version<>0 then
    begin

      for j:=0 to Length(Versions[Version-1])-1 do
      begin

        idx:=FindIndex(Versions[Version-1][j]);

        if idx<>-1 then
        begin

          // �M�����u���B���ꍇ
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

                // ���J�j�J�����B���ꍇ
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
          // ���J�j�J�������B���ꍇ
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
    else   // �o�[�W�����ʂ���Ȃ��Ƃ�
    begin

      // ���J�j�J���ƃM�����u���B���Ƃ��̏ꍇ����
      if HideMechanical and HideGambling then
        TLVersion.Assign(liNonMechGamb)
      else if HideMechanical then
        TLVersion.Assign(liNonMech)
      else if HideGambling then
        TLVersion.Assign(liNonGambling)
      else
        TLVersion.Assign(TLMaster);
    end;

    /// �����P
    // ���x�D��R�[�h
    case cmbEtc.ItemIndex of
      1:begin // �}�X�^�Z�b�g
          for i:=0 to TLVersion.Count-1 do
          begin
            if PRecordset(TLVersion[i]).Master then
              TLSub.Add(TLVersion[i]);
          end;
        end;
      2:begin // �N���[���Z�b�g
          for i:=0 to TLVersion.Count-1 do
          begin
            if not PRecordset(TLVersion[i]).Master then
              TLSub.Add(TLVersion[i]);
          end;
        end;
      3:begin // ����\
          for i:=0 to TLVersion.Count-1 do
          begin
            if PRecordset(TLVersion[i]).Status then
              TLSub.Add(TLVersion[i]);
          end;
        end;
      4:begin // ����s��
          for i:=0 to TLVersion.Count-1 do
          begin
            if not PRecordset(TLVersion[i]).Status then
              TLSub.Add(TLVersion[i]);
          end;
        end;
      5:begin // CHD�Q�[��
          for i:=0 to TLVersion.Count-1 do
          begin
            if PRecordset(TLVersion[i]).CHD<>'' then
              TLSub.Add(TLVersion[i]);
          end;
        end;
      6:begin // �x�N�^�[
          for i:=0 to TLVersion.Count-1 do
          begin
            if PRecordset(TLVersion[i]).Vector then
              TLSub.Add(TLVersion[i]);
          end;
        end;
      7:begin // �����e
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

      9:begin // �c���
          for i:=0 to TLVersion.Count-1 do
          begin
            if PRecordset(TLVersion[i]).Vertical then
              TLSub.Add(TLVersion[i]);
          end;
        end;
      10:begin // �����
          for i:=0 to TLVersion.Count-1 do
          begin
            if not PRecordset(TLVersion[i]).Vertical then
              TLSub.Add(TLVersion[i]);
          end;
        end;
      11:begin // �A�i���O����
          for i:=0 to TLVersion.Count-1 do
          begin
            if PRecordset(TLVersion[i]).Analog then
              TLSub.Add(TLVersion[i]);
          end;
        end;
      12:begin // �T���v��
          for i:=0 to TLVersion.Count-1 do
          begin
            if PRecordset(TLVersion[i]).SampleOf<>'' then
              TLSub.Add(TLVersion[i]);
          end;
        end;
      13:begin // �T���v���s��
          for i:=0 to TLVersion.Count-1 do
          begin
            if (PRecordset(TLVersion[i]).Sample=False) and
               (PRecordset(TLVersion[i]).SampleOf<>'') then
              TLSub.Add(TLVersion[i]);
          end;
        end;
      14:begin // ROM�L��
          for i:=0 to TLVersion.Count-1 do
          begin
            if PRecordset(TLVersion[i]).ROM then
              TLSub.Add(TLVersion[i]);
          end;
        end;
      15:begin // ROM����
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

    // �N
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


    // ���[�J�[
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
  // �e�L�X�g�����̂Ƃ�
  begin

    TLSub.Clear;
    TLSub.Capacity:=TLMaster.Count;

    TLVersion.Clear;// �ꎞ�p

    // ���J�j�J���ƃM�����u���B���Ƃ��̏ꍇ����
    if HideMechanical and HideGambling then
      TLVersion.Assign(liNonMechGamb)
    else if HideMechanical then
      TLVersion.Assign(liNonMech)
    else if HideGambling then
      TLVersion.Assign(liNonGambling)
    else
      TLVersion.Assign(TLMaster);

    // ��������
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

  // �I�����ڂ̕��A
  idx:=-1;
  for i:=0 to TLSub.Count-1 do
  begin
    if PRecordset(TLSub[i]).ZipName=SelZip then
    begin
      idx:=i;
      break;
    end;
  end;

  if TLSub.Count<>0 then  // ���X�g���ڂ�����Ƃ�
  begin
    if idx=-1 then // �}�b�`����
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
  else   // ���X�g���ڂ������Ƃ�
  begin

    ListView1.Update;
    Memo1.Text:='';
    CurrentIndex:=-1;
    UpdateStatus;

    // �ҏW�p�l��
    ToggleEditPanel(False);
    
    // �A�N�V�����̊Ǘ�
    //actDelScreenShot.Enabled:=False;
    actRRefine.Hint:='';
    actROpenSrc.Hint:='';

    Image32.Bitmap.Delete;
    CurrentShot:='';
    SelZip:='';
    SelDriver:='';

    // �X�e�[�^�X�o�[
    StatusBar1.Panels[3].Text:='';

    // �R�}���h�r���[�����
    frmCommand.LoadCommand('','');

  end;

  // �����L���ɂ���ƃh���b�v�_�E�����X�g�̍X�V�ɒǂ����Ȃ�
  //Application.ProcessMessages;

  ListView1.Repaint;
  ListView2.Repaint;
  StatusBar1.Panels[0].Text:=InttoStr(TLSub.Count)+ ' / ' + InttoStr(TLMaster.Count);

  LVUpdating:=False;

end;


//----------------------------------------------------------------------
// .res�t�@�C���̓ǂݍ���
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
  TLMaster.Clear;     // ���R�[�h�̃��Z�b�g
  liNonMech.Clear;    // �񃁃J�j�J���̃��Z�b�g
  liNonGambling.Clear;
  liNonMechGamb.Clear;

  Error := false; // �G���[�t���O

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

    // res�̃o�[�W�����`�F�b�N
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

    // �o�[�W����
    if AnsiPos('version=',ResList[n])<>0 then
    begin
      DatVersion:=Copy(ResList[n],pos('version=',ResList[n])+8,Length(ResList[n]));
      Flag:=True;
    end;

    // ���[�J�[��
    if Flag then Inc(n);
    cmbMaker.Items.Clear;
    cmbMaker.Items.Add(TEXT_MAKER_ALL);
    cmbMaker.ItemIndex:=0;
    for i:=0 to TsvSeparate(ResList[n],StrList)-1 do
    begin
      cmbMaker.Items.Add(StrList[i]);
    end;

    // ���[�J�[�������L���b�V���̏�����
    SetLength(TLManu, 0);
    SetLength(TLManu, cmbMaker.Items.Count);
    Inc(n);

    // �N�ナ�X�g
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

    // ���̑�
    cmbEtc.ItemIndex:=0;

//  ms := GetTickCount;
    // �Q�[�����
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
          ZipName     := StrList[0];              // Zip��
          DescE       := StrList[1];              // �p�ꖼ
          DescJ       := StrList[1];              // ���{�ꖼ�i��)
          Kana        := StrList[1];              // ���ȁi��)
          Maker       := StrList[2];              // ���[�J�[
          Year        := StrList[3];              // �����N
          CloneOf     := StrList[4];              // �}�X�^��
          RomOf       := StrList[5];              // RomOf
          SampleOf    := StrList[6];              // �T���v����
          ID          := i;                       // �C���f�b�N�X (�T�u���X�g����Q��)
          MasterID    := StrtoInt(StrList[7]);    // �}�X�^��ID
          Master      := StrtoBool(StrList[8]);   // �}�X�^
          Vector      := StrtoBool(StrList[9]);   // �x�N�^�[
          Lightgun    := StrtoBool(StrList[10]);  // �����e
          Analog      := StrtoBool(StrList[11]);  // �A�i���O����
          Status      := StrtoBool(StrList[12]);  // �X�e�[�^�X
          Vertical    := StrtoBool(StrList[13]);  // �c���
          Channels    := StrtoInt(StrList[14]);   // �T�E���h�`�����l����
          CPUs        := StrList[15];             // CPUs
          Sounds      := StrList[16];             // Sound chips
          Screens     := StrList[17];             // ��ʏ��
          NumScreens  := StrtoInt(StrList[18]);   // ��ʐ�
          Palettesize := StrtoInt(StrList[19]);   // �F��
          ResX        := StrtoInt(StrList[20]);   // �𑜓xX
          ResY        := StrtoInt(StrList[21]);   // �𑜓xY

          Color       := TGameStatus(StrtoInt(StrList[22]));
                                                  // �F�X�e�[�^�X
          Sound       := TGameStatus(StrtoInt(StrList[23]));
                                                  // ���X�e�[�^�X
          GFX         := TGameStatus(StrtoInt(StrList[24]));
                                                  // GFX�X�e�[�^�X
          Protect     := TGameStatus(StrtoInt(StrList[25]));
                                                  // �v���e�N�g�X�e�[�^�X
          Cocktail    := TGameStatus(StrtoInt(StrList[26]));
                                                  // �J�N�e���e�[�^�X
          SaveState   := TGameStatus(StrtoInt(StrList[27]));
                                                  // �Z�[�u�X�e�[�g
          Source      := StrList[28];             // �\�[�X
          CHD         := StrList[29];             // CHD
          CHDOnly     := StrtoBool(StrList[30]);  // CHD�̂�
          CHDMerge    := StrtoBool(StrList[31]);  // CHD�}�[�W
          LD          := StrtoBool(StrList[32]);  // ���[�U�[�f�B�X�N
          CHDNoDump   := StrtoBool(StrList[33]);  // CHD���z���o��
          isMechanical:= StrtoBool(StrList[34]);  // ���J�j�J���Q�[��
          ROM         := False;                   // ROM�L�肩
          Sample      := False;                   // Sample�L�肩

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


  // �񃁃J�j�J���Z�b�g�̒��o
  for i := 0 to TLMaster.Count - 1 do
  begin

    if not PRecordSet(TLMaster[i]).isMechanical then
      liNonMech.Add(TLMaster[i]);

  end;

  // ��M�����u���Z�b�g�̒��o
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

  // ��M�����u���{�񃁃J�j�J���Z�b�g�̒��o
  for i := 0 to liNonGambling.Count - 1 do
  begin

    if not PRecordSet(liNonGambling[i]).isMechanical then
      liNonMechGamb.Add(liNonGambling[i]);
  end;
//showmessage(inttostr(GetTickCount-ms));
end;


/// ----------------------------------------------------------------------------
// mame32plus��lang�t�@�C������ǂݍ���
function TForm1.ReadLang: boolean;

type
  PMMOList = ^TMMOList;
  TMMOList = record
    DescE : string;
    DescJ : string;  //
    Kana  : string;  //
    Flag  : boolean; //
  end;
  
  // lang�̕��я��ɍ��킹��(�p�ꖼ�Ń\�[�g)
  function LangSort(Item1, Item2: Pointer): Integer;
  begin
    Result := CompareText(PRecordset(Item1).DescE, PRecordset(Item2).DescE);
  end;

  // MMO(�p�ꖼ�Ń\�[�g)
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
  MMOList:    TList; // .mmo����ǂݍ��񂾃t�@�C���p
  i,j,k:      Integer;
  p:          PByte;
  Flag:       boolean;
  TLSort:     TList;  // �\�[�g�p

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
      until ((Buf2<>0) and (buf1>13)); // ���S����Ȃ�����

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

        if (p^)=0 then // Null����
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
      Application.MessageBox('lst.mmo�̓ǂݍ��ݎ��ɃG���[���N���܂����B'+CRLF2+
                              '���Ԃ�mmo�t�@�C�����ɖ�肪����܂��B ',
                              '�G���[', MB_ICONERROR + MB_OK);
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
      until ((Buf2<>0) and (buf1>13)); // ���S����Ȃ�����

      mmo.Seek(-4,soFromCurrent);

      mmo2.CopyFrom(mmo,mmo.Size-mmo.Position);
      mmo.Free;

      mmo2.Seek(0,soFromBeginning);
      p := mmo2.Memory;

      j:=0;
      Flag:=False;

      for i:=0 to mmo2.Size-1 do
      begin

        if (p^)=0 then // Null����
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
      Application.MessageBox('readings.mmo�̓ǂݍ��ݎ��ɃG���[���N���܂����B'+
                             CRLF2+'���Ԃ�t�@�C���ɖ�肪����܂��B  ',
                             '�G���[', MB_ICONERROR + MB_OK);
      Result:=False;
    end;

  finally
    mmo2.Free;
    StrStream.Free;
  end;

  if Result=False then
    exit;

  // ���蓖��
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

  // ���������
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

  // �R���g���[���̃E�B���h�E�֐������ւ�
  // ���̃E�B���h�E�֐��͕ۑ����Ă���
  OriginProc :=ListView1.WindowProc;
  ListView1.WindowProc :=SubClassProc;


  // �X�i�b�v�p�o�b�t�@
  SnapBitMap:=TPngImage.Create;

  // �X�e�[�^�X�o�[�p�o�b�t�@
  StatusBarBuf:=TBitMap.Create;
  StatusBarBuf.Width:= SB_LRMARGIN * 2 +
                       (32 + SB_MARKDISTANCE + SB_ITEMDISTANCE) *
                       SB_NUMOFITEMS -
                       SB_ITEMDISTANCE+3;

  StatusBarBuf.Height:=16;
  StatusBar1.Panels[4].Width:=StatusBarBuf.Width;

  // TrackList�pTList
  TLMaster:=TList.Create;
  TLSub:=TList.Create;
  TLFamily:=TList.Create;
  TLVersion:=TList.Create;
  liNonMech:=TList.Create;
  liNonGambling:=TList.Create;
  liNonMechGamb:=TList.Create;


  // �T�u���X�g�ɕ\������ROM�Z�b�g
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

  // ���C�ɓ���p�A�N�V�����ݒ�
  CreateFavoriteActions;

  // �ŏ��Ƀt�H�[����SHOW�������Active�Ŋm�F���邽�߂̃t���O
  bFormActivated := False;

end;

//-----------------------------------------------------------------------
procedure TForm1.FormDestroy(Sender: TObject);
var i: integer;
begin

  // TList�̊e���ڂ̃��������
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

  // �I�����ɍX�V�O�ƍX�V���2��Ăяo�����̂őO�̕����͂���
  // �X�V�O: Selected=False, Item.Index=�s��
  // �X�V��: Selected=True,  Item.Index=����
  if not Selected then exit;

  if DoNotUpdate and (booting=false) then exit;

  //
  if TLSub.Count=0 then exit;

  // �󃊃X�g�̂Ƃ�
  if (ListView1.Items.Count=0) or (Item.Index=-1) then
  begin

    CurrentIndex:=-1;
    Memo1.Text:='';
    CurrentShot:='';

    // �A�N�V�����̊Ǘ�
    //actDelScreenShot.Enabled:=False;

    // �ҏW�E�B���h�E
    ToggleEditPanel(False);

    // �Q�[���X�e�[�^�X�A�C�R��
    UpdateStatus;

    // �R�}���h�r���[
    frmCommand.LoadCommand('','');

  end
  else
  // ���X�g���ڂ���
  begin

    CurrentIndex:=StrtoInt(Item.SubItems[5]);

    // �R�}���h�r���[
    frmCommand.LoadCommand(
            PRecordSet(TLMaster[ CurrentIndex ]).ZipName,
            PRecordSet(TLMaster[ PRecordSet(TLMaster[currentIndex]).MasterID ]).ZipName );



    // �ҏW�E�B���h�E�ɏ��\��
    EditingIndex:=CurrentIndex; // �ҏW�Ώۂ̃C���f�b�N�X
    UpdateEditPanel(EditingIndex);

    // �X�e�[�^�X�o�[
    StatusBar1.Panels[3].Text:=PRecordSet(TLMaster[CurrentIndex]).DescE;


    /// �T�u���X�g��ROM�t�@�~���\��
    //  �T�u���X�g�̍X�V���K�v�ȏꍇ
    SelMasterID:=PRecordSet(TLMaster[CurrentIndex]).MasterID;

    if SubListID <> SelMasterID then
    begin

      SubListID:=SelMasterID;

      TLFamily.Clear;

      // �}�X�^�ǉ�
      TLFamily.Add(TLMaster[SubListID]);

      // �N���[���ǉ�
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



    // �T�u���X�g���ڂ̑I��
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


    // �\�����Ȃ炷���X�V��������
    if Panel7.Visible then
      Panel7.Update;

    // �Q�[���X�e�[�^�X�A�C�R���\��
    UpdateStatus;

    // dat
    FindDat(CurrentIndex);

    // �X�i�b�v�V���b�g
    ShowSnapshot(CurrentIndex);

    // �A�N�V����
    if ListView1.ItemIndex<>-1 then
    begin
      //actDelScreenShot.Enabled:=(CurrentShot<>'');
      actRRefine.Hint:=PRecordSet(TLSub[ListView1.ItemIndex]).Source;
      actROpenSrc.Hint:=PRecordSet(TLSub[ListView1.ItemIndex]).Source;
    end;

  end;

  SelZip:=Item.SubItems[0]; // �I�𒆂�Zip��
  SelDriver:=Item.SubItems[4]; // �I�𒆂̃h���C�o��
  actDelUpdate(nil);

end;

//-------------------------------------------------------------------------
// MAME�N������
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
// MAME�N��������
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
      showMessage('�N�����s�B�ʏ�̋N�����@�������Ă��������B');
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

  // �A�C�R��
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

// �f�[�^�����v���i�L�[���͂���j
procedure TForm1.FormShow(Sender: TObject);
var
  i,j,k: Integer;
  result: Integer;
  // debug�p
  ms          : Cardinal;
begin

  Tick:=GetTickCount;

  Form1.Caption:=APPNAME;

  // ExeDir
  ExeDir:=ExtractFilePath(Application.ExeName);

  // �ݒ菉����
  InitParams;


  // res�t�@�C�����̕ύX�ɔ����X�V
  if ( FileExists(ExeDir+'retrofire.res') AND ( NOT FileExists( ExeDir+RESNAME ))) then
  begin
    try
      RenameFile(ExeDir+'retrofire.res', ExeDir+RESNAME);
    except
      PostMessage(Handle,WM_CLOSE,0,0);
       Application.MessageBox('�f�[�^�t�@�C���̃t�@�C�������ύX����܂����B  '+CRLF2+
      '�uretrofire.res�v�t�@�C�����u'+RESNAME+'�v�ɉ������čċN�����ĉ������B  ',APPNAME, MB_ICONWARNING  + MB_OK);
      Application.Terminate;
      exit;
    end;
  end;


  // ����N�����̏���
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

  // ���\�[�X�ǂݍ���
  if result=1 then
  begin
    Application.MessageBox('�f�[�^�t�@�C���̃t�H�[�}�b�g���X�V����܂����B  '+CRLF2+
          '�u'+RESNAME+'�v���폜���āA�ċN�����ĉ������B  ',APPNAME, MB_ICONWARNING  + MB_OK);
    PostMessage(Handle,WM_CLOSE,0,0);
    Application.Terminate;
    Exit;
  end
  else
  if result=2 then
  begin
    Application.MessageBox('�f�[�^�t�@�C���u'+RESNAME+'�v�̓ǂݍ��݂Ɏ��s���܂����B  '+CRLF2+
          '�iMAME�̍X�V�ɔ����ALIST.XML�t�H�[�}�b�g���ύX���ꂽ�\��������܂��B�j',APPNAME, MB_ICONWARNING  + MB_OK);
    PostMessage(Handle,WM_CLOSE,0,0);
    Application.Terminate;
    Exit;
  end;


  // ini�ǂݍ���
  LoadIni;

  /// �R�}���h�r���[�A
  // �ꉞ�l���`�F�b�N
  // �E�[�𒴂��Ă��Ȃ���
  frmCommand.LoadCommandDat(datDir);
  if ComViewerLeft < Screen.Width-10 then
    frmCommand.Left := ComViewerLeft
  else
    frmCommand.Left := Screen.Width-ComViewerWidth;

  // ���[�𒴂��Ă��Ȃ���
  if ComViewerTop < Screen.WorkAreaRect.Bottom-10 then
    frmCommand.Top := ComViewerTop
  else
    frmCommand.Top := Form1.Top;

  frmCommand.Width := ComViewerWidth;
  frmCommand.Height := ComViewerHeight;

  // ��Ɏ�O�Ƃ�
  frmCommand.chkP2.Checked          := ComViewerP2;
  frmCommand.chkZentoHan.Checked    := ComViewerZentoHan;
  frmCommand.chkAlwaysOnTop.Checked := ComViewerAlwaysOnTop;
  frmCommand.chkAutoResize.Checked  := ComViewerAutoResize;

  frmCommand.initialIndex := ComViewerIndex; // �h���b�v�_�E�������l�i���j

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

  // �o�O�Ή�
  ActionMainMenuBar1.UseSystemFont:=True;

  //
  Booting:=True;


  // �A�X�y�N�g���ێ��̃`�F�b�N
  actKeepAspect.Checked := KeepAspect;


  ReadMame32jlst;
  ReadHistoryDat;
  ReadMameInfoDat;

  CreateZipIndex; // ZIP���̃C���f�b�N�X�쐬


  ms:=gettickcount;

  // ROM�X�e�[�^�X
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

  // Sample�X�e�[�^�X
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

  // �J�����\�[�g���ݒ�
  SetListViewColumnSortMark( ListView1, SortHistory[0] );
  CurrentMaker:= Form1.cmbMaker.Text;



  // �v���t�@�C���ݒ�
  // �h���b�v�_�E�����X�g
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


  // �R�}���h�r���[�A�\��
  if ComViewerVisible then
    frmCommand.Show;


  // �N��
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
// �|�b�v�A�b�v���̃v���t�@�C���ǉ�
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
// �A�N�V�����}�l�[�W��
procedure TForm1.actPlayExecute(Sender: TObject);
begin

  actPlayUpdate(nil);   // �p�X�֌W�̃`�F�b�N
  if actPlay.Enabled then
  begin

    RunMAME(SelZip);

  end;

end;


procedure TForm1.actPlayUpdate(Sender: TObject);
begin

  // �N���ΏۂȂ�
  if SelZip='' then
  begin
    actPlay.Caption :='�N��(&P)';
    actPlay.Enabled := False;
    actRCPlayEx.Enabled:=False;
    actRRefine.Enabled:=False;

  end
  else
  // ����
  begin
    actPlay.Caption :='�u'+SelZip+'�v���N��(&P)';

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
                      PChar('���̃X�N���[���V���b�g���폜���܂����H   '+CRLF2+St+'    '),
                      APPNAME, MB_YESNO or MB_ICONQUESTION) then
  begin

    try
      Trasher(CurrentShot);
      Image32.Bitmap.Delete;
      CurrentShot:='';

    except

      MessageBox(Form1.Handle,
                 PChar('�G���[���N���܂����B'),
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
  // �_�~�[�A�N�V����
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
             PChar('�ȉ���.cfg�t�@�C�����폜���܂����H   '+CRLF2+
             cfgDir+'\'+SelZip+'.cfg'+'    '),
             APPNAME, MB_YESNO or MB_ICONQUESTION) then
  begin
    try
      DeleteFile(cfgDir+'\'+SelZip+'.cfg');
    except
      MessageBox(Form1.Handle,
             PChar('�폜�ł��܂���ł����B   '),
             APPNAME, MB_OK or MB_ICONERROR);
    end;
  end;

end;

procedure TForm1.actDelNvExecute(Sender: TObject);
begin

  SetCurrentDir(ExeDir);

  // �t�H���_����nv�t�@�C��
  if DirectoryExists(nvramDir+'\'+SelZip) then
  begin

    if IDYES=MessageBox(Form1.Handle,
             PChar('�ȉ���nvram�t�H���_���폜���܂����H   '+CRLF2+
             nvramDir+'\'+SelZip+'\'+'    '),
             APPNAME, MB_YESNO or MB_ICONQUESTION) then
    begin
      try
        DeleteDirectory(nvramDir+'\'+SelZip);
      except
        MessageBox(Form1.Handle,
               PChar('�폜�ł��܂���ł����B   '),
               APPNAME, MB_OK or MB_ICONERROR);
      end;
    end;

  end

  else
  begin

    if IDYES=MessageBox(Form1.Handle,
             PChar('�ȉ���.nv�t�@�C�����폜���܂����H   '+CRLF2+
             nvramDir+'\'+SelZip+'.nv'+'    '),
             APPNAME, MB_YESNO or MB_ICONQUESTION) then
    begin
      try
        DeleteFile(nvramDir+'\'+SelZip+'.nv');
      except
        MessageBox(Form1.Handle,
               PChar('�폜�ł��܂���ł����B   '),
               APPNAME, MB_OK or MB_ICONERROR);
      end;
    end;

  end;

end;

procedure TForm1.actDelAutosaveExecute(Sender: TObject);
begin

  SetCurrentDir(ExeDir);
  
  if IDYES=MessageBox(Form1.Handle,
             PChar('�ȉ���autosave.sta�t�@�C�����폜���܂����H   '+CRLF2+
             staDir+'\'+SelZip+'\auto.sta    '),
             APPNAME, MB_YESNO or MB_ICONQUESTION) then
  begin
    try
      DeleteFile(staDir+'\'+SelZip+'\auto.sta');
    except
      MessageBox(Form1.Handle,
             PChar('�폜�ł��܂���ł����B   '),
             APPNAME, MB_OK or MB_ICONERROR);
    end;
  end;
  
end;

procedure TForm1.actBranch2Execute(Sender: TObject);
begin
  // �_�~�[
end;

procedure TForm1.actBranchExecute(Sender: TObject);
begin
  // �_�~�[
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

  // �t�H���_����nv�t�@�C��
  if DirectoryExists(nvramDir+'\'+SelZip) then
    St:=St+nvramDir+'\'+SelZip+'\' +CRLF;

  if FileExists(staDir+'\'+SelZip+'\auto.sta') then
    St:=St+staDir+'\'+SelZip+'\auto.sta';

  St:=Trim(St);

  if IDYES=MessageBox(Form1.Handle,
             PChar('�ȉ��̐ݒ�t�@�C�����폜���܂����H   '+CRLF2+St+'    '),
             APPNAME, MB_YESNO or MB_ICONQUESTION) then
  begin

    try
      if FileExists(cfgDir+'\'+SelZip+'.cfg') then
        DeleteFile(cfgDir+'\'+SelZip+'.cfg');

      if FileExists(nvramDir+'\'+SelZip+'.nv') then
        DeleteFile(nvramDir+'\'+SelZip+'.nv');

      // �t�H���_����nv�t�@�C��
      if DirectoryExists(nvramDir+'\'+SelZip) then
        DeleteDirectory(nvramDir+'\'+SelZip);

      if FileExists(staDir+'\'+SelZip+'\auto.sta') then
      begin
        DeleteFile(staDir+'\'+SelZip+'\auto.sta');
        // ��t�H���_�폜
        RemoveDir(staDir+'\'+SelZip); // ���s���ɗ�O�͏o���Ȃ�
      end;

    except
      MessageBox(Form1.Handle,
                 PChar('�폜�Ɏ��s���܂����B   '),
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
    actROpenSrc.Caption:='�u'+actROpenSrc.Hint+'�v��GitHub�ŊJ��(&O)';
    //actROpenSrc.Caption:='\drivers\'+actROpenSrc.Hint+'���J��(&O)';
    actROpenSrc.Enabled:=true;
    //actROpenSrc.Enabled:=FileExists(SrcDir+'\'+actROpenSrc.Hint);
  end
  else
  begin
    actROpenSrc.Caption:='GitHub���J��(&O)';
    actROpenSrc.Enabled:=False;
  end;
  
end;

procedure TForm1.actRRefineUpdate(Sender: TObject);
begin

  if actRRefine.Hint<>'' then
  begin
    actRRefine.Caption := '�u'+actRRefine.Hint+'�v�ōi�荞��(&S)';
    actRRefine.Enabled :=True;
  end
  else
  begin
    actRRefine.Caption := '�\�[�X�ōi�荞��(&S)';
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
  
  // �T�[�`�{�b�N�X���Z�b�g
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
  // �T�[�`�{�b�N�X���Z�b�g
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
  // �T�[�`�{�b�N�X���Z�b�g
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
  // �T�[�`�{�b�N�X���Z�b�g
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
  // �T�[�`�{�b�N�X���Z�b�g
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
  // �T�[�`�{�b�N�X���Z�b�g
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
    actVSearchBar.Caption:='�����p�l�����B��'
  else
    actVSearchBar.Caption:='�����p�l����\��';

  
end;

procedure TForm1.actVEditorUpdate(Sender: TObject);
begin

  if Panel7.Visible then
    actVEditor.Caption:='�ҏW�p�l�����B��'
  else
    actVEditor.Caption:='�ҏW�p�l����\��';

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
    actVCommand.Caption:='�R�}���h�r���[�A�����';
  end
  else
  begin
    actVCommand.Caption:='�R�}���h�r���[�A���J��';
  end;
end;

procedure TForm1.actVEditorExecute(Sender: TObject);
var i:integer;
begin

  // ����Ƃ��̏���
  // �ҏW�p�l���Ƀt�H�[�J�X������ꍇ��ListView1�Ɉڂ�
  if ListView2.Focused or edtDescJ.Focused or edtKana.Focused or Edit1.Focused or
     memCPU.Focused or memSound.Focused or memDisp.Focused or edtSource.Focused then
  begin
    ListView1.SetFocus;
  end;


  Splitter1.Visible:= not Splitter1.Visible;
  Panel7.Visible:= not Panel7.Visible;


  // �\������Ƃ���Splitter�̈ʒu�C��
  if Splitter1.Visible then
  begin
    Splitter1.Top:=Panel7.Top-5;
    if ListView1.Selected<>nil then
      ListView1.Selected.MakeVisible(True);
  end;

  // �����Ƃ���ListView1�̍��ڂ��đI��
  // ���C�����X�g�ɖ������̂�I��ł�ꍇ�̂���
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

    Re:=MessageBox(Form1.Handle,PChar('�Q�[�������ҏW����Ă��܂��B'+CRLF2+
                   '�ύX��mame32j.lst�ɕۑ����܂���?      '),PChar('�m�F'),
                    MB_YESNOCANCEL+MB_ICONEXCLAMATION);

    Case Re of
      mrYes:
      begin

        if WSaveMame32j then
        begin
          Action := caFree;
        end
        else
        begin  // MAME32j.lst�̕ۑ��L�����Z�����͖߂�
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
    actVInfoPane.Caption:='���p�l�����B��'
  else
    actVInfoPane.Caption:='���p�l����\��';
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
 // �_�~�[
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

// �}�[�W�Z�b�g��ROM����
procedure TForm1.actFRMargeExecute(Sender: TObject);
var i,j:integer;
    CHD,ROM: Boolean;
    Save_Cursor: TCursor;

begin

  SetCurrentDir(ExeDir);
  Save_Cursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;    // Show hourglass cursor

  try
    // �e�Z�b�g�������ׂ�
    for i:=0 to TLMaster.Count-1 do
    begin
      PRecordset(TLMaster[i]).ROM:=False;
      CHD:=False;

      // CHD�����̃Z�b�g�̏ꍇ
      ROM:=PRecordset(TLMaster[i]).CHDOnly;

      if PRecordset(TLMaster[i]).Master then
      begin

        for j:=0 to Length(RomDirs)-1 do
        begin

          if PRecordset(TLMaster[i]).CHD='' then // CHD�������ꍇ
          begin
            CHD:=True;
            ROM:= ( FileExists(RomDirs[j]+'\'+PRecordset(TLMaster[i]).ZipName+'.zip') OR
                    FileExists(RomDirs[j]+'\'+PRecordset(TLMaster[i]).ZipName+'.7z')
                  );

            // ���S�ɕʃZ�b�g��ROM���g���ꍇ (CloneOf���Ȃ��̂�RomOf������)
            if (PRecordset(TLMaster[i]).CloneOf='') and (PRecordset(TLMaster[i]).RomOf<>'') then
            begin
              if PRecordset(TLMaster[i]).RomOf='gts1s' then
                PRecordset(TLMaster[i]).RomOf:='gts1'; // ��肠����

              ROM:=( FileExists(RomDirs[j]+'\'+PRecordset(TLMaster[i]).RomOf+'.zip') OR
                     FileExists(RomDirs[j]+'\'+PRecordset(TLMaster[i]).RomOf+'.7z')
                    );
            end;


          end
          else  // CHD������ꍇ
          begin
            if ROM=False then // CHD�̂݃Z�b�g
              ROM:= ( FileExists(RomDirs[j]+'\'+PRecordset(TLMaster[i]).ZipName+'.zip') OR
                      FileExists(RomDirs[j]+'\'+PRecordset(TLMaster[i]).ZipName+'.7z')
                    );
            if CHD=False then
              CHD:=FileExists(RomDirs[j]+'\'+PRecordset(TLMaster[PRecordset(TLMaster[i]).MasterID]).ZipName+'\'+
                 PRecordset(TLMaster[i]).CHD+'.chd');
            if CHD=False then
              CHD:=FileExists(RomDirs[j]+'\'+PRecordset(TLMaster[i]).ZipName+'\'+
                PRecordset(TLMaster[i]).CHD+'.chd');

            // �}�[�WCHD������ꍇ
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

    // �q�Z�b�g��ROM��Ԃ�e�ɍ��킹��
    for i:=0 to TLMaster.Count-1 do
    begin
      if not PRecordset(TLMaster[i]).Master then
      begin
        PRecordset(TLMaster[i]).ROM:=PRecordset(TLMaster[PRecordset(TLMaster[i]).MasterID]).ROM;
      end;
    end;

    /// �T���v���Z�b�g�̌�����
    actFSearchSampleExecute(nil);

    // �A�C�R���̍ĕ`��
    ListView1.Repaint;

    // �T�u���X�g�X�V
    ListView2.Repaint;

  finally
    Screen.Cursor := Save_Cursor;
  end;
end;

// �X�v���b�g�Z�b�g��ROM����
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
      
      // CHD�����̃Z�b�g�̏ꍇ
      ROM:=PRecordset(TLMaster[i]).CHDOnly;

      // �e�Z�b�g�Ǝq�Z�b�g�������ꍇ
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
           (PRecordset(TLMaster[i]).CHDNoDump) then // CHD�������ꍇ/CHD��NoDump�̏ꍇ
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

          // RomOf������ꍇ�̏���
          if (PRecordset(TLMaster[i]).RomOf<>'') then
          begin

            // BIOS���`�F�b�N
            blBIOS := ( FileExists(RomDirs[j]+'\'+PRecordset(TLMaster[i]).RomOf+'.zip') OR
                        FileExists(RomDirs[j]+'\'+PRecordset(TLMaster[i]).RomOf+'.7z')
                        );

            // ROM�{�̂������OK�ɂ���
            if blBIOS and ROM then
              ROM := True;

            // BIOS�̂݃Z�b�g�p�̌ʑΉ�
            if (PRecordset(TLMaster[i]).RomOf='gp_110') or
               (PRecordset(TLMaster[i]).RomOf='allied') then
            begin

              ROM := blBIOS;

            end;

          end;


          // ���S�ɕʃZ�b�g��ROM���g���ꍇ (CloneOf���Ȃ��̂�RomOf������)
          {if (PRecordset(TLMaster[i]).CloneOf='') and (PRecordset(TLMaster[i]).RomOf<>'') then
          begin
            if PRecordset(TLMaster[i]).RomOf='gts1s' then
              PRecordset(TLMaster[i]).RomOf:='gts1'; // ��肠����

            ROM:=FileExists(RomDirs[j]+'\'+PRecordset(TLMaster[i]).RomOf+'.zip');
          end;
          }


        end
        else  // CHD������ꍇ
        begin

          if ROM=False then // CHD�̂݃Z�b�g
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

          // �}�[�WCHD������ꍇ
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

    /// �T���v���Z�b�g�̌�����
    actFSearchSampleExecute(nil);

    // �A�C�R���̍ĕ`��
    ListView1.Repaint;

    // �T�u���X�g�X�V
    ListView2.Repaint;

  finally
    Screen.Cursor := Save_Cursor;
  end;

end;

// �T���v���̌���
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

// �N���E�h�X�V
procedure TForm1.actFHttpExecute(Sender: TObject);
var response: integer;
begin

  response := frmHttp.ShowModal;

  // �X�V���ʂ� mrOK �Ȃ�
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
  //�_�~�[
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
// �X�e�[�^�X�o�[�̃p�l���X�V
procedure TForm1.UpdateStatus;
var Idx:integer;
begin


  Idx:=CurrentIndex;
  
  StatusBarBuf.Canvas.Brush.Color:=clBtnFace;
  StatusBarBuf.Canvas.FillRect(Rect(0,0,StatusBarBuf.Width,StatusBarBuf.Height));
  SB_HintText:='';
  
  ImageList2.Draw(StatusBarBuf.Canvas, SB_LRMARGIN ,0,20); // ����
  
  ImageList2.Draw(StatusBarBuf.Canvas, SB_LRMARGIN +
                  (32+SB_ITEMDISTANCE)*1,0,23);            // GFX
  ImageList2.Draw(StatusBarBuf.Canvas, SB_LRMARGIN +
                  (32+SB_ITEMDISTANCE)*2+SB_MARKDISTANCE,0,21); // �F
  ImageList2.Draw(StatusBarBuf.Canvas, SB_LRMARGIN +
                  (32+SB_ITEMDISTANCE)*3+SB_MARKDISTANCE,0,22); // ��
  ImageList2.Draw(StatusBarBuf.Canvas, SB_LRMARGIN +
                  (32+SB_ITEMDISTANCE)*4+SB_MARKDISTANCE,0,24); // �v���e�N�g
  ImageList2.Draw(StatusBarBuf.Canvas, SB_LRMARGIN +
                  (32+SB_ITEMDISTANCE)*5+SB_MARKDISTANCE,0,34); // �Z�[�u�X�e�[�g

                  
  if Idx=-1 then
  begin
    ImageList2.Draw(StatusBarBuf.Canvas, SB_LRMARGIN+16,0,28); // 
    ImageList2.Draw(StatusBarBuf.Canvas, SB_LRMARGIN+(32+SB_ITEMDISTANCE+SB_MARKDISTANCE)*1+16,0,28); // GFX
    ImageList2.Draw(StatusBarBuf.Canvas, SB_LRMARGIN+(32+SB_ITEMDISTANCE+SB_MARKDISTANCE)*2+16,0,28); // �F
    ImageList2.Draw(StatusBarBuf.Canvas, SB_LRMARGIN+(32+SB_ITEMDISTANCE+SB_MARKDISTANCE)*3+16,0,28); // ��
    ImageList2.Draw(StatusBarBuf.Canvas, SB_LRMARGIN+(32+SB_ITEMDISTANCE+SB_MARKDISTANCE)*4+16,0,28); // �v���e�N�g
    ImageList2.Draw(StatusBarBuf.Canvas, SB_LRMARGIN+(32+SB_ITEMDISTANCE+SB_MARKDISTANCE)*5+16,0,28); // �Z�[�u�X�e�[�g
  end
  else
  begin
    if PRecordSet(TLMaster[Idx]).Status then // ����
      ImageList2.Draw(StatusBarBuf.Canvas, SB_LRMARGIN+16+SB_MARKDISTANCE, 0,25)
    else
      ImageList2.Draw(StatusBarBuf.Canvas, SB_LRMARGIN+16+SB_MARKDISTANCE, 0,27);

    ImageList2.Draw(StatusBarBuf.Canvas, SB_LRMARGIN+(32+SB_ITEMDISTANCE+SB_MARKDISTANCE)*1+16,
                    0,25+Ord(PRecordSet(TLMaster[Idx]).GFX)); // GFX
    ImageList2.Draw(StatusBarBuf.Canvas, SB_LRMARGIN+(32+SB_ITEMDISTANCE+SB_MARKDISTANCE)*2+16,
                    0,25+Ord(PRecordSet(TLMaster[Idx]).Color)); // �F
    ImageList2.Draw(StatusBarBuf.Canvas, SB_LRMARGIN+(32+SB_ITEMDISTANCE+SB_MARKDISTANCE)*3+16,
                    0,25+Ord(PRecordSet(TLMaster[Idx]).Sound)); // ��
    ImageList2.Draw(StatusBarBuf.Canvas, SB_LRMARGIN+(32+SB_ITEMDISTANCE+SB_MARKDISTANCE)*4+16,
                    0,25+Ord(PRecordSet(TLMaster[Idx]).Protect)); // �v���e�N�g
    ImageList2.Draw(StatusBarBuf.Canvas, SB_LRMARGIN+(32+SB_ITEMDISTANCE+SB_MARKDISTANCE)*5+16,
                    0,25+Ord(PRecordSet(TLMaster[Idx]).SaveState)); // �Z�[�u�X�e�[�g

    if not PRecordSet(TLMaster[Idx]).Status then
      SB_HintText:='����s��'+CRLF;

    if PRecordSet(TLMaster[Idx]).GFX=gsImperfect then
      SB_HintText:=SB_HintText+'�O���t�B�b�N�F�s���S'+CRLF;

    if PRecordSet(TLMaster[Idx]).Color=gsImperfect then
      SB_HintText:=SB_HintText+'�F�F�s���S'+CRLF
    else
    if PRecordSet(TLMaster[Idx]).Color=gsPreliminary then
      SB_HintText:=SB_HintText+'�F�F�s��'+CRLF;

    if PRecordSet(TLMaster[Idx]).Sound=gsImperfect then
      SB_HintText:=SB_HintText+'�T�E���h�F�s���S'+CRLF
    else
    if PRecordSet(TLMaster[Idx]).Sound=gsPreliminary then
      SB_HintText:=SB_HintText+'�T�E���h�F�Ȃ�'+CRLF;

    if PRecordSet(TLMaster[Idx]).Protect=gsPreliminary then
      SB_HintText:=SB_HintText+'�v���e�N�g�F�s���S'+CRLF;

    if PRecordSet(TLMaster[Idx]).Cocktail=gsPreliminary then
      SB_HintText:=SB_HintText+'��ʔ��]�F������'+CRLF;

    if PRecordSet(TLMaster[Idx]).SaveState=gsPreliminary then
      SB_HintText:=SB_HintText+'�Z�[�u�X�e�[�g�F���T�|�[�g'+CRLF;

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
  ResizePanelNumber=3;    //���T�C�Y����Statusbar�̃p�l���ԍ����w��
  MinSize=0;              //���T�C�Y����Ă��ێ��������ŏ���Width���w��
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
// �W���C�X�e�B�b�N
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

    // �{�^��1�͋N��
    if (JoyInfo.wButtons and JOY_BUTTON1)>0 then begin

      if JoyLaunchTimer.Enabled=false then begin

        JoyLaunchTimer.Enabled := True;
        actPlayExecute(nil);

      end;

    end;

    // �{�^��3��PageDown
    if (JoyInfo.wButtons and JOY_BUTTON3)>0 then
        PostMessage(ListView1.Handle, WM_KEYDOWN, 33, 1 );

    // �{�^��4��PageUp
    if (JoyInfo.wButtons and JOY_BUTTON4)>0 then
        PostMessage(ListView1.Handle, WM_KEYDOWN, 34, 1 );


    // ��{�^��
    if (JoyInfo.wYpos < 20000) OR ((UsePOV = true) and (JoyInfo.dwPOV = JOY_POVFORWARD)) then
    begin

      if ListView1.Items.Count=0 then exit;
      if ListView1.ItemFocused.Index <= 0 then exit;

      if (JoyDelayTick=0) or (JoyDelayTick + KeyBoardDelay < GetTickCount) then
      begin

        ListView1.ItemIndex:=ListView1.ItemFocused.Index; // Focusboder����
        ListView1.ItemIndex:=ListView1.ItemFocused.Index-1;
        ListView1.Items[ListView1.ItemIndex].Selected:=True;
        ListView1.Items[ListView1.ItemIndex].Focused:=True;
        ListView1.Selected.MakeVisible(True);

      end;

      if JoyStatus<>jsUp then // �L�[���s�[�g�J�n
      begin
        JoyStatus:=jsUp;
        JoyDelayTick:=GetTickCount;
      end;

    end
    else
    // ���{�^��
    if (JoyInfo.wYpos > 45535) or ((UsePOV = true) and (JoyInfo.dwPOV = JOY_POVBACKWARD)) then
    begin

      if ListView1.Items.Count=0 then exit;
      if ListView1.ItemFocused.Index = ListView1.Items.Count-1 then exit;

      if (JoyDelayTick=0) or (JoyDelayTick + KeyBoardDelay < GetTickCount) then
      begin

        ListView1.ItemIndex:=ListView1.ItemFocused.Index; // Focusboder����
        ListView1.ItemIndex:=ListView1.ItemFocused.Index+1;
        ListView1.Items[ListView1.ItemIndex].Selected:=True;
        ListView1.Items[ListView1.ItemIndex].Focused:=True;
        ListView1.Selected.MakeVisible(True);

      end;

      if JoyStatus<>jsDown then // �L�[���s�[�g�J�n
      begin
        JoyStatus:=jsDown;
        JoyDelayTick:=GetTickCount;
      end;

    end
    else // ������Ă��Ȃ��Ƃ�
    begin
      JoyStatus:=jsNone;
      JoyDelayTick:=0;
    end;

    // ���{�^��
    if (JoyInfo.wXpos< 20000) or ((UsePOV = true) and (JoyInfo.dwPOV = JOY_POVLEFT))  then
    begin
      if ListView1.Focused then
        ListView1.Scroll(-20,0);
      if ListView2.Focused then
        ListView2.Scroll(-20,0);
    end
    else
    // �E�{�^��
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

  // �p�l�����̂̍ő�T�C�Y
  if NewSize > Panel7.Constraints.MaxHeight then
  begin
    NewSize:=Panel7.Constraints.MaxHeight;
    Accept:=False;
  end;

end;



//------------------------------------------------------------------------------
// �Q�[�����ҏW�p�l��
// �S�̂̍X�V
procedure TForm1.UpdateEditPanel(const idx: integer);
begin

  ToggleEditPanel(True);
  EditUpdating:=True;
  edtDescJ.Text:=PRecordSet(TLMaster[idx]).DescJ;
  edtKana.Text:=PRecordSet(TLMaster[idx]).Kana;
  Edit1.Text:=PRecordSet(TLMaster[idx]).DescE; // Edit1���Ō�ɍX�V
  
  ShowGameInfo(idx); // �E�������X�V

  EditUpdating:=False;

end;

// �E���̃Q�[�����\��
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

// �I���W�i�����_�u���N���b�N�őI��
procedure TForm1.Edit1DblClick(Sender: TObject);
begin
  Edit1.SelStart:=0;
  Edit1.SelLength:=Length(Edit1.Text);
end;

// Undo�p�f�[�^�̕ێ��Ɩ���̔��f
procedure TForm1.Edit1Change(Sender: TObject);
begin
  if Edit1.Text<>'' then
  begin

    if (edtDescJ.Text=Edit1.Text) and (edtKana.Text=Edit1.Text) then
      StatusBar1.Panels[2].Text:='����'
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

// ���{�ꖼeditbox�̊e����
procedure TForm1.edtDescJChange(Sender: TObject);
var i:integer;
begin

  // �O������̍X�V�łȂ��Ƃ�
  if (EditUpdating=False) and (Edit1.Text<>'') then
  begin

    PRecordset(TLMaster[EditingIndex]).DescJ:=edtDescJ.Text;

    // ���C�����X�g�̍X�V
    // �\���̈���ɂ���ꍇ�̂�
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

    // �T�u���X�g�̍X�V
    ListView2.ItemFocused.Caption:=edtDescJ.Text;
    
    if (edtDescJ.Text=Edit1.Text) and (edtKana.Text=Edit1.Text) then
    begin
      ListView2.ItemFocused.SubItems[5]:='�~';
      StatusBar1.Panels[2].Text:='����'
    end
    else
    begin
      ListView2.ItemFocused.SubItems[5]:='��';
      StatusBar1.Panels[2].Text:='';
    end;

    ListView2.UpdateItems(ListView2.ItemFocused.Index,ListView2.ItemFocused.Index);

    //
    Edited:=True;
    StatusBar1.Panels[1].Text:='�ύX����';

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

// ��݂���EditBox�̊e����
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

  // �O������̍X�V�łȂ��Ƃ�
  if (EditUpdating=False) and (Edit1.Text<>'') then
  begin
    PRecordset(TLMaster[EditingIndex]).Kana:=edtKana.Text;

    Edited:=True;
    Form1.StatusBar1.Panels[1].Text:='�ύX����';


    // �T�u���X�g�̍X�V
    
    if (edtDescJ.Text=Edit1.Text) and (edtKana.Text=Edit1.Text) then
    begin
      ListView2.ItemFocused.SubItems[5]:='�~';
      StatusBar1.Panels[2].Text:='����'
    end
    else
    begin
      ListView2.ItemFocused.SubItems[5]:='��';
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
                      PChar('�}�X�^�Z�b�g�̓ǂ݉����u'+masterkana+'�v�����Ɏ����������܂��B'),
                      APPNAME, MB_YESNO or MB_ICONQUESTION) then
  begin

      // �N���[���Z�b�g
      for i:=0 to TLMaster.Count-1 do
      begin
        if (PRecordSet(TLMaster[i]).MasterID=SubListID) and
           (PRecordSet(TLMaster[i]).Master=False) then
        begin

          // �Q�[������ set ##������ꍇ�͏�������
          desc:=PRecordSet(TLMaster[i]).DescE;

          if pos('set ', desc ) <>0 then
          begin

            // �񌅂̏ꍇ
            st := copy( desc, pos('set ', desc)+4, 2);
            if IsNumeric(st) then
            begin
              PRecordSet(TLMaster[i]).Kana := masterkana+st;
            end
            else
            begin
              // �ꌅ�̏ꍇ
              st := copy( desc, pos('set ', desc)+4, 1);
              if IsNumeric(st) then
              begin
                PRecordSet(TLMaster[i]).Kana := masterkana+'0'+st;
              end;

            end;

          end
          else
          begin
            // set���Ȃ��ꍇ�͌��̐������������̂܂ܒǉ�
            st:= copy( desc, pos('(',desc), length(desc));
            PRecordSet(TLMaster[i]).Kana := masterkana+st;

          end;
        end;
      end;

      // �e�Z�b�g����������

      // �Q�[������ set ##������ꍇ�͏�������
          desc:=PRecordSet(TLMaster[SelMasterID]).DescE;

          if pos('set ', desc ) <>0 then
          begin

            // �񌅂̏ꍇ
            st := copy( desc, pos('set ', desc)+4, 2);
            if IsNumeric(st) then
            begin
             PRecordSet(TLMaster[SelMasterID]).Kana := masterkana+st;
            end
            else
            begin
              // �ꌅ�̏ꍇ
              st := copy( desc, pos('set ', desc)+4, 1);
              if IsNumeric(st) then
              begin
                PRecordSet(TLMaster[SelMasterID]).Kana := masterkana+'0'+st;
              end;

            end;

          end
          else
          begin
            // set���Ȃ��ꍇ�͂��̂܂ܒǉ�
            PRecordSet(TLMaster[SelMasterID]).Kana := masterkana;

          end;

  end;

  // �ҏW�E�B���h�E�ɏ��\��
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
                      PChar('���̃Z�b�g�t�@�~���̃Q�[���������Z�b�g���܂��B'),
                      APPNAME, MB_YESNO or MB_ICONQUESTION) then
  begin

      // �N���[���Z�b�g
      for i:=0 to TLMaster.Count-1 do
      begin
        if (PRecordSet(TLMaster[i]).MasterID=SubListID) and
           (PRecordSet(TLMaster[i]).Master=False) then
        begin

          PRecordSet(TLMaster[i]).DescJ := PRecordSet(TLMaster[i]).DescE;

        end;
      end;

      // �e�Z�b�g����������

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

  // �I�����ɍX�V�O�ƍX�V���2��Ăяo�����̂őO�̕����͂���
  // �X�V�O: Selected=False, Item.Index=�s��
  // �X�V��: Selected=True,  Item.Index=����
  if not Selected then exit;

  // �O������X�V���Ă���ꍇ�͔�����
  if DoNotUpdateSL then exit;

  // �I�𒆂̃C���f�b�N�X
  EditingIndex:=StrtoInt(Item.SubItems[6]);
  CurrentIndex:=EditingIndex;


  // �R�}���h�r���[
  frmCommand.LoadCommand(
          PRecordSet(TLMaster[ CurrentIndex ]).ZipName,
          PRecordSet(TLMaster[ PRecordSet(TLMaster[CurrentIndex]).MasterID ]).ZipName );


  // �ҏW�E�B���h�E�ɏ��\��
  UpdateEditPanel(EditingIndex);

  // �X�e�[�^�X�o�[
  StatusBar1.Panels[3].Text:=PRecordSet(TLMaster[EditingIndex]).DescE;

  // �Q�[���X�e�[�^�X�A�C�R���\��
  UpdateStatus;

  // �A�N�V����
  actROpenSrc.Hint:=PRecordSet(TLMaster[EditingIndex]).Source;
  SelZip:=Item.SubItems[0]; // �I�𒆂�Zip��

  // �X�i�b�v�V���b�g
  ShowSnapshot(EditingIndex);

  // dat
  FindDat(CurrentIndex);

  actDelUpdate(nil);

end;

// Enter�L�[�ŋN��
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


// INP�L�^�N��
procedure TForm1.actFRecUpdate(Sender: TObject);
begin

  actPlayUpdate(nil);   // �p�X�֌W�̃`�F�b�N

  actFRec.Enabled:= actPlay.Enabled;

end;

// ���C�ɓ���ǉ�
{procedure TForm1.actFAVAddExecute(Sender: TObject);
var
  i: integer;
begin

  // ���`�F�b�N
  if favorites.Count >= MAXFAVORITES then
  begin
    Application.MessageBox(PWideChar('���C�ɓ���̍ő吔�� '+InttoStr(MAXFAVORITES)+' ���ł��B'), APPNAME, MB_ICONSTOP );
    exit;
  end;

  // �d���`�F�b�N
  for i := 0 to favorites.Count - 1 do
  begin
    if favorites[i]=SelZip then
    begin
      Application.MessageBox(PWideChar(SelZip+' �͂��C�ɓ���ɓo�^�ς݂ł��B'), APPNAME, MB_ICONSTOP );
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

  SaveDialog1.Filter:='���v���C�t�@�C��(*.inp, *.zip)|*.inp;*.zip';
  SaveDialog1.Title:='�L�^����inp�t�@�C����';

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

// inp�Đ�
procedure TForm1.actFReplayUpdate(Sender: TObject);
begin

  actPlayUpdate(nil);   // �p�X�֌W�̃`�F�b�N
  actFReplay.Enabled:= actPlay.Enabled;

end;

procedure TForm1.actFReplayExecute(Sender: TObject);
var i, TempProfile: integer;
    st: string;
    opt: string;
    zip: string;
begin

  OpenDialog1.Filter:='���v���C�t�@�C��(*.inp)|*.inp';
  OpenDialog1.Title:='�Đ�����inp�t�@�C����I��';

  if DirectoryExists(inpDir) then
    OpenDialog1.InitialDir:=inpDir
  else
    OpenDialog1.InitialDir:=ExeDir;

  if OpenDialog1.Execute then
  begin

    // ���s�t�@�C����T��
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

    // �N���Ώۂ̃Q�[�������擾����
    zip:=GetInpGame(OpenDialog1.FileName);

    if zip='' then
    begin
      Windows.MessageBox(Form1.Handle,'INP�t�@�C��������������܂���B','�G���[', MB_ICONERROR);
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

  // ROM�X�e�[�^�X�̈ꎞ�Ҕ�
  SetLength(ROMTemp,TLMaster.Count);
  for i:=0 to TLMaster.Count-1 do
  begin
    ROMTemp[i].Zip:=PRecordset(TLMaster[i]).ZipName;
    ROMTemp[i].ROM:=PRecordset(TLMaster[i]).ROM;
  end;

  // Sample�X�e�[�^�X�̈ꎞ�Ҕ�
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

    Application.MessageBox('�f�[�^�t�@�C���̓ǂݍ��݂Ɏ��s���܂����B'+CRLF+
          '������MAME�{�̂�I�����Ă��������B',APPNAME, MB_ICONERROR + MB_OK);
    Application.Terminate;
    Exit;
  end
  else
  if result=2 then
  begin
    if FileExists(ExeDir+'listxml.tmp') then
      DeleteFile(ExeDir+'listxml.tmp');

    Application.MessageBox('�f�[�^�t�@�C���̓ǂݍ��݂Ɏ��s���܂����B'+CRLF+
          'MAME����LIST.XML�t�H�[�}�b�g���ύX���ꂽ�\��������܂��B',APPNAME, MB_ICONERROR + MB_OK);
    Application.Terminate;
    Exit;
  end;

  CreateZipIndex; // ZIP���̃C���f�b�N�X�쐬

  //

  if ReadMame32jlst=False then
    ReadLang;

  // ROM�X�e�[�^�X����
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

  // Sample�X�e�[�^�X����
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

  // �e�f�[�^�̍ēǂݍ���
  ReadHistoryDat;
  ReadMameInfoDat;
  SetVersionINI;

  // Form Title�X�V
  SetFormTitle;

  // �i�荞�݃��Z�b�g
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

// �t�H�[���̃^�C�g���ݒ�
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
    Item.Subitems.Add('�~')
  else
    Item.Subitems.Add('��');

  Item.Subitems.Add(InttoStr(PRecordSet(TLFamily[i]).ID));

  // �A�C�R��
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

  // ListView�p�A�C�R���̔w�i�F
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

      // ��ԉ��܂ōs������擪���猟���𑱂���
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

// �t�H���_������o��
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

// �p��̃��X�g�o��
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
  // "�Q�[����","�J����","�̔���","�N�x","�W������",
  // "�R���g���[��","�V�X�e���{�[�h","CPU","�T�E���h",
  // "�𑜓x","�F��","","�T�|�[�g","����","�Z�b�g1",
  // "�Z�b�g2","�Z�b�g3","�Z�b�g4","�Z�b�g5","�Z�b�g6",
  // "�Z�b�g7","�Z�b�g8","�Z�b�g9","�Z�b�g10",
  // "����1","����2","����3","����4","����5","����6","����7","����8","����9","����10"

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
	    st:=st+#9+'�f�[�^�C�[�X�g';
	    st:=st+#9+'�f�[�^�C�[�X�g';
    end
    else
    if (maker = 'Sega') then
    begin
	    st:=st+#9+'�Z�K';
	    st:=st+#9+'�Z�K';
    end
    else
    if (maker = 'Taito') then
    begin
	    st:=st+#9+'�^�C�g�[';
	    st:=st+#9+'�^�C�g�[';
    end
    else
    if (maker = 'Capcom') then
    begin
	    st:=st+#9+'�J�v�R��';
	    st:=st+#9+'�J�v�R��';
    end
    else
    begin

  	  if (maker = 'Unknown') then
	      maker:= '���[�J�[�s��';

	    st:=st+#9+'���C�O���i�i'+maker+'�j';

      st:=st+#9+'';

    end;


	  // dist
//	  st:=st+#9+'';

	  // year
	  st:=st+#9+PRecordSet(TLMaster[idx]).Year;

	  // genre
	  st:=st+#9+'���s���{�[��';

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
	  st:=st+#9+ '��';

	  // ver
	  //st:=st+#9+ 'v'+Copy(DatVersion, 1, Pos(' (',DatVersion)-1);
	  st:=st+#9+ 'v'+DatVersion; // ���t�͖����Ȃ���

	  // desc
	  st:=st+#9;


	  // �S�Z�b�g�ǉ�
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

  // ���`�F�b�N
  if favorites2.Count >= MAXFAVORITES2 then
  begin
    Application.MessageBox(PWideChar('���C�ɓ���̍ő吔�� '+InttoStr(MAXFAVORITES2)+' ���ł��B'), APPNAME, MB_ICONSTOP );
    exit;
  end;

  // �d���`�F�b�N
  for i := 0 to favorites2.Count - 1 do
  begin

    kind := copy(favorites2[i], 1, pos( #9, favorites2[i] ) -1 );
    zip := copy(favorites2[i], pos( #9, favorites2[i] )+1, favorites2[i].Length);

    if (kind<>'f') AND ( zip=SelZip ) then
    begin
      Application.MessageBox( PWideChar(SelZip+' �͂��C�ɓ���ɓo�^�ς݂ł��B'), APPNAME, MB_ICONSTOP );
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
  if (SelZip<>'') // �I������
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
  // �ΏۂȂ�
  if SelZip='' then
  begin
    actFEmma.Caption :='&EMMA�Ō���...';
    actFEmma.Enabled := False;
  end
  else
  // ����
  begin
    actFEmma.Caption := '�u'+SelZip+'�v��&EMMA�Ō���...';
    actFEmma.Enabled := True;
  end;
end;

// ���C�ɓ���̋N��
procedure TForm1.RunFavorite(Sender: TObject);
begin

  // �v���t�@�C�����I��
  if CurrentProfile=-1 then exit;

  // ���s�t�@�C���m�F
  if (FileExists(MameExe[CurrentProfile].ExePath)) and
     ((DirectoryExists(MameExe[CurrentProfile].WorkDir) or
      (MameExe[CurrentProfile].WorkDir='')))
  then
  begin

    RunMAME( favorites[(Sender as TAction).Tag] );

  end;

end;

// ���C�ɓ���̋N���V�^
procedure TForm1.RunFavorite2(Sender: TObject);
var zip: String;
    tag: Integer;
begin

  // �v���t�@�C�����I��
  if CurrentProfile=-1 then exit;

  // ���s�t�@�C���m�F
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
  // �_�~�[
  // �A�N�V�������j���[���̃t�H���_�p
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

    // �܂�����
    for i:=0 to Length(FavActions2)-1 do
    begin
      FavActions2[i].Free;
    end;

    if Favorites2.Count = 0 then begin
      setlength( FavActions2, 0 );
      exit;
    end;

    // ���C�ɓ��肪���郁�j���[�ʒu
    AC:= ActionManager1.ActionBars[5].Items[3];

    n := 0;
    folderIdx := -1; //�t�H���_���o�^

    try
      for i:=0 to Favorites2.Count-1 do begin

        if (trim( Favorites2[i] ) <> '') AND ( Favorites2[i].Substring(1,1) <> '#' ) then begin

          setlength( FavActions2, n+1 );

          kind := copy(Favorites2[i], 1, pos( #9, Favorites2[i] ) -1 );
          zip := copy(Favorites2[i], pos( #9, Favorites2[i] )+1, Favorites2[i].Length);

          // �t�H���_�ǉ�
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
          // �^�C�g������
          begin

            // zip��������擾����
            idx:= FindIndex( zip );

            /// �s���ȃQ�[��
            if idx=-1 then
            begin
              st := zip + ' - <�s���ȃQ�[��>';
              icoidx := 8+39;
            end
            else
            /// ���݂���Q�[��
            begin
              if En then
                st := zip + ' - '+ PRecordSet(TLMaster[idx]).DescE
              else
                st := zip + ' - '+ PRecordSet(TLMaster[idx]).DescJ;

              if Length(st)>40 then
              begin
                st:=copy(st,0,40)+'...';
              end;

              // �A�C�R��
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

            // ���[�g�K�w�̃^�C�g��
            if ( kind = '-1' ) then begin
              AC.Items.Add.Action := FavActions2[n];
              Inc(folderIdx);
            end
            else begin
              // ���K�w�̃^�C�g��
              AC.Items[3+folderIdx].Items.Add.Action:=FavActions2[n];
            end;

          end;

          inc(n);
        end;
      end;

    except
      Application.MessageBox(PWideChar('���C�ɓ���̓ǂݍ��ݎ��ɃG���[���N���܂����B'+#13#10+'�ݒ�t�@�C�����폜���Ă�蒼���Ă��������B'), APPNAME, MB_ICONSTOP );
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

    // �X�i�b�v�V���b�g
    ShowSnapshot(CurrentIndex);

    // �A�N�V����
    //actDelScreenShot.Enabled:=(CurrentShot<>'');
    actRRefine.Hint:=PRecordSet(TLSub[ListView1.ItemIndex]).Source;
    actROpenSrc.Hint:=PRecordSet(TLSub[ListView1.ItemIndex]).Source;

  end
  else
  if ListView2.Focused then
  begin

    if ListView2.ItemIndex=-1 then exit;

    actDelUpdate(nil); // �폜���j���[�̍X�V

    // �X�i�b�v�V���b�g
    ShowSnapshot(EditingIndex);

  end;

end;

procedure TForm1.actOpenTestersUpdate(Sender: TObject);
begin

  // �ΏۂȂ�
  if SelDriver='' then
  begin
    actOpenTesters.Caption :='&Testers�Ō���...';
    actOpenTesters.Enabled := False;
  end
  else
  // ����
  begin
    actOpenTesters.Caption := '�u'+SelDriver+'�v��&Testers�Ō���...';
    actOpenTesters.Enabled := True;
  end;

end;

procedure TForm1.actOpenTestersExecute(Sender: TObject);
begin
  if (SelDriver<>'') // �I������
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

      // ��ԉ��܂ōs������擪���猟���𑱂���
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
  // "�Q�[����","�J����","�̔���","�N�x","�W������1","�W������2","�R���g���[��","�V�X�e���{�[�h","�C�O�t���O","�T�|�[�g","����",
  // "�Z�b�g1","�Z�b�g2","�Z�b�g3","�Z�b�g4","�Z�b�g5","�Z�b�g6","�Z�b�g7","�Z�b�g8","�Z�b�g9","�Z�b�g10","�Z�b�g11","�Z�b�g12",  .... "�Z�b�g100"

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
    maker:= '���[�J�[�s��';


  if (maker = 'bootleg') then
  begin
    st:=st+#9+'���C����';
    st:=st+#9+'���C����';
  end
  else
  begin
    st:=st+#9+'���C�O���i�i'+maker+'�j';
    st:=st+#9+'�������̔��Ȃ�';
  end;

  // year
  st:=st+#9+PRecordSet(Item).Year;

  // genre
  st:=st+#9+'��������';

  // genre2
  st:=st+#9+'';

  // ctrler
  st:=st+#9+'��������';

  // sys
  st:=st+#9;

  //
  st:=st+#9+ '��';

  // ver
//  st:=st+#9+ 'v'+Copy(DatVersion, 1, Pos(' (',DatVersion)-1);
  st:=st+#9+ trim('v'+DatVersion);

  // desc
  st:=st+#9;


  // �S�Z�b�g�ǉ�
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
  // "�Q�[����","�J����","�̔���","�N�x","�W������1","�W������2","�R���g���[��","�V�X�e���{�[�h","�C�O�t���O","�T�|�[�g","����",
  // "�Z�b�g1","�Z�b�g2","�Z�b�g3","�Z�b�g4","�Z�b�g5","�Z�b�g6","�Z�b�g7","�Z�b�g8","�Z�b�g9","�Z�b�g10","�Z�b�g11","�Z�b�g12",  .... "�Z�b�g100"

  st:='';
  s:='';
  cpu:='';
  sound:='';

  // �S�Z�b�g�ǉ�
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

