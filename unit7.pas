unit Unit7;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, DBGrids, StdCtrls,
  Menus, Grids;

type

  { TForm7 }

  TForm7 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    Edit1: TEdit;
    StringGrid1: TStringGrid;
    procedure Button2Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox3Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  Form7: TForm7;

implementation
uses Unit1;

{$R *.lfm}

{ TForm7 }
procedure zapoln(n:integer);
var i:integer;
  begin
  Form1.SQLQuery1.Close;
  Form1.SQLQuery1.Clear;
  Form1.SQLQuery1.SQL.Text:='SELECT * FROM marks';
  Form1.SQLQuery1.Open;
  Form1.SQLQuery1.First;
    for i:=1 to n do
        begin
        Form7.StringGrid1.Cells[0,i]:=Form1.SQLQuery1.FieldByName('id').AsString;
        Form7.StringGrid1.Cells[1,i]:=Form1.SQLQuery1.FieldByName('student').AsString;
        Form7.StringGrid1.Cells[2,i]:=Form1.SQLQuery1.FieldByName('lesson').AsString;
        Form7.StringGrid1.Cells[3,i]:=Form1.SQLQuery1.FieldByName('mark').AsString;
        Form1.SQLQuery1.Next;
        end;
  end;

procedure updcombo();
var i,n: integer;
  begin
   // Получение кол-ва строк в groups
    Form1.SQLQuery1.Close;
    Form1.SQLQuery1.Clear;
    Form1.SQLQuery1.SQL.Text:='SELECT COUNT(*) as cnt FROM groups';
    Form1.SQLQuery1.Open;
    Form1.SQLQuery1.First;
    n:=Form1.SQLQuery1.Fields[0].AsInteger;
    // ------------------------------------
    // Добавление значений в ComboBox
    Form1.SQLQuery1.Close;
    Form1.SQLQuery1.Clear;
    Form1.SQLQuery1.SQL.Text:='SELECT name FROM groups';
    Form1.SQLQuery1.Open;
    Form1.SQLQuery1.First;
    // ------------------------------------
    for i:=1 to n do
    begin
      Form7.ComboBox1.Items.Add(Form1.SQLQuery1.Fields[0].AsString);
      Form1.SQLQuery1.Next;
    end;
  end;
procedure updcombo_stud();
var i,n:integer;
  begin
     // Получение кол-ва строк в student's с группой N-й.
    Form1.SQLQuery1.Close;
    Form1.SQLQuery1.Clear;
    Form1.SQLQuery1.SQL.Text:='SELECT COUNT(*) as cnt FROM students WHERE groups=:group';
    Form1.SQLQuery1.ParamByName('group').AsString:=Form7.ComboBox1.Text;
    Form1.SQLQuery1.Open;
    Form1.SQLQuery1.First;
    n:=Form1.SQLQuery1.Fields[0].AsInteger;
    // ------------------------------------
        // Добавление значений в ComboBox 2
    Form1.SQLQuery1.Close;
    Form1.SQLQuery1.Clear;
    Form1.SQLQuery1.SQL.Text:='SELECT name FROM students WHERE groups=:group';
    Form1.SQLQuery1.ParamByName('group').AsString:=Form7.ComboBox1.Text;
    Form1.SQLQuery1.Open;
    Form1.SQLQuery1.First;
    // ------------------------------------
    for i:=1 to n do
    begin
      Form7.ComboBox2.Items.Add(Form1.SQLQuery1.Fields[0].AsString);
      Form1.SQLQuery1.Next;
    end;
  end;
procedure updcombo_lesson();
var i,n:integer;
  begin
     // Получение кол-ва строк в lesson's с пользователем N-й.
    Form1.SQLQuery1.Close;
    Form1.SQLQuery1.Clear;
    Form1.SQLQuery1.SQL.Text:='SELECT COUNT(*) as cnt FROM lesson';
    Form1.SQLQuery1.Open;
    Form1.SQLQuery1.First;
    n:=Form1.SQLQuery1.Fields[0].AsInteger;
    // ------------------------------------
        // Добавление значений в ComboBox 3
    Form1.SQLQuery1.Close;
    Form1.SQLQuery1.Clear;
    Form1.SQLQuery1.SQL.Text:='SELECT name FROM lesson';
    Form1.SQLQuery1.Open;
    Form1.SQLQuery1.First;
    // ------------------------------------
    for i:=1 to n do
    begin
      Form7.ComboBox3.Items.Add(Form1.SQLQuery1.Fields[0].AsString);
      Form1.SQLQuery1.Next;
    end;
  end;
// ПОЛУЧЕНИЕ ОЦЕНОК
procedure get();
begin
Form1.SQLQuery1.Close;
Form1.SQLQuery1.Clear;
Form1.SQLQuery1.SQL.Text:='SELECT COUNT(*) as cnt FROM students';
Form1.SQLQuery1.Open;
Form1.SQLQuery1.First;
with Form7.StringGrid1 do
     begin
     RowCount:=Form1.SQLQuery1.Fields[0].AsInteger+1;
     ColWidths[0]:=204;
     ColWidths[1]:=204;
     ColWidths[2]:=204;
     ColWidths[3]:=204;
     Cells[0,0]:='ID';
     Cells[1,0]:='Имя';
     Cells[2,0]:='Дисциплина';
     Cells[3,0]:='Оценка';
     end;
zapoln(Form1.SQLQuery1.Fields[0].AsInteger);
end;

procedure TForm7.FormShow(Sender: TObject);
begin

updcombo();
updcombo_lesson();

end;


procedure TForm7.ComboBox1Change(Sender: TObject);
begin
updcombo_stud();
end;

procedure TForm7.Button2Click(Sender: TObject);
begin

end;

procedure TForm7.ComboBox3Change(Sender: TObject);
begin
get();
end;


end.

