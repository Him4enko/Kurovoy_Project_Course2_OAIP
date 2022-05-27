unit Unit2;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, IdHashSHA, IdGlobal, IdHash, IdHashMessageDigest;

type

  { TForm2 }

  TForm2 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    procedure Button1Click(Sender: TObject);
  private

  public

  end;

var
  Form2: TForm2;

implementation
uses Unit1, Unit3;
{$R *.lfm}

{ TForm2 }
procedure registration(login, password, email: string);
var IdHashMD5: TIdHashMessageDigest5; pass_hash: string;
begin
try
  IdHashMD5:=TIdHashMessageDigest5.Create;
  pass_hash:= IdHashMD5.HashStringAsHex ( password );
  IdHashMD5.Free;
  Form1.SQLQuery1.Close;
  Form1.SQLQuery1.SQL.Text:='INSERT INTO users (login, password, email) VALUES ("' + login + '","' + pass_hash + '","' + email + '")';
  Form1.SQLQuery1.ExecSQL;
  Form1.SQLTransaction1.Commit;
  ShowMessage('Вы успешно зарегистрировались ' + login);
  Form2.Close;
except
  ShowMessage('Произошла ошибка регистрации, обратитесь к системному администратору');
end;
end;

procedure TForm2.Button1Click(Sender: TObject);
var login, password, email: string;
begin
login:=Edit1.Text;
password:=Edit2.Text;
email:=Edit4.Text;
if (((login <> '') and (password <> '')) and (email <> '')) then
begin
if password = Edit3.Text then
begin
registration(login, password, email);
end;
end;
end;


end.

