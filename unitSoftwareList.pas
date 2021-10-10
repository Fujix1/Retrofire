unit unitSoftwareList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, System.Generics.Collections,
  Vcl.WinXCtrls, Vcl.ComCtrls, Generics.Collections, Common, Diagnostics,CommCtrl;

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

  private
    { Private �錾 }

    var
      softlistAvailable: boolean; // �\�t�g���X�g�L��

      lastZip: string; // ���O�I������Ă���zip��
      lastMasterIndex: integer; // ���O�ɑI������Ă���zip�}�X�^�C���f�b�N�X

      currentSoftMasterIndex: integer;
      currentSoftlistName: string;

      currentSoftlistIndex: integer; //

      lang: string;
      selectedSoftName: string;

      SubList: TList;

    procedure updateListView;
    function updateSoftItems(const SLName:string; orderBy: integer; asc:boolean; searchWord: string): integer;

  public
    { Public �錾 }


    function init(const ExeDir:string): boolean;
    procedure setSoftlist(const zip:string; forceUpdate:boolean = false);
    procedure updateLang(newLang: string);
    procedure saveIni;
    procedure SetListViewColumnSortMark(ColumnIndex: Integer);

    var
      lastSoftlist: string; // �ŐV�̑I���\�t�g���X�g
      lastSoftware: string; // �ŐV�̑I���\�t�g�E�F�A
      columnSort: integer; //

      DoNotUpdateListView: boolean;

      softMaster: TObjectDictionary<string, TStringList>;


      softlistData2: TList;

  end;


var
  frmSoftwareList: TfrmSoftwareList;

// ��r����
function AscSort2(Item1, Item2: Pointer): Integer;

implementation

uses Unit1;

{$R *.dfm}

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


// ����������
// ������Ăяo�����̂Œ���
// return ����/���s
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

  // �ݒ蕜��
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


  // �\�t�g���X�g�S���Ǎ���
  try

    if Assigned(softlistData2) then
    begin

      saveIni;

      // �\�t�g���X�g�f�[�^���S�폜
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

      // �\�t�g���X�g�G���g��
      if (fields.Count = 3) then
      begin

        New(newItem);
        newItem.name := fields[0]; // ���O
        newItem.desc := fields[1]; // ����
        newItem.softwares := TList.Create;  // �\�t�g�G���g��
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


    // �f�[�^�Q�ƕ��@
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



    // �\�t�g���X�g�f�[�^�폜
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

    // �\�t�g�E�F�A�̃}�X�^���
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


// �\���Ɏg���\�t�g���ڂ��č\������
function TfrmSoftwareList.updateSoftItems(const SLName:string; orderBy: integer; asc:boolean; searchWord: string):integer;
var key: string;
    i, j, n: integer;
    tempSoftwares: Array of TSoftware;

begin

  n:=0;

  SubList.Free;

  SubList:=TList.Create;

  searchWord:= Trim(searchWord);

  // SLName �Ō���
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


  // �\�[�g
  SubList.Sort(@AscSort2);


  StatusBar1.Panels[0].Text:=inttostr(SubList.Count) + ' / ' +
  inttostr(PSoftlist2(softlistData2[j]).softwares.Count);

  result:=SubList.Count;

end;


// ��r����
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

  if Column.Caption = '�Q�[����' then idx := 1
  else if Column.Caption = 'ZIP��' then idx := 2
  else if Column.Caption = '���[�J�[' then idx := 3
  else if Column.Caption = '�N�x' then idx := 4
  else if Column.Caption = '�}�X�^' then idx := 5;

  if abs(columnSort) = idx then columnSort:=columnSort*-1
  else columnSort:=idx;

  SetListViewColumnSortMark( columnSort );

  UpdateListView;

end;

procedure TfrmSoftwareList.ListView1Data(Sender: TObject; Item: TListItem);
var
  i:integer;
  softname: string;

