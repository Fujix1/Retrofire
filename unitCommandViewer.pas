unit unitCommandViewer;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, PngImage, strutils;


  const LINEHEIGHT = 18; // 一行の高さ
  const FONTSIZE = 10;   // フォントサイズ


// zip->コマンドリストインデックス
type
  TCommandIndex = record
    zip : string;
    idx : integer;
end;


type
  TfrmCommand = class(TForm)
    Panel1: TPanel;
    ScrollBox1: TScrollBox;
    Image1: TImage;
    Panel3: TPanel;
    chkP2: TCheckBox;
    chkZentoHan: TCheckBox;
    chkAlwaysOnTop: TCheckBox;
    chkAutoResize: TCheckBox;
    Panel4: TPanel;
    cmbCommandType: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure chkAlwaysOnTopClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cmbCommandTypeChange(Sender: TObject);
    procedure chkP2Click(Sender: TObject);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure Image1Click(Sender: TObject);
    procedure chkZentoHanClick(Sender: TObject);
  private
    { Private 宣言 }
    var
      datLoaded: boolean;
      Png: TPngImage;
      iconBitmap: TBitmap; // アイコン用ビットマップ

      commandList: TStringList; // コマンドリスト本体
      commandIndex: array of TCommandIndex; // zip->コマンドインデックス
      currentIndex: Integer; // 今表示中のコマンドインデックス　-1=なし

      commands: TStringList; // 今表示中の各コマンド群

      partialUpdate: boolean; // コマンド更新時のスクロール抑制

    function CsvSeparate(const Str: string; StrList: TStrings): Integer;
    function explode(cDelimiter,  sValue : string) : TStringList;
    function ZenToHan( fromText: String ): string;
    function NormalizeSpecialChars( fromText: String ): string;
    function DrawButton( dest: TCanvas; iconBitmap: TBitmap; destRect: TRect; st: string;  P2: boolean ): boolean;
    function DrawButton2( dest: TCanvas; iconBitmap: TBitmap; destRect: TRect; st: string;  P2: boolean ): boolean;
    procedure TextOut( pBitmap: TBitMap ; pText: string; P2:boolean );

    procedure SetCommand( pCommandText: string );

  public
    { Public 宣言 }
    var
      initialIndex: integer; // 選択インデックス初期値

    procedure LoadCommandDat( datDir: string );
    procedure LoadCommand( zipName: string; zipMaster: string );

  end;

var
  frmCommand: TfrmCommand;

implementation
  uses Unit1;

