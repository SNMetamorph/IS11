unit exam;

 Interface
 
uses crt,CompMatr,Compl;

procedure Exam1;
procedure Exam2;
procedure MenuExam;

Implementation

procedure Exam1;
var n,i,j,x,y:integer;

a:Matrix;
begin
  x:=1;y:=10;
 writeln('Введите размер комплексной матрицы');
 readln(n);
  InputMatrix(1,1,n,a);
  writeln;
  writeln;
 for i:=1 to n do
 begin
   if i mod 2 = 0 then
     
  for j:=n downto 1 do
write('(',(A[j,i].Re):2,'+i*',(A[j,i].Im):2,')')
  else 
    for j:=1 to n do
   write('(',(A[j,i].Re):2,'+i*',(A[j,i].Im):2,')');
  writeln;
  writeln;
  end;
 
  end;


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
P:real;
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