
Program punto5;








{ crear un pograma que te permita crear un archivo de flores de america, una vez hecho eso se tienen
que dar varias opciones con distintas cosas para hacer}

Type 

  registro = Record
    numeroespecie : integer;
    alturaMax : integer;
    nombreCientifico : string[30];
    nombreVulgar :  string[30];
    color : string[30];
  End;

  tipoArchivo = file Of registro;


Var 

  archivo : tipoArchivo;
  reg : registro;
  nombreArch : string[30];
  opcion : integer;

Procedure incisoe(Var arch : tipoArchivo);

Var 
  txt : TextFile;
  reg : registro;
Begin
  assign(txt, 'flores.txt');
  rewrite(txt);
  While ( Not eof(arch)) Do
    Begin
      read(arch, reg);
      write(txt, reg.numeroespecie);
      write(txt, ' ');
      write(txt, reg.alturaMax);
      write(txt, ' ');
      write(txt, reg.nombreCientifico);
      write(txt, ' ');
      write(txt, reg.nombreVulgar);
      write(txt, ' ');
      writeln(txt, reg.color);

    End;
  close(txt);
End;

Begin
  writeln('ingrese un nombre para el archivo');
  readln(nombreArch);
  assign(archivo,nombreArch);
  rewrite(archivo);


  writeln(





'ingrese primero numero especie, luego alturaMax, luego nomreCientifico, luego nombreVulgar, luego color'
  );
  readln(reg.numeroespecie);
  readln(reg.alturaMax);
  readln(reg.nombreCientifico);
  If (reg.nombreCientifico <> 'zzz')Then
    Begin
      readln(reg.nombreVulgar);
      readln(reg.color);

      While (reg.nombreCientifico <> 'zzz') Do
        Begin
          write(archivo, reg);
          writeln(





'ingrese primero numero especie, luego alturaMax, luego nomreCientifico, luego nombreVulgar, luego color'
          );
          readln(reg.numeroespecie);
          readln(reg.alturaMax);
          readln(reg.nombreCientifico);
          If (reg.nombreCientifico = 'zzz')Then
            break;
          readln(reg.nombreVulgar);
          readln(reg.color);


        End;




    End;

    {en esta instancia se cargo todo el archivo}
  write('ingrese la opcion 1 que es el inciso e');
  readln(opcion);

  Case opcion Of 
    1:
       Begin
         Reset(archivo);
         incisoe(archivo);
       End;

    Else
      writeln('Opción no válida');
  End;


  close(archivo);

End.
