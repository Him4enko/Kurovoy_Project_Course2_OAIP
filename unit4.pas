unit Unit4;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Grids, ValEdit,
  ActnList, StdCtrls;

type

  { TForm4 }

  TForm4 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    StringGrid1: TStringGrid;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  Form4: TForm4;

implementation
uses unit1;

{$R *.lfm}

{ TForm4 }
procedure zapoln(n:integer);
var i:integer;
  begin
  Form1.SQLQuery1.Close;
  Form1.SQLQuery1.Clear;
  Form1.SQLQuery1.SQL.Text:='SELECT * FROM groups';
  Form1.SQLQuery1.Open;
  Form1.SQLQuery1.First;
    for i:=1 to n do
        begin
        Form4.StringGrid1.Cells[0,i]:=Form1.SQLQuery1.FieldByName('id').AsString;
        Form4.StringGrid1.Cells[1,i]:=Form1.SQLQuery1.FieldByName('name').AsString;
        Form4.StringGrid1.Cells[2,i]:=Form1.SQLQuery1.FieldByName('course').AsString;
        Form4.StringGrid1.Cells[3,i]:=Form1.SQLQuery1.FieldByName('tutor').AsString;
        Form1.SQLQuery1.Next;
        end;
  end;

procedure TForm4.FormShow(Sender: TObject);
begin
  Form1.SQLQuery1.Close;
  Form1.SQLQuery1.Clear;
  Form1.SQLQuery1.SQL.Text:='SELECT COUNT(*) as cnt FROM groups';
  Form1.SQLQuery1.Open;
  Form1.SQLQuery1.First;
  with StringGrid1 do
       begin
       RowCount:=Form1.SQLQuery1.Fields[0].AsInteger+1;
       ColWidths[0]:=122;
       ColWidths[1]:=122;
       ColWidths[2]:=122;
       ColWidths[3]:=122;
       Cells[0,0]:='ID';
       Cells[1,0]:='Группа';
       Cells[2,0]:='Курс';
       Cells[3,0]:='ID Преподавателя';
       end;
  zapoln(Form1.SQLQuery1.Fields[0].AsInteger);
end;

procedure TForm4.Button1Click(Sender: TObject);
begin
  // Добавление группы
  Form1.SQLQuery1.Close;
  Form1.SQLQuery1.Clear;
  Form1.SQLQuery1.SQL.Text:='INSERT INTO groups (id, name, course, tutor) VALUES (:id, :name, :course, :tutor)';
  Form1.SQLQuery1.ParamByName('id').AsInteger:=StrToInt(Edit2.Text);
  Form1.SQLQuery1.ParamByName('name').AsString:=Edit1.Text;
  Form1.SQLQuery1.ParamByName('course').AsInteger:=StrToInt(Edit3.Text);
  Form1.SQLQuery1.ParamByName('tutor').AsInteger:=StrToInt(Edit4.Text);
  Form1.SQLQuery1.ExecSQL;
  Form1.SQLTransaction1.Commit;
  // Обновление групп после добавления
  Form1.SQLQuery1.Close;
  Form1.SQLQuery1.Clear;
  Form1.SQLQuery1.SQL.Text:='SELECT COUNT(*) as cnt FROM groups';
  Form1.SQLQuery1.Open;
  Form1.SQLQuery1.First;
  StringGrid1.RowCount:=Form1.SQLQuery1.Fields[0].AsInteger+1;
  zapoln(Form1.SQLQuery1.Fields[0].AsInteger);
end;

procedure TForm4.Button2Click(Sender: TObject);
begin
  // Удаление группы
  Form1.SQLQuery1.Close;  // закрываем компонент
  Form1.SQLQuery1.SQL.Text:='delete from groups where id=:id'; // запрос на удаление данных
  Form1.SQLQuery1.ParamByName('id').AsString:=Edit2.Text; //указываем требуемый параметр
  Form1.SQLQuery1.ExecSQL; // выполняем запрос
  Form1.SQLTransaction1.Commit; //подтверждаем изменения в базе
   // Обновление после удаления
   Form1.SQLQuery1.Close;
   Form1.SQLQuery1.SQL.Text:='SELECT COUNT(*) as cnt FROM groups';
   Form1.SQLQuery1.Open;
   Form1.SQLQuery1.First;
   StringGrid1.RowCount:=Form1.SQLQuery1.Fields[0].AsInteger+1;
   zapoln(Form1.SQLQuery1.Fields[0].AsInteger);
end;



{ TForm4 }


end.

