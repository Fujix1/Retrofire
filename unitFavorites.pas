unit unitFavorites;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls,
  System.Actions, Vcl.ActnList, System.ImageList, Vcl.ImgList, Vcl.Menus,
   Vcl.ActnPopup, Vcl.PlatformDefaultStyleActnCtrls;

type
  TfrmFavorites = class(TForm)
    btnCancel: TButton;
    btnSaveClose: TButton;
    Button1: TButton;
    ImageList1: TImageList;
    ActionList1: TActionList;
    actDeleteTreeNode: TAction;
    actMoveOutTreeNode: TAction;
    Button3: TButton;
    Bevel1: TBevel;
    btnGetItemOutOfFolder: TButton;
    TreeView1: TTreeView;
    Label1: TLabel;
    actNewFolder: TAction;
    PopupActionBar1: TPopupActionBar;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    procedure btnCancelClick(Sender: TObject);
    procedure TreeView1Collapsing(Sender: TObject; Node: TTreeNode;
      var AllowCollapse: Boolean);
    procedure TreeView1Editing(Sender: TObject; Node: TTreeNode;
      var AllowEdit: Boolean);
    procedure TreeView1DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure TreeView1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure FormShow(Sender: TObject);
    procedure actDeleteTreeNodeUpdate(Sender: TObject);
    procedure actMoveOutTreeNodeUpdate(Sender: TObject);
    procedure actMoveOutTreeNodeExecute(Sender: TObject);
    procedure actDeleteTreeNodeExecute(Sender: TObject);
    procedure btnSaveCloseClick(Sender: TObject);
    procedure actNewFolderExecute(Sender: TObject);
    procedure TreeView1Click(Sender: TObject);
    procedure TreeView1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private �錾 }
    type
      PFavData = ^TFavData;  //TFavData�̃|�C���^�^
      TFavData = record
        zip: string;          // ���C�ɓ����zip��
//        description: string;  // ����
//        isParent: boolean;    // �e�Z�b�g��
    end;

    procedure strToTreeView( strInput: TStringList );

  public
    { Public �錾 }
  end;

var
  frmFavorites: TfrmFavorites;

implementation

uses Common;

{$R *.dfm}

procedure TfrmFavorites.strToTreeView( strInput: TStringList );
var i : Integer;
    kind, zip: String;
    newTreeNode: TTreeNode;
    pFav: PFavData;  //�|�C���^�^
    idx: Integer;
    st: String;
    icon: Integer;
