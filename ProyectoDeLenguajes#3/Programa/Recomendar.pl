% Agregar directiva de codificación UTF-8
:- encoding(utf8).
% Declaraciones dynamic para los predicados
:- dynamic usuario/4.
:- dynamic pelicula/6.

% Géneros de películas
generos_peliculas([accion, comedia, drama, fantasia, terror, suspenso, musical, historia]).

% Géneros de series
generos_series([accion, comedia, drama, fantasia, terror, suspenso, musical, historia, reality_show]).

% Géneros de canciones
generos_canciones([clasica, jazz, rhythm, blues, rb, rock, roll, country, pop, reggae, hip_hop]).

% Regla para incluir un nuevo usuario en la base de conocimientos
agregar_usuario :-
    write("Ingrese el nombre del usuario: "),
    read_line_to_string(user_input, Nombre),
    atom_string(NombreAtom, Nombre),
    not(usuario(NombreAtom, _, _, _)),
    generar_lista_afinidades_peliculas(AfinidadesPeliculas),
    generar_lista_afinidades_series(AfinidadesSeries),
    generar_lista_afinidades_canciones(AfinidadesCanciones),
    agregar_usuario_con_calificaciones(NombreAtom, AfinidadesPeliculas, AfinidadesSeries, AfinidadesCanciones).


% Regla para agregar un nuevo usuario con sus calificaciones de películas
agregar_usuario_con_calificaciones(Nombre, GeneroPelicula, GeneroSerie, GeneroCancion) :-
    assert(usuario(Nombre, GeneroPelicula, GeneroSerie, GeneroCancion)),
    write("Usuario agregado correctamente."),nl.

% Regla para mostrar todos los usuarios registrados en la base de conocimientos
mostrar_usuarios :-
    findall((Nombre, GeneroPelicula, GeneroSerie, GeneroCancion), usuario(Nombre, GeneroPelicula, GeneroSerie, GeneroCancion), Usuarios),
    imprimir_usuarios(Usuarios).

% Regla auxiliar para imprimir los usuarios registrados
imprimir_usuarios([]).
imprimir_usuarios([(Nombre, GeneroPelicula, GeneroSerie, GeneroCancion)|T]) :-
    format("Nombre: ~w~n", [Nombre]),
    format("Género de película: ~w~n", [GeneroPelicula]),
    format("Género de serie: ~w~n", [GeneroSerie]),
    format("Género de canción: ~w~n~n", [GeneroCancion]),
    imprimir_usuarios(T).

% Regla para generar la lista de afinidades para películas
generar_lista_afinidades_peliculas(Afinidades) :-
    generos_peliculas(Generos),
    generar_lista_afinidades(Generos, Afinidades, "Película").

% Regla para generar la lista de afinidades para series
generar_lista_afinidades_series(Afinidades) :-
    generos_series(Generos),
    generar_lista_afinidades(Generos, Afinidades, "Serie").

% Regla para generar la lista de afinidades para canciones
generar_lista_afinidades_canciones(Afinidades) :-
    generos_canciones(Generos),
    generar_lista_afinidades(Generos, Afinidades, "Canción").

% Regla para generar la lista de afinidades para un tipo de género dado
generar_lista_afinidades([], [], _).
generar_lista_afinidades([Genero|T], [(Genero, Afinidad)|Afinidades], Tipo) :-
    format("Ingrese el grado de afinidad para el género ~w (~w) (1-10): ", [Genero, Tipo]),
    read(Afinidad),
    validar_afinidad(Afinidad, Tipo),
    generar_lista_afinidades(T, Afinidades, Tipo).

% Regla para validar que el valor de afinidad esté en el rango correcto
validar_afinidad(Afinidad, Tipo) :-
    number(Afinidad),
    Afinidad >= 1,
    Afinidad =< 10,
    !.
validar_afinidad(_, Tipo) :-
    format("El valor de afinidad para ~w debe ser un número entre 1 y 10. Por favor, intente nuevamente.", [Tipo]),
    nl,
    fail.

% Regla principal para recomendar títulos al usuario
recomendar :-
    write("Ingrese el nombre de usuario: "),
    read(NombreUsuario),
    usuario(NombreUsuario, GeneroPelicula, GeneroSerie, GeneroCancion),
    generar_lista_recomendaciones(GeneroPelicula, GeneroSerie, GeneroCancion, Recomendaciones),
    imprimir_recomendaciones(Recomendaciones).

