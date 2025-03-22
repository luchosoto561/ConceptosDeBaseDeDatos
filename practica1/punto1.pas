
Program punto1;








{Realizar un programa que permita crear un archivo conteniendo información de
nombres de materiales de construcción, el archivo no es ordenado. Efectúe la
declaración de tipos correspondiente y luego realice un programa que permita la
carga del archivo con datos ingresados por el usuario. El nombre del archivo
debe
ser proporcionado por el usuario. La carga finaliza al procesar el nombre ‘
cemento’
que debe incorporarse al archivo.}

Type 
  nombrematerial = Record
    nombre : string[30];
  End;

  archivo = file Of nombrematerial;

Var 
  arch : archivo;
  nombre : string[30];
  nm : nombrematerial;
Begin
  write('ingrese el nombre logico del archivo');
  Readln(nombre);
  Assign(arch, nombre);
  Rewrite(arch);
  Write('ingrese el nombre del material que desea cargar en el archivo');
  Readln(nm.nombre);

  While (nm.nombre <> 'cemento') Do
    Begin
      Write(arch,nm);
      Write('ingrese el nombre del material que desea cargar en el archivo');
      Readln(nm.nombre);
    End;
  Close(arch);

End.
