Unit Compl;

Interface 

uses Crt;
Type Complex = record
      Re, Im : real
end;

procedure Input(x, y: integer; var a: Complex);{Ввод} 
procedure Output(x,y:integer;var a: Complex);{Вывод} 
procedure Add(u, v : Complex; var w : Complex); {Сложение} 
procedure Mult(u, v : Complex; Var w : Complex); {Умножение} 
procedure Inv(z : Complex; Var w : Complex); {Инверсия}
procedure Diviz(u, v: Complex; var w: Complex);{Деление} 
function Modul(z : Complex):real; {Модуль комплексного числа} 
procedure Codj(z : Complex; var w : Complex); {Сопряженное число}
procedure Zero(var z : Complex);{Комплексный ноль}
procedure One(var z : Complex); {Комплексная еденица}
procedure Prod(a : real; z: Complex; var w : Complex); {Комлексное число умножить на скаляр} 
procedure ExpC(z : Complex; var w : Complex);{Экспонента}
procedure CosC(z : Complex; var w : Complex);{Синус}
procedure SinC(z : Complex; var w : Complex);{Косинус}
procedure Wait; 

procedure MenuComplex;{меню}

Implementation
procedure Input(x, y: integer; var a: Complex);{Ввод} 
begin
       GoToXY(x,y+1); readln(a.Re);
       GoToXY(x+7,y+1); readln(a.Im);
       GoToXY(x+5,y+1);
       clearline;
       GoToXY(x+5,y+1);
       writeln(a.Re,'+',a.Im,'i');
end;

procedure Output(x,y:integer;var a: Complex);{Вывод} 
begin
  //gotoxy(x+5,y+1);
  if a.Im > 0 then
    writeln(a.Re, '+', a.Im, 'i')
  else 
    writeln(a.Re, a.Im, 'i');
end;

procedure Add(u, v : Complex; Var w : Complex);{Сложение}
begin
w.Re := u.Re+v.Re;
w.Im := u.Im+v.Im;
end;

procedure Mult(u, v : Complex; Var w : Complex);{Умножение} 
begin
w.Re := u.Re*v.Re - u.Im*v.Im;
w.Im := u.Re*v.Im + u.Im*v.Re;
end;

procedure Inv(z : Complex; Var w : Complex);{Инверсия}
var q : real;
begin
q := sqr(z.Re)+sqr(z.Im);
w.Re := z.Re/q;
w.Im := -z.Im/q;
end;

procedure Diviz(u, v: Complex; var w: Complex);{Деление}
var
  z: Complex;
begin
  Inv(v, z);
  Mult(u, z, w);
end;

function Modul(z:complex):real;{Модуль комплексного числа} 
begin
Modul := sqrt(sqr(z.Re)+sqr(z.Im))
end;

procedure Codj(z : Complex; var w : Complex);{Сопряженное число}
begin
w.Re := z.Re;
w.Im := -z.Im
end;

procedure Zero(var z : Complex);{Комплексный ноль} 
begin
z.Re := 0;
z.Im := 0
end;

procedure One(var z : Complex);{Комплексная еденица} 
begin
z.Re := 1;
z.Im := 0
end;

procedure Prod(a : real; z: Complex; var w : Complex);{Комлексное число умножить на скаляр}
begin
w.Re := a*z.Re;
w.Im := a*z.Im
end;

procedure ExpC(z: Complex; var w : Complex);{Экспанента}
const eps=0.001;
var
   p:Complex;
   k:integer; 
begin
  k:=0; One(p); One(w);
  while Modul(p)>=eps do
  begin
    k:=k+1;
    Mult(p,z,p);
    Prod(1/k,p,p);
    Add(w,p,w);
  end;
end;

procedure CosC(z: Complex; var w : Complex);{Косинус}
const eps=0.001;
var
   z2,p:Complex;
   m:integer; 
begin
  Mult(z,z,z2); m:=0; One(p); One(w);
  while Modul(p)>=eps do
  begin
    m:=m+2;
    Mult(p,z2,p); 
    Prod(-1/m/(m-1),p,p);
    Add(w,p,w);
  end;  
end;

procedure SinC(z: Complex; var w : Complex);{Синус}
const eps=0.001;
var
   p,z2:Complex;
   m:integer; 
begin
    Zero(w); Add(w,z,w); Mult(z,z,z2); One(p); Mult(z,p,p);
    while Modul(p)>=eps do
    begin
      m:=m+2;
      Mult(p,z2,p);
      Prod(-1/m/(m+1),p,p);
      Add(w,p,w);
    end;