begin

  i:=Item.Index;

  if lang='ja' then
    Item.Caption := PSoftware(SubList[i]).alt
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

      // ��ԉ��܂ōs������擪���猟���𑱂���
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
  // �I�����ɍX�V�O�ƍX�V���2��Ăяo�����̂őO�̕����͂���
  // �X�V�O: Selected=False, Item.Index=�s��
  // �X�V��: Selected=True,  Item.Index=����

  if not Selected then exit;

  selectedSoftName:=Item.SubItems[0];

  PSoftlist2(softlistData2[currentSoftlistIndex]).lastSelect:=selectedSoftName;
  StatusBar1.Panels[1].Text:= PSoftware(SubList[ListView1.ItemIndex]).desc;

  supported := PSoftware(SubList[ListView1.ItemIndex]).supported;
  if (supported = 'yes') then
    StatusBar1.Panels[2].Text:='����\ '
  else if (supported = 'partial') then
    StatusBar1.Panels[2].Text:='�����T�|�[�g '
  else if (supported = 'no') then
    StatusBar1.Panels[2].Text:='���T�|�[�g '
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

// zip ���Ń\�t�g���X�g���X�V����
procedure TfrmSoftwareList.setSoftlist(const zip:string; forceUpdate:boolean = false);
var
  i,j,n: integer;
  st: string;
  needUpdate: boolean;

  sl: TStringList;
  softList: TSoftList;
  lastListCount: integer; // �ύX���O�̃h���b�v�_�E�����X�g��

begin

  if not softlistAvailable then exit;

  // 2��Ă΂��̂�h�~
  if (zip = lastZip) then exit;


  needUpdate := false;
  lastListCount:=cmbSoftList.Items.Count;

  if forceUpdate then
  begin
    lastListCount:=0; // �����X�V
    lastZip:='';
  end;


  // �\�t�g���X�g���邩�m�F
  if (softMaster.TryGetValue(zip, sl)) then
  begin

    needUpdate := true;

    // ���O�̑I���ƈ�v���邩
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


    // ��v���Ȃ������Ƃ��͍X�V
    if needUpdate then
    begin
      cmbSoftList.Items.Clear;
      for i := 0 to sl.Count-1 do
      begin

        for j := 0 to softlistData2.Count-1 do // ���݂��Ȃ��\�t�g���X�g������
        begin
          if sl[i] = PSoftlist2(SoftlistData2[j]).name then
          begin
            cmbSoftList.Items.Add(PSoftlist2(SoftlistData2[j]).desc + ' (' + PSoftlist2(SoftlistData2[j]).name+')');
            break;
          end;
        end;

      end;
      cmbSoftList.Enabled := true;
      cmbSoftList.ItemIndex := 0;
    end;

    lastZip:=zip;
    frmSoftwareList.Caption:='�\�t�g�E�F�A���X�g - '+zip+' - ���X�g��: '+inttostr(cmbSoftList.Items.Count);

  end
  else
  begin
    cmbSoftList.Items.Clear;
    cmbSoftList.Enabled:=false;
    lastZip:='';
    frmSoftwareList.Caption:='�\�t�g�E�F�A���X�g';
    StatusBar1.Panels[0].Text:='';
    StatusBar1.Panels[1].Text:='';
    StatusBar1.Panels[2].Text:='';

  end;


  // �`��X�V
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

// ���X�g�r���[�̍X�V
procedure TfrmSoftwareList.updateListView;
var i: integer;
    st: string;

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

  currentSoftlistName := softMaster[lastZip][cmbSoftlist.ItemIndex]; // �I�𒆂̃\�t�g���X�g��

  if ( updateSoftItems(currentSoftlistName, 0, true, SearchBox1.Text) = 0 ) then
  begin
    // �\��������̂�0��
    ListView1.Items.BeginUpdate;
    ListView1.Items.Count:=0;
    ListView1.Enabled := true;
    ListView1.Refresh;
    ListView1.Items.EndUpdate;
    StatusBar1.Panels[0].Text:= '';
    StatusBar1.Panels[1].Text:= '';
    StatusBar1.Panels[2].Text:= '';

    exit;
  end;

  ListView1.Items.BeginUpdate;
  ListView1.items.Count := SubList.Count;
  ListView1.Enabled := true;
  SearchBox1.Enabled := true;

  // �I�����ڕ���
  st := PSoftList2(softListData2[currentSoftlistIndex]).lastSelect;

  if (st<>'') then // �I�𗚗�������
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
// �J�������ݒ�
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

// DEL�L�[�̓��͂������̂ő΍�
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

end.