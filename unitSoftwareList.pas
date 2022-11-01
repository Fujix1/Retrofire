unit unitSoftwareList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, System.Generics.Collections,
  Vcl.WinXCtrls, Vcl.ComCtrls, Generics.Collections, Common, Diagnostics,CommCtrl, DWMAPI;

type
  TfrmSoftwareList = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    cmbSoftlist: TComboBox;

    ListView1: TListView;
    chkAlwaysOnTop: TCheckBox;
    StatusBar1: TStatusBar;
    Timer1: TTimer;
    SearchBox1: TSearchBox;

    procedure chkAlwaysOnTopClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmbSoftlistChange(Sender: TObject);
    procedure ListView1Data(Sender: TObject; Item: TListItem);
    procedure ListView1AdvancedCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; Stage: TCustomDrawStage;
      var DefaultDraw: Boolean);
    procedure ListView1SelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure ListView1DblClick(Sender: TObject);
    procedure ListView1KeyPress(Sender: TObject; var Key: Char);
    procedure ListView1DataFind(Sender: TObject; Find: TItemFind;
      const FindString: string; const FindPosition: TPoint; FindData: Pointer;
      StartIndex: Integer; Direction: TSearchDirection; Wrap: Boolean;
      var Index: Integer);
    procedure FormResize(Sender: TObject);
    procedure ListView1ColumnClick(Sender: TObject; Column: TListColumn);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Timer1Timer(Sender: TObject);
    procedure edtSearchKeyPress(Sender: TObject; var Key: Char);
    procedure SearchBox1Change(Sender: TObject);
    procedure SearchBox1Enter(Sender: TObject);
    procedure SearchBox1Exit(Sender: TObject);
    procedure SearchBox1KeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);

  private
    { Private 宣言 }

    var
      softlistAvailable: boolean; // ソフトリスト有効

      lastZip: string; // 直前選択されていたzip名
      lastMasterIndex: integer; // 直前に選択されていたzipマスタインデックス

      currentSoftMasterIndex: integer;
      currentSoftlistName: string;

      currentSoftlistIndex: integer; //

      lang: string;
      selectedSoftName: string;

      SubList: TList;
      FpntMoveOrg,
      FpntMoveFit     : TPoint;

    procedure updateListView;
    function updateSoftItems(const SLName:string; orderBy: integer; asc:boolean; searchWord: string): integer;
    procedure WMSizing(var MSG: Tmessage); message WM_Sizing;
    procedure WMEnterSizeMove(var MSG: Tmessage); message WM_EnterSizeMove;
    procedure WMMoving(var MSG: Tmessage); message WM_Moving;

  public
    { Public 宣言 }

    function init(const ExeDir:string): boolean;
    procedure setSoftlist(const zip:string; forceUpdate:boolean = false);
    procedure updateLang(newLang: string);
    procedure saveIni;
    procedure SetListViewColumnSortMark(ColumnIndex: Integer);

    var
      lastSoftlist: string; // 最新の選択ソフトリスト
      lastSoftware: string; // 最新の選択ソフトウェア
      columnSort: integer; //

      DoNotUpdateListView: boolean;

      softMaster: TObjectDictionary<string, TStringList>;
      softlistData2: TList;

      softlistHistory: TStringList; // 選んだソフトリストのヒストリー

      isSnapped: Boolean;

    const
      MAXSOFTLISTHISTORY = 16;       // ヒストリーを保持する最大数

  end;


var
  frmSoftwareList: TfrmSoftwareList;

// 比較函数
function AscSort2(Item1, Item2: Pointer): Integer;

implementation

uses Unit1;

{$R *.dfm}



