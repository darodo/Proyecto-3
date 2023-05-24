% Predicado para cargar los archivos de series, canciones y películas
:- consult('GestionPeliculas.pl').
:- consult('GestionSeries.pl').
:- consult('GestionCanciones.pl').

% Agregar directiva de codificación UTF-8
:- encoding(utf8).

% Predicado para buscar coincidencias en las películas, series y canciones
buscar_produccion(Texto) :-
    (   pelicula(Nombre, Genero, ActorPrincipal, _),
        (   sub_atom(Nombre, _, _, _, Texto)
        ;   sub_atom(Genero, _, _, _, Texto)
        ;   sub_atom(ActorPrincipal, _, _, _, Texto)
        ),
        format('Película encontrada: ~w, ~w, ~w~n', [Nombre, Genero, ActorPrincipal])
    ;   serie(Nombre_S, Genero_S, Actor_S, _),
        (   sub_atom(Nombre_S, _, _, _, Texto)
        ;   sub_atom(Genero_S, _, _, _, Texto)
        ;   sub_atom(Actor_S, _, _, _, Texto)
        ),
        format('Serie encontrada: ~w, ~w, ~w~n', [Nombre_S, Genero_S, Actor_S])
    ;   cancion(Nombre_C, Genero_C, Cantante_C, _),
        (   sub_atom(Nombre_C, _, _, _, Texto)
        ;   sub_atom(Genero_C, _, _, _, Texto)
        ;   sub_atom(Cantante_C, _, _, _, Texto)
        ),
        format('Canción encontrada: ~w, ~w, ~w~n', [Nombre_C, Genero_C, Cantante_C])
    ),
    fail. % Vuelve a buscar más coincidencias


