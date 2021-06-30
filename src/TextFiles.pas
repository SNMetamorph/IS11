Unit TextFiles;
  Interface
Uses crt;

var
   Mode: byte;
   ok: boolean;
    
procedure MyWrite(stroka: string);//не арабский вывод
procedure MakeAndAddText;// создание и добавление т. файла
procedure ViewText;//просмотр т.файла
procedure BadBoys(Exam: byte);//двойка по одному предмету
procedure ReallyBadBoys;//две или более двоек 
procedure VeryBadBoys;//все двойки
procedure Wait;

procedure MenuTextFiles;{меню}

  Implementation   
procedure MyWrite(stroka: string);//не арабский вывод
var 
  result: string;
  i, n: byte;
begin
  result:= stroka;
  n:= length(stroka);
  i:= 1;
  while (result[i] = ' ') and (i <= n) do 
    i:= i + 1;
  delete(result, 1, i - 1);
  write(result);
end;

procedure MakeAndAddText;// создание и добавление т. файла
var 
  ch: char;
  ok: boolean;
  TextName: string[12];
  Name: string[10];
  Mark: string[3];
  StudentText: Text;
begin
  ok:= True;
  writeln('Введите имя файла:');
  readln(TextName);
  assign(StudentText, TextName);
  {$I-} append(StudentText); {$I+}
  if not FileExists(TextName) then
    rewrite(StudentText);
  while ok do
  begin
    GoToXY(30, 10);
    writeln('Будете еще вводить? y/n');
    GoToXY(30, 11);
    readln(ch);
    clrscr;
    GoToXY(30, 11);
    writeln(' ');
    if (ch = 'N') or
       (ch = 'n') or
       (ch = 'Т') or
       (ch = 'т') then
    begin
      ok:= False;
      close(StudentText);
    end
    else
    begin
      GoToXY(30, 20);
      writeln('Введите фамилию студента:');
      GoToXY(30, 21);
      readln(Name);
      clrscr;
      GoToXY(30, 22);
      writeln('Введите его оценки:');
      GoToXY(30, 23);
      readln(Mark);
      clrscr;
      write(StudentText, Name:10, Mark:3);
    end;
  end;
end;

procedure ViewText;//просмотр т.файла
var
  k: byte;
  ch: char;
  TextName: string[12];
  Name: string[10];
  Mark: string[3];
  StudentText: Text;
begin
  clrscr;
  k:= 3;
  writeln('Введите имя файла:');
  readln(TextName);
  assign(StudentText, TextName);
  {$I-} reset(StudentText); {$I+}
  if not FileExists(TextName) then 
    writeln('Файл', TextName, ' не найден')
  else
  begin
    while not EOF(StudentText) do
    begin
      k:= k + 1;
      read(StudentText, Name, Mark);
      GoToXY(1, k);
      MyWrite(Name);
      GoToXY(12, k);
      write(Mark);
    end;
    close(StudentText);
  end;
end;

procedure BadBoys(Exam: byte);//двойка по одному предмету
var
  ch: char;
  k: byte;
  TextName: string[12];
  Name: string[10];
  Mark: string[3];
  StudentText: Text;
begin
   k:= 3;
   writeln('Введите имя файла:');
   readln(TextName);
   assign(StudentText, TextName);
   {$I-} reset(StudentText); {$I+}
   if not FileExists(TextName) then 
     writeln('Файл', TextName, ' не найден')
   else
    begin
      while not EOF(StudentText) do
      begin
        read(StudentText, Name, Mark);
        if Mark[Exam] = '2' then
        begin
          k:= k + 1;
          GoToXY(1, k);
          MyWrite(Name);
        end;
      end;
      close(StudentText);
    end;
end;

procedure ReallyBadBoys;//две или более двоек 
var
  ch: char;
  k: byte;
  TextName: string[12];
  Name: string[10];
  Mark: string[3];
  StudentText: Text;
begin
   k:= 3;
   writeln('Введите имя файла:');
   readln(TextName);
   assign(StudentText, TextName);
   {$I-} reset(StudentText); {$I+}
   if not FileExists(TextName) then 
     writeln('Файл', TextName, ' не найден')
   else
    begin
      while not EOF(StudentText) do
      begin
        read(StudentText, Name, Mark);
        if(((Mark[1] = '2') and (Mark[2] = '2')) 
        or ((Mark[2] = '2') and (Mark[3] = '2'))
        or ((Mark[1] = '2') and (Mark[3] = '2'))
        or ((Mark[1] = '1') and (Mark[2] = '2') and (Mark[3] = '2'))) then
        begin
          k:= k + 1;
          GoToXY(1, k);
          MyWrite(Name);
        end;
      end;
      close(StudentText);
    end;
end;

procedure VeryBadBoys;//все двойки
var
  ch: char;
  k: byte;
  TextName: string[12];
  Name: string[10];
  Mark: string[3];
  StudentText: Text;
begin
   k:= 3;
   writeln('Введите имя файла:');
   readln(TextName);
   assign(StudentText, TextName);
   {$I-} reset(StudentText); {$I+}
   if not FileExists(TextName) then 
     writeln('Файл', TextName, ' не найден')
   else
    begin
      while not EOF(StudentText) do
      begin
        read(StudentText, Name, Mark);
        if Mark = '222' then
        begin
          k:= k + 1;
          GoToXY(1, k);
          MyWrite(Name);
        end;
      end;
      close(StudentText);
    end;
end;

procedure Wait;
  begin
    repeat until KeyPressed;
    while KeyPressed do ReadKey
  end;
  

procedure MenuTextFiles;{меню}
var 
  ok: boolean;
  Mode: integer;
begin
  Ok:=true;
  while (Ok) do
  begin
    clrscr;
    writeln('Укажите операцию:');
    writeln('  1:Создать т.файл');
    writeln('  2:Посмотреть т.файл');
    writeln('  3:Добавить в т.файл');
    writeln('  4:2 по МА');
    writeln('  5:2 по АГ');
    writeln('  6:2 по ОП');
    writeln('  7:Больше или равно двух 2');
    writeln('  8:Все двойки');
    writeln('  0:Выход');
    GoToXY(40, 17);
    readln(Mode);
    GoToXY(40, 17);
    clrscr;  
    case Mode of
         
     1: 
        begin 
           MakeAndAddText;
           gotoxy(30, 21);
           write('Создано!');
           Wait;
          end;
          
     2: 
        begin
          ViewText; 
          Wait;
        end;
          
      3:
        begin
          MakeAndAddText;
          gotoxy(30, 21);
          write('Добавлено!');
          Wait;
        end;
       
      4: 
        begin
          BadBoys(1);
          Wait;
        end;
        
      5: 
        begin
          BadBoys(2);
          Wait;
        end;
        
      6: 
        begin
          BadBoys(3);
          Wait;
        end;
        
      7: 
        begin 
          ReallyBadBoys;
          Wait;
        end;
        
      8: 
        begin
          VeryBadBoys;
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