procedure FormFitSizeToForms(frmTgt: TForm; var rectNew: TRect; iSide: integer);
  function Sub(const rectTgt: TRect; var rectForm: TRect) : boolean;
  begin
    result := false;
    if ((rectForm.Bottom + ciFittingThreshold >= rectTgt.Top   ) and
        (rectForm.Top    - ciFittingThreshold <= rectTgt.Bottom))then begin
      if (Abs(rectForm.Left - rectTgt.Left) <= ciFittingThreshold) then begin
        Inc(rectForm.Left, rectTgt.Left - rectForm.Left);
      end else if (Abs(rectForm.Left  - rectTgt.Right)
                   <= ciFittingThreshold) then begin
        Inc(rectForm.Left, rectTgt.Right - rectForm.Left);
        result := true;
      end;

      if (Abs(rectForm.Right - rectTgt.Right) <= ciFittingThreshold) then begin
        Inc(rectForm.Right, rectTgt.Right - rectForm.Right);
      end else if (Abs(rectForm.Right - rectTgt.Left )
                   <= ciFittingThreshold) then begin
        Inc(rectForm.Right, rectTgt.Left- rectForm.Right);
        result := true;
      end;
    end;

    if ((rectForm.Right + ciFittingThreshold >= rectTgt.Left ) and
        (rectForm.Left  - ciFittingThreshold <= rectTgt.Right))then begin
      if (Abs(rectForm.Top - rectTgt.Top) <= ciFittingThreshold) then begin
        Inc(rectForm.Top, rectTgt.Top - rectForm.Top);
      end else if (Abs(rectForm.Top  - rectTgt.Bottom)
                   <= ciFittingThreshold) then begin
        Inc(rectForm.Top, rectTgt.Bottom - rectForm.Top);
        result:=true;
      end;
      if (Abs(rectForm.Bottom - rectTgt.Bottom)
          <= ciFittingThreshold) then begin
        Inc(rectForm.Bottom, rectTgt.Bottom - rectForm.Bottom);
      end else if (Abs(rectForm.Bottom - rectTgt.Top )
                   <= ciFittingThreshold) then begin
        Inc(rectForm.Bottom, rectTgt.Top - rectForm.Bottom);
        result:=true;
      end;
    end;
  end;

var
  iCntr   : integer;
  frmTmp  : TForm;
  rectScreen,
  rectTmp,
  rectBuf : TRect;
begin

  getFrameSize(frmSoftwareList);

  rectBuf := Rect(rectNew.Left   + Frame.Left,
                  rectNew.Top    + Frame.Top,
                  rectNew.Right  + Frame.Right,
                  rectNew.Bottom + Frame.Left);

  if (SystemParametersInfo(SPI_GETWORKAREA, 0, @rectScreen, 0) = TRUE) then begin
    Sub(rectScreen, rectBuf);
  end;

  for iCntr := 0 to Screen.FormCount - 1 do begin
    frmTmp  := Screen.Forms[iCntr];
    if (frmTmp = Form1) and (frmTmp <> frmTgt) and (frmTmp.Visible) then begin


      DwmGetWindowAttribute(frmTmp.Handle,
                            DWMWA_EXTENDED_FRAME_BOUNDS,
                            @rectTmp,
                            SizeOf(TRect));
      Sub(rectTmp, rectBuf);
    end;
  end;

  case (iSide) of
    WMSZ_LEFT,
    WMSZ_TOPLEFT,
    WMSZ_BOTTOMLEFT  : rectNew.Left  := rectBuf.Left-Frame.Left;
    WMSZ_RIGHT,
    WMSZ_TOPRIGHT,
    WMSZ_BOTTOMRIGHT : rectNew.Right := rectBuf.Right-Frame.Right;
  end;

  case (iSide) of
    WMSZ_TOP,
    WMSZ_TOPLEFT,
    WMSZ_TOPRIGHT    : rectNew.Top    := rectBuf.Top-Frame.Top;

    WMSZ_BOTTOM,
    WMSZ_BOTTOMLEFT,
    WMSZ_BOTTOMRIGHT : rectNew.Bottom := rectBuf.Bottom-Frame.Bottom;
  end;

end;


