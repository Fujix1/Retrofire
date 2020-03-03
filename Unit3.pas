unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, ImgList, common,
  System.ImageList;

type
  TForm3 = class(TForm)
    BitBtn4: TBitBtn;
    ImageList1: TImageList;
    ListView1: TListView;
    btnDelete: TButton;
    btnUp: TBitBtn;
    btnDown: TBitBtn;
    Bevel1: TBevel;
    procedure FormShow(Sender: TObject);
    procedure ListView1AdvancedCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; Stage: TCustomDrawStage;
      var DefaultDraw: Boolean);
    procedure ListView1SelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnDownClick(Sender: TObject);
    procedure btnUpClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

  private
    { Private 宣言 }
  public
    { Public 宣言 }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

// 削除
procedure TForm3.btnDeleteClick(Sender: TObject);
var
  idx: integer;
begin

  if btnDelete.Enabled=False then exit;

  idx:= ListView1.ItemIndex;

  if Application.MessageBox( PWideChar( ListView1.Items[ idx ].SubItems[0] +' を削除します。'), APPNAME, MB_YESNO+MB_ICONQUESTION)=IDYES then
  begin

    favorites.Delete(idx);
    ListView1.Items.Delete(idx);


    // 消した後の選び直し
    if ListView1.Items.Count<>0 then
    begin
      if favorites.Count = idx then
        ListView1.ItemIndex := favorites.Count-1
      else
        ListView1.ItemIndex:= idx;
      ListView1.SetFocus;
    end;

  end;
end;


// 下に移動
procedure TForm3.btnDownClick(Sender: TObject);
var
  newItem: TListItem;
  idx: integer;
begin

  ListView1.Items.BeginUpdate;

  idx:= ListView1.ItemIndex;
  newItem:=ListView1.Items.Insert( idx +2);
  newItem.Assign(ListView1.Items[ idx ]);
  ListView1.Items[idx].Delete;
  ListView1.ItemIndex:=idx+1;
  ListView1.Items[idx+1].Focused:=True;

  ListView1.Items.EndUpdate;
  ListView1.SetFocus;

  favorites.Move(idx, idx+1);

end;

// 上に移動
procedure TForm3.btnUpClick(Sender: TObject);
var
  newItem: TListItem;
  idx: integer;
begin

  ListView1.Items.BeginUpdate;

  idx:= ListView1.ItemIndex;
  newItem:=ListView1.Items.Insert( idx-1 );
  newItem.Assign(ListView1.Items[ idx+1 ]);
  ListView1.Items[idx+1].Delete;
  ListView1.ItemIndex:=idx-1;
  ListView1.Items[idx-1].Focused:=True;

  ListView1.Items.EndUpdate;
  ListView1.SetFocus;

  favorites.Move(idx, idx-1);

end;



// お気に入りの展開
procedure TForm3.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  // DELキー
  if key=46 then
  begin

    btnDeleteClick(nil);

  end;

end;

procedure TForm3.FormShow(Sender: TObject);
var
  newItem: TListItem;
  i, idx : integer;
begin

  ListView1.Items.Clear;

  for i := 0 to favorites.Count - 1 do
  begin

    newItem := ListView1.Items.Add;

    idx:= FindIndex( favorites[i] );
    if idx=-1 then
    begin
      newItem.Caption:='　(不明なゲーム)';
      newItem.ImageIndex:= 8;
      newItem.SubItems.Add( favorites[i] );
    end
    else
    begin
      newItem.Caption:=PRecordSet(TLMaster[idx]).DescJ;

      // アイコン
      if PRecordSet(TLMaster[idx]).Status then
        if PRecordSet(TLMaster[idx]).Master then
          newItem.ImageIndex:=0
        else
          newItem.ImageIndex:=1
      else
      if PRecordSet(TLMaster[idx]).Master then
        newItem.ImageIndex:=2
      else
        newItem.ImageIndex:=3;

      if PRecordset(TLMaster[idx]).ROM=False then
        newItem.ImageIndex:=newItem.ImageIndex+4;

      newItem.SubItems.Add( favorites[i] );
    end;

  end;

  if ListView1.Items.Count<>0 then
  begin

    ListView1.ItemIndex:=0;

  end;

end;

procedure TForm3.ListView1AdvancedCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; Stage: TCustomDrawStage;
  var DefaultDraw: Boolean);
begin

  if Item.Index mod 2 = 1 then
    ListView1.Canvas.Brush.Color:=$f5f5f5;

  // 不明ゲームの表示
  if Item.ImageIndex =8 then
  begin
    ListView1.Canvas.Font.Color:=$909090;
    //ListView1.Canvas.Font.Style:=[fsItalic];
  end;

end;

procedure TForm3.ListView1SelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin

  // ボタンの活性化
  if Selected=False then
  begin

    btnDelete.Enabled:=False;
    btnUp.Enabled:=False;
    btnDown.Enabled:=False;

  end
  else
  begin

    btnUp.Enabled := (Item.Index <> 0);
    btnDown.Enabled := (Item.Index  <> ListView1.Items.Count-1);
    btnDelete.Enabled:=True;

  end;

end;

end.
