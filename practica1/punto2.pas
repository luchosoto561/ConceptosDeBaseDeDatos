
Program punto2;


{Desarrollar un programa que permita la apertura de un archivo de números
enteros no ordenados. La información del archivo corresponde a la cantidad de votantes
de cada ciudad de la Provincia de Buenos Aires en una elección presidencial.
Recorriendo el archivo una única vez, informe por pantalla la cantidad mínima
y
máxima de votantes. Además durante el recorrido, el programa deberá listar el
contenido del archivo en pantalla. El nombre del archivo a procesar debe ser
proporcionado por el usuario.}

Type 

  registro = Record
    nombreCiudad : string[30];
    cant : integer;
  End;

  archivo = file Of registro;

Var 
  arch : archivo;
  nombreArch : string[30];
  reg : registro;
  max : integer;
  min : integer;

Begin


  writeln(





'ingrese el nombre del archivo que contiene cantidad de votantes en cada provincia de buenos aires'
  );
  readln(nombreArch);
  assign(arch,nombreArch);
  reset(arch);

  min := 999999999;
  max := -1;
  While (Not eof(arch)) Do
    Begin
      read(arch,reg);
      If (reg.cant < min)Then
        min := reg.cant;
      If (reg.cant > max)Then
        max := reg.cant;
      write(reg.cant);
      write(' ');

    End;


  close(arch);






End.
