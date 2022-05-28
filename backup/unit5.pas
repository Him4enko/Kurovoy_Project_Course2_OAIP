unit Unit5;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Grids;

type

  { TForm5 }

  TForm5 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    StringGrid1: TStringGrid;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  Form5: TForm5;

implementation
uses Unit1;

{$R *.lfm}

{ TForm5 }
procedure zapoln(n:integer);
var i:integer;
  begin
  Form1.SQLQuery1.Close;
  Form1.SQLQuery1.Clear;
  Form1.SQLQuery1.SQL.Text:='SELECT * FROM tutors';
  Form1.SQLQuery1.Open;
  Form1.SQLQuery1.First;
    for i:=1 to n do
        begin
        Form5.StringGrid1.Cells[0,i]:=Form1.SQLQuery1.FieldByName('id').AsString;
        Form5.StringGrid1.Cells[1,i]:=Form1.SQLQuery1.FieldByName('name').AsString;
        Form5.StringGrid1.Cells[2,i]:=Form1.SQLQuery1.FieldByName('groups').AsString;
        Form1.SQLQuery1.Next;
        end;
  end;


procedure TForm5.FormShow(Sender: TObject);
begin
  Form1.SQLQuery1.Close;
  Form1.SQLQuery1.Clear;
  Form1.SQLQuery1.SQL.Text:='SELECT COUNT(*) as cnt FROM tutors';
  Form1.SQLQuery1.Open;
  Form1.SQLQuery1.First;
  with StringGrid1 do
       begin
       RowCount:=Form1.SQLQuery1.Fields[0].AsInteger+1;
       ColWidths[0]:=133;
       ColWidths[1]:=133;
       ColWidths[2]:=133;
       Cells[0,0]:='ID преподавателя';
       Cells[1,0]:='Ф.И.О.';
       Cells[2,0]:='Группа';
       end;
  zapoln(Form1.SQLQuery1.Fields[0].AsInteger);
end;

procedure TForm5.Button1Click(Sender: TObject);
begin
    // Добавление преподавателя
  Form1.SQLQuery1.Close;
  Form1.SQLQuery1.Clear;
  Form1.SQLQuery1.SQL.Text:='INSERT INTO tutors (id, name, course, tutor) VALUES (:id, :name, :course, :tutor)';
  Form1.SQLQuery1.ParamByName('id').AsInteger:=StrToInt(Edit3.Text);
  Form1.SQLQuery1.ParamByName('name').AsString:=Edit1.Text;
  Form1.SQLQuery1.ParamByName('groups').AsInteger:=StrToInt(Edit2.Text);
  Form1.SQLQuery1.ExecSQL;
  Form1.SQLTransaction1.Commit;
  // Обновление преподавателей
  Form1.SQLQuery1.Close;
  Form1.SQLQuery1.Clear;
  Form1.SQLQuery1.SQL.Text:='SELECT COUNT(*) as cnt FROM tutors';
  Form1.SQLQuery1.Open;
  Form1.SQLQuery1.First;
  StringGrid1.RowCount:=Form1.SQLQuery1.Fields[0].AsInteger+1;
  zapoln(Form1.SQLQuery1.Fields[0].AsInteger);
end;

procedure TForm5.Button2Click(Sender: TObject);
begin
  // Удаление группы
  Form1.SQLQuery1.Close;  // закрываем компонент
  Form1.SQLQuery1.SQL.Text:='delete from tutors where id=:id'; // запрос на удаление данных
  Form1.SQLQuery1.ParamByName('id').AsString:=Edit3.Text; //указываем требуемый параметр
  Form1.SQLQuery1.ExecSQL; // выполняем запрос
  Form1.SQLTransaction1.Commit; //подтверждаем изменения в базе
   // Обновление после удаления
   Form1.SQLQuery1.Close;
   Form1.SQLQuery1.SQL.Text:='SELECT COUNT(*) as cnt FROM tutors';
   Form1.SQLQuery1.Open;
   Form1.SQLQuery1.First;
   StringGrid1.RowCount:=Form1.SQLQuery1.Fields[0].AsInteger+1;
   zapoln(Form1.SQLQuery1.Fields[0].AsInteger);
end;

end.

