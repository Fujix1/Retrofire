  unit Unit2;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Variants, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Common, ExtCtrls;

type
  TForm2 = class(TForm)
    OpenDialog1: TOpenDialog;
    btnOK:      TButton;
    btnCancel:  TButton;
    GroupBox1:  TGroupBox;
    Edit2:      TEdit;
    Button3:    TButton;
    Label4:     TLabel;
    Timer1: TTimer;
    Label1: TLabel;

    procedure FormShow(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    
  private
    { Private �錾 }
  public
    { Public �錾 }
  end;

  function ExtractListXML: boolean;

var
  Form2: TForm2;
  CancelFlag:boolean;
  second: integer;

implementation

uses Unit1;

{$R *.dfm}

procedure TForm2.FormShow(Sender: TObject);
begin

  CancelFlag:=False;
  second:=0;

  if CurrentProfile<>-1 then
  begin
    if FileExists(MameExe[CurrentProfile].ExePath) then
    begin
      Edit2.Text:=MameExe[CurrentProfile].ExePath;
      OpenDialog1.InitialDir:= ExtractFilePath( MameExe[CurrentProfile].ExePath );
    end;
  end;

end;

procedure TForm2.Timer1Timer(Sender: TObject);
var m:integer;
ss,mm:string;
begin

  inc(second);
  ss:= '0'+inttostr(second mod 60);
  ss:= copy( ss, length(ss)-1, 2 );

  mm:= inttostr( second div 60 );


  Label1.Caption:= mm+':'+ss;

end;

procedure TForm2.Button3Click(Sender: TObject);
begin

  if DirectoryExists(lastExePath) then
    OpenDialog1.InitialDir:=lastExePath;

  if OpenDialog1.Execute then
  begin
    Edit2.Text:=OpenDialog1.FileName;
  end;



end;

procedure TForm2.btnOKClick(Sender: TObject);
var
  Save_Cursor : TCursor;
  SI :TStartupInfo;
  PI :TProcessInformation;
  parameter: string;
  cmd: Commd;
  papp: PChar;
begin

  Save_Cursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;    // Show hourglass cursor
  ModalResult:=mrOK;

try

  timer1.Enabled:=true;
  Label4.Caption:='listxml�o�͒�...';
  Edit2.Enabled:=False;
  Button3.Enabled:=False;
  BtnOK.Enabled:=False;
  LastExePath:=ExtractFilePath(OpenDialog1.FileName);



  Application.ProcessMessages;

  /// listxml�̏o�� ---------------------------------------------------
  if FileExists(ExeDir+'listxml.tmp') then
    DeleteFile(ExeDir+'listxml.tmp');

	cmd := SetCommand;

	parameter := '"'+cmd.App+ '" ' +cmd.Param + '""'+ Edit2.Text +'"'+
         ' -listxml > "' + ExeDir +'listxml.tmp""';

	if cmd.App = '' then
		papp := nil
	else
		papp := PChar(cmd.App);

	GetStartupInfo(SI);

  SetLength(parameter, Length(parameter));

	// �R���\�[�����B������ԂŋN������
	SI.wShowWindow := SW_HIDE;

  UniqueString(parameter);  // �w�肳�ꂽ������ 1 �̎Q�ƃJ�E���g�������Ƃ�ۏ؂��܂�

	if not CreateProcessW(
                      nil,
                      PWideChar(parameter),
                      nil,
                      nil,
                      False,
                      CREATE_DEFAULT_ERROR_MODE,
                      nil,
                      PWideChar(ExeDir),
                      SI,
                      PI
                      )
	then
		Exit;

	// �A�v���P�[�V�����̏I���҂�
  try
  	while (WaitForSingleObject(PI.hProcess, 100) = WAIT_TIMEOUT) and
          (CancelFlag=False) do
    begin
		  Application.ProcessMessages;
      Sleep(50);
    end;

    // �L�����Z�����Ƀv���Z�X���܂������Ă�ꍇ
    {if WaitForSingleObject(PI.hProcess, 0) = WAIT_TIMEOUT then
    begin
      TerminateProcess(PI.hProcess, 0);
    end;
    }
  finally
    CloseHandle(PI.hThread);
    CloseHandle(PI.hProcess);
  end;
  
  if CancelFlag then
  begin
    ModalResult:=mrCancel;
    exit;
  end;

  /// listxml�̉�� ---------------------------------------------------
  if ExtractListXML=False then
  begin
    MessageBox(Form2.Handle,'listxml�t�@�C�����������o�͂���Ă��܂���B',APPNAME,MB_OK or MB_ICONERROR);
    ModalResult:=mrCancel;
  end;

  finally
    Screen.Cursor := Save_Cursor;  // Always restore to normal
  end;

  // ���������ꍇ listxml��temp�t�@�C���폜
  if ModalResult=mrOK then
  begin
    if FileExists(ExeDir+'listxml.tmp') then
      DeleteFile(ExeDir+'listxml.tmp');
    if FileExists(ExeDir+'listsourcefile.tmp') then
      DeleteFile(ExeDir+'listsourcefile.tmp');
  end;
  //

  timer1.Enabled:=False;
  Form2.Hide;
  Label4.Caption:='';
  Edit2.Enabled:=True;
  Button3.Enabled:=True;
  BtnOK.Enabled:=True;

end;


// listxml����̃f�[�^���o
function ExtractListXML : boolean;

type //
  PListInfo = ^TListInfo;
  TListInfo = record

    ZipName : string;     // Zip��
    DescE   : string;     // �p�ꖼ
    Maker   : string;     // ���[�J�[
    Year    : string;     // �����N

    CloneOf : string;     // �}�X�^��
    MasterID: integer;    // �}�X�^��ID
    Master  : boolean;    // �}�X�^

    RomOf   : string;     //  RomOf

    SampleOf: string;     // �T���v����

    Vector  : boolean;    // �x�N�^�[
    LightGun: boolean;    // �����e
    Analog  : boolean;    // �A�i���O����
    Status  : boolean;    // �X�e�[�^�X Good=True
    Channels: integer;    // �T�E���h�`�����l����
    Vertical: boolean;    // �c���

    CPUs    : string;     // CPUs
    Sounds  : string;     // Sound chips
    Screens : string;     // ��ʏ��
    NumScreens: integer;  // ��ʐ�
    Palettesize :integer; // �F��
    ResX    : Word;       // �𑜓xX
    ResY    : Word;       // �𑜓xY
    ScanRate: string;     // �X�L�������[�g
    Color   : TGameStatus;// �F�X�e�[�^�X
    Sound   : TGameStatus;// ���X�e�[�^�X
    GFX     : TGameStatus;// GFX�X�e�[�^�X
    Protect : TGameStatus;// �v���e�N�g�X�e�[�^�X
    Cocktail: TGameStatus;// �J�N�e���X�e�[�^�X
    SaveState:TGameStatus;// �Z�[�u�X�e�[�g
    Source  : string;     // �\�[�X�t�@�C��
    CHD     : string;     // CHD
    CHDOnly : boolean;    // CHD�݂̂̃Q�[��
    CHDMerge: boolean;    // CHD�̃}�[�W�w�肠��
    LD      : boolean;    // ���[�U�[�f�B�X�N
    CHDNoDump: boolean;   // CHD���z���o��
    isMechanical: boolean;// ���J�j�J���Q�[��

    Flag    : boolean;    // �ėp
end;

type
  TMakerList = record
    Maker : string;  // ������
    Count : integer; // �J�E���g
    Clone : boolean; //
end;


  function AscSort(Item1, Item2: Pointer): Integer;
  begin
    Result := CompareText(PListInfo(Item1).ZipName, PListInfo(Item2).ZipName);
  end;

var
  ListInfo : TList;
  NewItem : PListInfo;

  MakerList: array of TMakerList;
  F1 : TextFile;
  St,S,S2,Years,CPUs,Sounds: string;
  CPU   : array of string;
  Audio : array of string;
  Screen: array of string;
  w,h: string;
  r: real;
  i,j,ii: integer;
  StrList,SL: TStringList;
  CPUList,SoundList: TStringList;
  Clock,Count: integer;

  Rec : TSearchRec; // �t�@�C���T�C�Y�擾�p
  fs : Single;

  sltRes  :  TStringList;


begin



  Form2.Label4.Caption:='�f�[�^��͒�...';
  Application.ProcessMessages;

  // �t�@�C�������邩
  if FileExists(ExeDir+'listxml.tmp')=False then
  begin
    result:=False;
    exit;
  end;

  // �t�@�C���T�C�Y�`�F�b�N
  fs:=0;
  if FindFirst(ExeDir+'listxml.tmp', faAnyFile, Rec) = 0 then
  begin
    fs:= Rec.Size / 1024; // KB�ɕϊ�
  end;
  FindClose(Rec);

  if fs<=10 then // 10kB�ȉ��Ȃ�
  begin
    result:=False;
    exit;
  end;

  AssignFile(F1, ExeDir+'listxml.tmp', CP_UTF8);
  Reset(F1);
  
  try
  
    ListInfo:=TList.Create;

    CPUList:=TStringList.Create;
    CPUList.Duplicates:=dupIgnore;
    CPUList.Sorted:=True;

    SoundList:=TStringList.Create;
    SoundList.Duplicates:=dupIgnore;
    SoundList.Sorted:=True;

    while not Eof(F1) do
    begin

      ReadLn(F1,St);
//      St:=Utf8ToString(uSt);

      // MAME�̃o�[�W����
      if Pos('<mame build=',St)<>0 then
      begin
        DatVersion:=ExtractXML('build',St);

        // �o�[�W�����Ɋ��ʂ�����΍폜
        if (Pos('(',DatVersion)<>0) then
        begin
          DatVersion := Copy( DatVersion, 1, Pos('(',DatVersion)-1 );
        end;

      end;


      // �n��
      if ( (Copy(St,1,6)=#9+'<game') and
           (Pos('runnable="no"',St)=0) and
           (Pos('isbios="yes"',St)=0) ) // bios����Ȃ� (0.117u2)
         or (
           (Copy(St,1,6)=#9+'<mach') and
           (Pos('runnable="no"',St)=0) and
           (Pos('isbios="yes"',St)=0) ) // bios����Ȃ� (0.117u2)

         then
      begin

        // ������
        New(NewItem);
        SetLength(CPU,0);
        SetLength(Audio,0);
        SetLength(Screen,0);

        NewItem.ZipName     :='';
        NewItem.DescE       :='';
        NewItem.Maker       :='';
        NewItem.Year        :='????';
        NewItem.CloneOf     :='';
        NewItem.RomOf       :='';
        NewItem.MasterID    :=-1;
        NewItem.Master      :=True;
        NewItem.SampleOf    :='';
        NewItem.Vector      :=False;
        NewItem.LightGun    :=False;
        NewItem.Analog      :=False;
        NewItem.Status      :=False;
        NewItem.Vertical    :=False;
        NewItem.Channels    :=0;
        NewItem.ResX        :=0;
        NewItem.ResY        :=0;
        NewItem.CPUs        :='';
        NewItem.Sounds      :='--';
        NewItem.Screens     :='--';
        NewItem.NumScreens  :=0;
        NewItem.Source      :='';
        NewItem.Palettesize :=0;
        NewItem.Sound       :=gsUnknown;
        NewItem.Color       :=gsUnknown;
        NewItem.GFX         :=gsUnknown;
        NewItem.Protect     :=gsUnknown;
        NewItem.Cocktail    :=gsUnknown;
        NewItem.SaveState   :=gsUnknown;
        NewItem.Flag        :=False;
        NewItem.CHD         :='';
        NewItem.CHDOnly     :=True;
        NewItem.CHDMerge    :=False;
        NewItem.LD          :=False;
        NewItem.CHDNoDump   :=False;
        NewItem.isMechanical:=False;

        /// ZIP name
        if pos('name=',St)<>0 then
        begin
          NewItem.ZipName:=ExtractXML('name',St);
        end;

        /// CloneOf
        if pos('cloneof=',St)<>0 then
        begin
          NewItem.CloneOf:=ExtractXML('cloneof',St);
          NewItem.Master:=False;
        end;

        /// RomOf
        if pos('romof=',St)<>0 then
        begin
          NewItem.RomOf:=ExtractXML('romof',St);
        end;

        /// SampleOf
        if pos('sampleof=',St)<>0 then
        begin
          NewItem.SampleOf:=ExtractXML('sampleof',St);
        end;

        /// Source File (new format from 0.85)
        if pos('sourcefile=',St)<>0 then
        begin
          NewItem.Source:=ExtractXML('sourcefile',St);
        end;

        /// isMechanical
        if pos('ismechanical="yes"',St)<>0 then
        begin
          NewItem.isMechanical:=True;
        end;


        ReadLn(F1,St);

        while ( (St<>#9+'</game>') and (St<>#9+'</machine>') ) do
        begin

          /// Description-E
          if Copy(St,1,7)=#9#9+'<desc' then
          begin
            i:=Pos('>',St)+1;
            NewItem.DescE:=NormalizeString(Copy(St,i,PosEx('<',St,i)-i));
            // update: TAB�����������Ă�ꍇ��菜��

            NewItem.DescE := StringReplace(NewItem.DescE, #9, ' ', [ rfReplaceAll ]);

          end
          else
          /// Year
          if Copy(St,1,7)=#9#9+'<year' then
          begin
            i:=Pos('>',St)+1;
            NewItem.Year:=Copy(St,i,PosEx('<',St,i)-i);
          end
          else
          /// Maker
          if Copy(St,1,7)=#9#9+'<manu' then
          begin
            i:=Pos('>',St)+1;
            NewItem.Maker:=NormalizeString(Copy(St,i,PosEx('<',St,i)-i));
          end
          else
          /// ROM
          if (Copy(St,1,6)=#9#9+'<rom') and (NewItem.CHDOnly) then
          begin
            if (Pos('merge"=',St)<>0) then
              NewItem.CHDOnly:=False;
          end
          else
          /// Sound Channels
          if Copy(St,1,6)=#9#9+'<sou' then
          begin
            NewItem.Channels:=StrtoInt(ExtractXML('channels',St));
          end
          else
          /// CHD
          if Copy(St,1,7)=#9#9+'<disk' then
          begin
            NewItem.CHD:=ExtractXML('name',St);

            // CHDMerge
            if ExtractXML('merge',St)<>'' then
              NewItem.CHDMerge:=True;

            // LD
            if ExtractXML('region',St)='laserdisc' then
              NewItem.LD:=True;

            // CHDNoDump
            if ExtractXML('status',St)='nodump' then
              NewItem.CHDNoDump:=True;

          end
          else
          /// Control
          if Copy(St,1,11)=#9#9#9+'<control' then
          begin
            if pos('lightgun',St)<>0 then
              NewItem.LightGun:=True;

            if (pos('dial',St)<>0) or (pos('paddle',St)<>0) or
               (pos('stick',St)<>0) or (pos('trackball',St)<>0) then
              NewItem.Analog:=True;

          end
          else

          // �e�Z�b�g�̃T���v���`�F�b�N
          if pos('sample name',St)<>0 then
          begin

            if NewItem.SampleOf='' then
              NewItem.SampleOf:=NewItem.ZipName;

          end
          else

          /// <driver>
          if Copy(St,1,5)=#9#9+'<dr' then
          begin

            if pos('emulation="good"',St)<>0 then
            begin
              NewItem.Status:=True;
            end;

            // Color
            if pos('color="good"',St)<>0 then
            begin
              NewItem.Color:=gsGood;
            end
            else
            if pos('color="preliminary"',St)<>0 then
            begin
              NewItem.Color:=gsPreliminary;
            end
            else
            if pos('color="imperfect"',St)<>0 then
            begin
              NewItem.Color:=gsImperfect;
            end;

            // Sound
            if pos('sound="good"',St)<>0 then
            begin
              NewItem.Sound:=gsGood;
            end
            else
            if pos('sound="preliminary"',St)<>0 then
            begin
              NewItem.Sound:=gsPreliminary;
            end
            else
            if pos('sound="imperfect"',St)<>0 then
            begin
              NewItem.Sound:=gsImperfect;
            end;

            // GFX
            if pos('graphic="good"',St)<>0 then
            begin
              NewItem.GFX:=gsGood;
            end
            else
            if pos('graphic="',St)<>0 then
            begin
              NewItem.GFX:=gsImperfect;
            end;

            // Protection
            if pos('protection="preliminary"',St)<>0 then
            begin
              NewItem.Protect:=gsPreliminary;
            end;

            // Cocktail
            if (pos('cocktail="preliminary"',St)<>0) then
            begin
              NewItem.Cocktail:=gsPreliminary;
            end;

            // Save State
            if pos('savestate="supported"',St)<>0 then
            begin
              NewItem.SaveState:=gsGood;
            end
            else
            if pos('savestate="unsupported"',St)<>0 then
            begin
              NewItem.SaveState:=gsPreliminary;
            end;

            // Palette Size
            if (pos('palettesize',St)<>0) then
            begin
              NewItem.Palettesize:=StrtoInt(ExtractXML('palettesize',St));
            end;

          end
          else
          /// <feature   // �V�����e��X�e�[�^�X�ւ̑Ή�
          if Copy(St,1,10)=#9#9+'<feature' then
          begin

            // Sound
            if pos('"sound" status="unemulated"',St)<>0 then
            begin
              NewItem.Sound:=gsPreliminary;
            end
            else
            if pos('"sound" status="imperfect"',St)<>0 then
            begin
              NewItem.Sound:=gsImperfect;
            end
            else
            // GFX
            if pos('"graphics" status="imperfect"',St)<>0 then
            begin
              NewItem.GFX:=gsImperfect;
            end
            else
            if pos('"graphics" status="unemulated"',St)<>0 then
            begin
              NewItem.GFX:=gsPreliminary;
            end
            else
            // Protection
            if pos('"protection" status="unemulated"',St)<>0 then
            begin
              NewItem.Protect:=gsPreliminary;
            end
            else
            if pos('"protection" status="imperfect"',St)<>0 then
            begin
              NewItem.Protect:=gsImperfect;
            end
            else
            // Color
            if pos('"palette" status="unemulated"',St)<>0 then
            begin
              NewItem.Color:=gsPreliminary;
            end
            else
            if pos('"palette" status="imperfect"',St)<>0 then
            begin
              NewItem.Color:=gsImperfect;
            end


          end
          else

          /// <chip type="cpu">
          if Copy(St,1,18)=#9#9+'<chip type="cpu"' then
          begin

            S:=ExtractXML('name',St);
            S2:=ExtractXML('tag',St);

            SetLength(CPU, Length(CPU)+1);

            // CPU���X�g
            CPUList.Add(S);

            Clock:=StrtoInt(ExtractXML('clock',St));

            if Clock < 1000000 then
              S := S+ FormatFloat(' @ #.### KHz', Clock / 1000)
            else
              S := S+ FormatFloat(' @ #.###### MHz', Clock / 1000000);


            // Sound�pCPU
            if S2='soundcpu' then
              S:= S+' (sound)'
            else
            if S2='audiocpu' then
              S:= S+' (audio)'
            else
            // ���C��CPU
            if S2='maincpu' then
              S:= S+' (main)'
            else
            // ���̑���CPU
            if trim(S2)<>'' then
              S:= S+' ('+S2+')';


            CPU[Length(CPU)-1]:=S;


          end
          else
          // <chip type="audio">
          if Copy(St,1,18)=#9#9+'<chip type="audi' then
          begin

            S:=ExtractXML('name',St);

            // autio�R���|�[�l���g��Speaker�̏ꍇ������
            if S<>'Speaker' then
            begin

              SetLength(Audio, Length(Audio)+1);

              // Sound�`�b�v���X�g�ɒǉ�
              SoundList.Add(S);

              if pos('clock',St)<>0 then  // clock������ꍇ
              begin

                Clock:=StrtoInt(ExtractXML('clock',St));

                if Clock < 1000000 then
                  S := S + FormatFloat(' @ #.### KHz', Clock / 1000)
                else
                  S := S + FormatFloat(' @ #.###### MHz', Clock / 1000000);

              end;

              Audio[Length(Audio)-1]:=S;
            end;

          end
          else

          // screens v0.106u12
          if (pos('<display ',St)<>0) then
          begin

            w:='';
            h:='';

            // Vector
            if pos('vector',St)<>0 then
            begin
              NewItem.Vector:=True;
            end;

            // Vertical Screen
            if (ExtractXML('rotate',St)='90') or (ExtractXML('rotate',St)='270') then
            begin
              NewItem.Vertical:=True;
              w:=ExtractXML('height',St);
              h:=ExtractXML('width',St);
            end
            else
            begin
              w:=ExtractXML('width',St);
              h:=ExtractXML('height',St);
            end;

            r:=StrtoFloat(ExtractXML('refresh',St));

            SetLength(Screen, Length(Screen)+1);

            if NewItem.Vector then
            begin
                Screen[Length(Screen)-1]:=FormatFloat('Vector @ #.###### Hz', r)
            end
            else
            begin
              Screen[Length(Screen)-1]:= w+'x'+h+FormatFloat(' @ #.###### Hz', r);

              if NewItem.ResX=0 then
              begin
                NewItem.ResX:=StrtoInt(w);
                NewItem.ResY:=StrtoInt(h);
              end;

            end;

            Inc(NewItem.NumScreens);

            //

          end;

//          ReadLn(F1,uSt);   // utf-8�œǂݍ���
//          St:=Utf8ToString(uSt);
          ReadLn(F1,St);

        end;

        // CPU�܂Ƃ�
        St:='';
        for ii:=1 to Length(CPU) do
        begin
          Count:=1;
          for j:=ii+1 to Length(CPU) do
          begin
            if CPU[ii-1] = CPU[j-1] then
            begin
              CPU[j-1]:='';
              Inc(Count);
            end;
          end;

          if CPU[ii-1]<>'' then
          begin
            if Count=1 then
              St:=St+','+ CPU[ii-1]
            else
              St:=St+','+ InttoStr(Count)+' x '+ CPU[ii-1];
          end;

        end;

        NewItem.CPUs := AnsiReplaceText( Copy(St,2,Length(St)),'__big_',' (big)');
        NewItem.CPUs := AnsiReplaceText( NewItem.CPUs, '__little_', ' (little)');
        NewItem.CPUs := AnsiReplaceText( NewItem.CPUs, '_', ' ');

        NewItem.CPUs := AnsiReplaceText( NewItem.CPUs , '&quot;', '"');
        NewItem.CPUs := AnsiReplaceText( NewItem.CPUs , '&amp;', '&');
        NewItem.CPUs := AnsiReplaceText( NewItem.CPUs , '&lt;', '<');
        NewItem.CPUs := AnsiReplaceText( NewItem.CPUs , '&gt;', '>');


        NewItem.Maker:=AnsiReplaceText(NewItem.Maker,'&#233;','e');

        if (NewItem.Maker='unknown') then
            NewItem.Maker:='<unknown>';
        if (NewItem.Maker='Unknown') then
            NewItem.Maker:='<unknown>';


        // Sounds�܂Ƃ�
        St:='';
        for ii:=1 to Length(Audio) do
        begin
          Count:=1;
          // �d�����폜
          for j:=ii+1 to Length(Audio) do
          begin
            if Audio[ii-1] = Audio[j-1] then
            begin
              Audio[j-1]:='';
              Inc(Count);
            end;
          end;

          if Audio[ii-1]<>'' then
          begin
            if Count=1 then
              St:=St+','+ Audio[ii-1]
            else
              St:=St+','+ InttoStr(Count)+' x '+ Audio[ii-1];
          end;
        end;

        if st<>'' then
        begin
          NewItem.Sounds:=AnsiReplaceText(Copy(St,2,Length(St)),'_',' ');

          NewItem.Sounds := AnsiReplaceText( NewItem.Sounds , '&quot;', '"');
          NewItem.Sounds := AnsiReplaceText( NewItem.Sounds , '&amp;', '&');
          NewItem.Sounds := AnsiReplaceText( NewItem.Sounds , '&lt;', '<');
          NewItem.Sounds := AnsiReplaceText( NewItem.Sounds , '&gt;', '>');

        end;

        
        // Screen�܂Ƃ�
        St:='';

        for ii:=1 to Length(Screen) do
        begin
          Count:=1;
          for j:=ii+1 to Length(Screen) do
          begin
            if Screen[ii-1] = Screen[j-1] then
            begin
              Screen[j-1]:='';
              Inc(Count);
            end;
          end;

          if Screen[ii-1]<>'' then
          begin
            if Count=1 then
              St:=St+','+ Screen[ii-1]
            else
              St:=St+','+ InttoStr(Count)+' x '+ Screen[ii-1];
          end;
        end;

        S:='';
        if NewItem.Vector then
          S:='�x�N�^�C'
        else
          S:='���X�^�C';

        if NewItem.Vertical then
          S:=S+'�c�\���C'
        else
          S:=S+'���\���C';

        if (not NewItem.Vector) and (NewItem.Palettesize<>0) then
          S:=S+InttoStr(NewItem.Palettesize)+'�F�C';

        if NewItem.NumScreens>0 then
        begin
          S:=S+InttoStr(NewItem.NumScreens)+'���';
          NewItem.Screens:=S+St;
        end
        else
        begin
          NewItem.Screens:='--';
        end;


        ListInfo.Add(NewItem);

      end;

      // �I���
      Application.ProcessMessages;

    end;
                                      
  finally
    CloseFile(F1);

  end;

  // ���ڂ�������Ɠǂݍ��܂ꂽ��
  if ListInfo.Count=0 then
  begin
    result:=False;
    exit;
  end;

  // Zip�������ŕ��בւ�
  ListInfo.Sort(@AscSort);

  // �}�X�^ID�̌���
  Form2.Label4.Caption:='�}�X�^������...';
  Application.ProcessMessages;

  for i:=0 to ListInfo.Count-1 do
  begin
    Application.ProcessMessages;

    if PListInfo(ListInfo[i]).CloneOf<>'' then
    begin
      for j:=0 to ListInfo.Count-1 do
      begin
        if (PListInfo(ListInfo[j]).Master) and
           (PListInfo(ListInfo[i]).CloneOf=PListInfo(ListInfo[j]).ZipName) then
        begin
          PListInfo(ListInfo[i]).MasterID:=j;
          break;
        end;
      end;
    end
    else
    begin
      PListInfo(ListInfo[i]).MasterID:=i;
    end;
  end;


  ///
  Form2.Label4.Caption:='���[�J�[���̍i�荞��...';
  Application.ProcessMessages;


  // �S���o���o���ɂ���
  StrList:=TStringList.Create;
  SL:=TStringList.Create;

  for i:=0 to ListInfo.Count-1 do
  begin

    // license���
    St:=AnsiReplaceStr(PListInfo(ListInfo[i]).Maker,' license','');
    // licence���
    St:=AnsiReplaceStr(St,' licence','');
    // licensed from���
    St:=AnsiReplaceStr(St,'licensed from ','');
    // ?�����
    St:=AnsiReplaceStr(St,'?','');
    // , supported by
    St:=AnsiReplaceStr(St,', supported by ',#9);
    // , distributed by
    St:=AnsiReplaceStr(St,', distributed by ',#9);
    // �u+�v���utab�v��
    //St:=AnsiReplaceStr(St,'+',#9);
    // �u[�v�����
    St:=AnsiReplaceStr(St,'[','');
    // �u)�v�����
    St:=AnsiReplaceStr(St,')','');
    // �u(�v���utab�v��
    St:=AnsiReplaceStr(St,'(',#9);
    // �u]�v���utab�v��
    St:=AnsiReplaceStr(St,']',#9);
    // �u / �v���utab�v��
    St:=AnsiReplaceStr(St,' / ',#9);
    // �u/�v���utab�v��
    St:=AnsiReplaceStr(St,'/',#9);
    // �utab tab�v���utab�v��
    St:=AnsiReplaceStr(St,#9+' '+#9,#9);

    // �u<unknown>�v���uzzz<unknown>�v��
    St:=AnsiReplaceStr(St,'<unknown>','zzz<unknown>');
    // �u????�v���uzzz<unknown>�v��
    St:=AnsiReplaceStr(St,'????','zzz<unknown>');


    SL.Clear;
    Application.ProcessMessages;


    for j:=0 to TsvSeparate(St,SL)-1 do
    begin
      if SL[j]='Ameri' then SL[j]:='Ameri_';
      if SL[j]='Soft' then SL[j]:='Soft_';

      StrList.Add(Trim(SL[j]));

    end;

  end;


  StrList.Sort;

  // �d�����J�E���g
  for i:=0 to StrList.Count-1 do
  begin
    if StrList[i]<>'' then
    begin

      ii:=1;
      for j:=i+1 to StrList.Count-1 do
      begin
        if StrList[i]=StrList[j] then
        begin
          inc(ii);
          StrList[j]:='';
        end;
      end;
      SetLength(MakerList,Length(MakerList)+1);
      MakerList[Length(MakerList)-1].Maker:=StrList[i];
      MakerList[Length(MakerList)-1].Count:=ii;
    end;
  end;

  // ��ݍ���
  for i:=0 to Length(MakerList)-1 do
  begin
    if MakerList[i].Clone=False then
    begin
      for j:=0 to Length(MakerList)-1 do
      begin
        if (i<>j) and
           (pos(MakerList[i].Maker+' ', MakerList[j].Maker+' ')<>0) then
        begin
          Inc(MakerList[i].Count,MakerList[j].Count);
          MakerList[j].Clone:=True;
        end;
      end;
    end;
  end;


  // ��s�ɂ܂Ƃ߂�
  St:='';
  for i:=1 to Length(MakerList)-1 do
  begin

    if (MakerList[i].Clone=false) and (MakerList[i].Count>=MAKER) then
    begin

      if MakerList[i].Maker='zzz<unknown>' then
        MakerList[i].Maker:='<unknown>';

      St:=St+MakerList[i].Maker+#9;
    end;
  end;

  St:=Trim(St);
  FreeAndNil(SL);
  FreeAndNil(StrList);
  SetLength(MakerList,0);


  /// �N��ꗗ
  StrList:=TStringList.Create;
  StrList.Duplicates:=dupIgnore; // �d���ǉ����Ȃ�
  StrList.Sorted:=True;
  for i:=0 to ListInfo.Count-1 do
  begin
    StrList.Add(PListInfo(ListInfo[i]).Year);
  end;

  // ????�����Ɏ����Ă���
  StrList.Sorted:=False;
  if StrList[0]='????' then
     StrList.Move(0,StrList.Count-1);

  Years:=StrList[0];
  for i:=1 to StrList.Count-1 do
  begin
    Years:=Years+#9+StrList[i];
  end;
  FreeAndNil(StrList);
  
  /// CPUs�ꗗ
  CPUs:=CPUList[0];
  for i:=1 to CPUList.Count-1 do
  begin
    CPUs:=CPUs+#9+CPUList[i];
  end;
  FreeAndNil(CPUList);
  CPUs:=AnsiReplaceText(CPUs,'__big_',' (big)');
  CPUs:=AnsiReplaceText(CPUs,'__little_',' (little)');
  CPUs:=AnsiReplaceText(CPUs,'_',' ');

  CPUs := AnsiReplaceText( CPUs , '&quot;', '"');
  CPUs := AnsiReplaceText( CPUs , '&amp;', '&');
  CPUs := AnsiReplaceText( CPUs , '&lt;', '<');
  CPUs := AnsiReplaceText( CPUs , '&gt;', '>');

  /// Sound�`�b�v�ꗗ
  Sounds:=SoundList[0];
  for i:=1 to SoundList.Count-1 do
  begin
    Sounds:=Sounds+#9+SoundList[i];
  end;
  SoundList.Free;
  Sounds:=AnsiReplaceText(Sounds,'_',' ');

  ////
  /// �o��
  Form2.Label4.Caption:='���\�[�X�t�@�C���o�͒�...';
  Application.ProcessMessages;

  sltRes := TStringList.Create;

  // �o�[�W����
  sltRes.Add('ResVersion='+BUILDNO);

  if DatVersion<>'' then
    sltRes.Add('version='+DatVersion);

  // ���[�J�[��
  sltRes.Add(St);

  // �N��
  sltRes.Add(Years);

  // CPUs
  sltRes.Add(CPUs);

  // Sounds
  sltRes.Add(Sounds);

  // �Q�[�����
  for i:=0 to ListInfo.Count-1 do
  begin
    St:=
      PListInfo(ListInfo[i]).ZipName+#9+                  // Zip��
      PListInfo(ListInfo[i]).DescE+#9+                    // �p�ꖼ
      PListInfo(ListInfo[i]).Maker+#9+                    // ���[�J�[
      PListInfo(ListInfo[i]).Year+#9+                     // �����N
      PListInfo(ListInfo[i]).CloneOf+#9+                  // �}�X�^��
      PListInfo(ListInfo[i]).RomOf+#9+                    // RomOf
      PListInfo(ListInfo[i]).SampleOf+#9+                 // �T���v����
      InttoStr(PListInfo(ListInfo[i]).MasterID)+#9+       // �}�X�^��ID
      BoolToStr(PListInfo(ListInfo[i]).Master)+#9+        // �}�X�^
      BoolToStr(PListInfo(ListInfo[i]).Vector)+#9+        // �x�N�^�[
      BoolToStr(PListInfo(ListInfo[i]).Lightgun)+#9+      // �����e
      BoolToStr(PListInfo(ListInfo[i]).Analog)+#9+        // �A�i���O����
      BooltoStr(PListInfo(ListInfo[i]).Status)+#9+        // �X�e�[�^�X Good=True
      BooltoStr(PListInfo(ListInfo[i]).Vertical)+#9+      // �c���
      InttoStr(PListInfo(ListInfo[i]).Channels)+#9+       // �T�E���h�`�����l����
      PListInfo(ListInfo[i]).CPUs+#9+                     // CPUs
      PListInfo(ListInfo[i]).Sounds+#9+                   // Sound chips
      PListInfo(ListInfo[i]).Screens+#9+                  // ��ʏ��
      InttoStr(PListInfo(ListInfo[i]).NumScreens)+#9+     // ��ʐ�
      InttoStr(PListInfo(ListInfo[i]).Palettesize)+#9+    // �F��
      InttoStr(PListInfo(ListInfo[i]).ResX)+#9+           // �𑜓xX
      InttoStr(PListInfo(ListInfo[i]).ResY)+#9+           // �𑜓xY

      InttoStr(Ord(PListInfo(ListInfo[i]).Color))+#9+     // �F�X�e�[�^�X
      InttoStr(Ord(PListInfo(ListInfo[i]).Sound))+#9+     // ���X�e�[�^�X
      InttoStr(Ord(PListInfo(ListInfo[i]).GFX))+#9+       // GFX�X�e�[�^�X
      InttoStr(Ord(PListInfo(ListInfo[i]).Protect))+#9+   // �v���e�N�g�X�e�[�^�X
      InttoStr(Ord(PListInfo(ListInfo[i]).Cocktail))+#9+  // �J�N�e�����[�h�X�e�[�^�X
      InttoStr(Ord(PListInfo(ListInfo[i]).SaveState))+#9+ // �Z�[�u�X�e�[�g
      PListInfo(ListInfo[i]).Source+#9+                   // �\�[�X�t�@�C��
      PListInfo(ListInfo[i]).CHD+#9+                      // CHD
      BoolToStr(PListInfo(ListInfo[i]).CHDOnly)+#9+       // CHD�̂�
      BoolToStr(PListInfo(ListInfo[i]).CHDMerge)+#9+      // CHD�}�[�W�w�肠��
      BoolToStr(PListInfo(ListInfo[i]).LD)+#9+            // ���[�U�[�f�B�X�N
      BoolToStr(PListInfo(ListInfo[i]).CHDNoDump)+#9+     // CHD���z���o��
      BoolToStr(PListInfo(ListInfo[i]).isMechanical);     // ���J�j�J���Q�[��
      sltRes.Add(St);
  end;

  try
    sltRes.SaveToFile(ExeDir+RESNAME, TEncoding.UTF8);

  except
    on E: EFCreateError do
    begin
      ListInfo.Clear;
      ListInfo.Free;
      sltRes.Free;

      Application.MessageBox('���\�[�X�t�@�C���������ݎ��s�B',APPNAME, MB_ICONSTOP);
      exit;
    end;
  end;

  // TList�̊e���ڂ̃��������
  for i:= 0 to ListInfo.Count-1 do
    dispose(PListInfo(ListInfo[i]));

  ListInfo.Clear;
  ListInfo.Free;
  sltRes.Free;

  result:=True;

end;

procedure TForm2.Edit2Change(Sender: TObject);
begin

  btnOK.Enabled:=(FileExists(Edit2.Text));

end;

end.
