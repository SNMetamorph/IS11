Unit Tree;
Interface
Uses Crt;

Type NodePtr = ^Node;
     Node = record
     Name: char;
     Key: byte;
     Left, Right: NodePtr
 end;
 
procedure MakeSubTrees(Leaf:NodePtr);
Procedure Wait;
Procedure MakeTree(var Top: NodePtr);
Procedure WayUpDown(Top: NodePtr);
Procedure WayDownUp(Top: NodePtr);
Procedure WayHoriz(Top: NodePtr; Level: byte);
Function High(Top: NodePtr): byte;
Procedure ViewTree(Top: NodePtr);
Procedure SearchNode(Top: NodePtr; var Leaf: NodePtr);
Procedure AddSubTree(Top: NodePtr);
procedure MenuTtree;

Implementation

var 
  Key,Symbol:char;
  Flag:boolean;
  Top,Leaf:NodePtr;
  Level,Mode:byte;
  
procedure MakeSubTrees(Leaf:NodePtr);
var
  top:NodePtr;
begin
  GoToXY(30, 18); 
  writeln('Введите текущий узел:');
  GoToXY(40, 19); 
  readln(Leaf^.Name);
  GoToXY(30, 18); 
  writeln(' ');
  GoToXY(40, 19); 
  writeln(' ');
  GoToXY(25, 20); 
  writeln(Leaf^.Name, ' имеет левое поддерево?:');
  GoToXY(40, 21); 
  readln(Key);
  GoToXY(25, 20); 
  writeln(' ');
  GoToXY(40, 21); 
  writeln(' ');
  if Key in ['y', 'Y', 'н', 'Н'] then
  begin
    new(Top); 
    Leaf^.Left := Top; 
    MakeSubTrees(Top)
  end
  else 
    Leaf^.Left := nil;
  GoToXY(25, 20); 
  writeln(Leaf^.Name, ' имеет правое поддерево?:');
  GoToXY(40, 21); 
  readln(Key);
  GoToXY(25, 20); 
  writeln(' ');
  GoToXY(40, 21); 
  writeln(' ');
  if Key in ['y', 'Y', 'н', 'Н'] then
  begin
    new(Top); 
    Leaf^.Right := Top; 
    MakeSubTrees(Top)
  end
else Leaf^.Right := nil;
end;
 
Procedure Wait;
begin
  repeat until KeyPressed;
  while KeyPressed do ReadKey;
end;

Procedure MakeTree(var Top: NodePtr);
begin
  new(Top);
  MakeSubTrees(Top)
end;

Procedure WayUpDown(Top: NodePtr);
begin
  if Top <> nil then
  begin
    write(Top^.Name, ' ');
    WayUpDown(Top^.Left);
    WayUpDown(Top^.Right)
  end
end;

Procedure WayDownUp(Top: NodePtr);
begin
  if Top <> nil then
  begin
    WayDownUp(Top^.Left);
    WayDownUp(Top^.Right);
    write(Top^.Name, ' ')
  end;
end;

Procedure WayHoriz(Top: NodePtr; Level: byte);//выводит вершины одного уровня
begin
  if Top <> nil then
  if Level = 1 then write(Top^.Name, ' ')
  else
  begin
    WayHoriz(Top^.Left, Level - 1);
    WayHoriz(Top^.Right, Level - 1)
  end
end;

Function High(Top: NodePtr): byte;//Функция выводит высоту дерева
var HighLeft, HighRight: byte;
begin
  if Top = nil then High := 0
  else
  begin
    HighLeft := High(Top^.Left);
    HighRight := High(Top^.Right);
    if HighLeft > HighRight then 
      High := HighLeft + 1
  else High := HighRight + 1
  end
end;

Procedure ViewTree(Top: NodePtr);//Процедура выводит дерево
var i, HighTree: byte;
begin
  HighTree := High(Top);
  for i := 1 to HighTree do
  begin
    writeln; 
    WayHoriz(Top, i)
  end
end;

Procedure SearchNode(Top: NodePtr; var Leaf: NodePtr);//ищет узел
begin
  if (Top <> nil) and (Flag = True) then
  begin
    if Symbol = Top^.Name then
    begin
      Flag := False; 
      Leaf := Top
    end
    else
    begin
      SearchNode(Top^.Left, Leaf);
      SearchNode(Top^.Right, Leaf)
    end
  end
