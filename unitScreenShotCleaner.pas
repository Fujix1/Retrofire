unit unitScreenShotCleaner;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Common;

type
  TForm6 = class(TForm)
    Label1: TLabel;
    btnAnalyze: TButton;
    btnCleanup: TButton;
    GroupBox1: TGroupBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    ListView1: TListView;
    btnCancel: TButton;
    Label2: TLabel;
    CheckBox4: TCheckBox;
    procedure btnCancelClick(Sender: TObject);
    procedure btnAnalyzeClick(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure btnCleanupClick(Sender: TObject);
  private
    { Private �錾 }
  public
    { Public �錾 }
  end;

var
  Form6: TForm6;

implementation

{$R *.dfm}

procedure TForm6.btnAnalyzeClick(Sender: TObject);
var     folderPath :String;
        SearchRec  :TSearchRec;
        Res, Attri :Integer;
        NewItem: TListItem;
        filename   :String;

        filecount, foldcount: integer;
begin

  ListView1.Items.Clear;
  filecount := 0;
  foldcount := 0;
  label2.Caption := '';
  btnCleanup.Enabled:=False;

  Application.ProcessMessages;

  folderPath:=IncludeTrailingPathDelimiter(SnapDir); //�p�X�̌��Ɂ����Ȃ���������Ă����

  // �X�i�b�v�t�H���_�̊m�F
  if DirectoryExists(folderPath)=false then
  begin
    Application.MessageBox('�X�N���[���V���b�g�̃t�H���_������܂���B',
                          '�G���[', MB_ICONERROR + MB_OK);
    exit;
  end;


  label2.Caption := '��͒�..';
  Application.ProcessMessages;


  FindFirst( folderPath +'*', faAnyFile, SearchRec);

  //������
  Res := 0;


  /// �Â����O.PNG�̍폜
  try
    try
      while Res = 0 do
      begin
        Attri := SearchRec.Attr;
        if  (Attri <> faReadOnly) and (Attri <> faHidden) and
            (Attri <> faSysFile) then
        begin

          if (Attri <> faDirectory) then
          begin

            // �s��ZIP��PNG��T��
            if LowerCase(ExtractFileExt( SearchRec.Name )) = '.png' then
            begin
              if Checkbox1.Checked then
              begin
                filename := Copy( SearchRec.Name, 0, Length(SearchRec.Name)-4) ;

                if FindIndex(filename)=-1 then
                begin
                  NewItem := ListView1.Items.Add;
                  NewItem.Caption := '�s����ZIP���V���b�g';
                  NewItem.SubItems.Add( SearchRec.Name );
                  inc( filecount );
                end;
              end;
            end
            else
            begin
            // PNG�ȊO�̃t�@�C��
              if Checkbox4.Checked then
              begin
                NewItem := ListView1.Items.Add;
                NewItem.Caption := 'PNG�ȊO';
                NewItem.SubItems.Add( SearchRec.Name );
                inc( filecount );
              end;
            end;

          end
          else
          /// �t�H���_�̏���
          begin


            if (SearchRec.Name<>'.') and (SearchRec.Name<>'..') then
            begin
              // �s��ZIP�̃t�H���_��T��
              if FindIndex(SearchRec.Name)=-1 then
              begin
                if Checkbox3.Checked then
                begin
                  NewItem := ListView1.Items.Add;
                  NewItem.Caption := '�s�v�t�H���_';
                  NewItem.SubItems.Add( SearchRec.Name );
                  inc( foldcount );
                end;
              end
              else
              begin
              // ZIP���ƃ}�b�`����t�H���_������

                // ZIP.png�������AZIP\0000.png������Ƃ�
                if ( FileExists( folderPath + SearchRec.Name +'.png') = false ) and
                   ( FileExists( folderPath + SearchRec.Name +'\0000.png') ) then
                begin

                  if Checkbox2.Checked then
                  begin

                    NewItem := ListView1.Items.Add;
                    NewItem.Caption := '�t�H���_������ړ�';
                    NewItem.SubItems.Add( SearchRec.Name + '\0000.png -> '+SearchRec.Name+'.png' );

                    NewItem := ListView1.Items.Add;
                    NewItem.Caption := '�t�H���_���폜';
                    NewItem.SubItems.Add( SearchRec.Name );

                    inc( foldcount );
                  end;
                end
                else
                begin
                // ZIP.png������Ƃ�
                  if Checkbox3.Checked then
                  begin
                    NewItem := ListView1.Items.Add;
                    NewItem.Caption := 'PNG�d���t�H���_';
                    NewItem.SubItems.Add( SearchRec.Name );
                    inc( foldcount );
                  end;

                end;

              end;

            end;


          end;


        end;
        Res := FindNext(SearchRec);
      end;
    except
      Application.MessageBox('�������ɃG���[���N���܂����B',
                             '�G���[', MB_ICONERROR + MB_OK);
    end;
  finally
    FindClose(SearchRec);

  end;

  label2.Caption:='�폜�t�@�C���� = '+inttostr(filecount)+
                  ',  �폜�t�H���_�� = '+inttostr(foldcount);
  btnCleanup.Enabled:=True;

end;

procedure TForm6.btnCancelClick(Sender: TObject);
begin

  Form6.Close;

end;

procedure TForm6.btnCleanupClick(Sender: TObject);
var     folderPath :String;
        SearchRec  :TSearchRec;
        Res, Attri :Integer;
        NewItem: TListItem;
        filename   :String;

        filecount, foldcount: integer;
begin

  ListView1.Items.Clear;
  filecount := 0;
  foldcount := 0;
  label2.Caption := '';
  btnCleanup.Enabled:=False;

  Application.ProcessMessages;

  folderPath:=IncludeTrailingPathDelimiter(SnapDir); //�p�X�̌��Ɂ����Ȃ���������Ă����

  // �X�i�b�v�t�H���_�̊m�F
  if DirectoryExists(folderPath)=false then
  begin
    Application.MessageBox('�X�N���[���V���b�g�̃t�H���_������܂���B',
                          '�G���[', MB_ICONERROR + MB_OK);
    exit;
  end;


  label2.Caption := '������..';
  btnCancel.Enabled:=False;
  btnAnalyze.Enabled:=False;
  btnCleanup.Enabled:=False;

  Application.ProcessMessages;


  FindFirst( folderPath +'*', faAnyFile, SearchRec);

  //������
  Res := 0;


  /// �Â����O.PNG�̍폜
  try
    try
      while Res = 0 do
      begin
        Attri := SearchRec.Attr;
        if  (Attri <> faReadOnly) and (Attri <> faHidden) and
            (Attri <> faSysFile) then
        begin

          if (Attri <> faDirectory) then
          begin

            // �s��ZIP��PNG��T��
            if LowerCase(ExtractFileExt( SearchRec.Name )) = '.png' then
            begin
              if Checkbox1.Checked then
              begin
                filename := Copy( SearchRec.Name, 0, Length(SearchRec.Name)-4) ;

                if FindIndex(filename)=-1 then
                begin

                  label2.Caption := '�S�~���Ɉړ���: '+folderPath+SearchRec.Name;
                  Trasher( folderPath+SearchRec.Name );


                  inc( filecount );
                  NewItem := ListView1.Items.Add;
                  NewItem.Caption := '�s����ZIP���V���b�g';
                  NewItem.SubItems.Add( SearchRec.Name );
                  ListView1.Selected  :=  ListView1.Items[ListView1.Items.Count - 1];
                  ListView1.Selected.MakeVisible(True);
                  Application.ProcessMessages;
                end;
              end;
            end
            else
            begin
            // PNG�ȊO�̃t�@�C��
              if Checkbox4.Checked then
              begin

                label2.Caption := '�S�~���Ɉړ���: '+folderPath+SearchRec.Name;
                Trasher( folderPath+SearchRec.Name );

                NewItem := ListView1.Items.Add;
                NewItem.Caption := 'PNG�ȊO';
                NewItem.SubItems.Add( SearchRec.Name );
                inc( filecount );
                ListView1.Selected  :=  ListView1.Items[ListView1.Items.Count - 1];
                ListView1.Selected.MakeVisible(True);
                Application.ProcessMessages;

              end;
            end;

          end
          else
          /// �t�H���_�̏���
          begin


            if (SearchRec.Name<>'.') and (SearchRec.Name<>'..') then
            begin
              // �s��ZIP�̃t�H���_��T��
              if FindIndex(SearchRec.Name)=-1 then
              begin
                if Checkbox3.Checked then
                begin

                  label2.Caption := '�S�~���Ɉړ���: '+folderPath+SearchRec.Name;
                  Trasher( folderPath+SearchRec.Name );

                  NewItem := ListView1.Items.Add;
                  NewItem.Caption := '�s�v�t�H���_';
                  NewItem.SubItems.Add( SearchRec.Name );
                  inc( foldcount );
                  ListView1.Selected  :=  ListView1.Items[ListView1.Items.Count - 1];
                  ListView1.Selected.MakeVisible(True);
                  Application.ProcessMessages;

                end;
              end
              else
              begin
              // ZIP���ƃ}�b�`����t�H���_������

                // ZIP.png�������AZIP\0000.png������Ƃ�
                if ( FileExists( folderPath + SearchRec.Name +'.png') = false ) and
                   ( FileExists( folderPath + SearchRec.Name +'\0000.png') ) then
                begin

                  if Checkbox2.Checked then
                  begin

                    label2.Caption := '�t�H���_������ړ���: '+folderPath+SearchRec.Name;

                    try
                      if RenameFile(folderPath + SearchRec.Name +'\0000.png',
                                    folderPath + SearchRec.Name +'.png') then
                      begin
                        RemoveDir( folderPath + SearchRec.Name );

                      end;

                    except

                    end;

                    NewItem := ListView1.Items.Add;
                    NewItem.Caption := '�t�H���_������ړ�';
                    NewItem.SubItems.Add( SearchRec.Name + '\0000.png -> '+SearchRec.Name+'.png' );

                    NewItem := ListView1.Items.Add;
                    NewItem.Caption := '�t�H���_���폜';
                    NewItem.SubItems.Add( SearchRec.Name );

                    inc( foldcount );
                    ListView1.Selected  :=  ListView1.Items[ListView1.Items.Count - 1];
                    ListView1.Selected.MakeVisible(True);
                    Application.ProcessMessages;
                  end;
                end
                else
                begin
                // ZIP.png������Ƃ�
                  if Checkbox3.Checked then
                  begin

                    label2.Caption := '�S�~���Ɉړ���: '+folderPath+SearchRec.Name;
                    Trasher( folderPath+SearchRec.Name );

                    NewItem := ListView1.Items.Add;
                    NewItem.Caption := 'PNG�d���t�H���_';
                    NewItem.SubItems.Add( SearchRec.Name );
                    inc( foldcount );
                    ListView1.Selected  :=  ListView1.Items[ListView1.Items.Count - 1];
                    ListView1.Selected.MakeVisible(True);
                    Application.ProcessMessages;
                  end;

                end;

              end;

            end;


          end;


        end;
        Res := FindNext(SearchRec);
      end;
    except
      Application.MessageBox('�폜���ɃG���[���N���܂����B',
                             '�G���[', MB_ICONERROR + MB_OK);
    end;
  finally
    FindClose(SearchRec);

  end;

  label2.Caption:='�폜�����t�@�C���� = '+inttostr(filecount)+
                  ',  �폜�����t�H���_�� = '+inttostr(foldcount);
  btnCleanup.Enabled:=False;
  btnCancel.Enabled:=True;
  btnAnalyze.Enabled:=True;

  beep;

end;

procedure TForm6.FormHide(Sender: TObject);
begin

  ListView1.Items.Clear;
  btnCleanup.Enabled:=False;
  Label2.Caption:='';

end;

end.
