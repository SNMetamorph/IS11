unit RealVect;

 Interface
uses Crt;
const
  n = 3;
type
  vector = array [1..n] of real;

procedure InputV(x,y:integer; var z:Vector);{ввод}
procedure OutputV(x,y:integer; z:Vector); {вывод}
procedure AddVector(x,y:vector; var z:vector);{сложение векторов}
function ScalProd(x,y:vector):real;  {скалярное произведение}
procedure VectProd(x,y:vector; var z:vector); {векторное произведение}
function MixProd(x,y,z:vector):real; {смешанное произведение}
function ModulVector(x:vector ) :real; {модуль вектора}
procedure Wait;

procedure MenuRealVect;{меню}


 Implementation
 
procedure InputV(x,y:integer; var z:Vector);{ввод}
var i:integer;
begin
     GoToXY(x+2,y+1); 
     for i:=1 to n do 
       begin
       GoToXY(x+3*i,y+1);
       read(z[i]);
       end;
     clearline;
     GoToXY(x+2,y+1); 
     writeln('(',z[1],' ; ',z[2],' ; ',z[3],')');
     
end;

procedure OutputV(x,y:integer; z:Vector);{вывод}
begin
     GoToXY(x+2,y+1);
     writeln('(',z[1],' ; ',z[2],' ; ',z[3],')');
end;


procedure AddVector(x,y:vector; var z:vector); {сложение векторов}
var
  i:integer;
begin
  for i:= 1 to n do
    z[i]:=x[i]+y[i];
end;

function ScalProd(x,y:vector):real;{скалярное произведение}
var
  i:integer;
  s:real;
begin
  s:=0;
  for i:=1 to n do
    s:=s+x[i]*y[i];
  ScalProd:=s;
end;

procedure VectProd(x,y:vector; var z:vector);{векторное произведение}
begin
  z[1]:=x[2]*y[3]-x[3]*y[2];
  z[2]:=x[3]*y[1]-x[1]*y[3];
  z[3]:=x[1]*y[2]-x[2]*y[1];
end;

function MixProd(x,y,z:vector):real;{смешанное произведение}
var
  w:vector;
begin
  VectProd(x,y,w);
  MixProd:=ScalProd(w,z);
end;

function ModulVector(x: Vector ):real;{модуль вектора}
var s:real;
i:integer;
begin
  s:=0;
  for i:=1 to n do 
    s:=s+sqr(x[i]);
  ModulVector:=sqrt(s);
end;

procedure Wait;
  begin
    repeat until KeyPressed;
    while KeyPressed do ReadKey;
  end;

procedure MenuRealVect;
     var 
       ok: boolean;
       Mode: integer;
       x,y,z: vector;
       f,w: real;
     begin
     Ok:=true;
     while (Ok) do
     begin
       clrscr;
       writeln('Укажите операцию:');
       writeln('  1:Сумма векторов');
       writeln('  2:Скалярное умножение векторов');
       writeln('  3:Векторное произведение векторов');
       writeln('  4:Смешанное произведение векторов');
       writeln('  5:Модуль вектора');
       writeln('  0:Выход');
       GoToXY(40, 17);
       readln(Mode);
       GoToXY(40, 17);
       clearline;
       clrscr;
       
       case Mode of
         
       1: 
          begin {сложение векторов}
            Writeln('Введите первый вектор: ');
            InputV(3,1,x);
            Writeln('Введите второй вектор: ');
            InputV(3,3,y);
            AddVector(x,y,z);
            Writeln('Сумма векторов: ');
            OutputV(3,5,z);
            Wait;
          end;
          
       2: 
          begin{скалярное произведение}
            Writeln('Введите первый вектор: ');
            InputV(3,1,x);
            Writeln('Введите второй вектор: ');
            InputV(3,3,y);
            f := ScalProd(x,y);
            Writeln('Cкалярное произведение: ',f);
            Wait;
          end;
          
       3:
          begin{векторное произведение}
            Writeln('Введите первый вектор: ');
            InputV(3,1,x);
            Writeln('Введите второй вектор: ');
            InputV(3,3,y);
            VectProd(x,y,z);
            Writeln('Векторное произведение: ');
            OutputV(3,5,z);
            Wait;
          end;
          
       4: 
          begin{смешанное произведение}
            Writeln('Введите первый вектор: ');
            InputV(3,1,x);
            Writeln('Введите второй вектор: ');
            InputV(3,3,y);
            Writeln('Введите третий вектор: ');
            InputV(3,5,z);
            w := MixProd(x,y,z);
            Writeln('Cмешанное произведение: ',w);
            Wait;
          end;
          
        5:
          begin{модуль вектора}
            Writeln('Введите вектор: ');
            InputV(3,1,x);
            f := ModulVector(x);
            Writeln('Модуль данного вектора: ',f);
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
  