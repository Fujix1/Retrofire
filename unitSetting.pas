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
    { Private �錾 }

    MameExeTemp : TList; // �ꎞ�p
    Updating : boolean;  // �O������X�V��

    Dragging: Boolean;
    OldIndex: Integer;
    TempStr: string;
    Save_Cursor : TCursor;

    samplePathTemp  : string;  // sample��Temp�p�X
    cfgDirTemp      : string;  // cfg��Temp�p�X
    nvramDirTemp    : string;  // nvram��Temp�p�X
    staDirTemp      : string;  // sta��Temp�p�X
    snapDirTemp     : string;  // snap��Temp�p�X
    inpDirTemp      : string;  // inp��Temp�p�X
    datDirTemp      : string;  // dat��Temp�p�X
    langDirTemp     : string;  // lang�̈ꎞ�p�X
    versionDirTemp  : string;  // version.ini�̈ꎞ�p�X

    ROMDirsTemp     : array of string; // roms�̈ꎞ�p�X
    SoftDirsTemp    : array of string; // soft�̈ꎞ�p�X
    
    procedure ToggleEditor(Flag: boolean);
    procedure ListBoxSelect;
    procedure CheckUDButtons;

  public
    { Public �錾 }
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

  // exe���X�g��Temp���X�g�Ɉړ�
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

  // ��̏ꍇ
  ToggleEditor(ListBox1.Items.Count<>0);

  // �\������̂�I�𒆂̃v���t�@�C���ɑ�����
  if CurrentProfile<>-1 then
  begin
    ListBox1.Selected[CurrentProfile]:=True;
    ListBox1.OnClick(nil);
  end;

  // Src�p�X
//  Edit6.Text:=SrcDir;

  // Temp�p�X�Ɉړ�

  SetLength(ROMDirsTemp,Length(ROMDirs));
  for i:=0 to Length(ROMDirs)-1 do
    ROMDirsTemp[i]:=ROMDirs[i];

  SetLength(SoftDirsTemp,Length(SoftDirs));
  for i:=0 to Length(SoftDirs)-1 do
    SoftDirsTemp[i]:=SoftDirs[i];

  samplePathTemp := samplePath; // sample��Temp�p�X
  cfgDirTemp     := cfgDir;     // cfg��Temp�p�X
  nvramDirTemp   := nvramDir;   // nvram��Temp�p�X
  staDirTemp     := staDir;     // sta��Temp�p�X
  snapDirTemp    := snapDir;    // snap��Temp�p�X
  inpDirTemp     := inpDir;     // inp��Temp�p�X
  datDirTemp     := datDir;     // dat��Temp�p�X
  langDirTemp    := langDir;    // lang��Temp�p�X
  versionDirTemp := versionDir; // version.ini��Temp�p�X

  ComboBox1.ItemIndex:=0;
  ComboBox1Change(nil);
end;


procedure TfrmSetting.FormClose(Sender: TObject; var Action: TCloseAction);
var i:integer;
begin
    // TList�̊e���ڂ̃��������
  for i:= 0 to MameExeTemp.count-1 do
    dispose(PMameExe(MameExeTemp[i]));

  MameExeTemp.Free;

end;


//------------------------------------------------------------------------------
// �ǉ�
procedure TfrmSetting.btnAddClick(Sender: TObject);
var i,j:integer;
  st: string;
  flag: boolean;
  NewItem : PMameExe;

begin

  if OpenDialog1.Execute then
  begin

    // �V�K�̖��O
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

    // �ꌏ�ڂ̂Ƃ�
    if ListBox1.Items.Count=0 then
    begin
      MameExeTemp.Add(NewItem);
      ListBox1.Items.Add(St);
      ToggleEditor(True);
      ListBox1.Selected[ListBox1.Items.Count-1]:=True;
    end
    else  // �񌏖ڂ���̂Ƃ�
    begin
      // �J�[�\���ʒu�ɑ}��
      //MameExeTemp.Insert(ListBox1.ItemIndex, NewItem);
      //ListBox1.Items.Insert(ListBox1.ItemIndex, St);
      //ListBox1.Selected[ListBox1.ItemIndex-1]:=True;

      // �Ō�ɒǉ�
      MameExeTemp.Add(NewItem);
      ListBox1.Items.Add(St);
      ListBox1.Selected[ListBox1.Items.Count-1]:=True;
    end;


    ListBox1.OnClick(nil);
    CheckUDButtons;
    Edit1.SetFocus;


  end;

end;

// �{�̑I��
procedure TfrmSetting.Button2Click(Sender: TObject);
begin

  // �t�@�C���̂���f�B���N�g���ɍ��킹��
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

    // �h���b�O��
    if Dragging then
    begin
      // �h���b�O���̍s��I��F�ɂ���
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

      // �I���s
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
    // �h���b�O�\�Ȉʒu�ɂ���ꍇ
    // �h���b�O���ƕʂ�Index�Ȃ��
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
    // �h���b�O�\�Ȉʒu�ɂ���ꍇ
    // �h���b�O�O�ƕʂ�Index�Ȃ��
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
  // �h���b�O���͏������Ȃ�
  // OnMouseDown -> OnClick -> OnMouseUP�̏�
  if Dragging=False then
    ListBoxSelect;

  CheckUDButtons;  
