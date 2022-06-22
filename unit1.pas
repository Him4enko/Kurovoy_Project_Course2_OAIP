unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, mysql80conn, SQLDB, SQLDBLib, DB, Forms, Controls,
  Graphics, Dialogs, StdCtrls, MaskEdit, RTTICtrls, SynHighlighterJScript,
  SynEdit, SynHighlighterCpp, SynHighlighterHTML, IdHashSHA, IdGlobal, IdHash,
  IdHashMessageDigest;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    DataSource1: TDataSource;
    Edit1: TEdit;
    Edit2: TEdit;
    MySQL80Connection1: TMySQL80Connection;
    SQLQuery1: TSQLQuery;
    SQLScript1: TSQLScript;
    SQLTransaction1: TSQLTransaction;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  login: string;
  status: boolean;
  temp_time: integer; // Переменная для хранения значения, в дальнейшем скрытие 1 формы
implementation
uses Unit2, Unit3;
{$R *.lfm}

{ TForm1 }
// Процедура подключения к базе данных
procedure connection();
var i:integer; login, password: string;
  IdHashMD5: TIdHashMessageDigest5;
begin
try
// VARIABLES
login:= Form1.Edit1.Text;
password:=Form1.Edit2.Text;
IdHashMD5:=TIdHashMessageDigest5.Create;
////////////

Form1.MySQL80Connection1.Connected:=true;
Form1.SQLTransaction1.Active := True;
Form1.MySQL80Connection1.Open;
Form1.SQLQuery1.SQL.Text := 'SELECT * FROM users WHERE (login="' + login + '");';
Form1.SQLQuery1.Open;
Form1.SQLQuery1.First;

if Form1.SQLQuery1.FieldByName('password').AsString = IdHashMD5.HashStringAsHex (password) then
begin
ShowMessage('Вы авторизовались!');
IdHashMD5.Free;
status:=True;
end;
except
  begin
    ShowMessage('Подключение к базе данных, завершилось с ошибкой подключения или произошла непредвиденная ошибка!');
  end;
end;
end;
procedure TForm1.Button1Click(Sender: TObject);
begin
Connection();
if(status = True) then
begin
login:=Edit1.Text;
Form3.Show;
temp_time:=1;
end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
Form2.Show;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
temp_time:=0;
end;

end.

