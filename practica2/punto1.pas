
Program punto1;






{el area de recuersos humanos de un ministerio administra el personal del mismo distribuido en 10 direcciones generales
entre otras funciones recibe periodicamente un archivo detalle de cada una de las direcciones conteniendo informacion de 
las licencias solicitadas por el personal. tanto el maestro como el detalle estan ordenados por codigo de empleado.

realice un proceso que reciba los detalles y actualice el archivo maestro con la info de los archivos detalle.
    Se debe actualizar la cantidad de dias que le restan de vacaciones. si el empleado tiene menos dias de los que solicita debera 
informarse en un archivo de texto indicando : codigo de empleado, nombre y apellido, cantidad de dias que tine y cantidad
de dias que solicita}



Type 
  fecha = Record
    dia : integer;
    mes : integer;
    ano : integer;
  End;

  detalle = Record
    codigoEmpleado : integer;
    fecha : fecha;
    cantDiasLicencia : integer;
  End;

  maestro = Record
    codigoEmpleado : integer;
    nombreyApellido : string[50];
    fechaNacimiento : fecha;
    direccion : string[50];
    cantHijos : integer;
    telefono : integer;
    cantDiasVacaciones : integer;
  End;

  tipoArchDetalle = file Of detalle;
  tipoArchMaestro = file Of maestro;


Var 

  archivoDetalle : tipoArchDetalle;
  archivoMaestro : tipoArchMaestro;
  txt : TextFile;
Procedure actualizarMaestro(Var archMaestro: tipoArchMaestro ; Var archDetalle :
                            tipoArchDetalle);

Var 
  d : detalle;
  m : maestro;
Begin
  assign(txt, 'txt');
  rewrite(txt);






{tenemos el archivo maestro y el detalle en modo lectura y escritura, tener en cuenta que no todos los del maestro piden licencia, y que estan ambos archivos ordenados por codigoEmpleado}
  While (Not eof(archDetalle)) Do
    Begin
      read(archDetalle, d);
      read(archMaestro, m);
      While (d.codigoEmpleado <> m.codigoEmpleado ) Do
        Begin
          read(archMaestro, m);
        End;
            {aca tengo el maestro con el mismo codigo que el detalle}
      If (m.cantDiasVacaciones < d.cantDiasLicencia)Then
        Begin
          write(txt, m.codigoEmpleado);
          write(txt, ' ');
          write(txt, m.nombreyApellido);
          write(txt, ' ');
          write(txt, m.cantDiasVacaciones);
          write(txt, ' ');
          writeln(txt, d.cantDiasLicencia);
        End
      Else
        Begin
          m.cantDiasVacaciones := m.cantDiasVacaciones - d.cantDiasLicencia;
          seek(archMaestro, filepos(archMaestro)-1);
          write(archMaestro, m);
        End;
    End;

  close(txt);

End;
Begin
  assign(archivoDetalle, 'archivoDetalle');
  assign(archivoMaestro, 'archivoMaestro');
  reset(archivoDetalle);
  reset(archivoMaestro);

  actualizarMaestro(archivoMaestro, archivoDetalle);

  close(archivoDetalle);
  close(archivoMaestro);
End.