procedure FormFitMoveToForms(frmTgt: TForm; var rectForm: TRect);

  function SubH(const rectTgt: TRect): boolean;
  begin
    Result := FALSE;
    if ((rectForm.Bottom + ciFittingThreshold >= rectTgt.Top   ) and
        (rectForm.Top    - ciFittingThreshold <= rectTgt.Bottom))then begin
      if (Abs(rectForm.Left - rectTgt.Left) <= ciFittingThreshold) then begin
        OffsetRect(rectForm, rectTgt.Left - rectForm.Left, 0);
        Result := TRUE;
      end else if (Abs(rectForm.Right - rectTgt.Right)
                   <= ciFittingThreshold) then begin
        OffsetRect(rectForm, rectTgt.Right - rectForm.Right, 0);
        Result := TRUE;
      end else if (Abs(rectForm.Left  - rectTgt.Right)
                   <= ciFittingThreshold) then begin
        OffsetRect(rectForm, rectTgt.Right - rectForm.Left, 0);
        Result := TRUE;
      end else if (Abs(rectForm.Right - rectTgt.Left )
                   <= ciFittingThreshold) then begin
        OffsetRect(rectForm, rectTgt.Left- rectForm.Right, 0);
        Result := TRUE;
      end;
    end;
  end;

  function SubV(const rectTgt: TRect): boolean;
  begin
    Result := FALSE;
    if ((rectForm.Right + ciFittingThreshold >= rectTgt.Left ) and
        (rectForm.Left  - ciFittingThreshold <= rectTgt.Right))then begin
      if (Abs(rectForm.Top - rectTgt.Top) <= ciFittingThreshold) then begin
        OffsetRect(rectForm, 0, rectTgt.Top - rectForm.Top);
        Result := TRUE;
      end else if (Abs(rectForm.Bottom - rectTgt.Bottom)
                   <= ciFittingThreshold) then begin
        OffsetRect(rectForm, 0, rectTgt.Bottom - rectForm.Bottom);
        Result := TRUE;
      end else if (Abs(rectForm.Top  - rectTgt.Bottom)
                   <= ciFittingThreshold) then begin
        OffsetRect(rectForm, 0, rectTgt.Bottom - rectForm.Top);
        Result := TRUE;
      end else if (Abs(rectForm.Bottom - rectTgt.Top )
                   <= ciFittingThreshold) then begin
        OffsetRect(rectForm, 0, rectTgt.Top - rectForm.Bottom);
        Result := TRUE;
      end;
    end;
  end;

var
  iCntr       : integer;
  frmTmp      : TForm;
  rectTmp     : TRect;
  rectScreen  : TRect;
  boolScreen  : boolean;
  flag        : boolean;
begin

  flag := false;
  boolScreen := SystemParametersInfo(SPI_GETWORKAREA, 0, @rectScreen, 0);

  if (boolScreen = FALSE) or (SubH(rectScreen) = FALSE) then begin
    for iCntr := 0 to Screen.FormCount - 1 do begin
      frmTmp  := Screen.Forms[iCntr];
      DwmGetWindowAttribute(frmTmp.Handle,
                            DWMWA_EXTENDED_FRAME_BOUNDS,
                            @rectTmp,
                            SizeOf(TRect));

      if (frmTmp = Form1) and  (frmTmp <> frmTgt) and (frmTmp.Visible) then begin
        if (SubH(rectTmp)) then
        begin
          flag := true;
          break;
        end;
      end;
    end;
  end;


  if (boolScreen = FALSE) or (SubV(rectScreen) = FALSE) then begin
    for iCntr := 0 to Screen.FormCount - 1 do begin
      frmTmp  := Screen.Forms[iCntr];
      DwmGetWindowAttribute(frmTmp.Handle,
                            DWMWA_EXTENDED_FRAME_BOUNDS,
                            @rectTmp,
                            SizeOf(TRect));

      if (frmTmp = Form1) and (frmTmp <> frmTgt) and (frmTmp.Visible) then begin
        if (SubV(rectTmp)) then
        begin
          flag := true;
          break;
        end;
      end;
    end;
  end;


end;



procedure TfrmSoftwareList.WMSizing(var MSG: Tmessage);
begin
  inherited;
  FormFitSizeToForms(Self, PRect(Msg.LParam)^, Msg.WParam);
  Msg.Result := -1;
end;


procedure TfrmSoftwareList.WMEnterSizeMove(var MSG: Tmessage);
var rectTmp: TRect;
begin
  inherited;

  DwmGetWindowAttribute(Self.Handle,
                        DWMWA_EXTENDED_FRAME_BOUNDS,
                        @rectTmp,
                        SizeOf(TRect));

  FpntMoveOrg.X := rectTmp.Left;
  FpntMoveOrg.Y := rectTmp.Top;
  FpntMoveFit   := FpntMoveOrg;
end;

procedure TfrmSoftwareList.WMMoving(var MSG: Tmessage);
var
  rectNew : TRect;
  iWidth,
  iHeight : integer;
