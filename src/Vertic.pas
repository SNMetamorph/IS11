Unit Vertic;
  Interface
Uses Crt;
Type PtrVertic = ^StackVertic;
     StackVertic = record
     Number: integer;
     Name: string[20];
     Next: PtrVertic
end;
Type PtrHoriz = ^StackHoriz;
     StackHoriz = record
     Number: integer;
     Group: string[10];
     Head: PtrVertic;
     Next: PtrHoriz;
end;

procedure FlipVertic(var Vertic: PtrVertic);//Переворот списка студентов
procedure FlipHoriz( var Horiz: PtrHoriz);//Переворот списка групп
procedure MakeMenuVertic(var Vertic: PtrVertic);//Создание списка студентов
procedure MakeMenuHoriz;//Создание списка групп
procedure PutMenuVertic(Vertic: PtrVertic; n: integer);//Вывод списка студентов под выбранной группой
procedure ChoiceMenuHoriz;//Выбор группы
procedure Wait;

procedure MenuVertic;{меню}

  Implementation
  
var 
  Horiz: PtrHoriz;

procedure FlipVertic(var Vertic: PtrVertic);//Переворот списка студентов
var 
  Top, Last: PtrVertic;
begin
  New(Top);
  Top^.Next:= Nil;
  Top^.Number:= Vertic^.Number;
  Top^.Name:= Vertic^.Name;
  Vertic:= Vertic^.Next;
  Last:= Top;
  while Vertic <> Nil do
  begin
    New(Top);
    Top^.Next:= Last;
    Top^.Number:= Vertic^.Number;
    Top^.Name:= Vertic^.Name;
    Vertic:= vertic^.next;
    Last:= Top;
  end;
  Vertic:= last;
end;

procedure FlipHoriz( var Horiz: PtrHoriz);//Переворот списка групп
var 
  Top, Last: PtrHoriz;
begin
  New(Top);
  Top^.Next:= Nil;
  Top^.Number:= Horiz^.Number;
  Top^.Group:= Horiz^.Group;
  Top^.Head:= Horiz^.Head;
  Horiz:= Horiz^.Next;
  Last:= Top;
  while Horiz <> Nil do
  begin
    New(Top);
    Top^.Next:= Last;
    Top^.Number:= Horiz^.Number;
    Top^.Group:= Horiz^.Group;
    Top^.Head:= Horiz^.Head;
    Horiz:= Horiz^.Next;
    Last:=Top;
  end;
  Horiz:= Last;
end;

procedure MakeMenuVertic(var Vertic: PtrVertic);//Создание списка студентов
var 
  Top: PtrVertic;
  ok: boolean;
  NameValue: string[20];
  k: integer;
begin
  ok:= true;
  Vertic:= nil;
  k:= 0;
  while ok do 
  begin
    writeln('Введите фамилию (буква N чтобы завершить ввод):');
    readln(namevalue);
    k:=k+1;
    if (NameValue = 'N') or
       (NameValue = 'n') or
       (NameValue = 'Т') or
       (NameValue = 'т') then
      ok:= false
    else  
    begin
      New(Top);
      Top^.Next := Vertic;
      Top^.Number := k;
      Top^.Name := NameValue;
      Vertic:= Top;
    end;
  end;
  FlipVertic(Vertic);
end;

procedure MakeMenuHoriz;//Создание списка групп
var 
  Vertic: PtrVertic;
  Top: PtrHoriz;
  GroupValue: string[10];
  ok: boolean;
  k: integer;
begin
  ok:= true;
  Horiz:= nil;
  k:= 0;
  while ok do
  begin
    writeln('Введите название группы (буква N чтобы завершить ввод):');
    readln(GroupValue);
    k:=k+1;
    if (GroupValue = 'N') or
       (GroupValue = 'n') or
       (GroupValue = 'Т') or
       (GroupValue = 'т') then 
      ok := false
    else
    begin
      New(top);
      Top^.Next:= Horiz;
      Top^.Number:= k;
      Top^.Group:= GroupValue;
      MakeMenuVertic(Vertic);
      Top^.Head:= Vertic;
      Horiz:= Top;
    end;
  end;
end;

procedure PutMenuVertic(Vertic: PtrVertic; n: integer);//Вывод списка студентов под выбранной группой
var
  Top: PtrVertic;
  PozX, PozY: integer;
begin
  Top:= Vertic;
  PozY:= 2;
  PozX:= 12 * n - 7;
  while Top <> Nil do
  begin
    PozY:= PozY + 1;
    GoToXY(PozX, PozY);
    write(Top^.Name);
    Top:= Top^.Next;
  end;
end;

procedure ChoiceMenuHoriz;//Выбор группы
var Top: PtrHoriz;
    k, n: integer;
begin
  FlipHoriz(Horiz);
  Top:= Horiz;
  K:= 0;
  FlipHoriz(Horiz);
  while Top <> Nil do 
  begin
    n:=n+1;
    write(n:5,'.',Top^.Group:6);
    Top:= Top^.Next;
  end;
  GoToXy(30, 22);
  writeln('Выберите пункт меню');
  GoToXy(39, 24);
  read(n);
  Top:= Horiz;
  k:= 1+Horiz^.Number;
  while (Top^.Number + n <> k) do
    Top:= Top^.Next;
  PutMenuVertic(Top^.head, n);
end;

procedure Wait;
begin
  repeat until keyPressed;
  while keyPressed do readKey
end;

procedure MenuVertic; {меню}
var 
  ok: boolean;
  Mode: integer;
begin
  Ok:=true;
  while (Ok) do
  begin
    clrscr;
    writeln('Укажите операцию:');
    writeln('  1:Создание списков');
    writeln('  2:Просмотр списков');
    writeln('  0:Выход');
    GoToXY(40, 17);
    readln(Mode);
    GoToXY(40, 17);
    clearline;
    clrscr;     
    case Mode of
         
     1: 
        begin 
          MakeMenuHoriz;
          Wait;
        end;
          
     2: 
        begin
          ChoiceMenuHoriz;
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