% Agregar directiva de codificación UTF-8
:- encoding(utf8).

% Declaración dynamic para el predicado pelicula/4
:- dynamic pelicula/4.

% Predicado para verificar que el género sea válido
genero_valido(A) :- member(A, [accion, comedia, drama, fantasia, terror, suspenso, musical, historia]).

% Ingresa la película
insert_peliculas :-
  write('Agregar película:'), nl,
  write('Nombre: '),
  read(Nombre),
  write('Género: '),
  read(Genero),
  genero_valido(Genero), % valida que el género sea válido
  write('Actor principal: '),
  read(Actor),
  write('Director: '),
  read(Director),
  agregar_pelicula(Nombre, Genero, Actor, Director), % agrega la película a la base de conocimiento
  write('La película ha sido agregada a la base de conocimiento.'), nl.

% Predicado para agregar una película a la base de conocimiento
agregar_pelicula(Nombre, Genero, ActorPrincipal, Director) :-
    genero_valido(Genero),
    % Agregar la pelicula como un hecho en la base de conocimiento
    assertz(pelicula(Nombre, Genero, ActorPrincipal, Director)).

% Mostrar todas las películas almacenadas en la base de conocimiento
mostrar_peliculas :-
    % Encontrar todas las películas que están almacenadas en la base de conocimiento
    findall(pelicula(Nombre, Genero, ActorPrincipal, Director), pelicula(Nombre, Genero, ActorPrincipal, Director), Peliculas),
    % Verificar si la lista de películas está vacía
    (   Peliculas = []
    ->  write('No hay películas almacenadas en la base de conocimiento.')
    ;   % Mostrar cada película en una línea diferente
        imprimir_peliculas(Peliculas)
    ).

    imprimir_generos_peliculas :-
        write('accion, comedia, drama, fantasia, terror, suspenso, musical, historia'),nl.

% Mostrar una lista de películas
% Regla auxiliar para imprimir las películas almacenadas
imprimir_peliculas([]).
imprimir_peliculas([pelicula(Nombre, Genero, ActorPrincipal, Director)|T]) :-
    format("Nombre: ~w~n", [Nombre]),
    format("Genero: ~w~n", [Genero]),
    format("Actor Principal: ~w~n", [ActorPrincipal]),
    format("Director: ~w~n~n", [Director]),
    imprimir_peliculas(T).

% Cargar datos desde un archivo
cargar_datos_peliculas(Archivo) :-
    consult(Archivo).

% Guardar datos en un archivo
guardar_datos_peliculas(Archivo) :-
    tell(Archivo),
    listar_hechos_peliculas,
    told.

% Regla auxiliar para listar los hechos de películas en el archivo
listar_hechos_peliculas :-
    listing(pelicula/4).