begin
  inherited;


  getFrameSize(frmSoftwareList);

  rectNew := PRect(Msg.LParam)^;

  rectNew.Left    :=  rectNew.Left   + Frame.Left;
  rectNew.Top     :=  rectNew.Top    + Frame.Top;
  rectNew.Right   :=  rectNew.Right  + Frame.Right;
  rectNew.Bottom  :=  rectNew.Bottom + Frame.Bottom;

  FpntMoveOrg.X := FpntMoveOrg.X + rectNew.Left - FpntMoveFit.X;
  FpntMoveOrg.Y := FpntMoveOrg.Y + rectNew.Top  - FpntMoveFit.Y;

  iWidth  := rectNew.Width;
  iHeight := rectNew.Height;

  rectNew.TopLeft := FpntMoveOrg;
  rectNew.Right   := FpntMoveOrg.X + iWidth;
  rectNew.Bottom  := FpntMoveOrg.Y + iHeight;

  FormFitMoveToForms(Self, rectNew);

  FpntMoveFit := rectNew.TopLeft;

  PRect(Msg.LParam)^:= Rect(
    rectNew.Left    - Frame.Left,
    rectNew.Top     - Frame.Top,
    rectNew.Right   - Frame.Right,
    rectNew.Bottom  - Frame.Bottom
  );

  Msg.Result := -1;

end;






procedure TfrmSoftwareList.updateLang(newLang: string);
begin
  lang:=newLang;
  updateListView;
end;

procedure TfrmSoftwareList.cmbSoftlistChange(Sender: TObject);
begin
  UpdateListView;
end;

procedure TfrmSoftwareList.FormCreate(Sender: TObject);
begin
  lastMasterIndex := -1;
  lastZip:='';
  lang := 'ja';
  columnSort := 1;
  SetListViewColumnSortMark( columnSort );

  softlistHistory := TStringList.Create;
  softlistHistory.Capacity := MAXSOFTLISTHISTORY;
end;


procedure TfrmSoftwareList.FormDestroy(Sender: TObject);
begin
    softlistHistory.Free;
end;

procedure TfrmSoftwareList.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if searchBox1.Focused then
    exit;

  if Key=#8 then
  begin
    if SearchBox1.Enabled then
      SearchBox1.SetFocus;
  end;
end;

procedure TfrmSoftwareList.FormResize(Sender: TObject);
begin
  StatusBar1.Panels[1].Width := frmSoftwareList.ClientWidth - 200;
end;


// 初期化処理
// 複数回呼び出されるので注意
// return 成功/失敗
function TfrmSoftwareList.init(const ExeDir:string): boolean;
var

  master: TStringList;
  fields: TStringList;
  softdata: TStringList;

  i, j, n: integer;

  st: string;

  name, desc: string;
  newSoftlist: TSoftlist;

  sl: TStringList;
  dicSetting: TDictionary<string, string>;

  newItem: PSoftlist2;
  newSoft: PSoftware;

  p: PSoftlist2;

begin

  StatusBar1.Font.Size := 8;

  result:=false;
  softlistAvailable := false;

  fields:=TStringList.Create;
  fields.Delimiter:=#9;
  fields.StrictDelimiter:=true;


  if (FileExists(ExeDir + SL_DIR + SL_DATA)=false) then
  begin
    exit;
  end;

  // 設定復旧
  try
    dicSetting := TDictionary<string, string>.create;
    sl := TStringList.Create;
    if FIleExists(ExeDir + SL_DIR + SL_INI) then
    begin
      sl.LoadFromFile(ExeDir + SL_DIR + SL_INI, TEncoding.UTF8);
      for i := 0 to sl.Count-1 do
      begin
        fields.DelimitedText := sl[i];
        dicSetting.Add(fields[0], fields[1]);
      end;
    end;

  finally
    sl.Free;
  end;


  // ソフトリスト全部読込み
  try

    if Assigned(softlistData2) then
    begin

      saveIni;

      // ソフトリストデータ完全削除
      for i := 0 to softlistData2.Count-1 do
      begin
        p := PSoftlist2(softlistData2[i]);
        p.softwares.Free;
        Dispose(p);
      end;
      softlistData2.Free;
    end;


    softlistData2:= TList.Create;

    softdata := TStringList.Create;
    softdata.LoadFromFile( ExeDir + SL_DIR + SL_DATA, TEncoding.UTF8);

    for i := 0 to softdata.Count-1 do
    begin

      fields.DelimitedText:=softdata[i];

      // ソフトリストエントリ
      if (fields.Count = 3) then
      begin

        New(newItem);
        newItem.name := fields[0]; // 名前
        newItem.desc := fields[1]; // 説明
        newItem.softwares := TList.Create;  // ソフトエントリ
        if (dicSetting.TryGetValue(newItem.name ,st)) then
        begin
          newItem.lastSelect:=st;
        end
        else
        begin
          newItem.lastSelect:='';
        end;

        softlistData2.Add(newItem);


      end
      else if (fields.Count = 7) then
      begin

        New(newSoft);
        newSoft.name      := fields[0];
        newSoft.cloneof   := fields[1];
        newSoft.desc      := fields[2];
        newSoft.alt       := fields[3];
        newSoft.year      := fields[4];
        newSoft.publisher := fields[5];
        newSoft.supported := fields[6];
        if fields[3]='' then
          newSoft.alt:=fields[2];
        newItem.softwares.Add(newSoft);

      end;

    end;


    // データ参照方法
{
    for i := 0 to softlistData2.Count-1 do
    begin
      st:='';
      for j := 0 to PSoftlist2(softlistData2[i]).softwares.Count-1 do
      begin
        st:=st+#9+ PSoftware(PSoftlist2(softlistData2[i]).softwares[j]).name;
      end;

      Memo1.Lines.Add( PSoftlist2(softlistData2[i]).desc + st );
    end;



    // ソフトリストデータ削除
    for i := 0 to softlistData2.Count-1 do
    begin
      p := PSoftlist2(softlistData2[i]);
      p.softwares.Free;
      Dispose(p);
    end;

    softlistData2.Free;
 }

  finally
    softdata.Free;
    dicSetting.Free;
  end;


  try

    // ソフトウェアのマスタ情報
    if (Assigned(softMaster)) then softMaster.Free;

    softMaster := TObjectDictionary<String, TStringList>.Create;

    if FileExists(ExeDir + SL_DIR + SL_MASTER) then
    begin
      master := TStringList.Create;
      master.LoadFromFile(ExeDir + SL_DIR + SL_MASTER, TEncoding.UTF8);

      for i := 0 to master.Count -1 do
      begin
        fields.DelimitedText := master[i];
        softMaster.Add(fields[0], TStringList.Create);
        for j := 1 to fields.Count-1 do
        begin
          softMaster[fields[0]].Add(fields[j]);
        end;
      end;

      master.Free;

    end;

  finally

    fields.Free;

  end;

  softlistAvailable:=true;
  result:=true;

