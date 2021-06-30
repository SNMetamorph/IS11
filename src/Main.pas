Uses
  Crt, Compl, CompMatr, RealVect, CompVect, Izbrannoe, Stack, Queue,  Vertic, Files,BinTree,Tree,TreeMass,TextFiles,exam ;
var
  Mode:integer;
  ok: boolean; 
begin
  ok := true; 
  while ok do
  begin
  ClrScr;
    writeln('Укажите режим:');
    writeln('   1.Комплексные числа');
    writeln('   2.Комплексные матрицы');
    writeln('   3.Векторы');
    writeln('   4.Комплексные векторы');
    writeln('   5.Избранное');
    writeln('   6.Стеки');
    writeln('   7.Очереди');
    writeln('   8.Списки групп');
    writeln('   9.Файлы записи');
    writeln('   10.Текстовые файлы');
    writeln('   11.Деревья');
    writeln('   12.Деревья массив');
    writeln('   13.Бинарные деревья');
    writeln('   14.Экзамен');
    writeln('   0.Выход');
    GoToXY(40,17); readln(Mode);
    GoToXY(40,17); writeln('    ');
    case Mode of
      1:MenuComplex;
      2:MenuCompMatr;
      3:MenuRealVect;
      4:MenuCompVect;
      5:MenuIzbrannoe;
      6:MenuStack;
      7:MenuQueue;
      8:MenuVertic;
      9:MenuFiles;
      10:MenuTextFiles;
      11:MenuTtree;
      12:TreeMenu;
      13:StartTree;
      14:MenuExam;
      0:ok:=false
    else
     begin
      GoToXY(40,17);
      writeln('Ошибка!Повторите ввод!');
      delay(1000);
     end;
    end; 
   end;
   GoToXY(29,29);
end.