end;

//------------------------------------------------------------------------------
// �폜
procedure TfrmSetting.btnDeleteClick(Sender: TObject);
begin

  if IDYES=MessageBox(frmSetting.Handle,
             PChar('�u'+Edit1.Text+'�v���폜���܂���?   '),
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

// �X�V
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

  // Src�p�X
//  SrcDir:=Edit6.Text;

  /// history��mameinfo��comman.dat�̓ǂݒ���
  update_dat:=(datDir<>datDirTemp) or (langDir<>langDirTemp);
  
  // Temp�p�X����ړ�
  SetLength(ROMDirs,Length(ROMDirsTemp));
  for i:=0 to Length(ROMDirs)-1 do
    ROMDirs[i]:=ROMDirsTemp[i];

  SetLength(SoftDirs,Length(SoftDirsTemp));
  for i:=0 to Length(SoftDirs)-1 do
    SoftDirs[i]:=SoftDirsTemp[i];

  samplePath := samplePathTemp; // sample��Temp�p�X
  cfgDir     := cfgDirTemp;     // cfg��Temp�p�X
  nvramDir   := nvramDirTemp;   // nvram��Temp�p�X
  staDir     := staDirTemp;     // sta��Temp�p�X
  snapDir    := snapDirTemp;    // snap��Temp�p�X
  inpDir     := inpDirTemp;     // inp��Temp�p�X
  datDir     := datDirTemp;     // dat��Temp�p�X
  langDir    := langDirTemp;    // lang��Temp�p�X
  versionDir := versionDirTemp; // version.ini��Temp�p�X

  /// ���X�g�r���[�X�V
  if update_dat then
  begin
    ReadHistoryDat;
    ReadMameInfoDat;
    if ReadMame32jlst=False then
      Form1.ReadLang;

    frmCommand.LoadCommandDat( datDir ); // �R�}���h�ǂݒ���

  end;

  Form1.UpdateListView;
  // snap��history��
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
  SelectFolder :string;//�t�H���_�̃p�X���i�[����ϐ�

begin

  SelectFolder :=ExpandFileName(Edit6.Text);
  if FileCtrl.SelectDirectory('src�t�H���_��I��', '', SelectFolder ) then
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
// ROM / Software�t�H���_
procedure TfrmSetting.btnAddDirClick(Sender: TObject);
var
  SelectFolder :string;//�t�H���_�̃p�X���i�[����ϐ�

  St: string;

begin

  SetCurrentDir(ExeDir);

  SelectFolder:=ExeDir;

  if ComboBox1.ItemIndex = 0 then begin
    St:='�ǉ�����ROM�t�H���_��I��';
  end
  else if ComboBox1.ItemIndex = 1 then begin
    St:='�ǉ�����Software�t�H���_��I��';
  end;

  if FileCtrl.SelectDirectory( St, '', SelectFolder ) then
  begin

    if ComboBox1.ItemIndex = 0 then begin    // ROM�̂Ƃ�
      SetLength(RomDirsTemp,Length(RomDirsTemp)+1);
      RomDirsTemp[Length(RomDirsTemp)-1]:=SelectFolder;
    end
    else if ComboBox1.ItemIndex = 1 then begin // Software�̂Ƃ�
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
             PChar('�ȉ��̃f�B���N�g���ݒ���폜���܂���?   '+CRLF2+
                       ListView1.Items[ListView1.ItemIndex].Caption+'  '),
             APPNAME, MB_YESNO or MB_ICONQUESTION) then
  begin


    if ComboBox1.ItemIndex = 0 then begin    // ROM�̂Ƃ�
      n:= Length(RomDirsTemp);
      if n > 0 then
      begin
        for i:= ListView1.ItemIndex to n - 2 do RomDirsTemp[i]:= RomDirsTemp[i+1];
        SetLength(RomDirsTemp, n-1);
        ComboBox1Change(nil);
      end;
    end
    else if ComboBox1.ItemIndex = 1 then begin // Software�̂Ƃ�
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
  SelectFolder :string;//�t�H���_�̃p�X���i�[����ϐ�

