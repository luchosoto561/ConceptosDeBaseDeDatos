
Program punto4;


{ tengo 20 archivos detalle sobre peliculas en el cine y un archivo maestro con la misma informacion 
que los archivos detalle, tengo que hacer un procedimiento para actualizar el archivo maestro}

Type 

  pelicula = Record
    codigo : integer;
    nombre : string[40];
    genero : string[40];
    director : string[40];
    duracion : real;
    fecha : string[40];
    cantAsistentes : integer;
  End;

  tipoArch = file Of pelicula;

Var 

  archMaestro = tipoArch;
  archivos : array[1..20] Of tipoArch;

Begin



End.



{en este ejercicio no veo nada distinto al 3; lo importante es como hacer para que actualizar
 el maestro sea eficiente, entiendo yo que recorriendo los archivos lo menos posible}
