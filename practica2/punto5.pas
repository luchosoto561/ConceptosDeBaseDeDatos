
Program punto5;

{ La Dirección de Población Vulnerable del Ministerio de Salud y Desarrollo
Social solicita información a cada municipio indicando cantidad de niños y de adultos
mayores que están en situación de riesgo debido a la situación socioeconómica del país.
Para ello se recibe un archivo indicando: partido, localidad, barrio, cantidad de ninos
y cantidad de adultos mayores. Se sabe que el archivo se encuentra ordenado por partido y localidad.
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
  cantNinosTotal : integer;
  cantAdultosTotal : integer;
  cantNinosLocalidad : integer;
  cantMayoresLocalidad : integer;
  localidad :  integer;
  partido : string[50];

Begin
  assign(arch, 'archivo');
  reset(arch);


  read(arch, r);
  localidad := r.localidad;
  partido := r.partido;
  cantNinosTotal := 0;
  cantAdultosTotal := 0;


  While (Not eof(arch)) Do
    Begin
      While (r.partido = partido) Do
        Begin
          cantNinosLocalidad := 0;
          cantMayoresLocalidad := 0;
          While (r.localidad = localidad) Do
            Begin
              cantNinosLocalidad := cantNinosLocalidad + r.cantNinos;
              cantMayoresLocalidad := cantMayoresLocalidad + r.cantAdultos;
              cantNinosTotal := cantNinosTotal+cantNinosLocalidad;
              cantAdultosTotal := cantAdultosTotal+cantMayoresLocalidad;
            {aca es donde puedo informar todo lo que tengo que informar}

              read(arch,r);

            End;
        End;
    End;


  close(arch);
End.
