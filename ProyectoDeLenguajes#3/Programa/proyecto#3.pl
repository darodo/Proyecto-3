% Predicado principal que inicia el programa
inicio :- menu.

% Predicado que muestra el menú de opciones y recibe la elección del usuario
menu :-
  write('Seleccione una opción:'), nl,
  write('1. Opción 1'), nl,
  write('2. Opción 2'), nl,
  write('3. Salir'), nl,
  read(Eleccion),
  opcion(Eleccion).

% Predicado que se llama según la elección del usuario
opcion(1) :-
  write('Ha elegido la opción 1.'), nl,
  % Aquí iría el código correspondiente a la opción 1
  menu. % Vuelve al menú después de realizar la tarea

opcion(2) :-
  write('Ha elegido la opción 2.'), nl,
  % Aquí iría el código correspondiente a la opción 2
  menu. % Vuelve al menú después de realizar la tarea

opcion(3) :-
  write('Saliendo del sistema.'), nl.

opcion(_) :-
  write('Opción no válida.'), nl,
  menu. % Vuelve al menú si la elección no es válida

