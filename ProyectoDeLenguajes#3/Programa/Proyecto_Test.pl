% Cargar los módulos
:- consult('GestionPeliculas.pl').

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
  menu_peliculas. % llama al menú de gestión de películas

% Menú de gestión de películas
menu_peliculas :-
  write('Seleccione una opción:'), nl,
  write('1. Agregar película'), nl,
  write('2. Mostrar películas'), nl,
  write('3. Volver al menú administrativo'), nl,
  read(Eleccion),
  opcion_peliculas(Eleccion).

% Predicado que se llama según la elección del usuario en el menú de gestión de películas
opcion_peliculas(1) :-
  write('Agregar película:'), nl,
  write('Nombre: '),
  read(Nombre),
  write('Género: '),
  read(Genero),
  validar_genero(Genero), % valida que el género sea válido
  write('Actor principal: '),
  read(Actor),
  write('Director: '),
  read(Director),
  agregar_pelicula(Nombre, Genero, Actor, Director), % agrega la película a la base de conocimiento
  write('La película ha sido agregada a la base de conocimiento.'), nl,
  menu_peliculas. % vuelve al menú de gestión de películas

opcion_peliculas(2) :-
  mostrar_peliculas, % muestra todas las películas almacenadas en la base de conocimiento
  menu_peliculas. % vuelve al menú de gestión de películas

opcion_peliculas(3) :-
  write('Volviendo al menú administrativo.'), nl,
  menu_administrativo. % vuelve al menú administrativo

% Predicado para validar que el género sea válido
validar_genero(Genero) :-
  genero_permitido(Genero), % comprueba si el género está permitido
  !. % éxito si el género está permitido

validar_genero(_) :-
  write('Error: género no permitido. Los géneros permitidos son: Accion, Comedia, Drama, Fantasia, Terror, Suspenso, Musical e Historia.'), nl,
  fail. % falla si el género no está permitido

  % Predicado para comprobar si el género está permitido
  genero_permitido(accion).
  genero_permitido(comedia).
  genero_permitido(drama).
  genero_permitido(fantasia).
  genero_permitido(terror).
  genero_permitido(suspenso).
  genero_permitido(musical).
  genero_permitido(historia).
  
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
