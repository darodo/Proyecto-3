% Agregar directiva de codificación UTF-8
:- encoding(utf8).
% Declaraciones dynamic para los predicados
:- dynamic usuario/4.
:- dynamic pelicula/4.


% Géneros de películas
generos_peliculas([accion, comedia, drama, fantasia, terror, suspenso, musical, historia]).

% Géneros de series
generos_series([accion, comedia, drama, fantasia, terror, suspenso, musical, historia, reality_show]).

% Géneros de canciones
generos_canciones([clasica, jazz, rhythm, blues, rb, rock, roll, country, pop, reggae, hip_hop]).

% Regla para incluir un nuevo usuario en la base de conocimientos
agregar_usuario :-
    write("Ingrese el nombre del usuario: "),
    read(Nombre),
    not(usuario(Nombre, _, _, _)),
    generar_lista_afinidades_peliculas(AfinidadesPeliculas),
    generar_lista_afinidades_series(AfinidadesSeries),
    generar_lista_afinidades_canciones(AfinidadesCanciones),
    write("Películas disponibles:"),
    agregar_usuario_con_calificaciones(Nombre, AfinidadesPeliculas, AfinidadesSeries, AfinidadesCanciones).

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

% Cargar datos desde un archivo
cargar_datos_usuarios(Archivo) :-
    consult(Archivo).

% Guardar datos en un archivo
guardar_datos_usuarios(Archivo) :-
    tell(Archivo),
    listar_hechos_usuarios,
    told.

% Regla auxiliar para listar los hechos en el archivo
listar_hechos_usuarios :-
    listing(usuario/4).