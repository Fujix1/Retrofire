unit unitAbout;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, Common, ShellAPI, pngimage,
  Vcl.Imaging.jpeg;

type
  TForm5 = class(TForm)
    Label4: TLabel;
    Label7: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LinkLabel1LinkClick(Sender: TObject; const Link: string;
      LinkType: TSysLinkType);
    procedure FormShow(Sender: TObject);

  private
    { Private êÈåæ }
  public
    { Public êÈåæ }
  end;

var
  Form5: TForm5;

implementation

uses Unit1;

{$R *.dfm}

procedure TForm5.FormCreate(Sender: TObject);
begin
  Label1.Caption:='Build No. '+BUILDNO;
//  Form5.ClientHeight := 300;
//  Form5.ClientWidth := 450;
end;

procedure TForm5.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Form5.Close;
end;

procedure TForm5.FormShow(Sender: TObject);
begin
  Form5.Left:= Form1.Left+ (Form1.Width -Form5.Width) Div 2;
  Form5.Top := Form1.Top + (Form1.Height-Form5.Height) Div 2;

end;

procedure TForm5.LinkLabel1LinkClick(Sender: TObject; const Link: string;
  LinkType: TSysLinkType);
begin

  ShellExecute(Self.Handle,PChar('Open'),PChar(Link),nil,nil,SW_SHOWNORMAL);
  Form5.Close;

end;

end.
