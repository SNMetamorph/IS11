Unit Stack;
  Interface
Uses Crt;  
Type Ptr = ^Stak;
     Stak = record
     Inf:integer;
     Next:Ptr;
     end;
    
var Top, Kon:Ptr;
    value:integer;
    Tmp, Tmp1:Ptr; 
    Top1,Top2:Ptr;
    Kon1,Kon2:Ptr;
    
procedure MakeStack(Var Top:Ptr);//Создание стека
procedure AddStack(Var Top:Ptr);//Добавление в стек
procedure ViewStack(Var Top:Ptr);//Просмотр стека
procedure DeleteTop(Var Top:Ptr);//Удаление топа
procedure EraseStack(Var Top:Ptr);//Удаление всего стека
procedure ConcatenateStack(Var Top1,Top2:Ptr);//Объединение стеков
procedure ReverseStack(Var Top:Ptr);//Переворот стека
procedure Wait;

procedure MenuStack;{меню}

  Implementation
procedure MakeStack(Var Top:Ptr); //Создание стека
var 
  ok:boolean;
begin
  ok:=True;
  Top:=Nil;
  while ok do
  begin
    writeln('Введите число:');
    readln(value);
    if value = 999 then
       ok:=False
    else 
    begin
      New(Kon);
      Kon^.Inf:=value;
      Kon^.Next:=Top;
      Top:=Kon;
    end
  end
end;

procedure AddStack(Var Top:Ptr); //Добавление в стек
var
  ok:boolean;
begin
   ok:=True;
   while ok do
   begin
     writeln('Добавьте число:');
     readln(value);
     if value = 999 then
       ok:=False
     else 
     begin
       New(Kon);
       Kon^.Inf:=value;
       Kon^.Next:=Top;
       Top:=Kon;
     end
   end
end;

procedure ViewStack(Var Top:Ptr); //Просмотр стека
begin
  Kon:=Top;
  while Kon <> Nil do
  begin
    writeln(Kon^.Inf);
    Kon:=Kon^.Next;
  end
end;
  
procedure DeleteTop;//Удаление топа
begin
  Top:=Top^.Next;
end;

procedure EraseStack;//Удаление всего стека
begin
  Top:=Nil;
end;

procedure ConcatenateStack(Var Top1,Top2:Ptr);//Объединение стеков
begin
 Kon1:=Top1;
 while Kon1^.Next<>Nil do
 Kon1:=Kon1^.Next;
 Kon1^.Next:=Top2;
 writeln();
 writeln('Стеки обьединены!');
end;
   
procedure ReverseStack(Var Top:Ptr); //Переворот стека
var
   N,P:Ptr;
begin
 P:=Nil;
 while Top<>Nil do
 begin
  N:=Top^.Next;
  Top^.Next:=P;
  P:=Top;
  Top:=N;
 end;
 Top:=P;
end;

procedure Wait;
  begin
    repeat until KeyPressed;
    while KeyPressed do ReadKey;
  end;

procedure MenuStack;{меню}
     var 
       ok: boolean;
       Mode: integer;
     begin
     Ok:=true;
     while (Ok) do
     begin
       clrscr;
       writeln('Укажите операцию:');
       writeln('  1:Создание');
       writeln('  2:Добавление');
       writeln('  3:Просмотр');
       writeln('  4:Удаление top');
       writeln('  5:Удаление стека');
       writeln('  6:Обьединение стеков');
       writeln('  7:Перевернутый стек');
       writeln('  0:Выход');
       GoToXY(40, 17);
       readln(Mode);
       GoToXY(40, 17);
       clearline;
       clrscr;
       
       case Mode of
         
       1: 
          begin 
            MakeStack(Top1);
            gotoxy(30, 21);
            write('Создано!');
            Wait;
          end;
          
       2: 
          begin
            AddStack(Top1); 
            gotoxy(30, 21);
            write('Добавлено!');
            Wait;
          end;
          
       3:
          begin
            ViewStack(Top1);
            Wait;
          end;
          
       4: 
          begin
            DeleteTop(Top1); 
            gotoxy(30, 21);
            write('Удалено!');
            Wait;
          end;
       
       5: 
          begin
            EraseStack(Top1); 
            gotoxy(30, 21);
            write('Удалено!');
            Wait;
          end;
          
       6:
          begin
            if Top1=Nil then  begin MakeStack(Top1); writeln(); end;
            ViewStack(Top1);
            writeln();
            MakeStack(Top2);
            writeln();
            ViewStack(Top2);
            writeln();
            ConcatenateStack(Top1, Top2);
            ViewStack(Top1);
            Wait;
          end;
       7:
          begin
            ReverseStack(Top1);
            ViewStack(Top1);
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
  