end;

procedure Wait;{Ожидание}
begin
  repeat until KeyPressed;
  while KeyPressed do ReadKey;
end;


procedure MenuComplex;
var
  ok: boolean;
  Mode: integer;
  U, V, W: Complex;
  Scl: real;
begin
  ok := true; 
  while (ok) do
  begin
    clrscr;
    writeln('Укажите операцию:');
    writeln('  1: Сложение компл. чисел');
    writeln('  2: Умножение компл. чисел');
    writeln('  3: Инверсия компл. чисел');
    writeln('  4: Деление компл. чисел');
    writeln('  5: Модуль компл. числа');
    writeln('  6: Сопряженное число');
    writeln('  7: Компл. ноль');
    writeln('  8: Компл. единица');
    writeln('  9: Умножение компл. числа на скаляр');
    writeln('  10: Экспонента');
    writeln('  11: Синус');
    writeln('  12: Косинус');
    writeln('  0: Выход');
    GoToXY(40, 17);
    readln(Mode);
    GoToXY(40, 17);
    clearline;
    clrscr;
    case Mode Of
      
        1:
          begin {Сложение компл. чисел}
            clrscr;
            Writeln('Введите первое комплексное число: ');
            Input(3,1,U);
            Writeln('Введите второе комплексное число: ');
            Input(3,3,V);
            Add(U, V, W);
            Writeln('Ответ: ');
            Output(3,5,W);
            Wait;
          end;
        
        
        2:
          begin {Умножение комплексных чисел}
            clrscr;
            Writeln('Введите первое комплексное число: ');
            Input(3,1,U);
            Writeln('Введите второе комплексное число: ');
            Input(3,3,V);
            Mult(U, V, W); 
            Writeln('Ответ');
            Output(3,5,W);
            Wait;
          end;
          
          
        3:
          begin {Инверсия комплексного числа}
            clrscr;
            Writeln('Введите комплексное число: ');
            Input(3,1,U);
            Inv(U,W);
            Writeln('Ваше к.ч. в инверсии: ');
            output(3,3,W);
            Wait;
          end;
        
        4:
          begin {Деление комплексных чисел}
            clrscr;
            Writeln('Введите первое комплексное число: ');
            Input(3,1,U);
            Writeln('Введите второе комплексное число: ');
            Input(3,3,V);
            Diviz(U, V, W); 
            Writeln('Ответ');
            Output(3,5,W);
            Wait;
          end;
           
        5:
          begin {Модуль комплексного числа}
            clrscr;
            Writeln('Введите комплексное число: ');
            Input(3,1,U);
            writeln('Модуль введенного вами к.ч.: ',Modul(U));
            Wait;
          end;
          
        6:
          begin {Сопряженное число}
            clrscr;
            Writeln('Введите комплексное число: ');
            Input(3,1,U);
            Codj(U,W);
            Writeln('Сопр. число:');
            Output(3,3,W);
            Wait;
          end;
          
        7:
          begin {Комплексный ноль}
            clrscr;
            Writeln('Введите комплексное число: ');
            Input(3,1,U);
            Zero(U);
            Writeln('Компл. ноль:');
            Output(3,3,U);
            Wait;
          end;
        
        8:
          begin {Комплексная единица}
            clrscr;
            Writeln('Введите комплексное число: ');
            Input(3,1,U);
            One(U);
            Writeln('Компл. единица:');
            Output(3,3,U);
            Wait;
          end;
          
        9:
          begin {Умножение комплексного числа на скаляр}
            clrscr;
            Writeln('Введите комплексное число: ');
            Input(3,1,U);
            Writeln('Введите число, на которое следует умножить к.ч.: ');
            readln(Scl);
            Prod(Scl,U,W);
            Writeln('Ответ:');
            Output(3,5,W);
            Wait;
          end;
          
        10:
          begin {Экспонента}
            clrscr;
            Writeln('Введите комплексное число: ');
            Input(3,1,U);
            ExpC(U,W);
            Writeln('Экспонента:');
            Output(3,3,W);
            Wait;
          end;
             
        11:
          begin {Синус}
            clrscr;
            Writeln('Введите комплексное число: ');
            Input(3,1,U);
            SinC(U,W);
            Writeln('Синус:');
            Output(3,3,W);
            Wait;
          end;
          
        12:
          begin {Косинус}
            clrscr;
            Writeln('Введите комплексное число: ');
            Input(3,1,U);
            CosC(U,W);
            Writeln('Косинус:');
            Output(3,3,W);
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
