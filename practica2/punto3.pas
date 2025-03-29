
Program punto3;



{realizar un proceso que reciba los 20 detalles y actualice el archivo maestro con la info de los detalle.
TANTO EL MAESTRO COMO EL DETALLE SE ENCUENTRAN ORDENADOS POR CODIGO DE CALZADO Y EL NUMERO. ademas se debera
informar que calzados no tuvieron ventas y cuales quedaron por debajo del stock minimo. los calzados sin venta
se informan por pantalla, mientras que los calzados que quedaron por debajo del stock minimo se informan en 
un archivo txt llamado calzadosinstock.txt. NO SE REALIZAN CUENTAS SI NO SE POSEE STOCK}

Const 
  valorAlto = 32000;

Type 

  calzado = Record
    codigo : integer;
    numero : real;
    descripcion : string[100];
    precioUnitario : real;
    color : string[20];
    stock : integer;
    stockMin : integer;
  End;

  detalle = Record
    codigo : integer;
    numero : real;
    cantVendida : integer;
  End;

  tipoArchMaestro = file Of calzado;
  tipoArchDetalle = file Of detalle;
  adetalles = array[1..20] Of tipoArchDetalle;
  rdetalles = array[1..20] Of detalle;

Var 
  archMaestro : tipoArchMaestro;
  rmaestro : calzado;
  vectoraDetalles : adetalles;
  vectorrDetalles : rdetalles;
  min : detalle;

  calzadosinstocktxt : TextFile;

  i: integer;
  numero : string[3];

Procedure leer(Var adetalle : tipoArchDetalle ; Var rdetalle : detalle);
Begin
  If (Not eof(adetalle))Then
    Begin
      read(adetalle,rdetalle);
    End
  Else
    Begin
      rdetalle.codigo := valorAlto;
    End;
End;
Procedure minimo(Var vectoraDetalles : adetalles ; Var vectorrDetalles :
                 rdetalles ; Var min : detalle);

Var 
  posMin : integer;
Begin
  posMin := 1;
  min := vectorrDetalles[1];
  For i := 2 To 20 Do
    Begin
      If (vectorrDetalles[i].codigo < min.codigo)Then
        Begin
          If (vectorrDetalles[i].numero < min.numero)Then
            posMin := i;
          min := vectorrDetalles[i];
        End;
    End;
  leer(vectoraDetalles[posMin], vectorrDetalles[posMin]);
End;
Begin
  assign(archMaestro, 'archivoMaestro.dat');
  For i:=1 To 20 Do
    Begin
      writeln('ingrese el numero del archivo detalle');
      readln(numero);
      assign(vectoraDetalles[i], 'archivoDetalle' + numero);
    End;
  reset(archMaestro);
  rewrite(calzadosinstocktxt);
  read(archMaestro,rmaestro);
  For i := 1 To 20 Do
    Begin
      reset(vectoraDetalles[i]);
      leer(vectoraDetalles[i],vectorrDetalles[i]);
    End;
  minimo(vectoraDetalles, vectorrDetalles, min);
  While (min.codigo <> valorAlto) Do
    Begin
      While (min.codigo <> rmaestro.codigo) Do
        Begin
          writeln('el siguiente calzado no tuvo ventas' + rmaestro.descripcion);
          read(archMaestro, rmaestro);
        End;
      While (min.codigo = rmaestro.codigo) Do
        Begin
          While (min.numero <> rmaestro.numero) Do
            Begin
              writeln('el siguiente calzado no tuvo ventas' + rmaestro.
                      descripcion);
              read(archMaestro, rmaestro);
            End;
          While (min.numero = rmaestro.numero) Do
            Begin

  { min y rmaestro tienen el mismo talle y el mismo codigo por lo que actualizo}
              If (rmaestro.stock > min.cantVendida)Then
                Begin
                  rmaestro.stock := rmaestro.stock - min.cantVendida;
                  If (rmaestro.stock < rmaestro.stockMin)Then
                    writeln(calzadosinstocktxt, rmaestro.descripcion);

                End;
              minimo(vectoraDetalles, vectorrDetalles, min);
              If (min.codigo <> rmaestro.codigo)Then
                break;
            End;
          seek(archMaestro, FilePos(archMaestro)-1);
          write(archMaestro, rmaestro);
        End;
    End;
  close(archMaestro);
  close(calzadosinstocktxt);
  For i := 1 To 20 Do
    Begin
      close(vectoraDetalles[i]);
    End;
End.
