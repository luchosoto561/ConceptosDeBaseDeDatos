
Program punto6;



{ realizar un programa que permita crear un archivo binario a partir de la info almacenada en un
archivo de texto, el nombre del archivo de textos es libros.txt, cada libro se almacena en tres 
lineas del archivo de texto, la primera linea contiene isbn y titulo, la segunda almacena el anio 
de edicion y editorial y la tercera linea almacena el genero del libro. 
ANALICE OTRAS POSIBLES FORMAS DE REPRESENTAR LA INFORMACION EN EL TXT}

Type 

  tipoLibro = Record
    ISBN : integer;
    titulo : string[30];
    genero : string[30];
    editorial : string[30];
    anioEdicion : integer;

  End;

  tipoArch = file Of tipoLibro;


Var 
  arch : tipoArch;
  libro : tipoLibro;
  txt : TextFile;
  opcion : integer;
Begin
  assign(arch, 'binariop6');
  rewrite(arch);
  assign(txt, 'libros.txt');
  reset(txt);
  {en este momento ya puedo leer del txt y escribir en el binario }
  While (eof(txt)) Do
    Begin
      read(txt, libro.ISBN);
      readln(txt, libro.titulo);
      read(txt,libro.anioEdicion);
      readln(txt, libro.editorial);
      readln(txt, libro.genero);
      write(arch, libro);
    End;
  close(txt);

{inciso b. abrir el archivo binario y que se permita la actualizacion del mismo. se debe poder 
agregar un libro y modificar uno existente.}
  reset(arch);
  writeln(
'ingrese 1 si quiere agregar un libro nuevo y dos si quiere modificar uno existente'
  );
  readln(opcion);
  Case opcion Of 
    1:
       Begin
         writeln(
'ingrese primero el ISBN, luego el titulo, luego el genero, luego la editorial, luego el anio de edicion'
         );
         readln(libro.ISBN);
         readln(libro.titulo);
         readln(libro.genero);
         readln(libro.editorial);
         readln(libro.anioEdicion);
         write(arch, libro);

       End;
    2:
       Begin
         writeln(
'tengo que recorrer el archivo binario buscando el registro, cuando lo encuentro me tengo que posicionar en filepos-1 y ahi escribir el archivo actualizado'
         );

       End;

    Else
      writeln('opcion invalida');
  End;

End.

{en este ejemplo nos damos cuenta de la diferencia entre el read y el readln, el read lee un elemento y lo intenta
convertir al elemento especificado, mientras que el readln lee hasta el final de la linea y se come el enter}
