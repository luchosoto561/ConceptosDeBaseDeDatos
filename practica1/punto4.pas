
Program punto4;



{ Crear un procedimiento que reciba como parámetro el archivo del punto 2,  y
genere un archivo de texto con el contenido del mismo.}

Type 
  registro = Record
    nombreCiudad : string[30];
    cant : integer;
  End;

  archivo = file Of registro;


Procedure generarArchtexto( Var arch : archivo );

Var 
  archtxt : TextFile;
  reg : registro;
Begin
  {tengo el archivo listo para que se lea o escriba en el mismo}
  assign(archtxt, 'archtxt');
  rewrite(archtxt);
  While (Not eof(arch)) Do
    Begin
      read(arch, reg);
      write(archtxt, reg.nombreCiudad);
      write(archtxt, reg.cant);
    End;
  close(archtxt);
End;


Var 
  archp2: archivo;

Begin
  assign(archp2, 'archp2');

{asigno el archivo con nombre logico archp2 que tengo en el directorio al archp2}
  reset(archp2);
  generarArchtexto(archp2);
  close(archp2);
End.
