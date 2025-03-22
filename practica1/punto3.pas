
Program punto3;





{Realizar un programa que permita crear un archivo de texto. El archivo se debe
cargar con la información ingresada mediante teclado. La información a cargar
representa los tipos de dinosaurios que habitaron en Sudamérica. La carga
finaliza al procesar el nombre ‘zzz’ que no debe incorporarse al archivo. }

Type 

  dinosaurio = Record
    nombre : string[30];
    peso : real;
    altura : real;

  End;


Var 

  archivo : TextFile;
  dino : dinosaurio;
  nombre : string[30];
Begin
  writeln('ingrese el nombre del archivo de texto');
  readln(nombre);
  assign(archivo,nombre);
  rewrite(archivo);

  writeln(




'ingrese primero el nombre del dinosaurio, luego el peso e kg y luego la altura en metros'
  );
  readln(dino.nombre);
  If (dino.nombre <> 'zzz')Then
    Begin


      readln(dino.peso);
      readln(dino.altura);

      While (dino.nombre <> 'zzz') Do
        Begin
          writeln(archivo, dino.nombre);
          If (dino.nombre = 'zzz')Then
            Break;
          writeln(archivo, dino.peso);
          writeln(archivo, dino.altura);


          writeln(




'ingrese primero el nombre del dinosaurio, luego el peso e kg y luego la altura en metros'
          );
          readln(dino.nombre);
          readln(dino.peso);
          readln(dino.altura);

        End;
    End;
  close(archivo);




End.