end;


// 表示に使うソフト項目を再構成する
function TfrmSoftwareList.updateSoftItems(const SLName:string; orderBy: integer; asc:boolean; searchWord: string):integer;
var key: string;
    i, j, n: integer;
    tempSoftwares: Array of TSoftware;

begin

  n:=0;

  SubList.Free;

  SubList:=TList.Create;

  searchWord:= Trim(searchWord);

  // SLName で検索
  for j := 0 to softlistData2.Count-1 do
  begin
    if PSoftlist2(softlistData2[j]).name = SLName then
    begin
      SubList.Capacity:=PSoftlist2(softlistData2[j]).softwares.Count;
      currentSoftlistIndex := j;
      break;
    end;
  end;

  if SearchWord='' then
  begin
    for i := 0 to PSoftlist2(softlistData2[j]).softwares.Count-1 do
    begin
      SubList.Add(PSoftlist2(softlistData2[j]).softwares[i]);
    end;

  end
  else
  begin

    for i := 0 to PSoftlist2(softlistData2[j]).softwares.Count-1 do
    begin

      if Lang='en' then
      begin
        if (Pos(searchWord, LowerCase( PSoftware(PSoftlist2(softlistData2[j]).softwares[i]).name))<>0) or
           (Pos(searchWord, LowerCase( PSoftware(PSoftlist2(softlistData2[j]).softwares[i]).desc))<>0) or
           (Pos(searchWord, LowerCase( PSoftware(PSoftlist2(softlistData2[j]).softwares[i]).publisher))<>0)
         then
          SubList.Add(PSoftlist2(softlistData2[j]).softwares[i]);
      end
      else
      begin
        if (Pos(searchWord, LowerCase( PSoftware(PSoftlist2(softlistData2[j]).softwares[i]).name))<>0) or
           (Pos(searchWord, LowerCase( PSoftware(PSoftlist2(softlistData2[j]).softwares[i]).alt))<>0) or
           (Pos(searchWord, LowerCase( PSoftware(PSoftlist2(softlistData2[j]).softwares[i]).publisher))<>0)
         then
          SubList.Add(PSoftlist2(softlistData2[j]).softwares[i]);
      end;
    end;


  end;


  SubList.Capacity:=SubList.Count;


  // ソート
  SubList.Sort(@AscSort2);


  StatusBar1.Panels[0].Text:=inttostr(SubList.Count) + ' / ' +
  inttostr(PSoftlist2(softlistData2[j]).softwares.Count);

  result:=SubList.Count;

end;


