% Predicado principal que inicia el programa
inicio :- menu_principal.

% Predicado que muestra el menú principal y recibe la elección del usuario
menu_principal :-
  write('Seleccione una opción:'), nl,
  write('1. Menú Administrativo'), nl,
  write('2. Menú General'), nl,
  write('3. Salir'), nl,
  read(Eleccion),
  opcion_principal(Eleccion).

% Predicado que se llama según la elección del usuario en el menú principal
opcion_principal(1) :-
  menu_administrativo,
  menu_principal.

opcion_principal(2) :-
  menu_general,
  menu_principal.

opcion_principal(3) :-
  write('Saliendo del sistema.'), nl.

opcion_principal(_) :-
  write('Opción no válida.'), nl,
  menu_principal.

% Predicado que muestra el menú administrativo y recibe la elección del usuario
menu_administrativo :-
  write('Seleccione una opción:'), nl,
  write('1. Gestión de películas'), nl,
  write('2. Gestión de series'), nl,
  write('3. Gestión de canciones'), nl,
  write('4. Gestión de usuarios'), nl,
  write('5. Ver historial de reproducciones'), nl,
  write('6. Volver al menú principal'), nl,
  read(Eleccion),
  opcion_administrativo(Eleccion).

% Predicado que se llama según la elección del usuario en el menú administrativo
opcion_administrativo(1) :-
  write('Ha elegido la opción 1 (Gestión de películas).'), nl,
  % Aquí iría el código correspondiente a la gestión de películas
  menu_administrativo. % Vuelve al menú administrativo después de realizar la tarea

opcion_administrativo(2) :-
  write('Ha elegido la opción 2 (Gestión de series).'), nl,
  % Aquí iría el código correspondiente a la gestión de series
  menu_administrativo. % Vuelve al menú administrativo después de realizar la tarea

opcion_administrativo(3) :-
  write('Ha elegido la opción 3 (Gestión de canciones).'), nl,
  % Aquí iría el código correspondiente a la gestión de canciones
  menu_administrativo. % Vuelve al menú administrativo después de realizar la tarea

opcion_administrativo(4) :-
  write('Ha elegido la opción 4 (Gestión de usuarios).'), nl,
  % Aquí iría el código correspondiente a la gestión de usuarios
  menu_administrativo. % Vuelve al menú administrativo después de realizar la tarea

opcion_administrativo(5) :-
  write('Ha elegido la opción 5 (Ver historial de reproducciones).'), nl,
  % Aquí iría el código correspondiente a ver el historial de reproducciones
  menu_administrativo. % Vuelve al menú administrativo después de realizar la tarea

opcion_administrativo(6) :-
  write('Volviendo al menú principal.'), nl.

opcion_administrativo(_) :-
  write('Opción no válida.'), nl,
  menu_administrativo. % Vuelve al menú administrativo si la elección no es válida

% Predicado que muestra el menú general y recibe la elección del usuario

menu_general :-
write('Seleccione una opción:'), nl,
write('1. Buscar producción'), nl,
write('2. Recomendar'), nl,
write('3. Registrar actividad'), nl,
write('4. Volver al menú principal'), nl,
read(Eleccion),
opcion_general(Eleccion).

% Predicado que se llama según la elección del usuario en el menú general
opcion_general(1) :-
write('Ha elegido la opción 1 (Buscar producción).'), nl,
% Aquí iría el código correspondiente a buscar producciones
menu_general. % Vuelve al menú general después de realizar la tarea

opcion_general(2) :-
write('Ha elegido la opción 2 (Recomendar).'), nl,
% Aquí iría el código correspondiente a recomendar producciones
menu_general. % Vuelve al menú general después de realizar la tarea

opcion_general(3) :-
write('Ha elegido la opción 3 (Registrar actividad).'), nl,
% Aquí iría el código correspondiente a registrar actividad
menu_general. % Vuelve al menú general después de realizar la tarea

opcion_general(4) :-
write('Volviendo al menú principal.'), nl.

opcion_general(_) :-
write('Opción no válida.'), nl,
menu_general. % Vuelve al menú general si la elección no es válida