{$R *.dfm}


  //---------------------------------------------------
  function TfrmCommand.explode(cDelimiter,  sValue : string) : TStringList;
  var
    s : string; p : integer;
    sl: TStringList;

  begin
    s := sValue;

    sl := TStringList.Create;

    while length(s) > 0 do
    begin
      p := pos(cDelimiter,s);
      if ( p > 0 ) then
      begin
        sl.Add( copy(s,0,p-1) );
        s := copy(s,p + length(cDelimiter),length(s));
      end
      else
      begin
        sl.Add( s );
        s := '';
      end;
    end;

    result:= sl;
  end;

  //---------------------------------------------------
  function TfrmCommand.ZenToHan( fromText: String ): string;
  const
    Dis = $FEE0;
  var
    Str   : String;
    i     : Integer;
    AChar : Cardinal;
  begin

    Str := '';

    for i := 1 to Length( fromText ) do begin
      AChar := Ord(fromText[i]);
      if (AChar >= $FF01) and (AChar <= $FF5A) then
      begin
        Str := Str + Chr(AChar - Dis);
      end
      else
      begin
        Str := Str + fromText[i];
      end;
    end;

    Result := Str;
  end;


  //---------------------------------------------------
  function TfrmCommand.NormalizeSpecialChars( fromText: String ): string;
  begin

    fromText:= StringReplace( fromText,'@A-button', '_A', [ rfReplaceAll ] );
    fromText:= StringReplace( fromText,'@B-button', '_B', [ rfReplaceAll ] );
    fromText:= StringReplace( fromText,'@C-button', '_C', [ rfReplaceAll ] );
    fromText:= StringReplace( fromText,'@D-button', '_D', [ rfReplaceAll ] );

    fromText:= StringReplace( fromText,'@E-button', '^e', [ rfReplaceAll ] );
    fromText:= StringReplace( fromText,'@F-button', '^f', [ rfReplaceAll ] );
    fromText:= StringReplace( fromText,'@G-button', '^g', [ rfReplaceAll ] );
    fromText:= StringReplace( fromText,'@H-button', '^h', [ rfReplaceAll ] );
    fromText:= StringReplace( fromText,'@I-button', '^i', [ rfReplaceAll ] );
    fromText:= StringReplace( fromText,'@J-button', '^j', [ rfReplaceAll ] );
    fromText:= StringReplace( fromText,'@K-button', '^k', [ rfReplaceAll ] );
    fromText:= StringReplace( fromText,'@L-button', '^l', [ rfReplaceAll ] );
    fromText:= StringReplace( fromText,'@M-button', '^m', [ rfReplaceAll ] );
    fromText:= StringReplace( fromText,'@N-button', '^n', [ rfReplaceAll ] );
    fromText:= StringReplace( fromText,'@O-button', '^o', [ rfReplaceAll ] );
    fromText:= StringReplace( fromText,'@P-button', '^p', [ rfReplaceAll ] );
    fromText:= StringReplace( fromText,'@Q-button', '^q', [ rfReplaceAll ] );
    fromText:= StringReplace( fromText,'@R-button', '^r', [ rfReplaceAll ] );
    fromText:= StringReplace( fromText,'@S-button', '^s', [ rfReplaceAll ] );
    fromText:= StringReplace( fromText,'@T-button', '^t', [ rfReplaceAll ] );
    fromText:= StringReplace( fromText,'@U-button', '^u', [ rfReplaceAll ] );
    fromText:= StringReplace( fromText,'@V-button', '^v', [ rfReplaceAll ] );
    fromText:= StringReplace( fromText,'@W-button', '^w', [ rfReplaceAll ] );
    fromText:= StringReplace( fromText,'@X-button', '^x', [ rfReplaceAll ] );
    fromText:= StringReplace( fromText,'@Y-button', '^y', [ rfReplaceAll ] );
    fromText:= StringReplace( fromText,'@Z-button', '^z', [ rfReplaceAll ] );


    fromText:= StringReplace( fromText,'@BALL',    '_5', [ rfReplaceAll ] );
    fromText:= StringReplace( fromText,'@start',   '_S', [ rfReplaceAll ] );
    fromText:= StringReplace( fromText,'@select',  '^S', [ rfReplaceAll ] );
    fromText:= StringReplace( fromText,'@punch',   '_P', [ rfReplaceAll ] );
    fromText:= StringReplace( fromText,'@kick',    '_K', [ rfReplaceAll ] );
    fromText:= StringReplace( fromText,'@guard',   '_G', [ rfReplaceAll ] );

    fromText:= StringReplace( fromText,'@L-punch', '^E', [ rfReplaceAll ] );
    fromText:= StringReplace( fromText,'@M-punch', '^F', [ rfReplaceAll ] );
    fromText:= StringReplace( fromText,'@S-punch', '^G', [ rfReplaceAll ] );

    fromText:= StringReplace( fromText,'@L-kick',  '^H', [ rfReplaceAll ] );
    fromText:= StringReplace( fromText,'@M-kick',  '^I', [ rfReplaceAll ] );
    fromText:= StringReplace( fromText,'@S-kick',  '^J', [ rfReplaceAll ] );

    fromText:= StringReplace( fromText,'@3-kick',  '^T', [ rfReplaceAll ] );
    fromText:= StringReplace( fromText,'@3-punch', '^U', [ rfReplaceAll ] );
    fromText:= StringReplace( fromText,'@2-kick',  '^V', [ rfReplaceAll ] );
    fromText:= StringReplace( fromText,'@2-punch', '^W', [ rfReplaceAll ] );

    fromText:= StringReplace( fromText,'@hcb', '_k', [ rfReplaceAll ] );
    fromText:= StringReplace( fromText,'@huf', '_l', [ rfReplaceAll ] );
    fromText:= StringReplace( fromText,'@hcf', '_m', [ rfReplaceAll ] );
    fromText:= StringReplace( fromText,'@hub', '_n', [ rfReplaceAll ] );
    fromText:= StringReplace( fromText,'@qfd', '_o', [ rfReplaceAll ] );
    fromText:= StringReplace( fromText,'@qdb', '_p', [ rfReplaceAll ] );
    fromText:= StringReplace( fromText,'@qbu', '_q', [ rfReplaceAll ] );
    fromText:= StringReplace( fromText,'@quf', '_r', [ rfReplaceAll ] );
    fromText:= StringReplace( fromText,'@qbd', '_s', [ rfReplaceAll ] );
    fromText:= StringReplace( fromText,'@qdf', '_t', [ rfReplaceAll ] );
    fromText:= StringReplace( fromText,'@qfu', '_u', [ rfReplaceAll ] );
    fromText:= StringReplace( fromText,'@qub', '_v', [ rfReplaceAll ] );
    fromText:= StringReplace( fromText,'@fdf', '_w', [ rfReplaceAll ] );
    fromText:= StringReplace( fromText,'@fub', '_x', [ rfReplaceAll ] );
    fromText:= StringReplace( fromText,'@fuf', '_y', [ rfReplaceAll ] );
    fromText:= StringReplace( fromText,'@fdb', '_z', [ rfReplaceAll ] );
    fromText:= StringReplace( fromText,'@xff', '_L', [ rfReplaceAll ] );
    fromText:= StringReplace( fromText,'@xbb', '_M', [ rfReplaceAll ] );
    fromText:= StringReplace( fromText,'@dsf', '_Q', [ rfReplaceAll ] );
    fromText:= StringReplace( fromText,'@dsb', '_R', [ rfReplaceAll ] );

    fromText:= StringReplace( fromText,'@decrease', '^-', [ rfReplaceAll ] );
    fromText:= StringReplace( fromText,'@increase', '^+', [ rfReplaceAll ] );

    Result := fromText;
  end;



  //---------------------------------------------------
  // ボタン文字を描画する
  function TfrmCommand.DrawButton( dest: TCanvas; iconBitmap: TBitmap; destRect: TRect; st: string;  P2: boolean ): boolean;
  // 置き換えされたら true

  var n: integer;
  begin

    n:=-1;


      {
      # 特殊キャラクタテキスト
      # ・             | _` |           |
      # ◎             | _@ |           |
      # ○             | _) |           |
      # ●             | _( |           |
      # ☆             | _* |           |
      # ★             | _& |           |
      # △             | _% |           |
      # ▲             | _$ |           |
      # 二重の四角     | _# |           |
      # □             | _] |           |
      # ■             | _[ |           |
      # ▽             | _{ |           |
      # ▼             | _ |           |
      # ◇             | _< |           |
      # ◆             | _> |           |

      # ＋             | _+ |           |
      # ・・・         | _. |           |
      # 矢印左下       | _1 |           |
      # 矢印下         | _2 |           |
      # 矢印右下       | _3 |           |
      # 矢印左         | _4 |           |
      # スティックのボール    | _5 | @BALL     |
      # 矢印右         | _6 |           |
      # 矢印左上       | _7 |           |
      # 矢印上         | _8 |           |
      # 矢印右上       | _9 |           |
      # ニュートラル   | _N |           |

      # 方向矢印の複合 (ショートハンド)
      # 下半回転右から左      | _k | @hcb      |※逆ヨガフレイムコマンド
      # 上半回転左から右      | _l | @huf      |
      # 下半回転左から右      | _m | @hcf      |※ヨガフレイムコマンド
      # 上半回転右から左      | _n | @hub      |
      # １／４回転右から下    | _o | @qfd      |
      # １／４回転下から左    | _p | @qdb      |※竜巻旋風脚コマンド
      # １／４回転左から上    | _q | @qbu      |
      # １／４回転上から右    | _r | @quf      |
      # １／４回転左から下    | _s | @qbd      |
      # １／４回転下から右    | _t | @qdf      |※波動拳コマンド
      # １／４回転右から上    | _u | @qfu      |
      # １／４回転  上から左  | _v | @qub      |
      # １回転下から時計回り  | _w | @fdf      |
      # １回転上から時計回り  | _x | @fub      |
      # １回転上から反時計回り| _y | @fuf      |
      # １回転下から反時計回り| _z | @fdb      |
      # 右＞右                | _L | @xff      |※ダッシュコマンド
      # 左＞左                | _M | @xbb      |※バックステップコマンド

      }

    if st='_+' then n:=0
    else if st='_.' then n:=1
    else if (st='_1') and P2 then n:=4
    else if st='_1' then n:=2
    else if st='_2' then n:=3
    else if (st='_3') and P2 then n:=2
    else if st='_3' then n:=4
    else if (st='_4') and P2 then n:=7
    else if st='_4' then n:=5
    else if st='_5' then n:=6
    else if (st='_6') and P2 then n:=5
    else if st='_6' then n:=7
    else if (st='_7') and P2 then n:=10
    else if st='_7' then n:=8
    else if st='_8' then n:=9
    else if (st='_9') and P2 then n:=8
    else if st='_9' then n:=10
    else if st='_N' then n:=11

    else if st='_A' then n:=40
    else if st='_B' then n:=41
    else if st='_C' then n:=42
    else if st='_D' then n:=43

    else if st='_P' then n:=66
    else if st='_K' then n:=67
    else if st='_G' then n:=68

    else if st='_a' then n:=30
    else if st='_b' then n:=31
    else if st='_c' then n:=32
    else if st='_d' then n:=33
    else if st='_e' then n:=34
    else if st='_f' then n:=35
    else if st='_g' then n:=36
    else if st='_h' then n:=37
    else if st='_i' then n:=38
    else if st='_j' then n:=39


    else if st='_Z' then n:=65


    else if (st='_m') and P2 then n:=14
    else if (st='_n') and P2 then n:=15
    else if (st='_k') and P2 then n:=16
    else if (st='_l') and P2 then n:=17
    else if (st='_s') and P2 then n:=18
    else if (st='_t') and P2 then n:=19
    else if (st='_u') and P2 then n:=20
    else if (st='_v') and P2 then n:=21
    else if (st='_o') and P2 then n:=22
    else if (st='_p') and P2 then n:=23
    else if (st='_q') and P2 then n:=24
    else if (st='_r') and P2 then n:=25
    else if (st='_z') and P2 then n:=26
    else if (st='_y') and P2 then n:=27
    else if (st='_x') and P2 then n:=28
    else if (st='_w') and P2 then n:=29
    else if (st='_M') and P2 then n:=12
    else if (st='_L') and P2 then n:=13



    else if st='_k' then n:=14
    else if st='_l' then n:=15
    else if st='_m' then n:=16
    else if st='_n' then n:=17
    else if st='_o' then n:=18
    else if st='_p' then n:=19
    else if st='_q' then n:=20
    else if st='_r' then n:=21
    else if st='_s' then n:=22
    else if st='_t' then n:=23
    else if st='_u' then n:=24
    else if st='_v' then n:=25
    else if st='_w' then n:=26
    else if st='_x' then n:=27
    else if st='_y' then n:=28
    else if st='_z' then n:=29
    else if st='_L' then n:=12
    else if st='_M' then n:=13
    else if st='_S' then n:=90

    else if st='_`' then n:=75
    else if st='_@' then n:=76
    else if st='_)' then n:=77
    else if st='_(' then n:=78
    else if st='_*' then n:=79
    else if st='_&' then n:=80
    else if st='_%' then n:=81
    else if st='_$' then n:=82
    else if st='_#' then n:=83
    else if st='_]' then n:=84
    else if st='_[' then n:=85
    else if st='_{' then n:=86
    else if st='_}' then n:=87
    else if st='_<' then n:=88
    else if st='_>' then n:=89;


      {
      # アルファベットボタン (NeoGeo用)
      # Aボタン        | _A | @A-button |
      # Bボタン        | _B | @B-button |
      # Cボタン        | _C | @C-button |
      # Dボタン        | _D | @D-button |
      # Eボタン        |    | @E-button |
      # Fボタン        |    | @F-button |
      # Gボタン        |    | @G-button |
      # Hボタン        |    | @H-button |
      # Iボタン        |    | @I-button |
      # Jボタン        |    | @J-button |
      # Kボタン        |    | @K-button |
      # Lボタン        |    | @L-button |
      # Mボタン        |    | @M-button |
      # Nボタン        |    | @N-button |
      # Oボタン        |    | @O-button |
      # Pボタン        |    | @P-button |
      # Qボタン        |    | @Q-button |
      # Rボタン        |    | @R-button |
      # Sボタン        | ^s | @S-button |
      # Tボタン        |    | @T-button |
      # Uボタン        |    | @U-button |
      # Vボタン        |    | @V-button |
      # Wボタン        |    | @W-button |
      # Xボタン        |    | @X-button |
      # Yボタン        |    | @Y-button |
      # Zボタン        | _Z | @Z-button |



      {
      #
      # 数字ボタン (Capcomと一般用)
      #  1ボタン       | _a |           |
      #  2ボタン       | _b |           |
      #  3ボタン       | _c |           |
      #  4ボタン       | _d |           |
      #  5ボタン       | _e |           |
      #  6ボタン       | _f |           |
      #  7ボタン       | _g |           |
      #  8ボタン       | _h |           |
      #  9ボタン       | _i |           |
      # 10ボタン       | _j |           |
      # ＋ボタン       |    | @decrease |
      # −ボタン        |    | @increase |


      # 特殊ボタン (NeoGeoとCapcom用)
      # スタート       | _S | @start    |
      # セレクト       | ^S | @select   |
      # パンチ         | _P | @punch    |
      # キック         | _K | @kick     |
      # ガード         | _G | @guard    |
      # 弱パンチ       | ^E | @L-punch  |
      # 中パンチ       | ^F | @M-punch  |
      # 強パンチ       | ^G | @S-punch  |
      # 弱キック       | ^H | @L-kick   |
      # 中キック       | ^I | @M-kick   |
      # 強キック       | ^J | @S-kick   |
      # キック３つ同時 | ^T | @3-kick   |
      # パンチ３つ同時 | ^U | @3-punch  |
      # キック２つ同時 | ^V | @2-kick   |
      # パンチ２つ同時 | ^W | @2-punch  |


      # 右＞下＞右下          | _Q | @dsf      |※昇竜拳コマンド
      # 左＞下＞左下          | _R | @dsb      |※逆昇竜拳コマンド


    }

    if n<>-1 then
    begin
      dest.CopyRect( destRect, iconBitmap.Canvas, rect(n*14,0,n*14+14,14));
      result := true;
    end
    else
    begin
      result := false;
    end;
  end;


  //---------------------------------------------------
  // ボタン文字を描画する
  function TfrmCommand.DrawButton2( dest: TCanvas; iconBitmap: TBitmap; destRect: TRect; st: string;  P2: boolean ): boolean;
  // 置き換えされたら true

    var n: integer;
  begin

    n:=-1;

    if st='^e' then n:=44
    else if st='^f' then n:=45
    else if st='^g' then n:=46
    else if st='^h' then n:=47
    else if st='^i' then n:=48
    else if st='^j' then n:=49
    else if st='^k' then n:=50
    else if st='^l' then n:=51
    else if st='^m' then n:=52
    else if st='^n' then n:=53
    else if st='^o' then n:=54
    else if st='^p' then n:=55
    else if st='^q' then n:=56
    else if st='^r' then n:=57
    else if st='^s' then n:=58
    else if st='^t' then n:=59
    else if st='^u' then n:=60
    else if st='^v' then n:=61
    else if st='^w' then n:=62
    else if st='^x' then n:=63
    else if st='^y' then n:=64
    else if st='^z' then n:=65

    else if st='^E' then n:=69
    else if st='^F' then n:=70
    else if st='^G' then n:=71
    else if st='^H' then n:=72
    else if st='^I' then n:=73
    else if st='^J' then n:=74
    else if st='^S' then n:=91
    else if st='^+' then n:=92
    else if st='^-' then n:=93;

    if n<>-1 then
    begin
      dest.CopyRect( destRect, iconBitmap.Canvas, rect(n*14,0,n*14+14,14));
      result := true;
    end
    else
    begin
      result := false;
    end;
  end;

  //---------------------------------------------------
  //
  procedure TfrmCommand.TextOut( pBitmap: TBitMap ; pText: string; P2:boolean );
  var

    i: integer;
    oSL: TStringList;
    rct: TRect;
    p,idx : integer;
    bytes : integer;

    FONTWIDTH: integer;

    penX, penY: integer;
    key: string;

    s: string;

  begin

    // 文字列ノーマライズ
    pText := NormalizeSpecialChars( pText );


    pBitmap.Canvas.TryLock;

    pBitmap.Canvas.Font.Name:= 'ＭＳ ゴシック';
    pBitmap.Canvas.Font.Size:= FONTSIZE;
    pBitmap.Canvas.Brush.Style := bsClear;
    pBitmap.Canvas.Brush.Color := $004D2A01;
    pBitmap.Canvas.Font.Color := $00FFFFFF;

    // 半角一文字の幅を計る
    FONTWIDTH := pBitmap.Canvas.TextExtent(' ').Width;

    // 全角→半角変換
    if chkZentoHan.Checked then
      pText := ZenToHan( pText );

    oSL := explode( #13#10, pText);

    // 文字描画領域RECT
    DrawText( pBitmap.Canvas.Handle, PChar(pText), Length(pText), rct,
    DT_CALCRECT or DT_EXPANDTABS or DT_NOPREFIX or DT_TOP or DT_EXTERNALLEADING );

    pBitmap.Width := rct.Width;
//    myBitmap.Height := rct.Height;  // 行間を広げるのでこの値は使わない
    pBitmap.Height := oSL.Count*LINEHEIGHT; // 行数×行高



    // 各行処理
    for i := 0 to oSL.Count-1 do
    begin

      // 文字出力
      pBitmap.Canvas.TextOut(
                        pBitmap.Canvas.PenPos.X,
                        pBitmap.Canvas.PenPos.Y,
                        oSL.Strings[i]
      );

      // ボタン類出力

      penY:= pBitmap.Canvas.PenPos.Y;

      p:=0;
      while( pos('_', oSL.Strings[i]) > 0 ) do
      begin

        idx:= pos('_', oSL.Strings[i]);

        if (idx>0) then
        begin

          key:= copy( oSL.Strings[i], idx, 2);

          if key<>'_' then
          begin
            bytes := Length( AnsiString( Copy( oSL.Strings[i], p, idx-1 )));
            penX := FONTWIDTH*bytes;
            rct := Rect( penX, penY, penX+14, penY+14 );

            if DrawButton( pBitmap.Canvas, iconBitmap, rct, key, P2 ) then
            begin
              // ボタンの置き換えがされたら
              oSL.Strings[i] := Copy( oSL.Strings[i], 1, idx-1 ) + '　'+ Copy( oSL.Strings[i], idx+2, Length( oSL.Strings[i]) );
            end
            else
            begin
              // されてないときは_をスペースに置き換え
              oSL.Strings[i] := Copy( oSL.Strings[i], 1, idx-1 ) + ' '+ Copy( oSL.Strings[i], idx+1, Length( oSL.Strings[i]) );
            end;
          end
          else
          begin
            // 行末の_をスペースに置き換え
            oSL.Strings[i] := Copy( oSL.Strings[i], 1, idx-1 ) + ' ';
          end;

        end;

      end;

      p:=0;
      while( pos('^', oSL.Strings[i]) >0 ) do
      begin

        idx:= pos('^', oSL.Strings[i]);
        if idx>0 then
        begin

          key:= copy( oSL.Strings[i], idx, 2);
          if key<>'^' then
          begin
            bytes := Length( AnsiString( Copy( oSL.Strings[i], p, idx-1 )));
            penX := FONTWIDTH*bytes;

            rct := Rect( penX, penY, penX+14, penY+14 );
            if DrawButton2( pBitmap.Canvas, iconBitmap, rct, key, P2 ) then
            begin
              // ボタンの置き換えがされたら
              oSL.Strings[i] := Copy( oSL.Strings[i], 1, idx-1 ) + '　'+ Copy( oSL.Strings[i], idx+2, Length( oSL.Strings[i]) );
            end
            else
            begin
              // されてないときは^を消す
              oSL.Strings[i] := Copy( oSL.Strings[i], 1, idx-1 ) + ' '+ Copy( oSL.Strings[i], idx+1, Length( oSL.Strings[i]) );
            end;
          end
          else
          begin
            // 行末の^をスペースに置き換え
            oSL.Strings[i] := Copy( oSL.Strings[i], 1, idx-1 ) + ' ';
          end;
        end;

      end;


      // 改行
      if i<oSL.Count then
      begin
        pBitmap.Canvas.MoveTo( 0, pBitmap.Canvas.PenPos.Y + LINEHEIGHT );
      end;
    end;



    pBitmap.Canvas.Unlock;
    oSL.Free;

  end;

// -----------------------------------------------------------------------------
// command.datを読み込む
procedure TfrmCommand.LoadCommandDat( datDir: string );
var
  CommandDatFile,StrList : TStringList;
  ExeDir: String;
//  ms: cardinal;
  i,j: integer;
  st: String;
  n,m: integer;
  buffer, cmd: String;
  CommandDir: String;
begin

//  ms :=GetTickCount;
  datLoaded:=false;


  ExeDir:=ExtractFilePath(Application.ExeName);

  CommandDatFile := TStringList.Create;


  if FileExists(datDir+'\command.dat') then
    CommandDir:=datDir+'\command.dat'
  else
  if ( FileExists( ExeDir+'command.dat') ) then
    CommandDir:= ExeDir+'\command.dat'
  else
  begin
    SetCommand('');
    commandList.Clear;
    datLoaded := false;
    currentIndex := -1;
    exit;
  end;


  commandDatFile.LoadFromFile( CommandDir, TEncoding.UTF8);
  n:=-1;

  for i := 0 to commandDatFile.Count-1 do
  begin

    if AnsiStartsStr( '$info', CommandDatFile[i] ) then
    begin

      // ここまでのバッファをコマンドに登録　-1以外のとき
      if n<>-1 then
      begin
        CommandList.Add( trim(buffer) );
      end;

      buffer:='';
      inc(n);

      st:=Copy(commandDatFile[i], pos('=',CommandDatFile[i])+1,Length(CommandDatFile[i]));
      StrList:=TStringList.Create;
      CsvSeparate(St,StrList);

      // $info のzip名を分割してインデックスを割り当てる
      for j:=0 to StrList.Count-1 do
      begin
        if Trim(StrList[j])<>'' then // zip名が空のものは追加しない
        begin
          m:=Length( CommandIndex );
          SetLength( CommandIndex, m+1 );
          CommandIndex[m].zip:=StrList[j];
          CommandIndex[m].idx:=n;
          //Memo1.Lines.Add( StrList[j]+' - '+inttostr(n));
        end;
      end;
      StrList.Free;

    end
    else
    if AnsiStartsStr( '$cmd', CommandDatFile[i] ) then
    begin
      cmd:='$cmd';
    end
    else
    if AnsiStartsStr( '$end', CommandDatFile[i] ) then
    begin
      buffer:=buffer+#13#10+cmd+#13#10+'$end';
    end
    else
    begin
      cmd := cmd+#13#10+CommandDatFile[i];
    end;
  end;

  // EOF後の直前バッファ登録
  if trim(buffer)<>'' then
    commandList.Add( trim(buffer) );


  commandDatFile.Free;

  datLoaded:=true;
  //Label3.Caption:= inttostr(GetTickCount-ms)+' ms';


end;

// -----------------------------------------------------------------------------
// Zip名で検索してコマンドの文字列を用意する
procedure TfrmCommand.LoadCommand( zipName: string; zipMaster: string );
var
  //ms: cardinal;
  i: integer;
  newIndex: integer; // 新しく見つかったインデックス
begin

  //ms :=GetTickCount;

  newIndex := -1; // 未発見=-1

  if zipName='' then
  begin
    currentIndex:=-1;
    SetCommand('');
    exit;
  end;

  if not datLoaded then exit;


  // 検索 本セット
  for i := 0 to Length(CommandIndex)-1 do
  begin
    if CommandIndex[i].zip = zipName then
    begin
      newIndex:=CommandIndex[i].idx;
      break;
    end;
  end;

  // 本セットで見つからない場合はマスタで検索
  if (newIndex=-1) and (zipName<>zipMaster) then
  begin
    for i := 0 to Length(CommandIndex)-1 do
    begin
      if CommandIndex[i].zip = zipMaster then
      begin
        newIndex:=CommandIndex[i].idx;
        break;
      end;
    end;
  end;

  // 見つかった場合と見つからなかった場合
  if (newIndex<>-1) and (newIndex<>currentIndex) then
  begin
    currentIndex := CommandIndex[i].idx;
    SetCommand( CommandList[ currentIndex ]); // コマンド文字列を解釈
  end
  else
  if newIndex=-1 then
  begin
    currentIndex:=-1;
    SetCommand('');
  end;


  //Label1.Caption:=zipName;
  //Label4.Caption:=zipMaster;

  //Label2.Caption:= inttostr(GetTickCount-ms)+' ms';

end;

// -----------------------------------------------------------------------------
// コマンド文字列を解釈して設定する
// 空コマンドは無効化する
procedure TfrmCommand.SetCommand( pCommandText: string );
var
  i,j,n: integer;
  ms :cardinal;
  stl: TStringList;
  tmp: String;
begin

  cmbCommandType.Items.Clear;
  cmbCommandType.Enabled:=false;

  if pCommandText='' then
  begin

    Image1.Width:=0;
    Image1.Height:=0;

  end
  else
  begin


    stl:=TStringList.Create;
    stl.Text:=pCommandText;
    commands.Clear;

    for i := 0 to stl.Count-1 do
    begin

      if Copy( stl[i], 1, 4 )='$cmd' then
      begin
        tmp:='';
      end
      else if Copy( stl[i], 1, 4 )='$end' then
      begin
        cmbCommandType.Items.Add( Copy( tmp, 1, pos( #13#10,tmp) ));
        cmbCommandType.Enabled:=True;

        commands.Add(trim(tmp));

      end
      else
      begin
        tmp:=tmp+stl[i]+#13#10;
      end;

    end;

    stl.Free;

    if cmbCommandType.Enabled then
    begin
      // 初期値があればそちらを使う
      if (initialIndex<>-1) and (initialIndex<cmbCommandType.Items.Count) then
      begin
        cmbCommandType.ItemIndex:=initialIndex;
        initialIndex:=-1;
      end
      else
      begin
        cmbCommandType.ItemIndex:=0;
      end;
      cmbCommandTypeChange( self );
    end
    else
    begin
      Image1.Width:=0;
      Image1.Height:=0;

    end;

  end;

end;



procedure TfrmCommand.chkAlwaysOnTopClick(Sender: TObject);
begin

  if chkAlwaysOnTop.Checked then
    self.FormStyle:=fsStayOnTop
  else
    self.FormStyle:=fsNormal;

end;

procedure TfrmCommand.FormCreate(Sender: TObject);
begin

  // デフォルトの位置とか
  self.Top:= 30;
  self.Left:= Screen.Width-self.Width;

  // アイコンをリソースから
  Png := TPngImage.Create;
  iconBitmap := TBitmap.Create;
  try
    Png.LoadFromResourceName(HInstance, 'COMMANDICONS');
    iconBitmap.Assign( png );
  finally
    Png.Free;
  end;


  // ドロップダウンの初期インデックス
  initialIndex := -1;

  // コマンドリストの初期インデックス
  currentIndex := -1;

  // コマンドリスト
  commandList    := TStringList.Create;

  // command.dat読み込み
  //LoadCommandDat;


  // 画像位置
  Image1.Left:=0;
  Image1.Top:=0;

  // スクロール位置リセット
  partialUpdate:=False;

  // 現在のコマンド群保持用
  commands:= TStringList.Create;

end;

procedure TfrmCommand.FormDestroy(Sender: TObject);
begin
  iconBitmap.Free;
  CommandList.Free;
  commands.Free;
end;


procedure TfrmCommand.FormMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
  if FindVCLWindow(MousePos) = ScrollBox1 then begin
    Handled := True;
    if WheelDelta > 0 then
      ScrollBox1.VertScrollBar.Position := ScrollBox1.VertScrollBar.Position - LINEHEIGHT*2
    else
      ScrollBox1.VertScrollBar.Position := ScrollBox1.VertScrollBar.Position + LINEHEIGHT*2;
  end;
end;

procedure TfrmCommand.Image1Click(Sender: TObject);
begin
  ScrollBox1.SetFocus;
end;

procedure TfrmCommand.chkP2Click(Sender: TObject);
begin
  partialUpdate:=true;
  cmbCommandTypeChange( Sender );
end;


procedure TfrmCommand.chkZentoHanClick(Sender: TObject);
begin
  partialUpdate:=true;
  cmbCommandTypeChange( Sender );
end;


procedure TfrmCommand.cmbCommandTypeChange(Sender: TObject);
var
  buffer: TBitmap;

begin

  if cmbCommandType.Items.Count=0 then exit;

  buffer := TBitmap.Create;

  TextOut( buffer, commands.Strings[ cmbCommandType.ItemIndex ], chkP2.Checked );

  Image1.Width:=buffer.Width;
  Image1.Height:=buffer.Height;
  Image1.Picture.Bitmap.Assign(buffer);

  // スクロール位置リセット抑制あるか
  if partialUpdate then
  begin
    partialUpdate:=false;
  end
  else
  begin
    ScrollBox1.VertScrollBar.Position:=0;
  end;

  // 自動リサイズ
  if chkAutoResize.Checked then
  begin

    // 右端か？
    if frmCommand.Width+frmCommand.Left = Screen.Width then
    begin

      if Image1.Width > 1000 then
        frmCommand.Width:=1000+GetSystemMetrics(SM_CXHSCROLL)+GetSystemMetrics(SM_CXSIZEFRAME)*2+4
      else
        frmCommand.Width:=Image1.Width+GetSystemMetrics(SM_CXHSCROLL)+GetSystemMetrics(SM_CXSIZEFRAME)*2+4;

      frmCommand.Left := Screen.Width-frmCommand.Width;

    end
    else
    begin
      if Image1.Width > 1000 then
        frmCommand.Width:=1000++GetSystemMetrics(SM_CXHSCROLL)+GetSystemMetrics(SM_CXSIZEFRAME)*2+4
      else
        frmCommand.Width:=Image1.Width+GetSystemMetrics(SM_CXHSCROLL)+GetSystemMetrics(SM_CXSIZEFRAME)*2+4;

      if frmCommand.Left+frmCommand.Width > Screen.Width then
        frmCommand.Left := Screen.Width-frmCommand.Width;
    end;


  end;


  buffer.Free;

end;



// -----------------------------------------------------------------------------
// CSV分割
function TfrmCommand.CsvSeparate(const Str: string; StrList: TStrings): Integer;
var
  Head, Tail: PChar;
  Len: Integer;
begin
  StrList.Clear;
  Head := PChar(Str);
  while True do
    if Head^ = '"' then begin
      StrList.Append(AnsiExtractQuotedStr(Head, '"'));
      if Head^ <> #0 then Inc(Head)
    end else begin
      Tail := AnsiStrPos(Head, ',');
      if Tail = nil then begin
        StrList.Append(Head);
        Break
      end else begin
        Len := Tail - Head;
        StrList.Append(Copy(Head, 1, Len));
        Inc(Head, Len + 1)
      end
    end;
  Result := StrList.Count
end;


end.