begin

  SelectFolder :=Edit3.Text;
  if FileCtrl.SelectDirectory('��ƃt�H���_��I��', '', SelectFolder ) then
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

  // �R�s�[�̖��O
  flag:=False;
  St:=Format('%s�̃R�s�[',[Edit1.Text]);

  for i:=1 to 99 do
  begin

    for j:=0 to MameExeTemp.Count-1 do
    begin

      if PMameExe(MameExeTemp[j]).Title=St then
      begin
        flag:=true; // �}�b�`�L�� 
        break;
      end;

    end;

    if flag=true then
    begin
      St:=Format('%s�̃R�s�[_%.2d',[Edit1.Text,i]);
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

    0: // ROM�t�@�C��
    begin
      for i:=0 to Length(ROMDirsTemp)-1 do
        ListView1.Items.Add.Caption:=ROMDirsTemp[i];
    end;

    1: // Soft�t�@�C��
    begin
      for i:=0 to Length(SoftDirsTemp)-1 do
        ListView1.Items.Add.Caption:=SoftDirsTemp[i];
    end;

    2: ListView1.Items.Add.Caption:=samplePathTemp; // �T���v��
    3: ListView1.Items.Add.Caption:=cfgDirTemp;     // cfg�t�@�C��
    4: ListView1.Items.Add.Caption:=nvramDirTemp;   // nvram�t�@�C��
    5: ListView1.Items.Add.Caption:=staDirTemp;     // sta�t�@�C��
    6: ListView1.Items.Add.Caption:=snapDirTemp;    // �X�i�b�v�V���b�g
    7: ListView1.Items.Add.Caption:=inpDirTemp;     // inp�t�@�C��
    8: ListView1.Items.Add.Caption:=datDirTemp;     // dat�t�@�C��
    9: ListView1.Items.Add.Caption:=langDirTemp;    // lang�t�H���_
    10: ListView1.Items.Add.Caption:=versionDirTemp; // folders�t�H���_
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
             PChar('�f�B���N�g��������܂���B�����܂���?   '),
             APPNAME, MB_YESNO or MB_ICONQUESTION) then
      flag:=False;
  end;
  
  // �󕶎���A�f�B���N�g���������ꍇ
  if (S='') or flag then
  begin
  
    case ComboBox1.ItemIndex of
      0: S:=RomDirsTemp[ListView1.ItemIndex];
      1: S:=SoftDirsTemp[ListView1.ItemIndex];
      2: S:=samplePathTemp; // �T���v��
      3: S:=cfgDirTemp;     // cfg�t�@�C��
      4: S:=nvramDirTemp;   // nvram�t�@�C��
      5: S:=staDirTemp;     // sta�t�@�C��
      6: S:=snapDirTemp;    // �X�i�b�v�V���b�g
      7: S:=inpDirTemp;     // inp�t�@�C��
      8: S:=datDirTemp;     // dat�t�@�C��
      9: S:=langDirTemp;    // lang�t�H���_
      10: S:=versionDirTemp; // version.ini�̃f�B���N�g��
    end;

  end
  else // �󕶎�����Ȃ��ꍇ
  begin

    case ComboBox1.ItemIndex of
      0: RomDirsTemp[ListView1.ItemIndex]:=S;
      1: SoftDirsTemp[ListView1.ItemIndex]:=S;
      2: samplePathTemp:=S; // �T���v��
      3: cfgDirTemp:=S;     // cfg�t�@�C��
      4: nvramDirTemp:=S;   // nvram�t�@�C��
      5: staDirTemp:=S;     // sta�t�@�C��
      6: snapDirTemp:=S;    // �X�i�b�v�V���b�g
      7: inpDirTemp:=S;     // inp�t�@�C��
      8: datDirTemp:=S;     // dat�t�@�C��
      9: langDirTemp:=S;    // lang�t�H���_
      10: versionDirTemp:=S  // version.ini�̃f�B���N�g��
    end;

  end;

end;

procedure TfrmSetting.Button1Click(Sender: TObject);
var
  SelectFolder :string;//�t�H���_�̃p�X���i�[����ϐ�
  selTitle: string; //
begin

  if ListView1.ItemIndex<>-1 then
  begin
    selTitle:='�t�H���_��I�� ('+ComboBox1.Text+')';

    if SysUtils.DirectoryExists(ListView1.Items[ListView1.ItemIndex].Caption) then
      SelectFolder:=ListView1.Items[ListView1.ItemIndex].Caption
    else
      SelectFolder:=ExeDir;


    if FileCtrl.SelectDirectory(selTitle, '', SelectFolder ) then
    begin
      ListView1.Items[ListView1.ItemIndex].Caption:=SelectFolder;

      // Temp�p�X�ɑ��
      case ComboBox1.ItemIndex of
        0: RomDirsTemp[ListView1.ItemIndex]   :=SelectFolder;
        1: SoftDirsTemp[ListView1.ItemIndex]  := SelectFolder; // �\�t�g���X�g�t�@�C��
        2: samplePathTemp   := SelectFolder; // �T���v��
        3: cfgDirTemp       := SelectFolder; // cfg�t�@�C��
        4: nvramDirTemp     := SelectFolder; // nvram�t�@�C��
        5: staDirTemp       := SelectFolder; // sta�t�@�C��
        6: snapDirTemp      := SelectFolder; // �X�i�b�v�V���b�g
        7: inpDirTemp       := SelectFolder; // inp�t�@�C��
        8: datDirTemp       := SelectFolder; // dat�t�@�C��
        9: langDirTemp      := SelectFolder; // lang�t�H���_
        10: versionDirTemp   := SelectFolder; // version.ini�t�H���_
      end;

    end;
  end;
  
end;



end.