begin

  // �����񂩂畜������
  TreeView1.items.Clear;

  for i:=0 to strInput.Count-1 do begin

    if (trim( strInput[i] ) <> '') then begin

      kind := copy(strInput[i], 1, pos( #9, strInput[i] ) -1 );
      zip := copy(strInput[i], pos( #9, strInput[i] )+1, strInput[i].Length);

      // �t�H���_�ǉ�
      if ( kind = 'f' ) then begin
        newTreeNode := TreeView1.Items.Add(nil,zip);
        newTreeNode.ImageIndex:=0;
        newTreeNode.SelectedIndex:=0;
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
          icon := 10;
        end
        else
        /// ���݂���Q�[��
        begin
          if En then
            st := zip + ' - '+ PRecordSet(TLMaster[idx]).DescE
          else
            st := zip + ' - '+ PRecordSet(TLMaster[idx]).DescJ;

          // �A�C�R��
          if PRecordSet(TLMaster[idx]).Status then
          begin
            if PRecordSet(TLMaster[idx]).Master then
              icon:=2
            else
              icon:=2+1;
          end
          else
          begin
            if PRecordSet(TLMaster[idx]).Master then
              icon:=2+2
            else
              icon:=2+3;
          end;

          if PRecordset(TLMaster[idx]).ROM=False then
            icon:=icon+3;
        end;


        // ���[�g�K�w�̃^�C�g��
        if ( kind = '-1' ) then begin
          newTreeNode := TreeView1.Items.Add(nil, st);
        end
        else begin
        // ���K�w�̃^�C�g��
          newTreeNode := TreeView1.Items.AddChild( TreeView1.Items[ strtoint(kind) ], st);
        end;

        newTreeNode.ImageIndex:=icon;
        newTreeNode.SelectedIndex:=icon;

        New(pFav);  //�������̈���m��
        pFav^.zip := zip;
        newTreeNode.Data := pFav;
      end;
    end;
  end;

  TreeView1.FullExpand;

end;

procedure TfrmFavorites.actDeleteTreeNodeExecute(Sender: TObject);
var
  StrText : String;
  iRet    : Integer;
  i       : Integer;
begin

  // �폜����
  if ( TreeView1.Selected <> nil ) then
  begin

    if ( TreeView1.Selected.ImageIndex = 0 ) then // �t�H���_�̏ꍇ
    begin

      StrText := '�t�H���_�u'+TreeView1.Selected.Text+'�v���폜���܂���?'+#13#10+#13#10+
                 '�t�H���_���̍��ڂ��폜����܂��B';
      iRet :=  Application.MessageBox(PChar(StrText), '�폜�m�F',
                                      MB_YESNO or MB_ICONQUESTION,);
      if iRet = IDYES then begin
        TreeView1.Selected.Delete; //
      end;

    end
    else
    begin

      StrText := '�ȉ��̂��C�ɓ��荀�ڂ��폜���܂����H'+ #13#10#13#10 +
        TreeView1.Selected.Text;
      iRet :=  Application.MessageBox(PChar(StrText), '�폜�m�F',
                                      MB_YESNO or MB_ICONQUESTION,);
      if iRet = IDYES then begin
        TreeView1.Selected.Delete; //
      end;

    end;

  end;

  TreeView1.SetFocus;

end;

procedure TfrmFavorites.actDeleteTreeNodeUpdate(Sender: TObject);
begin
  //
  actDeleteTreeNode.Enabled := (TreeView1.Selected <>nil);
end;

procedure TfrmFavorites.actMoveOutTreeNodeExecute(Sender: TObject);
var
  SourceNode: TTreeNode;
begin

  SourceNode := TreeView1.Selected;

  if ( SourceNode <> nil) and ( SourceNode.Level = 1 ) then
  begin

    if ( SourceNode.Parent.getNextSibling <> nil ) then
    begin
      // �e�Ɉړ�
      SourceNode.MoveTo( SourceNode.Parent.getNextSibling, naInsert );
    end
    else
    begin
      // �e�Ɉړ�
      if ( SourceNode.Parent<>nil) then
        SourceNode.MoveTo( SourceNode.Parent, naAdd );
    end;
  end;

  TreeView1.SetFocus;

end;

procedure TfrmFavorites.actMoveOutTreeNodeUpdate(Sender: TObject);
begin
  // �t�H���_����o���{�^���̊�����
  actMoveOutTreeNode.Enabled := ( (TreeView1.Selected <> nil) and
                                  (TreeView1.Selected.Level=1) and
                                  (TreeView1.Selected.ImageIndex <>0 )
                                );
end;

procedure TfrmFavorites.actNewFolderExecute(Sender: TObject);
var
  trCur:TTreeNode;
  trNew:TTreeNode;
begin

  trCur := TreeView1.Selected;//���݃J�[�\���̂���m�[�h

  //�}���ʒu�̌���
  if ( trCur <> nil ) then
  begin

    // �q�̏ꍇ�e�̃P�c
    if ( trCur.Level = 1 ) then
    begin
      trCur := trCur.Parent;
    end;

    // �Ō�̍��ڂłȂ��ꍇ�͎��̍��ڂ̎�O�ɒǉ�
    if ( trCur.getNextSibling <>nil ) then
    begin
      trCur := trCur.getNextSibling;
      trNew := TreeView1.Items.Insert( trCur, '�V�����t�H���_');
    end
    else
    begin
      // �Ō�̍��ڂ̏ꍇ�͍Ō���ɒǉ�
      trNew := TreeView1.Items.Add( trCur, '�V�����t�H���_');
    end;


  end
  else
  begin
      // �Ō�̍��ڂ̏ꍇ�͍Ō���ɒǉ�
      trNew := TreeView1.Items.Add( trCur, '�V�����t�H���_');
  end;

  trNew.ImageIndex := 0;
  trNew.MakeVisible;
  TreeView1.Select(trNew);

  TreeView1.SetFocus;

end;

procedure TfrmFavorites.btnCancelClick(Sender: TObject);
begin
  frmFavorites.Close;

end;

procedure TfrmFavorites.btnSaveCloseClick(Sender: TObject);
var i,parentIdx: Integer;
begin

  // �ۑ����ĕ���
  Favorites2.Clear;

  // �V���A���C�Y����
  for i:=0 to TreeView1.Items.Count-1 do
  begin

    if ( TreeView1.Items[i].ImageIndex = 0 ) then begin  // �t�H���_
      Favorites2.Add( 'f'+#9+ TreeView1.Items[i].Text );
    end
    else // ����
    begin
      if ( TreeView1.Items[i].Parent <> nil ) then begin
        parentIdx := TreeView1.Items[i].Parent.AbsoluteIndex;
      end
      else
      begin
        parentIdx := -1; // ���[�g
      end;

      Favorites2.Add( inttostr( parentIdx ) +#9+ TFavData(TreeView1.Items[i].data^).zip );

    end;

  end;

  frmFavorites.Close;

end;

procedure TfrmFavorites.FormShow(Sender: TObject);
begin
  // ���C�ɓ���f�[�^��͂ƓW�J
  strToTreeView( Favorites2 );
  TreeView1.SetFocus;
end;

procedure TfrmFavorites.TreeView1Click(Sender: TObject);
begin
  beep;
end;

procedure TfrmFavorites.TreeView1Collapsing(Sender: TObject; Node: TTreeNode;
  var AllowCollapse: Boolean);
begin
  AllowCollapse:=false;
end;

procedure TfrmFavorites.TreeView1DragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  DropNode : TTreeNode;
  SourceNode: TTreeNode;
begin
  //�h���b�v����
  DropNode := TreeView1.GetNodeAt(X,Y);
  SourceNode := TreeView1.Selected;

  if DropNode <> nil then
  begin

    // ���\�[�X���t�@�C���̂Ƃ�
    if ( SourceNode<>nil ) and ( SourceNode.ImageIndex <> 0 ) then
    begin

      // �t�@�C�����t�@�C���Ƀh���b�v�����ꍇ�A���̏�Ɉړ�����
      if ( DropNode.ImageIndex <> 0 ) then
      begin

        // �����Ȃ牺���ɑ}��
        if ( SourceNode.Index < DropNode.Index ) then begin
          if ( DropNode.getNextSibling <> nil ) then begin
            SourceNode.MoveTo( DropNode.getNextSibling, naInsert );
          end
          else begin
            SourceNode.MoveTo( DropNode, naAdd );
          end;

        end
        else begin
          SourceNode.MoveTo( DropNode,naInsert );
        end;
      end
      else
      begin
        SourceNode.MoveTo( DropNode,naAddChild );
      end;

    end
    else
    begin // ���\�[�X���t�H���_�̂Ƃ�

      // �t�H���_���t�@�C���Ƀh���b�v�����ꍇ
      // �g�b�v�K�w�Ȃ�A���̏�Ɉړ�����
      if ( DropNode.Level = 0 ) then
      begin

        // �����Ȃ牺���ɑ}��
        if ( SourceNode.Index < DropNode.Index ) then begin
          if ( DropNode.getNextSibling <> nil ) then begin
            SourceNode.MoveTo( DropNode.getNextSibling, naInsert );
          end
          else begin
            SourceNode.MoveTo( DropNode, naAdd );
          end;

        end
        else begin
          SourceNode.MoveTo( DropNode,naInsert );
        end;
      end;

    end;

  end;

  TreeView1.FullExpand;


end;

procedure TfrmFavorites.TreeView1DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
var
  DropNode : TTreeNode;
  SourceNode: TTreeNode;
begin
  //�h���b�O����
  Accept:=False;
  if Source is TTreeView then
  begin

    DropNode := TreeView1.GetNodeAt(X,Y);
    SourceNode := TreeView1.Selected;

    if DropNode <> nil then
    begin

      // �t�H���_�����K�w�ɂ̓h���b�v�ł��Ȃ�
      if ( SourceNode.ImageIndex = 0) and ( DropNode.Level <> 0 ) then
      begin
        Accept:=false;
      end
      else
      begin
        Accept:=True;
      end;

    end;

  end;

end;

procedure TfrmFavorites.TreeView1Editing(Sender: TObject; Node: TTreeNode;
  var AllowEdit: Boolean);
begin
  // �t�H���_����Ȃ��Ƃ��͕ҏW�s��
  if ( Node.ImageIndex <> 0 ) then
  begin
    AllowEdit := false;
  end;
end;

procedure TfrmFavorites.TreeView1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

var theNode: TTreeNode;
begin
  if Button = mbRight then begin

    theNode := TreeView1.GetNodeAt(X,Y);
    if ( theNode <> nil ) then begin
      theNode.Selected:=true;
    end;

  end;
end;

end.
