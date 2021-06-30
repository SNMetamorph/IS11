Unit Queue;
  Interface
Uses Crt; 
Type PtrQ = ^Queu;
     Queu = record
     Inf:integer;
     Next:PtrQ;
     end;
    
var Top, Kon, Left, Right, RightOut:PtrQ; 
    value:integer;

procedure MakeQueue;//Создание очереди
procedure AddQueue;//Добавление в очередь
procedure ViewQueue;//Просмотр очереди
procedure Wait;

procedure MenuQueue; {меню}

    Implementation
procedure MakeQueue;//Создание очереди
var
  ok:boolean;
begin
  ok:=True;
  writeln('Введите число');
  readln(value);
  New(Top);
  if value = 999 then
  begin
    ok:=False; 
    Top^.Next:=Nil
  end;
  Top^.Inf:=value; 
  Right:=Top; 
  Left:=Top;
  while ok do
  begin
    writeln('Введите число');
    readln(value);
    if value = 999 then
    begin
      ok:=False; 
      Top^.Next:=Nil
    end
    else
    begin
      New(Top);
      Right^.Next:=Top;
      Top^.Inf:=value;
      Right:=Top
    end;
  end;
end;

procedure AddQueue;//Добавление в очередь
var 
  ok:boolean;
begin
  ok:=True;
  while ok do 
  begin 
    writeln('Введите число');
    readln(value);
    if value = 999 then
    begin
      ok:=False;
      Top^.Next:=Nil
    end
    else
    begin
      New(Top); 
      Right^.Next:=Top;
      Top^.Inf:=value;
      Right:=Top
    end
  end;
  RightOut:=Right;
end;

procedure ViewQueue;//Просмотр очереди
begin
  Top:=Left;
  while Top <> Nil do
  begin
    writeln(Top^.Inf);
    Top:=Top^.Next
  end
end;
  
procedure Wait;
  begin
    repeat until KeyPressed;
    while KeyPressed do ReadKey;
  end;

procedure MenuQueue;{меню}
     var 
       ok: boolean;
       Mode: integer;
     begin
     Ok:=true;
     while (Ok) do
     begin
       clrscr;
       writeln('Укажите операцию:');
       writeln('  1:Создание очереди');
       writeln('  2:Добавление в очередь');
       writeln('  3:Просмотр очереди');
       writeln('  0:Выход');
       GoToXY(40, 17);
       readln(Mode);
       GoToXY(40, 17);
       clearline;
       clrscr;
       
       case Mode of
         
       1: 
          begin 
            MakeQueue;
            gotoxy(30, 21);
            write('Создано!');
            Wait;
          end;
          
       2: 
          begin
            AddQueue; 
            gotoxy(30, 21);
            write('Добавлено!');
            Wait;
          end;
          
       3:
          begin
            ViewQueue;
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
