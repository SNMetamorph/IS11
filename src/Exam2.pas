unit Exam;
Interface
uses crt, compl;
 procedure Reverse;
 procedure MenuExam;
 procedure wait;
procedure Exam1;
    Implementation
    procedure Wait;
 begin
  repeat
  until KeyPressed;
  while KeyPressed do
  Readkey;
 end;
 procedure Reverse;
const mm=1000; nm=1000;
var
  a: array [1..mm,1..nm] of Real;
  mx, mn, t: Real;
  m, n, i, j, imx, imn: Integer;
begin
  Randomize;
  repeat Write('M [1..',mm,'] N [1..',nm,']: '); ReadLn(m,n); 
  until (m in [1..mm]) and (n in [1..nm]);
  for i:=1 to m do for j:=1 to n do a[i,j]:=Random*10;
  WriteLn('A =');
  for i:=1 to m do begin
    for j:=1 to n do Write(a[i,j]:8:2); WriteLn;
  end;
  imn:=1; imn:=1; mn:=a[1,1]; mx:=a[1,1];
  for i:=1 to m do
    for j:=1 to n do begin
      if mn>a[i,j] then begin imn:=i; mn:=a[i,j]; end;
      if mx<a[i,j] then begin imx:=i; mx:=a[i,j]; end;
    end;
  WriteLn('Строки min: ',imn,', max: ',imx);
  if imn<>imx then
    for j:=1 to n do begin
      t:=a[imn,j]; a[imn,j]:=a[imx,j]; a[imx,j]:=t;
    end;
  WriteLn('A''=');
  for i:=1 to m do begin
    for j:=1 to n do Write(a[i,j]:8:2); WriteLn;
  end;
end;

procedure Exam1;
var z : Complex;
z2: Complex;
S : Complex;
eps : real;
k : integer;
P : Complex;
begin
input(20,20,z);
eps := 1;
writeln('Даны z из множества Комплексных чисел и точность eps > 0.');
writeln('Вычислить сумму.');
k:= 163; 
One(p);
//z.Re:= 2;
//z.Im:= 4;
Mult(z,z,z2);
Zero(S);
while (Modul(P) >= eps) do
begin
Prod(3*(k-1)/k, P, P);
Mult(P, z, P);
Add(P, S, S);
inc(k);
end;
writeln;
writeln('Сумма: ', S.Re, ' + ', S.Im, '*i');
end;
  procedure MenuExam;
   var Mode:integer;
     Ok:boolean;
begin
 Ok:=True;
 while Ok do
  begin
   ClrScr;
   writeln(' Выберите пункт');
   writeln(' 1: сумма');
   writeln(' 2: перевернуть');
   writeln(' 0: Выход');
   readln(Mode);
    case Mode of
     1:begin
        ClrScr;
        Exam1;
        Wait;
       end; 
       2:begin
        ClrScr;
        Reverse;
        Wait;
       end;
         0: begin
         exit;
        end;
       end;
      end;
    end;
  end.
