unit CompMatr;

 Interface
uses Compl,Crt;
const
  n= 10;
type
  Matrix = array [1..n, 1..n] of Complex;

procedure InputMatrix(x,y,n:integer; var a:matrix); {Ввод матрицы}
procedure OutputMatrix(x,y,n:integer; var a:matrix);  {Вывод матрицы}
procedure AddMatrix(a, b: matrix; var c: matrix);  {Сложение матриц}
procedure MultMatrix(a, b: matrix; var c: matrix);  {Умножение матриц}
procedure ProdMatrix(x: real; a: Matrix; var b: Matrix); {Матрицу умножить на скаляр}
procedure ZeroMatrix(var a: Matrix);{Нулевая матрица}
procedure OneMatrix(var a: Matrix);{Единичная матрица}
function Norm1Matrix(var a: matrix): real;  {1-я норма матрицы}
function Norm2Matrix(var a: matrix): real;  {2-я норма матрицы}
procedure ExpMatrix(a:matrix; var s:matrix); {Экспонента матрицы}

procedure MenuCompMatr;{меню}

Implementation

procedure InputMatrix(x,y,n:integer; var a:Matrix);{Ввод компл. матрицы}
var i,j: integer;
  begin
    for i:= 1 to n do 
      for j:= 1 to n do 
           begin
        GoToXY(x+10*i,y+2*j);
       read(A[i,j].Re);
      GoToXY(2+x+10*i,y+2*j);
      write('+i*');
      GoToXY(5+x+10*i,y+2*j);
       read(A[i,j].Im);
        end;
  end;
 
procedure OutputMatrix(x,y,n:integer; var a:Matrix); {Вывод матрицы}
var i,j: integer;
  begin
     for i:= 1 to n do 
      for j:= 1 to n do 
         begin
        GoToXY(x+10*i,y+2*j);
        write('(',A[i,j].Re,'+i*',A[i,j].Im,')');
        end;
  end;
  
procedure OutputMatrixExp(x,y:integer; var a:Matrix); {Вывод матрицы}
var i,j: integer;
  begin
     for i:= 1 to n do 
      for j:= 1 to n do 
         begin
        GoToXY(x+10*i,y+2*j);
        write('(',(A[i,j].Re):2:2,'+i*',(A[i,j].Im):2:2,')');
        end;
  end;

procedure AddMatrix(a, b: Matrix; var c: Matrix);  {Сложение компл. матриц}
var
  i, j: integer;
begin
  for i := 1 to n do 
    for j := 1 to n do 
      Add(a[i, j], b[i, j], c[i, j]);
end;

procedure MultMatrix(a, b: Matrix; var c: Matrix); {Умножение компл. матриц}
var i,j,k:integer;
var p,s:Complex;
begin
  for i:=1 to n do 
    for j:=1 to n do 
    begin
      Zero(s);
      for k:=1 to n do 
      begin
        Mult(a[i,k],b[k,j],p);
        Add(s,p,s);
      end;
      c[i,j]:=s;
    end;
end;

procedure ProdMatrix(x: real; a: Matrix; var b: Matrix);{Матрицу умножить на скаляр}
var 
  i, j: integer;
begin
  for i := 1 to n do  
    for j := 1 to n do
      Prod(x, a[i, j], b[i, j]);           
end;

procedure ZeroMatrix(var a: Matrix);{Нулевая матрица}
var 
  i, j: integer;
begin
  for i := 1 to n do  
    for j := 1 to n do
      Zero(a[i, j]);           
end;

procedure OneMatrix(var a: Matrix);{Единичная матрица}
var 
  i: integer;
begin
  ZeroMatrix(a);
  for i := 1 to n do  
    One(a[i, i]);           
end;

function Norm1Matrix(var a: matrix): real;  {1-я норма матрицы} 
var
  i, j: integer;
  z, s: real;
begin
  z := 0;
  for i := 1 to n do                            
  begin
    s := 0;
    for j := 1 to n do
    begin
      s := s + Modul(a[i, j]);
      if s > z then 
        z := s;
    end; 
  end;
  Norm1Matrix := z;
end;

function Norm2Matrix(var a: matrix): real;  {2-я норма матрицы} 
var
  i, j: integer;
  z, s: real;
