unit CompVect;

  Interface
uses crt, Compl;
const 
  n = 3;
type 
  VectorC = array[1..n] of Complex;

procedure InputVectorC(x,y:integer; var z:VectorC);{Ввод}
procedure OutputVectorC(x,y:integer; z:VectorC); {Вывод}
procedure OutputC(x,y:integer; var z:Complex);
procedure InputC(x,y:integer; var z:Complex);   
procedure AddVectorC(x,y:VectorC; var z:VectorC);{Сложение компл. векторов}
function  ScalProdVectorC (x,y: VectorC): Complex; {Скалярное произведеие компл. векторов}
procedure VectProdC(x, y: VectorC;  var z: VectorC); {Векторное произведение компл. векторов}
function MixProdC(x,y,z: VectorC): Complex;  {Смешанное произведение комплексных векторов}
function ModulVectorC(x:VectorC):real;{Модуль комплексного вектора}

procedure MenuCompVect;{меню}

  Implementation
procedure InputVectorC(x,y:integer; var z:VectorC); {ввод}
var i:integer;
  begin
     for i:=1 to n do
      begin  
       InputC(i*x+10*i,y,z[i]);
       OutputC(i*x+10*i,y,z[i]);
      end;
  end;
  
procedure OutputVectorC(x,y:integer; z:VectorC); {вывод}
var i:integer;
  begin
     GoToXY(x,y);
     for i:=1 to n do
        OutputC(i*x+10*i,y,z[i]);
  end;

procedure InputC(x,y:integer; var z:Complex);
  begin
       GoToXY(x,y+1); readln(z.Re);
       GoToXY(x+7,y+1); readln(z.Im);
       GoToXY(x,y+1);
       writeln('(',z.Re,')+i*(',z.Im,')');
  end;
  
procedure OutputC(x,y:integer; var z:Complex);
  begin
       GoToXY(x,y+1);
       writeln('(',z.Re,')+i*(',z.Im,')');
  end;


procedure AddVectorC(x,y: VectorC; var z: VectorC);{Сложение компл. векторов}
var 
  i:integer;
begin
  for i:=1 to n do 
    Add(x[i],y[i],z[i]);
end;
  
function  ScalProdVectorC (x,y: VectorC): Complex;{Скалярное произведеие компл. векторов}
var i:integer; p,s:Complex;
begin
   Zero(s);
   for i:=1 to n do
   begin
     Codj(y[i],y[i]);
     Mult(x[i],y[i],p);
     Add(s,p,s);
   end;
   ScalProdVectorC:= s; end;

procedure VectProdC(x,y: VectorC; var z: VectorC);{Векторное произведение компл. векторов}
var 
  w,s:Complex;
begin
   Mult(x[2],y[3],s); Mult(x[3],y[2],w); Prod(-1,w,w); Add(s,w,z[1]);
   Mult(x[3],y[1],s); Mult(x[1],y[3],w); Prod(-1,w,w); Add(s,w,z[2]);
   Mult(x[1],y[2],s); Mult(x[2],y[1],w); Prod(-1,w,w); Add(s,w,z[3]);
end;

function MixProdC(x,y,z: VectorC): Complex;{Смешанное произведение комплексных векторов}
var 
  w:VectorC;
begin
   VectProdC(y,z,w);
   MixProdC := ScalProdVectorC(x,w);
end;  

function ModulVectorC(x:VectorC):real;{Модуль комплексного вектора}
var 
  i:integer; s:real;
begin
  for i:=1 to n do 
    s := s + (x[i].Re*x[i].Re)+(x[i].Im*x[i].Im);
  ModulVectorC:= s;
end;  

procedure Wait;
  begin
    repeat until KeyPressed;
    while KeyPressed do ReadKey;
  end;

procedure MenuCompVect;
var 
  Mode:integer;
  Ok:boolean; 
  b:real; 
  f,w:Complex;
  x,y,z:VectorC;
begin
     Ok:=true;
     while (Ok) do
      begin
       clrscr;
       writeln('Укажите операцию:');
       writeln('   1:Сумма комплексных векторов');
       writeln('   2:Скалярное произведение комплексных векторов');
       writeln('   3:Векторное произведение комплексных векторов');
       writeln('   4:Смешанное произведение комплексных векторов');
       writeln('   5:Модуль комплексного вектора');
       writeln('   0:Выход');
       GoToXY(40, 17);
       readln(Mode);
       GoToXY(40, 17);
       clearline;
       clrscr;
      case Mode of
        
      1: 
        begin{Сложение компл. векторов}
          Writeln('Введите первый компл. вектор: ');
          InputVectorC(3,1,x);
          Writeln('Введите второй компл. вектор: ');
          InputVectorC(3,3,y);
          AddVectorC(x,y,z);
          Writeln('Сумма компл. векторов: ');
          OutputVectorC(3,5,z);
          Wait;
         end;
         
      2: 
        begin{Скалярное произведеие компл. векторов}
          Writeln('Введите первый компл. вектор: ');
          InputVectorC(3,1,x);
          Writeln('Введите второй компл. вектор: ');
          InputVectorC(3,3,y);
          f := ScalProdVectorC(x,y);
          Writeln('Cкалярное произведение: ');
          OutputC(13,5,f);
          Wait;
         end;
         
      3: 
        begin {Векторное произведение компл. векторов}
          Writeln('Введите первый компл. вектор: ');
          InputVectorC(3,1,x);
          Writeln('Введите второй компл. вектор: ');
          InputVectorC(3,3,y);
          VectProdC(x,y,z);
          Writeln('Векторное произведение: ');
          OutputVectorC(3,5,z);
          Wait;
         end;
         
      4: 
        begin {Смешанное произведение комплексных векторов}
          Writeln('Введите первый компл. вектор: ');
          InputVectorC(3,1,x);
          Writeln('Введите второй компл. вектор: ');
          InputVectorC(3,3,y);
          Writeln('Введите третий компл. вектор: ');
          InputVectorC(3,5,y);
          w := MixProdC(x,y,z);
          Writeln('Смешанное произведение компл. векторов: ');
          OutputC(13,7,w);
          Wait;
         end;
         
      5: 
        begin {Модуль комплексного вектора}
          Writeln('Введите компл. вектор: ');
          InputVectorC(3,1,x);
          b :=ModulVectorC(x); 
          Writeln('Модуль компл. вектора: ',b);
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
  