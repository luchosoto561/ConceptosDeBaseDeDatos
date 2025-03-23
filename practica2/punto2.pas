
Program punto2;



{se necesita contabilizar los cd vendidos de una discografica. se dispone de un archivo con informacion.
realizar un programa que muestre un listado como el que se detalla en la consigna. dicho listado debe ser
mostrado en pantalla y ademas en un archivo de texto, en el de texto se debe listar nombre del disco, nombre del autor
y cantidad vendida}

Type 

  registro = Record
    codigoAutor : integer;
    nombreAutor : string[50];
    nombreDisco : string[50];
    genero : string[50];
    cantVendida : string[50];
  End;

  tipoArchivo = file Of registro;

Var 
  arch : tipoArchivo;
  r : registro;
  txt : TextFile;
Begin
  assign(arch, 'archivo');
  assign(txt,'txt');
  reset(arch);
  rewrite(txt);
  While (Not eof(arch)) Do
    Begin
      read(arch, r);
      {procesamos cada registro del archivo}

    End;


  close(arch);
  close(txt);
End.



{no entiendo como tiene que ser el listado que mostramos en pantalla porque aparece total genero, total autor, total discografica y no entiendo como mostrar}
