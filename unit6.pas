unit Unit6;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Grids;

type

  { TForm6 }

  TForm6 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    StringGrid1: TStringGrid;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  Form6: TForm6;

implementation
uses Unit1;

{$R *.lfm}

{ TForm6 }
procedure zapoln(n:integer);
var i:integer;
  begin
  Form1.SQLQuery1.Close;
  Form1.SQLQuery1.Clear;
  Form1.SQLQuery1.SQL.Text:='SELECT * FROM students';
  Form1.SQLQuery1.Open;
  Form1.SQLQuery1.First;
    for i:=1 to n do
        begin
        Form6.StringGrid1.Cells[0,i]:=Form1.SQLQuery1.FieldByName('id').AsString;
        Form6.StringGrid1.Cells[1,i]:=Form1.SQLQuery1.FieldByName('name').AsString;
        Form6.StringGrid1.Cells[2,i]:=Form1.SQLQuery1.FieldByName('groups').AsString;
        Form6.StringGrid1.Cells[3,i]:=Form1.SQLQuery1.FieldByName('tutor').AsString;
        Form6.StringGrid1.Cells[4,i]:=Form1.SQLQuery1.FieldByName('course').AsString;
        Form1.SQLQuery1.Next;
        end;
  end;

procedure TForm6.Button1Click(Sender: TObject);
begin
// Добавление преподавателя
Form1.SQLQuery1.Close;
Form1.SQLQuery1.Clear;
Form1.SQLQuery1.SQL.Text:='INSERT INTO students (id, name, groups, tutor, course) VALUES (:id, :name, :groups, :tutor, :course)';
Form1.SQLQuery1.ParamByName('id').AsInteger:=StrToInt(Edit2.Text);
Form1.SQLQuery1.ParamByName('name').AsString:=Edit1.Text;
Form1.SQLQuery1.ParamByName('groups').AsString:=Edit3.Text;
Form1.SQLQuery1.ParamByName('tutor').AsInteger:=StrToInt(Edit4.Text);
Form1.SQLQuery1.ParamByName('course').AsInteger:=StrToInt(Edit5.Text);
Form1.SQLQuery1.ExecSQL;
Form1.SQLTransaction1.Commit;
// Обновление преподавателей
Form1.SQLQuery1.Close;
Form1.SQLQuery1.Clear;
Form1.SQLQuery1.SQL.Text:='SELECT COUNT(*) as cnt FROM students';
Form1.SQLQuery1.Open;
Form1.SQLQuery1.First;
StringGrid1.RowCount:=Form1.SQLQuery1.Fields[0].AsInteger+1;
zapoln(Form1.SQLQuery1.Fields[0].AsInteger);
end;

procedure TForm6.Button2Click(Sender: TObject);
begin
// Удаление группы
Form1.SQLQuery1.Close;  // закрываем компонент
Form1.SQLQuery1.SQL.Text:='delete from students where id=:id'; // запрос на удаление данных
Form1.SQLQuery1.ParamByName('id').AsString:=Edit2.Text; //указываем требуемый параметр
Form1.SQLQuery1.ExecSQL; // выполняем запрос
Form1.SQLTransaction1.Commit; //подтверждаем изменения в базе
// Обновление после удаления
Form1.SQLQuery1.Close;
Form1.SQLQuery1.SQL.Text:='SELECT COUNT(*) as cnt FROM students';
Form1.SQLQuery1.Open;
Form1.SQLQuery1.First;
StringGrid1.RowCount:=Form1.SQLQuery1.Fields[0].AsInteger+1;
zapoln(Form1.SQLQuery1.Fields[0].AsInteger);
end;

procedure TForm6.FormShow(Sender: TObject);
begin
Form1.SQLQuery1.Close;
Form1.SQLQuery1.Clear;
Form1.SQLQuery1.SQL.Text:='SELECT COUNT(*) as cnt FROM students';
Form1.SQLQuery1.Open;
Form1.SQLQuery1.First;
with StringGrid1 do
     begin
     RowCount:=Form1.SQLQuery1.Fields[0].AsInteger+1;
     ColWidths[0]:=146;
     ColWidths[1]:=146;
     ColWidths[2]:=146;
     ColWidths[3]:=146;
     ColWidths[3]:=146;
     Cells[0,0]:='ID';
     Cells[1,0]:='Ф.И.О.';
     Cells[2,0]:='ID Группы';
     Cells[3,0]:='ID Преподавателя';
     Cells[4,0]:='Курс';
     end;
zapoln(Form1.SQLQuery1.Fields[0].AsInteger);
end;

end.

