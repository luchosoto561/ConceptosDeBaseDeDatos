
Program punto7;





{ diariamente se generan 10 archivos detalle que registran todas las ventas de productos.
se pide realizar un programa con opciones para 
1) crear el archivo maestro a partir de un archivo de texto llamado "productos.txt"
2) actualizar el archivo maestro con los archivos detalle sabiendo que:
    - todos los archivos estan ordenados por codigo de producto
    - cada registro del maestro puede ser actualizado por muchos de los detalle
    - los archivos detalle solo contienen ventas de productos que estan en el maestro
    - siempre hay stock para realizar las ventas de productos que aparecen en los detalle }

Const 
  valorAlto = 32000;

Type 

  registro = Record
    codProd : integer;
    nombre : string[50];
    descripcion : string[100];
    precioVenta : double;
    stock : integer;
    stockMin : integer;
  End;

  detalle = Record
    codProd : integer;
    cantVendida : integer;
  End;

  tipoMestro = file Of registro;
  tipoDetalle = file Of detalle;

  detalles = array[1..10] Of tipoDetalle;
  rdetalles = array[1..10] Of detalle;

Var 

  maestro : tipoMestro;
  vectorD : detalles;
  vectorrD : rdetalles;
  n : integer;
  numero : string[3];
  txt : TextFile;

Procedure opcion1(Var maestro : tipoMestro ; Var txt : TextFile);

Begin
  writeln('nose que tengo que hacer si se selecciona esta opcion');






End;
Procedure leer(Var aDetalle : tipoDetalle; Var rDetalle : detalle);
Begin
  If (Not eof(aDetalle))Then
    Begin
      read(aDetalle, rDetalle);
    End
  Else
    Begin
      rDetalle.codProd := valorAlto;
    End;
End;

Procedure minimo(Var vectorD : detalles ; Var vectorrD : rdetalles ; Var min :
                 detalle);

Var 
  posMin, i : integer;

Begin
  posMin := 1;
  min := vectorrD[1];
  For i := 2 To 10 Do
    Begin
      If (min.codProd > vectorrD[i].codProd)Then
        Begin
          min := vectorrD[i];
          posMin := i;
        End;
    End;
  leer(vectorD[posMin], vectorrD[posMin]);
End;

Procedure opcion2(Var maestro : tipoMestro ; Var vectorD : detalles; Var
                  vectorrD : rdetalles);

Var 

  i : integer;
  rmaestro : registro;
  min : detalle;

Begin
  { actualizar el archivo maestro con los archivos detalle}
  For i := 1 To 10 Do
    Begin
      reset(vectorD[i]);
      leer(vectorD[i], vectorrD[i]);
    End;
  read(maestro, rmaestro);
  minimo(vectorD, vectorrD, min);
  While (min.codProd <> valorAlto) Do
    Begin
      While (rmaestro.codProd <> min.codProd) Do
        read(maestro, rmaestro);
      While (rmaestro.codProd = min.codProd) Do
        Begin
          rmaestro.stock := rmaestro.stock - min.cantVendida;
          minimo(vectorD, vectorrD, min);
        End;
      seek(maestro, filepos(maestro)-1);
      write(maestro, rmaestro);
    End;

  For i := 1 To 10 Do
    Begin
      close(vectorD[i]);
    End;

End;

{PROGRAMA PRINCIPAL}

Begin
  writeln(



'ingrese 1 si quiere crear el archivo maestro a partir de un archivo de texto llamado "productos.txt", ingrese 2 si quiere actualizar los archivos maestro con los 10 archivos detalle'
  );
  read(n);

  assign(maestro, 'maestro.dat');
  reset(maestro);
  If (n = 1)Then
    Begin
      assign(txt, 'productos.txt');
      reset(txt);

      opcion1(maestro, txt);

      close(txt);
    End;
  If (n = 2)Then
    Begin
      For n := 1 To 10 Do
        Begin
          writeln('ingrese el numero del archivo detalle');
          readln(numero);
          assign(vectorD[n], 'detalle' + numero);
        End;

      opcion2(maestro, vectorD, vectorrD);

      For n := 1 To 10 Do
        Begin
          close(vectorD[n]);
        End;
    End;

  close(maestro);


End.
