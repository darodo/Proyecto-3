% Predicado para agregar una serie a la base de conocimiento
agregar_serie(Nombre, Genero, Actor, Director) :-
    % Verificar que el género sea válido
    genero_valido_serie(Genero),
    % Agregar la serie como un hecho en la base de conocimiento
    assertz(serie(Nombre, Genero, Actor, Director)),
    write('La serie ha sido agregada a la base de conocimiento.').

% Verificar si un género es válido para una serie
genero_valido_serie(drama).
genero_valido_serie(comedia).
genero_valido_serie(fantasia).
genero_valido_serie(terror).
genero_valido_serie(suspenso).
genero_valido_serie(musical).
genero_valido_serie(historia).
genero_valido_serie(accion).
genero_valido_serie(reality_show).
genero_valido_serie(Genero) :-
    write('El género ingresado no es válido para una serie.'),
    fail.

% Mostrar todas las series almacenadas en la base de conocimiento
mostrar_series :-
    % Encontrar todas las series que están almacenadas en la base de conocimiento
    findall(serie(Nombre, Genero, Actor, Director), serie(Nombre, Genero, Actor, Director), Series),
    % Mostrar cada serie en una línea diferente
    mostrar_series_aux(Series).

% Mostrar una lista de series
mostrar_series_aux([]).
mostrar_series_aux([Serie|Resto]) :-
    write(Serie), nl,
    mostrar_series_aux(Resto).