// 比較函数
function AscSort2(Item1, Item2: Pointer): Integer;
begin

  Result:=0;

  if (Item1 = nil) or (Item2 = nil) then Exit;

  case frmSoftwareList.columnSort of
    1,-1:
    begin
      if frmSoftwareList.lang = 'ja' then
        Result := AnsiCompareText(PSoftware(Item1).alt,           PSoftware(Item2).alt)
      else
        Result := CompareText( PSoftware(Item1).desc,             PSoftware(Item2).desc);
    end;

    2,-2: Result := CompareText(PSoftware(Item1).name,            PSoftware(Item2).name);
    3,-3: Result := AnsiCompareText(PSoftware(Item1).publisher,   PSoftware(Item2).publisher);
    4,-4: Result := CompareText(PSoftware(Item1).year,            PSoftware(Item2).year);
    5,-5: Result := CompareText(PSoftware(Item1).cloneof,         PSoftware(Item2).cloneof);
  end;

  if frmSoftwareList.columnSort<1 then Result:=Result*-1;
                                                         
end;

procedure TfrmSoftwareList.ListView1AdvancedCustomDrawItem(
  Sender: TCustomListView; Item: TListItem; State: TCustomDrawState;
  Stage: TCustomDrawStage; var DefaultDraw: Boolean);
begin
  if Item.Index mod 2 = 1 then
    ListView1.Canvas.Brush.Color:=$f5f5f5;
end;


procedure TfrmSoftwareList.ListView1ColumnClick(Sender: TObject;
  Column: TListColumn);
var
  st: string;
  idx: integer;
begin

  if Column.Caption = 'ゲーム名' then idx := 1
  else if Column.Caption = 'ZIP名' then idx := 2
  else if Column.Caption = 'メーカー' then idx := 3
  else if Column.Caption = '年度' then idx := 4
  else if Column.Caption = 'マスタ' then idx := 5;

  if abs(columnSort) = idx then columnSort:=columnSort*-1
  else columnSort:=idx;

  SetListViewColumnSortMark( columnSort );

  UpdateListView;

end;

procedure TfrmSoftwareList.ListView1Data(Sender: TObject; Item: TListItem);
var
  i:integer;
begin

  i:=Item.Index;

  if lang='ja' then
  begin

    Item.Caption := PSoftware(SubList[i]).alt;

  end
  else
    Item.Caption := PSoftware(SubList[i]).desc;

  Item.SubItems.Add(PSoftware(SubList[i]).name);
  Item.SubItems.Add(PSoftware(SubList[i]).publisher);
  Item.SubItems.Add(PSoftware(SubList[i]).year);
  Item.SubItems.Add(PSoftware(SubList[i]).cloneof);

end;


procedure TfrmSoftwareList.ListView1DataFind(Sender: TObject; Find: TItemFind;
  const FindString: string; const FindPosition: TPoint; FindData: Pointer;
  StartIndex: Integer; Direction: TSearchDirection; Wrap: Boolean;
  var Index: Integer);
var
  i: Integer;
  Found: Boolean;
  softname: string;
begin

  i := StartIndex;
  softname:=softMaster[lastZip][cmbSoftList.ItemIndex];

  if (Find = ifExactString) or (Find = ifPartialString) then
  begin
    repeat

      // 一番下まで行ったら先頭から検索を続ける
      if (i = SubList.Count-1) then
        if Wrap then i := 0 else Exit;

      if lang='ja' then
        Found := Pos(LowerCase(FindString), LowerCase(PSoftware(SubList[i]).alt)) = 1
      else
        Found := Pos(LowerCase(FindString), LowerCase(PSoftware(SubList[i]).desc)) = 1;

      if not Found then Inc(i);

    until Found or (i = StartIndex);

    if Found then Index := i;

  end;


end;

procedure TfrmSoftwareList.ListView1SelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
  var
   i :integer;
   sl2: TSoftlist;
   supported: string;
begin
  // 選択時に更新前と更新後の2回呼び出されるので前の方をはじく
  // 更新前: Selected=False, Item.Index=不定
  // 更新後: Selected=True,  Item.Index=あり

  if not Selected then exit;

  selectedSoftName:=Item.SubItems[0];

  PSoftlist2(softlistData2[currentSoftlistIndex]).lastSelect:=selectedSoftName;
  StatusBar1.Panels[1].Text:= PSoftware(SubList[ListView1.ItemIndex]).desc;

  supported := PSoftware(SubList[ListView1.ItemIndex]).supported;
  if (supported = 'yes') then
    StatusBar1.Panels[2].Text:='動作可能 '
  else if (supported = 'partial') then
    StatusBar1.Panels[2].Text:='部分サポート '
  else if (supported = 'no') then
    StatusBar1.Panels[2].Text:='未サポート '
  else
    StatusBar1.Panels[2].Text:='';

