:- dynamic pelicula/4.

genero_valido(A) :- member(A, [accion, comedia, drama, fantasia, terror, suspenso, musical, historia]).

agregar_pelicula(Nombre, Genero, ActorPrincipal, Director) :-
    genero_valido(Genero),
    assertz(pelicula(Nombre, Genero, ActorPrincipal, Director)),
    write('La pelicula ha sido agregada a la base de conocimiento.').

mostrar_peliculas :-
    findall(pelicula(Nombre, Genero, ActorPrincipal, Director), pelicula(Nombre, Genero, ActorPrincipal, Director), Peliculas),
    imprimir_peliculas(Peliculas).

imprimir_peliculas([]).
imprimir_peliculas([Pelicula|Peliculas]) :-
    write(Pelicula), nl,
    imprimir_peliculas(Peliculas).
