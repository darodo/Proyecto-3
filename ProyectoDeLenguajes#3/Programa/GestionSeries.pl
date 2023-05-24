% Agregar directiva de codificación UTF-8
:- encoding(utf8).
% Declaración dynamic para el predicado serie/4
:- dynamic serie/4.
% Predicado para verificar que el género sea válido
genero_valido_serie(A) :- member(A, [accion, comedia, drama, fantasia, terror, suspenso, musical, historia, reality_show]).

% Ingresa la serie
insert_series :-
  write('Agregar serie:'), nl,
  write('Nombre: '),
  read(Nombre_S),
  write('Género: '),
  read(Genero_S),
  genero_valido_serie(Genero_S), % valida que el género sea válido
  write('Actor principal: '),
  read(Actor_S),
  write('Director: '),
  read(Director_S),
  agregar_serie(Nombre_S, Genero_S, Actor_S, Director_S), % agrega la serie a la base de conocimiento
  write('La serie ha sido agregada a la base de conocimiento.'), nl.

% Predicado para agregar una serie a la base de conocimiento
agregar_serie(Nombre_S, Genero_S, Actor_S, Director_S) :-
    genero_valido_serie(Genero_S),
    % Agregar la serie como un hecho en la base de conocimiento
    assertz(serie(Nombre_S, Genero_S, Actor_S, Director_S)).

% Mostrar todas las series almacenadas en la base de conocimiento
mostrar_series :-
    % Encontrar todas las series que están almacenadas en la base de conocimiento
    findall(serie(Nombre_S, Genero_S, Actor_S, Director_S), serie(Nombre_S, Genero_S, Actor_S, Director_S), Series),
    % Verificar si la lista de series está vacía
    (   Series = []
    ->  write('No hay series almacenadas en la base de conocimiento.')
    ;   % Mostrar cada serie en una línea diferente
        imprimir_series(Series)
    ).

% Mostrar una lista de series
imprimir_series([]).
imprimir_series([serie(Nombre_S, Genero_S, Actor_S, Director_S)|T]) :-
    format("Nombre: ~w~n", [Nombre_S]),
    format("Genero: ~w~n", [Genero_S]),
    format("Actor Principal: ~w~n", [Actor_S]),
    format("Director: ~w~n~n", [Director_S]),
    imprimir_series(T).

% Cargar datos desde un archivo
cargar_datos_series(Archivo) :-
    consult(Archivo).

% Guardar datos en un archivo
guardar_datos_series(Archivo) :-
    tell(Archivo),
    listar_hechos_series,
    told.

% Regla auxiliar para listar los hechos de películas en el archivo
listar_hechos_series :-
    listing(serie/4).