unit Unit3;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls;

type

  { TForm3 }

  TForm3 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private

  public

  end;

var
  Form3: TForm3;

implementation
uses Unit1, Unit2;

{$R *.lfm}

{ TForm3 }

procedure TForm3.FormCreate(Sender: TObject);
begin
Timer1.Enabled:=true;
end;

procedure TForm3.Timer1Timer(Sender: TObject);
begin
     if(temp_time = 1) then
     begin
      Label1.Caption:= Form1.Edit1.Text;
      Form1.Hide;
      Timer1.Enabled:=false;
      end;

end;

procedure TForm3.Button1Click(Sender: TObject);
begin
end;

end.