end;


procedure TfrmSoftwareList.ListView1DblClick(Sender: TObject);
begin
  if (selectedSoftName<>'') then
    Form1.RunSoft(selectedSoftName);
end;

procedure TfrmSoftwareList.ListView1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then
  begin
    Key:=#0;
    if (selectedSoftName<>'') then
      Form1.RunSoft(selectedSoftName);
  end;

end;

// zip 名でソフトリストを更新する
procedure TfrmSoftwareList.setSoftlist(const zip:string; forceUpdate:boolean = false);
var
  i,j,n: integer;
  st: string;
  needUpdate: boolean;

  sl: TStringList;
  lastListCount: integer; // 変更直前のドロップダウンリスト数

  softlistIndex: integer;//
  hit: boolean;
begin

  if not softlistAvailable then exit;

  // 2回呼ばれるのを防止
  if (zip = lastZip) then exit;


  needUpdate := false;
  lastListCount:=cmbSoftList.Items.Count;

  if forceUpdate then
  begin
    lastListCount:=0; // 強制更新
    lastZip:='';
  end;


  // ソフトリストあるか確認
  if (softMaster.TryGetValue(zip, sl)) then
  begin

    needUpdate := true;

    // 直前の選択と一致するか
    if lastZip<>'' then
    begin
      if softMaster[lastZip].Count = sl.Count then
      begin
        needUpdate := false;
        for i := 0 to sl.Count-1 do
        begin
          if softMaster[lastZip][i]<>sl[i] then
          begin
            needUpdate :=true;
            break;
          end;

        end;
      end;
    end;


    // 一致しなかったときは更新
    if needUpdate then
    begin
      cmbSoftList.Items.Clear;
      for i := 0 to sl.Count-1 do
      begin

        for j := 0 to softlistData2.Count-1 do
        begin
          if sl[i] = PSoftlist2(SoftlistData2[j]).name then
          begin
            softlistIndex := j;
            cmbSoftList.Items.Add(PSoftlist2(SoftlistData2[softlistIndex]).desc + ' (' + PSoftlist2(SoftlistData2[softlistIndex]).name+')');
            break;
          end;
        end;

      end;
      cmbSoftList.Enabled := true;

      // ヒストリーにあればそれを選択
      hit := false;
      for i := 0 to softlistHistory.Count-1 do
      begin
        for j := 0 to sl.Count-1 do
        begin
          if softlistHistory[i] = sl[j] then
          begin
            cmbSoftList.ItemIndex := j;
            hit := true;
            break;
          end;
        end;
        if hit then break;
      end;

      if not hit then cmbSoftList.ItemIndex := 0;
    end;

    lastZip:=zip;
    frmSoftwareList.Caption:='ソフトウェアリスト - '+zip+' - リスト数: '+inttostr(cmbSoftList.Items.Count);

  end
  else
  begin
    cmbSoftList.Items.Clear;
    cmbSoftList.Enabled:=false;
    searchBox1.Enabled:=false;
    lastZip:='';
    frmSoftwareList.Caption:='ソフトウェアリスト';
    StatusBar1.Panels[0].Text:='';
    StatusBar1.Panels[1].Text:='';
    StatusBar1.Panels[2].Text:='';

  end;


  // 描画更新
  if ((lastListCount<>0) and (cmbSoftlist.items.Count = 0)) or (needUpdate) or (forceUpdate) then
  begin
    updateListView;
  end;

end;

procedure TfrmSoftwareList.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := false;
  UpdateListView;
end;

procedure TfrmSoftwareList.chkAlwaysOnTopClick(Sender: TObject);
begin
  if chkAlwaysOnTop.Checked then
    self.FormStyle:=fsStayOnTop
  else
    self.FormStyle:=fsNormal;
end;

// リストビューの更新
procedure TfrmSoftwareList.updateListView;
var i: integer;
    st: string;
    idx: integer;
