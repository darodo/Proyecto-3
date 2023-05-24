% Cargar los módulos
:- consult('GestionPeliculas.pl').
:- consult('GestionSeries.pl').
:- consult('GestionCanciones.pl').
:- consult('GestionUsuarios.pl').

% Directiva de codificación UTF-8
:- encoding(utf8).

% Declaración dynamic para el predicado reproduccion/4
:- dynamic reproduccion/4.

% Regla para registrar una reproducción
registrar_reproduccion :-
    write("Ingrese el nombre del usuario: "),
    read(Nombre),
    usuario(Nombre, _, _, _), % Verificar si el usuario existe, sin importar su género
    write("Ingrese el tipo de producción (película, serie o canción): "),
    read(TipoProduccion),
    (
        TipoProduccion = pelicula ->
        mostrar_peliculas,
        write("Ingrese el nombre de la película: "),
        read(NombreTitulo),
        pelicula(NombreTitulo, _, _, _), % Verificar si la película existe, sin validar el género
        write("Ingrese la calificación asignada (de 1 a 5): "),
        read(Calificacion),
        validar_calificacion(Calificacion),
        guardar_reproduccion(Nombre, TipoProduccion, NombreTitulo, Calificacion)
    ;
        TipoProduccion = serie ->
        mostrar_series,
        write("Ingrese el nombre de la serie: "),
        read(NombreTitulo),
        serie(NombreTitulo, _, _, _), % Verificar si la serie existe, sin validar el género
        write("Ingrese la calificación asignada (de 1 a 5): "),
        read(Calificacion),
        validar_calificacion(Calificacion),
        guardar_reproduccion(Nombre, TipoProduccion, NombreTitulo, Calificacion)
    ;
        TipoProduccion = cancion ->
        mostrar_canciones,
        write("Ingrese el nombre de la canción: "),
        read(NombreTitulo),
        cancion(NombreTitulo, _, _, _), % Verificar si la canción existe, sin validar el género
        write("Ingrese la calificación asignada (de 1 a 5): "),
        read(Calificacion),
        validar_calificacion(Calificacion),
        guardar_reproduccion(Nombre, TipoProduccion, NombreTitulo, Calificacion)
    ).

% Regla para validar que la calificación esté en el rango correcto
validar_calificacion(Calificacion) :-
    Calificacion >= 1,
    Calificacion =< 5,
    !.
validar_calificacion(_) :-
    write("La calificación debe ser un número entre 1 y 5. Por favor, intente nuevamente."),
    nl,
    fail.

% Regla para guardar la reproducción en el historial
guardar_reproduccion(Nombre, TipoProduccion, NombreTitulo, Calificacion) :-
    % Agregar la reproducción a la base de conocimientos
    assertz(reproduccion(Nombre, TipoProduccion, NombreTitulo, Calificacion)),
    write("Reproducción registrada correctamente.").


% Cargar datos desde un archivo
cargar_datos_repro(Archivo) :-
    consult(Archivo).

% Guardar datos en un archivo
guardar_datos_repro(Archivo) :-
    tell(Archivo),
    listar_hechos_repro,
    told.

% Regla auxiliar para listar los hechos en el archivo
listar_hechos_repro :-
    listing(reproduccion/4).