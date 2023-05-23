% Agregar directiva de codificación UTF-8
:- encoding(utf8).
% Declaración dynamic para el predicado serie/4
:- dynamic usuario/4.

% Hechos para almacenar los usuarios y sus preferencias
% usuario(Nombre, [GenerosPeliculas], [GenerosSeries], [GenerosCanciones])
% El cuarto argumento es una lista de pares (Género, Afinidad)

% Predicado para mostrar todos los usuarios registrados
mostrar_usuarios :-
    findall([Nombre, Peliculas, Series, Canciones], usuario(Nombre, Peliculas, Series, Canciones), Usuarios),
    imprimir_usuarios(Usuarios).

% Predicado para imprimir la información de los usuarios
imprimir_usuarios([]).
imprimir_usuarios([[Nombre, Peliculas, Series, Canciones] | Resto]) :-
    write('Nombre: '), write(Nombre), nl,
    write('Películas: '), write(Peliculas), nl,
    write('Series: '), write(Series), nl,
    write('Canciones: '), write(Canciones), nl, nl,
    imprimir_usuarios(Resto).

% Predicado para agregar un nuevo usuario
agregar_usuario :-
    write('Ingrese el nombre del usuario: '),
    read(Nombre),
    write('Ingrese el grado de afinidad para cada género de película (separados por comas): '),
    read(Peliculas),
    write('Ingrese el grado de afinidad para cada género de serie (separados por comas): '),
    read(Series),
    write('Ingrese el grado de afinidad para cada género de canciones (separados por comas): '),
    read(Canciones),
    assertz(usuario(Nombre, Peliculas, Series, Canciones)),
    write('Usuario agregado correctamente.').
