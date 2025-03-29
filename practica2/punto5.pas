
Program punto5;



{ La Dirección de Población Vulnerable del Ministerio de Salud y Desarrollo
Social solicita información a cada municipio indicando cantidad de niños y de adultos
mayores que están en situación de riesgo debido a la situación socioeconómica del país.
Para ello se recibe un archivo indicando: partido, localidad, barrio, cantidad de ninos
y cantidad de adultos mayores. Se sabe que EL ARCHIVO SE ENCUENTRA ORDENADO POR PARTIDO Y LOCALIDAD.
 Se pide imprimir por pantalla con el formato que aparece en la consigna}

Type 
  registro = Record
    partido : string[50];
    localidad : integer;
    barrio : string[50];
    cantNinos : integer;
    cantAdultos : integer;
  End;

  tipoArch = file Of registro;

Var 
  arch : tipoArch;
  r : registro;
  cantNinosTotalPartido : integer;
  cantAdultosTotalPartido : integer;
  cantNinosLocalidad : integer;
  cantMayoresLocalidad : integer;
  localidadActual :  integer;
  partidoActual : string[50];

Begin
  assign(arch, 'archivo');
  reset(arch);


  read(arch, r);
  localidadActual := r.localidad;
  partidoActual := r.partido;
  While (Not eof(arch)) Do
    Begin
      cantNinosTotalPartido := 0;
      cantAdultosTotalPartido := 0;
      While (PartidoActual = r.partido) Do
        Begin
          cantNinosLocalidad := 0;
          cantMayoresLocalidad := 0;
          While (localidadActual = r.localidad) Do
            Begin
              cantNinosLocalidad := cantNinosLocalidad + r.cantNinos;
              cantMayoresLocalidad := cantMayoresLocalidad + r.cantAdultos;
              read(arch, r);
              If (eof(arch))Then
                break;
            End;
          If (eof(arch))Then
            Begin
              cantNinosLocalidad := cantNinosLocalidad + r.cantNinos;
              cantMayoresLocalidad := cantMayoresLocalidad + r.cantAdultos;
            End;
          writeln('la localidad ', localidadActual ,' tiene tantos ninos',
                  cantNinosLocalidad, ' y tiene tantos mayores ',
                  cantMayoresLocalidad );
          cantNinosTotalPartido := cantNinosTotalPartido + cantNinosLocalidad;
          cantAdultosTotalPartido := cantAdultosTotalPartido +
                                     cantMayoresLocalidad;
          If (eof(arch))Then
            break;
        End;
      writeln('el partido '+ partidoActual ,' tiene tantos ninos ',
              cantNinosTotalPartido,
              ' y tantos mayores con problemas socioeconomicos ' ,
              cantAdultosTotalPartido);
    End;

  close(arch);
End.
