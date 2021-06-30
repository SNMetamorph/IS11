Unit TextFile;
 Interface
 uses crt;
  
 procedure MyWrite(stroke:string);                              //Мой вывод
 procedure MakeAndAddText;                                      // Добавляет и создает 
 procedure ViewText;                                            // Показ
 procedure BadBoys(Exam:byte);                                  // Ученики , у которых одна двойка
 procedure ReallyBadBoys(Exam:byte;Exam2:byte);                 // Ученики , у которых две двойки
 procedure VeryReallBadBoys(Exam:byte;Exam2:byte;Exam3:byte);   // Ученики , у которых три двойки
 procedure Wait;
 procedure MenuTextFile;
 
 
 Implementation

procedure MyWrite(stroke:string);
var result:string;
i,n:byte;
begin
  result:=stroke;
  n:=length(stroke);
  i:=1;
  while (result[i]=' ')and (i<=n) do
    i:=i+1;
    delete(result,1,i-1);
    write(result);
end;


procedure MakeAndAddText;
var ch:char;
    ok:boolean;
    TextName:string[12];
    Name:string[10];
    Mark:string[3];
    StudentText:Text;
    begin
      writeln('Введите имя файла');
      readln(textname);
      assign(studenttext,textname);
      {$I-} append (studenttext);
      {$I+} if not FileExists (textname) then
        rewrite (studenttext);
        while ok do begin
          gotoxy(30,10);
       writeln('Будете еще вводить? yes/no ');
       gotoxy(30,10);
       readln(ch);{затитрка}
       if ch='no' then 
       begin
         ok:=false;
         close (studenttext);
       end 
        else
          begin
          gotoxy(30,20);
          writeln('Введите фамилию студента');
          gotoxy(30,21);
          readln(name);{затирка}
          gotoxy(30,22);
          writeln('Введите его оценки');
          gotoxy(30,23);
          readln(mark); {Затирка}
          write(studenttext,name:10,mark:3);
        end;  
        end;
    end;
    
    procedure ViewText;
    var k:byte;
        ch:char;
        TextName:string[12];
        Name:string[10];
        Mark:string[3];
        StudentText:Text;
    begin
      ClrScr;
      k:=3;
      writeln('Введите имя файла');
      readln(textname);
      assign(studenttext,textname);
      {$I-}reset (studenttext);
      {$I+}if not FileExists (textname)then
        writeln ('Файл ',textname,' не найден ')
       else 
       begin
         while not EOF(studenttext)do
         begin
           k:=k+1;
           read(studenttext,name,mark);
           gotoxy(1,k);
           MyWrite(name);
           gotoxy(12,k);
           write(mark);
         end;
         close (studenttext);
       end;
    end;
    
    procedure BadBoys(Exam:byte);
    var ch:char;
    k:byte;
    TextName:string[12];
    Name:string[10];
    Mark:string[3];
    StudentText:Text;
    begin
      ClrScr;
      k:=3;
      writeln('Введите имя файла');
         readln(textname);
      assign(studenttext,textname);
      {$I-}reset (studenttext);
      {$I+}if not FileExists (textname)then
        writeln ('Файл ',textname,' не найден ')
       else 
       begin
         while not EOF(studenttext)do
         begin
           read(studenttext,name,mark);
           if Mark[Exam] = '2' then 
           begin
              k:=k+1;
               gotoxy(1,k);
           MyWrite(name);
           end;
            close (studenttext);
            end;
       end;
    end;
    
    procedure ReallyBadBoys(Exam:byte;Exam2:byte);
    var ch:char;
    k:byte;
    TextName:string[12];
    Name:string[10];
    Mark:string[3];
    StudentText:Text;
    begin
      ClrScr;
      k:=3;
      writeln('Введите имя файла');
         readln(textname);
      assign(studenttext,textname);
      {$I-}reset (studenttext);
      {$I+}if not FileExists (textname)then
        writeln ('Файл ',textname,' не найден ')
       else 
       begin
         while not EOF(studenttext)do
         begin
           read(studenttext,name,mark);
           if ((Mark[exam] = '2') and (Mark[exam2] = '2'))or (Mark[exam] = '2') or (Mark[exam2] = '2')  then 
           begin
              k:=k+1;
               gotoxy(1,k);
           MyWrite(name);
           end;
            close (studenttext);
            end;
       end;
    end;
    
     procedure VeryReallBadBoys(Exam:byte;Exam2:byte;Exam3:byte);
    var ch:char;
    k:byte;
    TextName:string[12];
    Name:string[10];
    Mark:string[3];
    StudentText:Text;
    begin
      ClrScr;
      k:=3;
      writeln('Введите имя файла');
         readln(textname);
      assign(studenttext,textname);
      {$I-}reset (studenttext);
      {$I+}if not FileExists (textname)then
        writeln ('Файл ',textname,' не найден ')
       else 
       begin
         while not EOF(studenttext)do
         begin
           read(studenttext,name,mark);
           if ((Mark[Exam] = '2') and (Mark[Exam2] = '2' )and (Mark[Exam3] = '2') )then 
           begin
              k:=k+1;
               gotoxy(1,k);
           MyWrite(name);
           end;
            close (studenttext);
            end;
       end;
    end;
    procedure Wait;
    begin
      repeat until KeyPressed;
      while KeyPressed do ReadKey;
    end;
    
    procedure MenuTextFile;
    var Mode:integer;
    ok:boolean;
    var ch:char;
    k:byte;
    TextName:string[12];
    Name:string[10];
    Mark:string[3];
    StudentText:Text;
    result:string;
    i,n:byte;
    Exam:byte;Exam2:byte;Exam3:byte;

  begin
    ClrScr;  
    GoToXY(3, 4);
    writeln('Выберите операцию');
    GotoXY(1, 5);
    writeln('   1.Создание текстового файл');
    GotoXY(1, 6);
    writeln('   2.Просмотр текстового файла');
    GotoXY(1, 7);
    writeln('   3.Добавление в текстовый файл');
    GotoXY(1, 8);
    writeln('   4.Должники по математическому анализу');
    GoToXY(1, 9);
    writeln('   5.Должники по алгебре и геометрии ');
    GoToXY(1, 10);
    writeln('   6.Должники по программированию');
    GoToXY(1, 11);
    writeln('   7.Ребята, у кого 1 или 2 двойки ');
    GoToXY(1, 12);
    writeln('   8.Ребята, у кого 3 двойки');
    GoToXY(1, 13);
    writeln('   0.Выход');
    GoToXY(22, 4);
    readln(Mode);
    ClrScr; 
      case Mode of
        1:begin
          MakeAndAddText;
          wait;
          end;
        2: begin
          ViewText;
          wait;
           end;  
        3: begin
          MakeAndAddText;
          wait;
           end;    
        4: begin
          BadBoys (1);
          wait;
           end; 
        5: begin
          BadBoys (2);
          wait;
           end;   
        6: begin
          BadBoys (3);
          wait;
           end; 
        7: begin
          ReallyBadBoys(Exam,Exam2);
          wait;
           end; 
        8: begin
          VeryReallBadBoys(Exam,Exam2,Exam3);
          wait;
           end;
        0: ok := false;
           else
      begin
        GoToXY(30, 21);
        writeln('Ошибка!Повторите ввод!');
        delay(1500);
      end;   
      end;
    end;
    
    end.
    
    