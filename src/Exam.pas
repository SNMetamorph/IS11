unit Exam;
Interface
uses crt,Compl;

procedure Exam1;
procedure Exam2;
procedure MenuExam;

Implementation
procedure Exam1;
Begin
writeln('Не реализовано');
End;


procedure Exam2;
begin
writeln('Не реализовано');
end;

procedure MenuExam;
var
k:integer;
ok: boolean;
  Mode: integer;
begin
  ok := true; 
  while (ok) do
  begin
    clrscr;
    writeln('Выберите пункт:');
    writeln('  1: Задача 1');
    writeln('  2: Задача 2');
    writeln('  0: Выход');
    gotoxy(40, 17);
    readln(Mode);
    gotoxy(40, 17);

    case Mode of
      1:
        begin  
           clrscr;
          Exam1;
            Wait;
        end;
        
      2:
        begin 
          clrscr;
      Exam2;
        Wait;
           end;
      0: 
         begin
           ok:=false;
         end;
    else
      begin
        clrscr;
        gotoxy(30, 21);
        writeln('Ошибка! Повторите ввод:');
        delay(1000);
           end
    end
  end
end;
End.