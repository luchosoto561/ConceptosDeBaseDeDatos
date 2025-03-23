
Program punto3;


{realizar un proceso que reciba los 20 detalles y actualice el archivo maestro con la info de los detalle.
tanto el maestro como el detalle se encuentran ordenados por codigo de calzado y el numero. ademas se debera
informar que calzados no tuvieron ventas y cuales quedaron por debajo del stock minimo. los calzados sin venta
se informan por pantalla, mientras que los calzados que quedaron por debajo del stock minimo se informan en 
un archivo txt llamado calzadosinstock.txt. NO SE REALIZAN CUENTAS SI NO SE POSEE STOCK}

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

Var 
  archMaestro : tipoArchMaestro;
  archDetalle : tipoArchDetalle;
  c : calzado;
  d : detalle;
  txt : TextFile;

Procedure actualizarArchMaestro(Var archMaestro : tipoArchMaestro;  Var
                                archDetalle : tipoArchDetalle; Var txt: TextFile
);
Begin


{tengo el archivo detalle para leer y escribir y el archivo maestro para escribir}
  While (Not eof(archDetalle)) Do
    Begin
      read(archDetalle, d);
      read(archMaestro, c);
      While (d.codigo <> c.codigo) Do
        Begin
          While (d.numero <> c.numero) Do
            read(archMaestro,c);
        End;


{tengo el calzado con el mismo codigo y el mismo numero por lo que estoy listo para actualizar}
      If (d.cantVendida = 0)Then
        Begin
          write('el calzado con el siguiente codigo no vendio nada: ');
          writeln(d.codigo);
        End
      Else
        Begin
          If (c.stock-d.cantVendida >= 0)Then
            Begin
              c.stock := c.stock - d.cantVendida;
              seek(archMaestro,FilePos(archMaestro)-1);
              write(archMaestro,c);
              If (c.stock-d.cantVendida < c.stockMin)Then
                writeln(txt, c.descripcion);
            End;
        End;
    End;

End;
Begin
  assign(archMaestro, 'archivoMaestro');
  assign(archDetalle, 'archivoDetalle');
  assign(txt, 'calzadosinstock.txt');
  reset(archDetalle);
  rewrite(archMaestro);
  rewrite(txt);

  actualizarArchMaestro(archMaestro, archDetalle, txt);

  close(archMaestro);
  close(archDetalle);

End.
