
Program punto2;







{se necesita contabilizar los cd vendidos de una discografica. se dispone de un archivo con informacion.
realizar un programa que muestre un listado como el que se detalla en la consigna. dicho listado debe ser
mostrado en pantalla y ademas en un archivo de texto, en el de texto se debe listar nombre del disco, nombre del autor
y cantidad vendida. EL ARCHIVO ORIGEN ESTA ORDENADO POR CODIGO DE AUTOR, GENERO Y NOMBRE DE DISCO}

Type 

  registro = Record
    codigoAutor : integer;
    nombreAutor : string[50];
    nombreDisco : string[50];
    genero : string[50];
    cantVendida : integer;
  End;

  tipoArchivo = file Of registro;

Var 
  arch : tipoArchivo;
  r : registro;
  txt : TextFile;
  codActual : integer;
  generoActual : string[50];
  nombreDActual : string[50];
  cantTotal, cantAutor, cantGenero, cantDisco : integer;
Begin
  assign(arch, 'archivo');
  assign(txt,'txt');
  reset(arch);
  rewrite(txt);

  If (Not eof(arch))Then
    Begin
      read(arch, r);
      codActual := r.codigoAutor;
      generoActual := r.genero;
      nombreDActual := r.nombreDisco;

    End;
  cantTotal := 0;
  While (Not eof(arch)) Do
    Begin
      cantAutor := 0;
      While (r.codigoAutor = codActual) Do
        Begin
          cantGenero := 0;
          While (r.genero = generoActual) Do
            Begin
              cantDisco := 0;
              While (r.nombreDisco = nombreDActual) Do
                Begin
                  cantDisco := cantDisco + r.cantVendida;
                  read(arch, r);

                  If (eof(arch))Then
                    break;
                End;
              If (eof(arch))Then{ proceso el ultimo registro}
                cantDisco := cantDisco + r.cantVendida;
              writeln(txt, r.nombreAutor + ' ' + nombreDActual + ' ', cantDisco
              );
              writeln(nombreDActual + ' vendio ', cantDisco);
              cantGenero := cantGenero + cantDisco;
              nombreDActual := r.nombreDisco;

              If (eof(arch))Then
                break;
            End;
          writeln(generoActual + ' vendio ', cantGenero);
          cantAutor := cantAutor +cantGenero;
          generoActual := r.genero;
          If (eof(arch))Then
            break;

        End;
      writeln(codActual , ' vendio ',cantAutor);
      cantTotal := cantTotal + cantAutor;
      codActual := r.codigoAutor;

    End;
  writeln('la discografica vendio ', cantTotal);


  close(arch);
  close(txt);
End.
