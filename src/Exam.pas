unit Exam;

 Interface
 
uses crt,Compl;

procedure Exam1;
procedure Exam2;
procedure MenuExam;

Implementation
procedure Exam1;
var 
  z, w, p, z2 : complex;
  k, x, y : integer;
  e : real;
Begin
  GOTOXY(75, 1);
 write('Введите комплексное число z:');
 Input(x, y, z);
 ClrScr;
 writeln('Введите точность e:');
 Readln(e);
 mult(z, z, z2); // Посчитаем z^2, чтобы каждый раз заново не считать
 prod(1/2, z2, p); // Нашли изначальное число, от которого будем отталкиваться
 w := p;
 k := 2;
 while Modul(p)>=e do
 begin
   prod((2*k-1)/(k+1)/(2*k-3), p, p); 
   mult(z2, p, p);
   add(w, p, w);
   k:=k+1;
 end;
 writeln('Ответ:');
 Output(x, y, w);
End;


procedure Exam2;
var
k:integer;
P:real;
begin
P:=1;
for k:= 1 to 101 do
P:=P*(4*k*k/(4*k*k-1));
write('Произведение = ',P);
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
    writeln('Укажите операцию:');
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