begin
  z := 0;
  for j := 1 to n do                            
  begin
    s := 0;
    for i := 1 to n do
    begin
      s := s + Modul(a[i, j]);
      if s > z then 
        z := s;
    end; 
  end;
  Norm2Matrix := z;
end;

procedure ExpMatrix(a:Matrix; var s:Matrix);{Экспонента матрицы}
const eps=0.001;
var p:Matrix;
   k: integer;
begin
  k:=0;
  OneMatrix(s);
  OneMatrix(p);
  while Norm1Matrix(p)>= eps do
  begin
    k:=k+1;
    MultMatrix(p,a,p);
    ProdMatrix(1/k,p,p);
    AddMatrix(s,p,s);
    end;
  end;

procedure MenuCompMatr;
var
  ok: boolean;
  Mode: integer;
  U, V, W: Matrix;
  Scl: real;
begin
  ok := true; 
  while (ok) do
  begin
    clrscr;
    writeln('Укажите операцию:');
    writeln('  1: Сложение компл. матриц');
    writeln('  2: Умножение компл. матриц');
    writeln('  3: Умножение компл. матрицы на скаляр');
    writeln('  4: Нулевая компл. матрица');
    writeln('  5: Единичная  компл. матриц');
    writeln('  6: 1-я норма компл. матрицы');
    writeln('  7: 2-я норма компл. матрицы');
    writeln('  8: Экспонента матрицы');
    writeln('  0: Выход');
    gotoxy(40, 17);
    readln(Mode);
    gotoxy(40, 17);
    ClrScr;
    case Mode of
    
      1:
        begin  {Сложение компл. матриц}
          clrscr;
          Writeln('Введите комплексную матрицу №1');
          InputMatrix(5,1,n,U);
          Writeln('Введите комплексную матрицу №2');
          InputMatrix(5,6,n,V);
          AddMatrix(U, V, W);
          Writeln('Сумма данных комплексных матриц:');
          OutputMatrix(5,11,n,W);
          Wait;
        end;
        
      2:
        begin  {Умножение компл. матриц}
          clrscr;
          Writeln('Введите комплексную матрицу №1');
          InputMatrix(5,1,n,U); 
          Writeln('Введите комплексную матрицу №2');
          InputMatrix(5,6,n,V);
          MultMatrix(U, V, W);
          Writeln('Произведение данных комплексных матриц:');
          OutputMatrix(5,11,n,W);
          Wait;
        end;
            
      3:
        begin  {Умножение компл. матрицы на скаляр}
          Clrscr;   
          Write('Введите скаляр, на который следует умножить комп. матрицу: ');  
          Read(scl);
          Writeln('Введите комплексную матрицу: ');
          InputMatrix(5,1,n,U);
          ProdMatrix(scl, U, W);  
          Writeln('Ответ: ');
          OutputMatrix(5,6,n,W);
          Wait;
        end;
        
       4:
        begin  {Нулевая матрица}
          Clrscr;
          Writeln('Введите комплексную матрицу: ');
          InputMatrix(5,1,n,U);
          ZeroMatrix(U);
          Writeln('Нулевая матрица: ');
          OutputMatrix(5,6,n,U);
          Wait;
        end;
        
       5:
        begin  {Единичеая матрица}
          Clrscr; 
          Writeln('Введите комплексную матрицу: ');
          InputMatrix(5,1,n,U);
          OneMatrix(U);
          Writeln('Единичная матрица: ');
          OutputMatrix(5,6,n,U);
          Wait;
        end;
        
      6:
        begin  { 1-я Норма компл. матрицы}
          clrscr;
          Writeln('Введите комплексную матрицу: ');
          InputMatrix(5,1,n,U);
          Writeln;
          Writeln('1-я Норма матрицы = ', Norm1Matrix(U));
          Wait;
        end;
        
      7:
        begin  { 2-я Норма компл. матрицы}
          clrscr;
          Writeln('Введите комплексную матрицу: ');
          InputMatrix(5,1,n,U);
          Writeln;
          Writeln('2-я Норма матрицы = ', Norm2Matrix(U));
          Wait;
        end;
        
      8:
        begin {Экспонента матрицы}
          Writeln('Введите комплексную матрицу: ');
          InputMatrix(5,1,n,U);
          ExpMatrix(U,W);
          OutputMatrixExp(10,6,W);
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