begin

  if (cmbSoftlist.items.Count=0) then
  begin
    selectedSoftName := '';
    currentSoftlistName :='';
    currentSoftlistIndex := -1;

    ListView1.Items.BeginUpdate;
    ListView1.Items.Count:=0;
    ListView1.Enabled := false;
    ListView1.Refresh;
    ListView1.Items.EndUpdate;
    SearchBox1.Enabled := false;
    DoNotUpdateListView := true;
    //SearchBox1.Text := '';
    DoNotUpdateListView := false;

    StatusBar1.Panels[0].Text:= '';
    exit;
  end;

  currentSoftlistName := softMaster[lastZip][cmbSoftlist.ItemIndex]; // 選択中のソフトリスト名

  // ソフトリスト選択ヒストリー
  idx := softlistHistory.IndexOf(currentSoftlistName); // すでに登録があれば削除して先頭に追加
  if (idx<>-1) then
  begin
    softlistHistory.Delete(idx);
  end;
  softlistHistory.Insert(0, currentSoftlistName);
  // 最大数超えてたら削る
  if softlistHistory.Count>MAXSOFTLISTHISTORY then
    softlistHistory.Delete(MAXSOFTLISTHISTORY);


  if (updateSoftItems(currentSoftlistName, 0, true, SearchBox1.Text) = 0) then
  begin
    // 表示するものが0件
    ListView1.Items.BeginUpdate;
    ListView1.Items.Count:=0;
    ListView1.Enabled := true;
    ListView1.Refresh;
    ListView1.Items.EndUpdate;
    StatusBar1.Panels[0].Text:=inttostr(SubList.Count) + ' / ' + inttostr(PSoftlist2(softlistData2[currentSoftListIndex]).softwares.Count);
    StatusBar1.Panels[1].Text:= '';
    StatusBar1.Panels[2].Text:= '';
    searchbox1.enabled := true;
    exit;
  end;

  ListView1.Items.BeginUpdate;
  ListView1.items.Count := SubList.Count;
  ListView1.Enabled := true;
  SearchBox1.Enabled := true;

  // 選択項目復旧
  st := PSoftList2(softListData2[currentSoftlistIndex]).lastSelect;

  if (st<>'') then // 選択履歴がある
  begin
    for i := 0 to SubList.Count-1 do
    begin
      if PSoftware(SubList[i]).name = st then
      begin
        ListView1.ItemIndex := i;
        ListView1.Selected.MakeVisible(True);
        ListView1.Selected.Focused:=True;
        ListView1.Items.EndUpdate;
        exit;
      end;
    end;

  end;

  ListView1.ItemIndex := 0;
  ListView1.Items[0].MakeVisible(True);
  ListView1.Selected.Focused:=True;
  ListView1.Items.EndUpdate;
  ListView1SelectItem(nil, ListView1.ItemFocused, true);

end;

procedure TfrmSoftwareList.saveIni;
var
  sl: TStringList;
  i: integer;
begin

  if Assigned(softlistData2) then
  begin

    try
      sl := TStringList.Create;
      for i := 0 to softlistData2.Count-1 do
      begin
        sl.Add(PSoftlist2(softlistData2[i]).name+#9+PSoftlist2(softlistData2[i]).lastSelect);
      end;


      if (DirectoryExists(ExeDir + SL_DIR)) then
        sl.SaveToFile( ExeDir + SL_DIR + SL_INI, TEncoding.UTF8);

    finally
      sl.Free;
    end;

  end;

end;


//------------------------------------------------------------------------------
// カラム矢印設定
procedure TfrmSoftwareList.edtSearchKeyPress(Sender: TObject; var Key: Char);
begin
         {
  if Key=#13 then
  begin
    Key:=#0;
    ListView1.SetFocus;
  end;
          }
end;


procedure TfrmSoftwareList.SearchBox1Change(Sender: TObject);
begin
  if DoNotUpdateListView then exit;
  Timer1.Enabled := true;
end;

// DELキーの入力が取られるので対策
procedure TfrmSoftwareList.SearchBox1Enter(Sender: TObject);
begin
  Form1.actDelAllCfg.Enabled:=false;
end;

procedure TfrmSoftwareList.SearchBox1Exit(Sender: TObject);
begin
  Form1.actDelAllCfg.Enabled:=true;
end;

procedure TfrmSoftwareList.SearchBox1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then
  begin
    Key:=#0;
    if ListView1.Enabled then
      ListView1.SetFocus;
  end;
end;

procedure TfrmSoftwareList.SetListViewColumnSortMark(ColumnIndex: Integer);
var i: Integer;
  hColumn: THandle;
  hi: THDItem;
  IsAsc: boolean;
  LV: TListView;
begin

  LV:=ListView1;

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

end.
