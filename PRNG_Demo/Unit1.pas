unit Unit1;

{$DEFINE PARANOID}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses amprng;

{$R *.dfm}

procedure TForm1.FormActivate(Sender: TObject);
var
  key: array [0..11] of byte;
  iv:  array [0..9] of byte;

var
  I:  integer;
  F:  file;
  b:  byte;
  AM: TAMPRNG;
begin

  onactivate := nil;
  Application.ProcessMessages;
  randomize;

  for I := 0 to 11 do
    key[i] := random(256);
  for I := 0 to 9 do
    iv[i] := random(256);

  AM := TAMPRNG.Create(key, Length(key)
{$IFDEF PARANOID}
    , True
{$ENDIF}
    );
  AM.SetIV(iv, length(iv));

  assignfile(F, ExtractFilePath(Application.ExeName) + 'prng.rnd');
  rewrite(f, 1);


  for I := 0 to 1024 * 1024 * 30 do
  begin
    b := am.prng;
    BlockWrite(f, b, 1);
  end;

  closefile(F);
  am.Free;
  Close; 
end;

end.