% Regla para generar la lista de recomendaciones
generar_lista_recomendaciones(GeneroPelicula, GeneroSerie, GeneroCancion, Recomendaciones) :-
    findall((Tipo, Nombre, Genero, Actor, Productor, Puntuacion),
            pelicula(Tipo, Nombre, Genero, Actor, Productor, Puntuacion),
            Peliculas),
    calcular_afinidad_peliculas(Peliculas, GeneroPelicula, RecomendacionesGeneroPelicula),
    calcular_afinidad_series(Peliculas, GeneroSerie, RecomendacionesGeneroSerie),
    calcular_afinidad_canciones(Peliculas, GeneroCancion, RecomendacionesGeneroCancion),
    append(RecomendacionesGeneroPelicula, RecomendacionesGeneroSerie, TempRecomendaciones),
    append(TempRecomendaciones, RecomendacionesGeneroCancion, Recomendaciones),
    sort(5, @>=, Recomendaciones, SortedRecomendaciones),
    take(10, SortedRecomendaciones, Top10Recomendaciones).

% Regla para calcular la afinidad de las películas según el género
calcular_afinidad_peliculas([], _, []).
calcular_afinidad_peliculas([(Tipo, Nombre, Genero, Actor, Productor, Puntuacion)|T], GeneroUsuario, [(Tipo, Nombre, Genero, Actor, Productor, Puntuacion, Afinidad)|Recomendaciones]) :-
    afinidad_genero(Genero, GeneroUsuario, AfinidadGenero),
    afinidad_reproduccion(Tipo, AfinidadReproduccion),
    PuntuacionActor is Puntuacion * 2,
    calcular_afinidad_peliculas(T, GeneroUsuario, Recomendaciones),
    Afinidad is AfinidadGenero + AfinidadReproduccion + PuntuacionActor.

% Regla para calcular la afinidad de las series según el género
calcular_afinidad_series([], _, []).
calcular_afinidad_series([(Tipo, Nombre, Genero, Actor, Productor, Puntuacion)|T], GeneroUsuario, [(Tipo, Nombre, Genero, Actor, Productor, Puntuacion, Afinidad)|Recomendaciones]) :-
    afinidad_genero(Genero, GeneroUsuario, AfinidadGenero),
    afinidad_reproduccion(Tipo, AfinidadReproduccion),
    PuntuacionProductor is Puntuacion,
    calcular_afinidad_series(T, GeneroUsuario, Recomendaciones),
    Afinidad is AfinidadGenero + AfinidadReproduccion + PuntuacionProductor.

% Regla para calcular la afinidad de las canciones según el género
calcular_afinidad_canciones([], _, []).
calcular_afinidad_canciones([(Tipo, Nombre, Genero, Actor, Productor, Puntuacion)|T], GeneroUsuario, [(Tipo, Nombre, Genero, Actor, Productor, Puntuacion, Afinidad)|Recomendaciones]) :-
    afinidad_genero(Genero, GeneroUsuario, AfinidadGenero),
    afinidad_reproduccion(Tipo, AfinidadReproduccion),
    PuntuacionProductor is Puntuacion,
    calcular_afinidad_canciones(T, GeneroUsuario, Recomendaciones),
    Afinidad is AfinidadGenero + AfinidadReproduccion + PuntuacionProductor.

% Regla para calcular la afinidad entre géneros
afinidad_genero(Genero, GeneroUsuario, Afinidad) :-
    member(GeneroUsuario, Genero),
    Afinidad is 2,
    !.
afinidad_genero(_, _, 0).

% Regla para calcular la afinidad por reproducción
afinidad_reproduccion(visto_una_vez, 1).
afinidad_reproduccion(visto_mas_de_una_vez, 2).
afinidad_reproduccion(no_visto, 3).

% Regla auxiliar para imprimir las recomendaciones
imprimir_recomendaciones([]).
imprimir_recomendaciones([(Tipo, Nombre, Genero, Actor, Productor, Puntuacion, Afinidad)|T]) :-
    format("Tipo: ~w~n", [Tipo]),
    format("Nombre: ~w~n", [Nombre]),
    format("Género: ~w~n", [Genero]),
    format("Actor/Cantante: ~w~n", [Actor]),
    format("Productor/Director: ~w~n", [Productor]),
    format("Afinidad: ~w~n~n", [Afinidad]),
    imprimir_recomendaciones(T).

% Regla auxiliar para tomar los primeros N elementos de una lista
take(_, [], []).
take(N, [X|Xs], [X|Ys]) :-
    N > 0,
    N1 is N - 1,
    take(N1, Xs, Ys).
take(_, _, []).

% Regla principal para ejecutar el programa de recomendación
recomendar_titulos :-
    agregar_usuario,
    recomendar.
