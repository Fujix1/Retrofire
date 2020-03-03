unit unitSetting;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Common, Grids, ValEdit, ComCtrls,
  Filectrl, System.Types, unitCommandViewer;

type
  TfrmSetting = class(TForm)

    PageControl1: TPageControl;
    btnCancel: TBitBtn;
    BitBtn2:    TBitBtn;
    BitBtn3:    TBitBtn;
    btnOK: TBitBtn;
    TabSheet1:  TTabSheet;
    TabSheet2:  TTabSheet;
    btnAdd:     TButton;
    btnDelete:  TButton;
    btnCopy:    TButton;
    Button2:    TButton;
    Button8:    TButton;
    GroupBox1:  TGroupBox;
    Label2:     TLabel;
    Label3:     TLabel;
    Label5:     TLabel;
    Label4:     TLabel;
    Edit1:      TEdit;
    Edit2:      TEdit;
    Edit3:      TEdit;
    Edit4:      TEdit;

    ListBox1:   TListBox;
    OpenDialog1:    TOpenDialog;
    GroupBox6: TGroupBox;
    ListView1: TListView;
    ComboBox1: TComboBox;
    btnAddDir: TButton;
    btnDelDir: TButton;
    Button1: TButton;
    CheckBox1: TCheckBox;

    procedure FormShow(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
    procedure ListBox1DrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure ListBox1MeasureItem(Control: TWinControl; Index: Integer;
      var Height: Integer);
    procedure ListBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ListBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ListBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ListBox1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure btnAddDirClick(Sender: TObject);
    procedure btnDelDirClick(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure btnCopyClick(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ListView1Edited(Sender: TObject; Item: TListItem;
      var S: String);
    procedure Button1Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
 
  private
    { Private 宣言 }

    MameExeTemp : TList; // 一時用
    Updating : boolean;  // 外部から更新中

    Dragging: Boolean;
    OldIndex: Integer;
    TempStr: string;
    Save_Cursor : TCursor;

    samplePathTemp  : string;  // sampleのTempパス
    cfgDirTemp      : string;  // cfgのTempパス
    nvramDirTemp    : string;  // nvramのTempパス
    staDirTemp      : string;  // staのTempパス
    snapDirTemp     : string;  // snapのTempパス
    inpDirTemp      : string;  // inpのTempパス
    datDirTemp      : string;  // datのTempパス
    langDirTemp     : string;  // langの一時パス
    versionDirTemp  : string;  // version.iniの一時パス

    ROMDirsTemp     : array of string; // romsの一時パス
    SoftDirsTemp    : array of string; // softの一時パス
    
    procedure ToggleEditor(Flag: boolean);
    procedure ListBoxSelect;
    procedure CheckUDButtons;

  public
    { Public 宣言 }
  end;


var
  frmSetting: TfrmSetting;

implementation

uses Unit1;


{$R *.dfm}

procedure TfrmSetting.ToggleEditor(Flag: boolean);
begin

  GroupBox1.Enabled:=Flag;
  //btnAdd.Enabled:=Flag;
  btnDelete.Enabled:=Flag;
  btnCopy.Enabled:=Flag;
  CheckBox1.Enabled:=Flag;
  BitBtn2.Enabled:=Flag;
  BitBtn3.Enabled:=Flag;

  if Flag then
  begin
    Edit1.Color:=clWindow;
    Edit2.Color:=clWindow;
    Edit3.Color:=clWindow;
    Edit4.Color:=clWindow;
  end
  else
  begin
    Edit1.Color:=clBtnFace;
    Edit2.Color:=clBtnFace;
    Edit3.Color:=clBtnFace;
    Edit4.Color:=clBtnFace;
    Updating:=True;
    Edit1.Text:='';
    Edit2.Text:='';
    Edit3.Text:='';
    Edit4.Text:='';
    Updating:=False;
  end;

end;

procedure TfrmSetting.FormShow(Sender: TObject);
var i:integer;
    NewItem : PMameExe;
begin

  MameExeTemp:=TList.Create;
  ListBox1.Items.Clear;

  // exeリストをTempリストに移動
  for i:=0 to Length(MameExe)-1 do
  begin

    New(NewItem);
    NewItem.Title    := MameExe[i].Title;
    NewItem.ExePath  := MameExe[i].ExePath;
    NewItem.WorkDir  := MameExe[i].WorkDir;
    NewItem.Option   := MameExe[i].Option;
    NewItem.OptEnbld := MameExe[i].OptEnbld;
    ListBox1.Items.Add(NewItem.Title);
    MameExeTemp.Add(NewItem);

  end;

  // 空の場合
  ToggleEditor(ListBox1.Items.Count<>0);

  // 表示するのを選択中のプロファイルに揃える
  if CurrentProfile<>-1 then
  begin
    ListBox1.Selected[CurrentProfile]:=True;
    ListBox1.OnClick(nil);
  end;

  // Srcパス
//  Edit6.Text:=SrcDir;

  // Tempパスに移動

  SetLength(ROMDirsTemp,Length(ROMDirs));
  for i:=0 to Length(ROMDirs)-1 do
    ROMDirsTemp[i]:=ROMDirs[i];

  SetLength(SoftDirsTemp,Length(SoftDirs));
  for i:=0 to Length(SoftDirs)-1 do
    SoftDirsTemp[i]:=SoftDirs[i];

  samplePathTemp := samplePath; // sampleのTempパス
  cfgDirTemp     := cfgDir;     // cfgのTempパス
  nvramDirTemp   := nvramDir;   // nvramのTempパス
  staDirTemp     := staDir;     // staのTempパス
  snapDirTemp    := snapDir;    // snapのTempパス
  inpDirTemp     := inpDir;     // inpのTempパス
  datDirTemp     := datDir;     // datのTempパス
  langDirTemp    := langDir;    // langのTempパス
  versionDirTemp := versionDir; // version.iniのTempパス

  ComboBox1.ItemIndex:=0;
  ComboBox1Change(nil);
end;


procedure TfrmSetting.FormClose(Sender: TObject; var Action: TCloseAction);
var i:integer;
begin
    // TListの各項目のメモリ解放
  for i:= 0 to MameExeTemp.count-1 do
    dispose(PMameExe(MameExeTemp[i]));

  MameExeTemp.Free;

end;


//------------------------------------------------------------------------------
// 追加
procedure TfrmSetting.btnAddClick(Sender: TObject);
var i,j:integer;
  st: string;
  flag: boolean;
  NewItem : PMameExe;

begin

  if OpenDialog1.Execute then
  begin

    // 新規の名前
    flag:=False;
    for i:=1 to 99 do
    begin

      St:=Format('mame_%.2d',[i]);

      if MameExeTemp<>nil then
      begin
        for j:=0 to MameExeTemp.Count-1 do
        begin

          if PMameExe(MameExeTemp[j]).Title=St then
          begin
            flag:=True;
            break;
          end;

        end;

        if flag then
          flag:=false
        else
          break;

      end
      else
        break;
    end;

    New(NewItem);

    NewItem.Title   :=St;
    NewItem.ExePath :=OpenDialog1.FileName;
    NewItem.WorkDir :=ExtractFilePath(OpenDialog1.FileName);
    NewItem.Option  :='';
    NewItem.OptEnbld:=True;

    // 一件目のとき
    if ListBox1.Items.Count=0 then
    begin
      MameExeTemp.Add(NewItem);
      ListBox1.Items.Add(St);
      ToggleEditor(True);
      ListBox1.Selected[ListBox1.Items.Count-1]:=True;
    end
    else  // 二件目からのとき
    begin
      // カーソル位置に挿入
      //MameExeTemp.Insert(ListBox1.ItemIndex, NewItem);
      //ListBox1.Items.Insert(ListBox1.ItemIndex, St);
      //ListBox1.Selected[ListBox1.ItemIndex-1]:=True;

      // 最後に追加
      MameExeTemp.Add(NewItem);
      ListBox1.Items.Add(St);
      ListBox1.Selected[ListBox1.Items.Count-1]:=True;
    end;


    ListBox1.OnClick(nil);
    CheckUDButtons;
    Edit1.SetFocus;


  end;

end;

// 本体選択
procedure TfrmSetting.Button2Click(Sender: TObject);
begin

  // ファイルのあるディレクトリに合わせる
  if FileExists(Edit2.Text) then
    OpenDialog1.InitialDir:=ExtractFilePath(Edit2.Text);

  if OpenDialog1.Execute then
  begin
    Edit2.Text:=OpenDialog1.FileName;
    Edit3.Text:=ExtractFilePath(OpenDialog1.FileName);
  end;

end;

//------------------------------------------------------------------------------
procedure TfrmSetting.Edit1Change(Sender: TObject);
begin

  if Updating then Exit;

  PMameExe(MameExeTemp[ListBox1.ItemIndex]).Title:=Edit1.Text;
  ListBox1.Items[ListBox1.ItemIndex]:=Edit1.Text;

end;

procedure TfrmSetting.Edit2Change(Sender: TObject);
begin

  if Updating then Exit;

  PMameExe(MameExeTemp[ListBox1.ItemIndex]).ExePath:=Edit2.Text;
  
end;

procedure TfrmSetting.Edit3Change(Sender: TObject);
begin

  if Updating then Exit;

  PMameExe(MameExeTemp[ListBox1.ItemIndex]).WorkDir:=Edit3.Text;

end;

procedure TfrmSetting.Edit4Change(Sender: TObject);
begin
  if Updating then Exit;

  PMameExe(MameExeTemp[ListBox1.ItemIndex]).Option:=Edit4.Text;
  
end;

procedure TfrmSetting.CheckBox1Click(Sender: TObject);
begin
  if Updating then Exit;

  PMameExe(MameExeTemp[ListBox1.ItemIndex]).OptEnbld:=CheckBox1.Checked;

end;

//------------------------------------------------------------------------------
procedure TfrmSetting.ListBox1DrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
var
  St  :String;
  Rct :TRect;
  uFormat : Integer;

begin

  uFormat:= DT_LEFT or DT_SINGLELINE or DT_NOPREFIX or DT_VCENTER;

  with (Control as TListBox).Canvas do
  begin

    // ドラッグ中
    if Dragging then
    begin
      // ドラッグ元の行を選択色にする
      if OldIndex=Index then
      begin
        Brush.Color:=clHighLight;
        Font.Color:=clHighLightText;
      end
      else
      begin
        Brush.Color:=clBtnHighlight;
        Font.Color:=clWindowText;
      end;
    end
    else
    begin

      // 選択行
      if (odSelected in State) and (odFocused in State) then
      begin
        Brush.Color:=clHighLight;
        Font.Color:=clHighLightText;
      end
      else
      if (odSelected in State) then
      begin
        Brush.Color:=clMenu;
        Font.Color:=clWindowText;
      end

    end;

    FillRect(Rect);
    Rct:=Rect;
    Inc(Rct.Left,2);
    ST:=ListBox1.Items[Index];
    DrawText(Handle, PChar(ST), Length(ST), Rct, uFormat);
  end;

end;

procedure TfrmSetting.ListBox1MeasureItem(Control: TWinControl; Index: Integer;
  var Height: Integer);
begin
  Height := (abs(TListBox(Control).Font.Height)) + 1;
end;

procedure TfrmSetting.ListBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var 
  Index: integer;
begin

  Index := ListBox1.ItemAtPos(point(x, y), true);
  if Index > -1 then
  begin
    Updating:=True;
    Edit1.Text:=PMameExe(MameExeTemp[Index]).Title;
    Edit2.Text:=PMameExe(MameExeTemp[Index]).ExePath;
    Edit3.Text:=PMameExe(MameExeTemp[Index]).WorkDir;
    Edit4.Text:=PMameExe(MameExeTemp[Index]).Option;
    CheckBox1.Checked:=PMameExe(MameExeTemp[Index]).OptEnbld;
    Updating:=False;

    Save_Cursor := Screen.Cursor;
    Screen.Cursor := crNoDrop;    // Show Dragging Cursor
    TempStr := ListBox1.Items[Index];
    OldIndex := Index;
    Dragging := true;
    CheckUDButtons;
  end;

end;

procedure TfrmSetting.ListBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var Index: integer;
begin

  if Dragging then
  begin
    Index := ListBox1.ItemAtPos(point(x, y), true);
    if (Index > -1) and (OldIndex<>Index) then
    // ドラッグ可能な位置にある場合
    // ドラッグ元と別なIndexならば
      Screen.Cursor := crDrag
    else
      Screen.Cursor := crNoDrop;
  end;
    
end;

procedure TfrmSetting.ListBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var Index: integer;
begin

  if Dragging then
  begin
    Index := ListBox1.ItemAtPos(point(x, y), true);
    if (Index > -1) and (OldIndex<>Index) then
    // ドラッグ可能な位置にある場合
    // ドラッグ前と別なIndexならば
    begin

      MameExeTemp.Move(OldIndex,Index);

      ListBox1.Items.Delete(OldIndex);
      ListBox1.Items.Insert(Index, TempStr);
      ListBox1.ItemIndex := Index;
      OldIndex:=Index;
            
    end;
    Screen.Cursor := Save_Cursor;  // Always restore to normal
  end;
  Dragging := false;
  CheckUDButtons;
  
end;


procedure TfrmSetting.ListBoxSelect;
var idx:Integer;
begin

  idx:=ListBox1.ItemIndex;
  Updating:=True;
  Edit1.Text:=PMameExe(MameExeTemp[idx]).Title;
  Edit2.Text:=PMameExe(MameExeTemp[idx]).ExePath;
  Edit3.Text:=PMameExe(MameExeTemp[idx]).WorkDir;
  Edit4.Text:=PMameExe(MameExeTemp[idx]).Option;
  CheckBox1.Checked:=PMameExe(MameExeTemp[idx]).OptEnbld;
  Updating:=False;

end;

//------------------------------------------------------------------------------
procedure TfrmSetting.ListBox1Click(Sender: TObject);
begin
  // ドラッグ中は処理しない
  // OnMouseDown -> OnClick -> OnMouseUPの順
  if Dragging=False then
    ListBoxSelect;

  CheckUDButtons;  
end;

//------------------------------------------------------------------------------
// 削除
procedure TfrmSetting.btnDeleteClick(Sender: TObject);
begin

  if IDYES=MessageBox(frmSetting.Handle,
             PChar('「'+Edit1.Text+'」を削除しますか?   '),
             APPNAME, MB_YESNO or MB_ICONQUESTION) then
  begin

    dispose(PMameExe(MameExeTemp[ListBox1.ItemIndex]));
    MameExeTemp.Delete(ListBox1.ItemIndex);
    ListBox1.Items.Delete(ListBox1.ItemIndex);

    if ListBox1.Items.Count=0 then
    begin
      btnDelete.Enabled:=False;
      btnCopy.Enabled:=False;
      ToggleEditor(False);
    end
    else
    begin
      ListBox1.Selected[0]:=True;
      ListBox1.OnClick(nil);
      Edit1.SetFocus;
    end;

  end;
  
  CheckUDButtons;
  
end;

// 更新
procedure TfrmSetting.btnOKClick(Sender: TObject);
var i:Integer;
    update_dat:boolean;
begin

  Form1.ComboBox1.Items.Clear;

  SetLength(MameExe,MameExeTemp.Count);
  for i:=0 to MameExeTemp.Count-1 do
  begin
    MameExe[i].Title  := PMameExe(MameExeTemp[i]).Title;
    MameExe[i].ExePath:= PMameExe(MameExeTemp[i]).ExePath;
    MameExe[i].WorkDir:= PMameExe(MameExeTemp[i]).WorkDir;
    MameExe[i].Option := PMameExe(MameExeTemp[i]).Option;
    MameExe[i].OptEnbld := PMameExe(MameExeTemp[i]).OptEnbld;
    Form1.ComboBox1.Items.Add(PMameExe(MameExeTemp[i]).Title);
  end;

  if MameExeTemp.Count=0 then
  begin
    Form1.Caption:=APPNAME;
    CurrentProfile:=-1;
  end
  else
  begin
    Form1.ComboBox1.ItemIndex:=ListBox1.ItemIndex;
    Form1.ComboBox1.OnChange(nil);
  end;

  // Srcパス
//  SrcDir:=Edit6.Text;

  /// historyとmameinfoとcomman.datの読み直し
  update_dat:=(datDir<>datDirTemp) or (langDir<>langDirTemp);
  
  // Tempパスから移動
  SetLength(ROMDirs,Length(ROMDirsTemp));
  for i:=0 to Length(ROMDirs)-1 do
    ROMDirs[i]:=ROMDirsTemp[i];

  SetLength(SoftDirs,Length(SoftDirsTemp));
  for i:=0 to Length(SoftDirs)-1 do
    SoftDirs[i]:=SoftDirsTemp[i];

  samplePath := samplePathTemp; // sampleのTempパス
  cfgDir     := cfgDirTemp;     // cfgのTempパス
  nvramDir   := nvramDirTemp;   // nvramのTempパス
  staDir     := staDirTemp;     // staのTempパス
  snapDir    := snapDirTemp;    // snapのTempパス
  inpDir     := inpDirTemp;     // inpのTempパス
  datDir     := datDirTemp;     // datのTempパス
  langDir    := langDirTemp;    // langのTempパス
  versionDir := versionDirTemp; // version.iniのTempパス

  /// リストビュー更新
  if update_dat then
  begin
    ReadHistoryDat;
    ReadMameInfoDat;
    if ReadMame32jlst=False then
      Form1.ReadLang;

    frmCommand.LoadCommandDat( datDir ); // コマンド読み直し

  end;

  Form1.UpdateListView;
  // snapとhistoryも
  if Form1.ListView1.ItemIndex<>-1 then
    Form1.ListView1SelectItem(nil,Form1.ListView1.ItemFocused,True);

end;


//------------------------------------------------------------------------
procedure TfrmSetting.BitBtn2Click(Sender: TObject);
var
  Idx : Integer;
  St  : String;
begin

  with ListBox1 do
  begin

    if (ItemIndex=-1) or (ItemIndex=0) then exit;
    Idx := ItemIndex;
    St:=ListBox1.Items[Idx];
    ListBox1.Items.Delete(Idx);
    ListBox1.Items.Insert(Idx-1, St);

    MameExeTemp.Move(Idx,Idx-1);

    ItemIndex := Idx-1;
  end;
  CheckUDButtons;
  
end;

procedure TfrmSetting.BitBtn3Click(Sender: TObject);
var
  Idx : Integer;
  St  : String;
  
begin

  with ListBox1 do
  begin

    if (ItemIndex=-1) or (ItemIndex=Items.Count-1) then exit;
    Idx := ItemIndex;
    St:=ListBox1.Items[Idx];
    ListBox1.Items.Delete(Idx);
    ListBox1.Items.Insert(Idx+1, St);

    MameExeTemp.Move(Idx,Idx+1);

    ItemIndex := Idx+1;
  end;
  CheckUDButtons;
  
end;

{procedure TfrmSetting.Button5Click(Sender: TObject);
var
  SelectFolder :string;//フォルダのパスを格納する変数

begin

  SelectFolder :=ExpandFileName(Edit6.Text);
  if FileCtrl.SelectDirectory('srcフォルダを選択', '', SelectFolder ) then
  begin
    Edit6.Text:=SelectFolder;
  end;

end;
 }  {
procedure TfrmSetting.Edit6Exit(Sender: TObject);
begin

  if Edit6.Text='' then
    Edit6.Text:='src\';

end;
     }
procedure TfrmSetting.CheckUDButtons;
begin

  if ListBox1.Items.Count<=1 then
  begin
    BitBtn2.Enabled:=False;
    BitBtn3.Enabled:=False;
    exit;
  end;

  BitBtn2.Enabled:=ListBox1.ItemIndex<>0;
  BitBtn3.Enabled:=ListBox1.ItemIndex<>(ListBox1.Items.Count-1);


end;

// -----------------------------------------------------------------------------
// ROM / Softwareフォルダ
procedure TfrmSetting.btnAddDirClick(Sender: TObject);
var
  SelectFolder :string;//フォルダのパスを格納する変数

  St: string;

begin

  SetCurrentDir(ExeDir);

  SelectFolder:=ExeDir;

  if ComboBox1.ItemIndex = 0 then begin
    St:='追加するROMフォルダを選択';
  end
  else if ComboBox1.ItemIndex = 1 then begin
    St:='追加するSoftwareフォルダを選択';
  end;

  if FileCtrl.SelectDirectory( St, '', SelectFolder ) then
  begin

    if ComboBox1.ItemIndex = 0 then begin    // ROMのとき
      SetLength(RomDirsTemp,Length(RomDirsTemp)+1);
      RomDirsTemp[Length(RomDirsTemp)-1]:=SelectFolder;
    end
    else if ComboBox1.ItemIndex = 1 then begin // Softwareのとき
      SetLength(SoftDirsTemp,Length(SoftDirsTemp)+1);
      SoftDirsTemp[Length(SoftDirsTemp)-1]:=SelectFolder;
    end;

    ListView1.Items.Add.Caption:=SelectFolder;
    ListView1.Selected:=ListView1.Items[ListView1.Items.Count-1];
  end;

end;

procedure TfrmSetting.btnDelDirClick(Sender: TObject);
var i, n: Integer;
begin

  if ListView1.ItemIndex=-1 then exit;

  if IDYES=MessageBox(frmSetting.Handle,
             PChar('以下のディレクトリ設定を削除しますか?   '+CRLF2+
                       ListView1.Items[ListView1.ItemIndex].Caption+'  '),
             APPNAME, MB_YESNO or MB_ICONQUESTION) then
  begin


    if ComboBox1.ItemIndex = 0 then begin    // ROMのとき
      n:= Length(RomDirsTemp);
      if n > 0 then
      begin
        for i:= ListView1.ItemIndex to n - 2 do RomDirsTemp[i]:= RomDirsTemp[i+1];
        SetLength(RomDirsTemp, n-1);
        ComboBox1Change(nil);
      end;
    end
    else if ComboBox1.ItemIndex = 1 then begin // Softwareのとき
      n:= Length(SoftDirsTemp);
      if n > 0 then
      begin
        for i:= ListView1.ItemIndex to n - 2 do SoftDirsTemp[i]:= SoftDirsTemp[i+1];
        SetLength(SoftDirsTemp, n-1);
        ComboBox1Change(nil);
      end;
    end;



  end;
  
end;

procedure TfrmSetting.Button8Click(Sender: TObject);
var
  SelectFolder :string;//フォルダのパスを格納する変数

begin

  SelectFolder :=Edit3.Text;
  if FileCtrl.SelectDirectory('作業フォルダを選択', '', SelectFolder ) then
  begin
    Edit3.Text:=SelectFolder;
  end;

end;


procedure TfrmSetting.btnCopyClick(Sender: TObject);
var i,j:integer;
  st: string;
  flag: boolean;
  NewItem : PMameExe;

begin

  // コピーの名前
  flag:=False;
  St:=Format('%sのコピー',[Edit1.Text]);

  for i:=1 to 99 do
  begin

    for j:=0 to MameExeTemp.Count-1 do
    begin

      if PMameExe(MameExeTemp[j]).Title=St then
      begin
        flag:=true; // マッチ有り 
        break;
      end;

    end;

    if flag=true then
    begin
      St:=Format('%sのコピー_%.2d',[Edit1.Text,i]);
      flag:=false;
    end
    else
      break;
      
  end;

  New(NewItem);
  NewItem.Title   :=St;
  NewItem.ExePath :=PMameExe(MameExeTemp[ListBox1.ItemIndex]).ExePath;
  NewItem.WorkDir :=PMameExe(MameExeTemp[ListBox1.ItemIndex]).WorkDir;
  NewItem.Option  :=PMameExe(MameExeTemp[ListBox1.ItemIndex]).Option;
  NewItem.OptEnbld:=PMameExe(MameExeTemp[ListBox1.ItemIndex]).OptEnbld;

  MameExeTemp.Insert(ListBox1.ItemIndex+1, NewItem);


  ListBox1.Items.Insert(ListBox1.ItemIndex+1, St);
  ListBox1.Selected[ListBox1.ItemIndex+1]:=True;
  ListBox1.OnClick(nil);
  CheckUDButtons;
  Edit1.SetFocus;

end;

procedure TfrmSetting.ComboBox1Change(Sender: TObject);
var i:integer;
begin

  ListView1.Items.Clear;
  btnAddDir.Enabled:=(ComboBox1.ItemIndex=0) OR (ComboBox1.ItemIndex=1);
  btnDelDir.Enabled:=(ComboBox1.ItemIndex=0) OR (ComboBox1.ItemIndex=1);

  case ComboBox1.ItemIndex of

    0: // ROMファイル
    begin
      for i:=0 to Length(ROMDirsTemp)-1 do
        ListView1.Items.Add.Caption:=ROMDirsTemp[i];
    end;

    1: // Softファイル
    begin
      for i:=0 to Length(SoftDirsTemp)-1 do
        ListView1.Items.Add.Caption:=SoftDirsTemp[i];
    end;

    2: ListView1.Items.Add.Caption:=samplePathTemp; // サンプル
    3: ListView1.Items.Add.Caption:=cfgDirTemp;     // cfgファイル
    4: ListView1.Items.Add.Caption:=nvramDirTemp;   // nvramファイル
    5: ListView1.Items.Add.Caption:=staDirTemp;     // staファイル
    6: ListView1.Items.Add.Caption:=snapDirTemp;    // スナップショット
    7: ListView1.Items.Add.Caption:=inpDirTemp;     // inpファイル
    8: ListView1.Items.Add.Caption:=datDirTemp;     // datファイル
    9: ListView1.Items.Add.Caption:=langDirTemp;    // langフォルダ
    10: ListView1.Items.Add.Caption:=versionDirTemp; // foldersフォルダ
  end;

  ListView1.Selected:=ListView1.Items[0];

end;

procedure TfrmSetting.ListView1Edited(Sender: TObject; Item: TListItem;
  var S: String);
var flag:boolean;
begin
//  beep;

  flag:=False;
  if not SysUtils.DirectoryExists(S) then
  begin
    flag:=True;
    if IDYES=MessageBox(frmSetting.Handle,
             PChar('ディレクトリがありません。続けますか?   '),
             APPNAME, MB_YESNO or MB_ICONQUESTION) then
      flag:=False;
  end;
  
  // 空文字列、ディレクトリが無い場合
  if (S='') or flag then
  begin
  
    case ComboBox1.ItemIndex of
      0: S:=RomDirsTemp[ListView1.ItemIndex];
      1: S:=SoftDirsTemp[ListView1.ItemIndex];
      2: S:=samplePathTemp; // サンプル
      3: S:=cfgDirTemp;     // cfgファイル
      4: S:=nvramDirTemp;   // nvramファイル
      5: S:=staDirTemp;     // staファイル
      6: S:=snapDirTemp;    // スナップショット
      7: S:=inpDirTemp;     // inpファイル
      8: S:=datDirTemp;     // datファイル
      9: S:=langDirTemp;    // langフォルダ
      10: S:=versionDirTemp; // version.iniのディレクトリ
    end;

  end
  else // 空文字じゃない場合
  begin

    case ComboBox1.ItemIndex of
      0: RomDirsTemp[ListView1.ItemIndex]:=S;
      1: SoftDirsTemp[ListView1.ItemIndex]:=S;
      2: samplePathTemp:=S; // サンプル
      3: cfgDirTemp:=S;     // cfgファイル
      4: nvramDirTemp:=S;   // nvramファイル
      5: staDirTemp:=S;     // staファイル
      6: snapDirTemp:=S;    // スナップショット
      7: inpDirTemp:=S;     // inpファイル
      8: datDirTemp:=S;     // datファイル
      9: langDirTemp:=S;    // langフォルダ
      10: versionDirTemp:=S  // version.iniのディレクトリ
    end;

  end;

end;

procedure TfrmSetting.Button1Click(Sender: TObject);
var
  SelectFolder :string;//フォルダのパスを格納する変数
  selTitle: string; //
begin

  if ListView1.ItemIndex<>-1 then
  begin
    selTitle:='フォルダを選択 ('+ComboBox1.Text+')';

    if SysUtils.DirectoryExists(ListView1.Items[ListView1.ItemIndex].Caption) then
      SelectFolder:=ListView1.Items[ListView1.ItemIndex].Caption
    else
      SelectFolder:=ExeDir;


    if FileCtrl.SelectDirectory(selTitle, '', SelectFolder ) then
    begin
      ListView1.Items[ListView1.ItemIndex].Caption:=SelectFolder;

      // Tempパスに代入
      case ComboBox1.ItemIndex of
        0: RomDirsTemp[ListView1.ItemIndex]   :=SelectFolder;
        1: SoftDirsTemp[ListView1.ItemIndex]  := SelectFolder; // ソフトリストファイル
        2: samplePathTemp   := SelectFolder; // サンプル
        3: cfgDirTemp       := SelectFolder; // cfgファイル
        4: nvramDirTemp     := SelectFolder; // nvramファイル
        5: staDirTemp       := SelectFolder; // staファイル
        6: snapDirTemp      := SelectFolder; // スナップショット
        7: inpDirTemp       := SelectFolder; // inpファイル
        8: datDirTemp       := SelectFolder; // datファイル
        9: langDirTemp      := SelectFolder; // langフォルダ
        10: versionDirTemp   := SelectFolder; // version.iniフォルダ
      end;

    end;
  end;
  
end;



end.
