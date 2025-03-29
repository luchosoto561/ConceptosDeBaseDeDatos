
Program punto1;


{el area de recuersos humanos de un ministerio administra el personal del mismo distribuido en 10 direcciones generales
entre otras funciones recibe periodicamente un archivo detalle de cada una de las direcciones conteniendo informacion de 
las licencias solicitadas por el personal. tanto el maestro como el detalle estan ordenados por codigo de empleado.

realice un proceso que reciba los detalles y actualice el archivo maestro con la info de los archivos detalle.
    Se debe actualizar la cantidad de dias que le restan de vacaciones. si el empleado tiene menos dias de los que solicita debera 
informarse en un archivo de texto indicando : codigo de empleado, nombre y apellido, cantidad de dias que tine y cantidad
de dias que solicita}

Const 
  valorAlto = 32767;

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
  adetalles = array[1..10] Of tipoArchDetalle;
  rdetalles = array[1..10] Of detalle;

Var 
  rmaestro : maestro;
  archivoMaestro : tipoArchMaestro;
  vectoradetalle : adetalles;
  vectorrdetalles : rdetalles;
  txt : TextFile;
  min : detalle;
  i : integer;
  numero : string[3];

Procedure leer(Var ardetalle : tipoArchDetalle ; Var regdet : detalle);
Begin






{ carga regdet con el la informacion del archivo, si el archivo esta vacio devuelve valor alto}
  If (Not (eof(ardetalle)))Then
    Begin
      read(ardetalle, regdet);
    End
  Else
    Begin
      regdet.codigoEmpleado := valorAlto;
    End;
End;

Procedure minimo(Var vectoradetalle : adetalles ; Var vectorrdetalles :
                 rdetalles ; Var min : detalle );

Var 
  posMin, i : integer;
Begin





{ busca el minimo entre los codigos en el vector de rdetalles, lo asigma a min y llama a la funcion leer con las posiciones i que le corresponde a min}
  min := vectorrdetalles[1];
  posMin := 1;
  For i:=2 To 10 Do
    Begin
      If (vectorrdetalles[i].codigoEmpleado < min.codigoEmpleado)Then
        Begin
          min := vectorrdetalles[i];
          posMin := i;
        End;
    End;
  leer(vectoradetalle[posMin], vectorrdetalles[posMin]);

End;


{ PROGRAMA PRINCIPAL}

Begin
  For i :=1 To 10 Do
    Begin
      writeln('ingrese el numero de archivo detalle');
      readln(numero);
      assign(vectoradetalle[i], 'archivoDetalle'+ numero );
    End;
  assign(archivoMaestro, 'archivoMaestro');
  reset(archivoMaestro);
  rewrite(txt);
  For i := 1 To 10 Do
    Begin
      reset(vectoradetalle[i]);
      leer(vectoradetalle[i] , vectorrdetalles[i]);
    End;
  read(archivoMaestro,rmaestro);
  minimo(vectoradetalle, vectorrdetalles, min);
  While (min.codigoEmpleado <> valorAlto) Do
    Begin
      While (min.codigoEmpleado<> rmaestro.codigoEmpleado) Do
        Begin
          read(archivoMaestro, rmaestro);
        End;
      i := 0;


{se pone en 1 si la cantidad de licencia que pide es mayor que los dias de vacaciones que tiene}
      While (min.codigoEmpleado = rmaestro.codigoEmpleado) Do
        Begin
          If ((rmaestro.cantDiasVacaciones < min.cantDiasLicencia) And (i=0) )
            Then
            Begin
            { tengo que cargar el txt}
              write(txt,rmaestro.codigoEmpleado);
              writeln(txt, rmaestro.nombreyApellido);
              write(txt, rmaestro.cantDiasVacaciones);
              writeln(min.cantDiasLicencia);
              i := 1;
            End;
          If (i = 0)Then
            Begin
              rmaestro.cantDiasVacaciones := rmaestro.cantDiasVacaciones - min.
                                             cantDiasLicencia;
            End;
          minimo(vectoradetalle, vectorrdetalles, min);

        End;
      If (i = 0)Then
        Begin
          seek(archivoMaestro, filepos(archivoMaestro)-1);
          write(archivoMaestro, rmaestro);
        End;
    End;
  close(archivoMaestro);
  For i := 1 To 10 Do
    Begin
      close(vectoradetalle[i]);
    End;
  close(txt);

End.
