menu :-
    repeat,
    write('Menu:'), nl,
    write('1. Buscar producción'), nl,
    write('2. Recomendar'), nl,
    write('3. Registrar actividad'), nl,
    write('0. Salir'), nl,
    read(Opcion),
    ejecutar_opcion(Opcion),
    Opcion == 0, !.

ejecutar_opcion(1) :-
    buscar_produccion.

ejecutar_opcion(2) :-
    recomendar.

ejecutar_opcion(3) :-
    registrar_actividad.

ejecutar_opcion(0) :-
    !.

ejecutar_opcion(_) :-
    write('Opción inválida. Inténtelo de nuevo.'), nl.

buscar_produccion :-
    write('Ingrese el nombre de la producción a buscar: '), nl,
    read(Produccion),
    % Código para buscar la producción
    write('Resultado de la búsqueda.'), nl.

recomendar :-
    % Código para recomendar
    write('Recomendación.'), nl.

registrar_actividad :-
    % Código para registrar actividad
    write('Actividad registrada.'), nl.