end;

//Процедура добавляет поддерево
Procedure AddSubTree(Top: NodePtr);
begin
  GoToXY(30, 18); 
  writeln('Введите искомый узел');
  GoToXY(40, 19); 
  readln(Symbol);
  Flag := True; 
  SearchNode(Top, Leaf); 
  ClrScr;
  if Flag = True then
  begin
    write('Узел ', Symbol, ' не найден'); Wait
  end
  else
  begin
    GoToXY(25, 20);
    writeln('Желаете построить левое поддерево у ', Leaf^.Name, ' ?');
    GoToXY(40, 21); 
    readln(Key);
    GoToXY(23, 20);
    writeln(' ');
    GoToXY(40, 21);
    writeln(' ');
    if Key in ['y', 'Y', 'н', 'Н'] then
    if Leaf^.Left <> nil then
    begin
      GoToXY(25, 19);
      writeln('Левое поддерево у ', Leaf^.Name, ' уже есть');
      GoToXY(25, 20); 
      writeln('Все-таки желаете?');
      GoToXY(40, 21); 
      readln(Key);
      GoToXY(25, 19);
      writeln(' ');
      GoToXY(25, 20); 
      writeln(' ');
      GoToXY(40, 21); 
      writeln(' ');
      if Key in ['y', 'Y', 'н', 'Н'] then
      begin
        MakeTree(Top); 
        Leaf^.Left := Top
      end
    end
    else
    begin
      MakeTree(Top); Leaf^.Left := Top
    end;
    GoToXY(25, 20);
    writeln('Желаете построить правое поддерево у ', Leaf^.Name, ' ?');
    GoToXY(40, 21); 
    readln(Key);
    GoToXY(23, 20);
    writeln(' ');
    GoToXY(40, 21); 
    writeln(' ');
    if Key in ['y', 'Y', 'н', 'Н'] then
    if Leaf^.Right <> nil then
    begin
      GoToXY(25, 19);
      writeln(';Правое поддерево у ', Leaf^.Name, ' уже есть');
      GoToXY(25, 20); 
      writeln('Все-таки желаете?');
      GoToXY(40, 21); 
      readln(Key);
      GoToXY(25, 19);
      writeln(' ');
      GoToXY(25, 20); 
      writeln(' ');
      GoToXY(40, 21); 
      writeln(' ');
      if Key in ['y', 'Y', 'н', 'Н'] then
      begin
        MakeTree(Top); 
        Leaf^.Right := Top
      end
    end
    else
    begin
      MakeTree(Top); 
      Leaf^.Right := Top
    end
  end
end;

procedure MenuTtree;
var ok:boolean;
    Mode, Level:byte;
    Top: NodePtr;
begin
  Ok := True;
  while Ok do
  begin
    ClrScr;
    writeln('Укажите режим:');
    writeln('     1. Создание дерева');
    writeln('     2. Обход сверху вниз');
    writeln('     3. Обход снизу вверх');
    writeln('     4. Обход вершин одного уровня');
    writeln('     5. Высота дерева');
    writeln('     6. Просмотр дерева');
    writeln('     7. Добавление поддерева');
    writeln('     0. Выход');
    GoToXY(40, 23); readln(Mode);
    ClrScr;
    case Mode of
      1: 
         MakeTree(Top);
      2: begin 
           WayUpDown(Top); 
           Wait 
         end;
      3: begin 
           WayDownUp(Top); 
           Wait 
         end;
      4: begin
           GoToXY(30, 18); 
           writeln('Введите уровень');
           GoToXY(40, 19); 
           readln(Level); 
           ClrScr;
           WayHoriz(Top, Level); 
           Wait
         end;
      5: begin 
          writeln(High(Top):3); 
          Wait 
         end;
      6: begin 
          ViewTree(Top); 
          Wait 
         end;
      7: AddSubTree(Top);
      0: Ok := False
    else
    begin
      GoToXY(30, 23); writeln('Ошибка!');
      Wait
    end
    end
  end;
end;
end.