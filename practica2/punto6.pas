
Program punto6;



{ Un restaurante posee un archivo con información de los montos por servicios cobrados por cada
mozo durante la semana. la info del archivo se encuentra ordenada por codigo de mozo y cada mozo
puede tener n servicios cobrados con diferentes fechas. no se conoce la cantidad de mozos del resto.
realizar un procedimiento que reciba el arch anterior y lo compacte. en consecuencia debera generar
un nuevo archivo en el cual cada mozo aparezca una unica vez con el valor totol de los servicios. }

Type 

  f = Record
    dia : integer;
    mes : integer;
    ano : integer;
  End;

  servicio = Record
    codigoMozo : integer;
    fecha : f;
    monto : Double;
  End;

  compactar = Record
    codigoMozo : integer;
    montoTotal : double;
  End;

  tArchivo = file Of servicio;
  tAResultante = file Of compactar;

Var 

  arch : tArchivo;
  archResultante : tAResultante;

Procedure compacter(Var arch: tArchivo ; Var archResultante : tAResultante);

Var 
  rResult : compactar;
  r : servicio;
Begin
  If (Not eof(arch))Then
    Begin
      read(arch, r);
      rResult.codigoMozo := r.codigoMozo;
      rResult.montoTotal := 0;
    End;
  While (Not eof(arch)) Do
    Begin
      While (rResult.codigoMozo = r.codigoMozo) Do
        Begin
          rResult.montoTotal := rResult.montoTotal + r.monto;
          read(arch, r);
          If (eof(arch))Then
            Begin
              rResult.montoTotal := rResult.montoTotal + r.monto;
              break;
            End;
        End;
      write(archResultante, rResult);
      rResult.codigoMozo := r.codigoMozo;
      rResult.montoTotal := 0;;
    End;

End;

Begin
  assign(arch, 'archivo.dat');
  assign(archResultante, 'archivoResultante.dat');
  reset(arch);
  rewrite(archResultante);

  compacter(arch, archResultante);

  close(arch);
  close(archResultante);
End.
