Unit Files;
  Interface
Uses crt;
Type Student = record
     Name: string[10];
     Mark: string[3];
end;

var
  Mode:integer;

procedure WriteBadMarks;//вывод 2 в новый файл
procedure ShowBadMarks;//вывод 2 на экран
procedure AddFile;//Добавление в файл 
procedure ViewFile;//Просмотр файла
procedure MakeFile;//Создание файла записи
procedure Wait;

procedure MenuFiles;{меню}

  Implementation
procedure ViewFile;//Просмотр файла
var 
  k: integer;
  ch: char;
  FileName: string[12];
  StudentFile: file of Student;
  FlowStudent: Student;
begin
  k:= 3;
  writeln('Введите имя файла:');
  readln(FileName);
  assign(StudentFile, FileName);
  reset(StudentFile);
  while not EOF(StudentFile) do 
  begin
    k:=k+1;
    read(StudentFile, FlowStudent);
    GoToXY(1, k);
    write(FlowStudent.Name);
    GoToXY(11, k);
    writeln(FlowStudent.Mark);
  end;
  close(StudentFile);
end;

procedure AddFile;//Добавление в файл 
var 
  ch: char;
  ok: boolean;
  NewName, FileName: string[12];
  NewFile, StudentFile: file of Student;
  FlowStudent: Student;
begin
  ok:= True;
  writeln('Введите имя файла:');
  readln(FileName);
  assign(StudentFile, FileName);
  reset(StudentFile);
  NewName:='aaaa';
  assign(NewFile, NewName);
  rewrite(NewFile);
  while not EOF(StudentFile) do 
  begin
    read(StudentFile, FlowStudent);
    write(NewFile, FlowStudent);
  end;
  with FlowStudent do
  while ok do
  begin
    GoToXY(30, 10);
    writeln('Будете еще вводить? Yes\No');
    GoToXY(30, 11);
    readln(ch);
    clrscr;
    if (ch = 'N') or
       (ch = 'n') or
       (ch = 'Т') or
       (ch = 'т') then
    begin
      ok:=false;
      close(NewFile);
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
      write(StudentFile, FlowStudent);
      write(NewFile,FlowStudent);
    end;
  end; 
  close(StudentFile);
  erase(StudentFile);
  rename(NewFile, FileName);
end;

procedure MakeFile;//Создание файла записи
var 
  ch: char;
  ok: boolean;
  FileName: string[12];
  StudentFile: file of Student;
  FlowStudent: Student;
begin
  ok:= True;
  writeln('Введите имя файла:');
  readln(FileName);
  assign(StudentFile,FileName);
  rewrite(StudentFile);
  with FlowStudent do
  while ok do 
  begin
    GoToXY(30, 10);
    writeln('Будете еще вводить? Yes\No');
    GoToXY(30, 11);
    readln(ch);
    clrscr;
    if (ch = 'N') or
       (ch = 'n') or
       (ch = 'Т') or
       (ch = 'т') then
    begin
      ok:= False;
      close(StudentFile)
    end
    else
    begin
      GoToXY(30, 20);
      writeln('Введите фамилию студента:');
      GoToXY(30, 21);
      readln(Name);
      clrscr;
      GoToXY(30, 22);
      writeln('Введите его оценки');
      GoToXY(30, 23);
      readln(Mark);
      clrscr;
      write(StudentFile, FlowStudent);
    end;
  end;
end;

procedure ShowBadMarks;//вывод 2 на экран
var 
  count, i, k: integer;
  FileName: string[12];
  StudentFile: file of Student;
  FlowStudent: Student;
begin
  k:=4;
  writeln('Введите имя файла:');
  readln(FileName);
  assign(StudentFile,FileName);
  reset(StudentFile);
  writeln('Двоечники:');
  reset(StudentFile);
  while not EOF(StudentFile) do 
  begin
    count:=0;
    read(StudentFile, FlowStudent);
    for i:= 1 to 3 do
    begin
      if(FlowStudent.Mark[i] = '2') then
        count:= count + 1;
    end;
    if (count >= 1) then
    begin
      k:=k+1;
      GoToXY(1, k);
      write(FlowStudent.Name);
      GoToXY(11, k);
      writeln(FlowStudent.Mark);
    end;
   end;
  close(StudentFile);
end;

procedure WriteBadMarks;//вывод 2 в новый файл
var 
  count, i, k: integer;
  FileName: string[12];
  StudentFile: file of Student;
  FlowStudent: Student;
  NewFile: text;
begin
  writeln('Введите имя файла:');
  readln(FileName);
  assign(StudentFile,FileName);
  reset(StudentFile);
  assign(NewFile, 'BabMarks.txt');
  rewrite(NewFile);
  writeln(NewFile, 'Двоечники:');
  while not EOF(StudentFile) do 
  begin
    count:=0;
    read(StudentFile, FlowStudent);
    for i:= 1 to 3 do
    begin
      if(FlowStudent.Mark[i] = '2') then
        count:= count + 1;
    end;
    if (count >= 1) then
    begin
      writeln(NewFile, FlowStudent.Name, ' ', FlowStudent.Mark);
    end;
   end;
  close(StudentFile);
  close(NewFile);
end;

procedure Wait;
  begin
    repeat until KeyPressed;
    while KeyPressed do ReadKey
  end;
  
procedure MenuFiles;{меню}
var 
  ok: boolean;
  Mode: integer;
begin
  Ok:=true;
  while (Ok) do
  begin
    clrscr;
    writeln('Укажите операцию:');
    writeln('  1:Создать файл');
    writeln('  2:Посмотреть файл');
    writeln('  3:Добавить файл');
    writeln('  4:Вывод двоечников на экран');
    writeln('  5:Вывод двоечников в новый файл');
    writeln('  0:Выход');
    GoToXY(40, 17);
    readln(Mode);
    GoToXY(40, 17);
    clearline;
    clrscr;  
    case Mode of
         
     1: 
        begin 
           MakeFile;
           gotoxy(30, 21);
           write('Создано!');
           Wait;
          end;
          
     2: 
        begin
          ViewFile; 
          gotoxy(30, 21);
          Wait;
        end;
          
      3:
        begin
          AddFile;
          gotoxy(30, 21);
          write('Добавлено!');
          Wait;
        end;
       
       4:
        begin
          ShowBadMarks;
          Wait;
        end; 
       
       5:
        begin
         WriteBadMarks;
         gotoxy(30, 21);
         write('Создано!');
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

