Unit Izbrannoe;

  Interface
uses Crt;
procedure Izb;{Z из единиц}
procedure Wait;
Procedure MenuIzbrannoe;{меню}

  Implementation

procedure Izb;{Z из единиц}
const 
  n=4;
var 
  a:array [1..n,1..n] of integer;
  m,i,j:integer;
begin
  for i:=1 to n do
    for j:=1 to n do {Фон}
      a[i,j]:=0;
    
    
  for i:=n to n do 
    for j:=1 to n do 
       a[i,j]:=1;
    
  for i:=1 to 1 do 
    for j:=1 to n do 
       a[i,j]:=1;
    
  for i:=1 to n do 
    a[i,n-i+1]:=1;
    
 
  for i:=1 to n do
    for j :=1 to n do 
    begin
       GotoXY(7*j+1,3*i);
       writeln(a[i,j]:5);
    end;
end;  
procedure Wait;
  begin
    repeat until KeyPressed;
    while KeyPressed do ReadKey;
  end;

procedure MenuIzbrannoe;
     var 
       ok: boolean;
       Mode: integer;
     begin
     Ok:=true;
     while (Ok) do
     begin
       clrscr;
       writeln('  1:Z из единиц');
       writeln('  0:Выход');
       GoToXY(40, 17);
       readln(Mode);
       GoToXY(40, 17);
       clearline;
       clrscr;
       
       case Mode of
         
       1: 
          begin{скалярное произведение}
            Izb;
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
       end;
     end;
   end;
 end;
End.
  