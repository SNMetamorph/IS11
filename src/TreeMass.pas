Unit TreeMass;

interface

uses Crt;

const
  n = 11;

type
  Node = record
    ch: char;
    left, right: byte;
  end;

var
  Tree: array[1..n] of Node;

procedure WayUpDown(next: byte);
procedure WayDownUp(next: byte);
procedure WayHoriz(next, level: byte);
procedure SaveTree;
procedure ReadTree;
procedure TreeMenu;

implementation

procedure WayUpDown(next: byte);
begin
  if (next <> 0) then
    with Tree[next] do
    begin
      write(ch);
      WayUpDown(left);
      WayUpDown(right);
    end;
end;

procedure WayDownUp(next: byte);
begin
  if(next <> 0) then
    with Tree[next] do 
    begin
      WayDownUp(left);
      WayDownUp(right);
      write(ch);
    end;
end;

procedure WayHoriz(next, level: byte);
begin
  if(next <> 0) then
    with Tree[next] do 
      if(level = 1) then 
        write(ch)
      else
      begin
        WayHoriz(left, level - 1);
        WayHoriz(right, level - 1);
      end;
end;

procedure SaveTree;
var
  ok: boolean;
  i: integer;
  ch: char;
  left, right: byte;
  TreeTableFile: file of Node;
  TreeNode: Node;
  fileName: string[12];
begin
  writeln('Дайте файлу имя');
  readln(fileName);
  assign(TreeTableFile, FileName);
  rewrite(TreeTableFile);
  for i := 1 to n do
  begin
    clrScr;
    writeln('Строка ', i);
    writeln;
    with TreeNode do
    begin
      writeln('Введите символ');
      readln(ch);
      writeln('Введите левое значение');
      readln(left);
      writeln('Введите правое значение');
      readln(right);
    end;
    write(TreeTableFile, TreeNode);
  end;
  close(TreeTableFile);
end;

procedure ReadTree;
var
  fileName: string[12];
  TreeTableFile: file of Node;
  TreeNode: Node;
  i: integer;
begin
  clrscr;
  writeln('Введите имя файла с деревом');
  read(fileName);
  assign(TreeTableFile, fileName);
  reset(TreeTableFile);
  while not EOF(TreeTableFile) do
    for i := 1 to n do
    begin
      read(TreeTableFile, TreeNode);
      Tree[i].ch := TreeNode.ch;
      Tree[i].left := TreeNode.left;
      Tree[i].right := TreeNode.right;
     // writeln(Tree[i].ch:3, Tree[i].left:3, Tree[i].right:3);
    end;
  close(TreeTableFile);
end;

procedure Wait;
begin
  repeat until KeyPressed;
  while KeyPressed do ReadKey;
end;

procedure TreeMenu;
var
  Mode, i: integer;
  ok: boolean;
  level: byte;
begin
  ok := true;
  while ok do
  begin
    clrscr;
    gotoXY(3,4);
    writeln('Выберите операцию');
    GotoXY(1, 5);
    writeln('   1.Создать дерево');
    GotoXY(1, 6);
    writeln('   2.Обход сверху вниз');
    GotoXY(1, 7);
    writeln('   3.Обход снизу вверх');
    GotoXY(1, 8);
    writeln('   4.Обход по горизонтали');
    GotoXY(1, 9);
    writeln('   0.Выход');
    GoToXY(22, 4);
    readln(Mode);
    ClrScr; 
    case Mode of 
      1:
        begin
          SaveTree;
          clrscr;
          writeln('Дерево записано');
          Wait;
        end;
      2: 
        begin
          ReadTree;
          WayUpDown(1);
          Wait;
        end;
      3: 
        begin
          ReadTree;
          WayDownUp(1);
          Wait;
        end;
      4: 
        begin
          ReadTree;
          writeln('Введите уровень');
          read(level);
          WayHoriz(1, level);
          Wait;
        end;
      0: ok := false;
    end;
  end;
end;

end.