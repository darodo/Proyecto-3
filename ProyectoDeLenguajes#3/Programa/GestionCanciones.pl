% Agregar directiva de codificación UTF-8
:- encoding(utf8).
% Declaración dynamic para el predicado serie/4
:- dynamic cancion/4.
% Predicado para verificar que el género sea válido
genero_valido_cancion(A) :- member(A, [clasica, jazz, rhythm, blues, rb, rock, roll, country, pop, reggae, hip_hop]).

%Ingresa la cancion
insert_canciones :-  
  write('Agregar cancion:'), nl,
  write('Nombre: '),
  read(Nombre_C),
  write('Género: '),
  read(Genero_C),
  genero_valido_cancion(Genero_C), % valida que el género sea válido
  write('Cantante: '),
  read(Cantante_C),
  write('Productor: '),
  read(Productor_C),
  agregar_cancion(Nombre_C, Genero_C, Cantante_C, Productor_C), % agrega la cancion a la base de conocimiento
  write('La cancion ha sido agregada a la base de conocimiento.'), nl.


% Predicado para agregar una cancion a la base de conocimiento
agregar_cancion(Nombre_C, Genero_C, Cantante_C, Productor_C) :-
    genero_valido_cancion(Genero_C),
    % Agregar la cancion como un hecho en la base de conocimiento
    assertz(cancion(Nombre_C, Genero_C, Cantante_C, Productor_C)).

% Mostrar todas las canciones almacenadas en la base de conocimiento
mostrar_canciones :-
    % Encontrar todas las canciones que están almacenadas en la base de conocimiento
    findall(cancion(Nombre_C, Genero_C, Cantante_C, Productor_C), cancion(Nombre_C, Genero_C, Cantante_C, Productor_C), Canciones),
    % Verificar si la lista de canciones está vacía
    (   Canciones = []
    ->  write('No hay canciones almacenadas en la base de conocimiento.')
    ;   % Mostrar cada canción en una línea diferente
        imprimir_canciones(Canciones)
    ).

% Mostrar una lista de canciones
imprimir_canciones([]).
imprimir_canciones([cancion(Nombre_C, Genero_C, Cantante_C, Productor_C)|T]) :-
    format("Nombre: ~w~n", [Nombre_C]),
    format("Genero: ~w~n", [Genero_C]),
    format("Cantante: ~w~n", [Cantante_C]),
    format("Productor: ~w~n~n", [Productor_C]),
    imprimir_canciones(T).

% Cargar datos desde un archivo
cargar_datos_canciones(Archivo) :-
    consult(Archivo).

% Guardar datos en un archivo
guardar_datos_canciones(Archivo) :-
    tell(Archivo),
    listar_hechos_canciones,
    told.

% Regla auxiliar para listar los hechos de películas en el archivo
listar_hechos_canciones :-
    listing(cancion/4).