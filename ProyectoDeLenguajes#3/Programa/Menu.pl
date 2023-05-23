% Cargar los módulos
:- consult('GestionPeliculas.pl').
:- consult('GestionSeries.pl').
:- consult('GestionCanciones.pl').
:- consult('GestionUsuarios.pl').
:- consult('Historial.pl').

% Predicado principal que inicia el programa
inicio :- menu_principal.
% Agregar directiva de codificación UTF-8
:- encoding(utf8).

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

opcion_administrativo(1) :-
  write('Ha elegido la opción 1 (Gestión de películas).'), nl,
  menu_peliculas. % llama al menú de gestión de películas

opcion_administrativo(2) :-
  write('Ha elegido la opción 2 (Gestión de series).'), nl,
  menu_series. % Vuelve al menú administrativo después de realizar la tarea

opcion_administrativo(3) :-
  write('Ha elegido la opción 3 (Gestión de canciones).'), nl,
  menu_canciones. % Vuelve al menú administrativo después de realizar la tarea

opcion_administrativo(4) :-
  write('Ha elegido la opción 4 (Gestión de usuarios).'), nl,
  menu_usuarios. % Vuelve al menú administrativo después de realizar la tarea

opcion_administrativo(5) :-
  write('Ha elegido la opción 5 (Ver historial de reproducciones).'), nl,
  menu_historial. % Vuelve al menú administrativo después de realizar la tarea

opcion_administrativo(6) :-
  write('Volviendo al menú principal.'), nl.

opcion_administrativo(_) :-
  write('Opción no válida.'), nl,
  menu_administrativo. % Vuelve al menú administrativo si la elección no es válida

%############################################################################################################ PELICULAS
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
  insert_peliculas,
  menu_peliculas. % vuelve al menú de gestión de películas

opcion_peliculas(2) :-
  mostrar_peliculas, % muestra todas las películas almacenadas en la base de conocimiento
  menu_peliculas. % vuelve al menú de gestión de películas

opcion_peliculas(3) :-
  write('Volviendo al menú administrativo.'), nl,
  menu_administrativo. % vuelve al menú administrativo

%############################################################################################################ SERIES
% Menú de gestión de series
menu_series :-
  write('Seleccione una opción:'), nl,
  write('1. Agregar serie'), nl,
  write('2. Mostrar serie'), nl,
  write('3. Volver al menú administrativo'), nl,
  read(Eleccion),
  opcion_series(Eleccion).

% Predicado que se llama según la elección del usuario en el menú de gestión de series
opcion_series(1) :-
  insert_series,
  menu_series.

opcion_series(2) :-
  mostrar_series, % muestra todas las series almacenadas en la base de conocimiento
  menu_series. % vuelve al menú de gestión de series

opcion_series(3) :-
  write('Volviendo al menú administrativo.'), nl,
  menu_administrativo. % vuelve al menú administrativo

%############################################################################################################ CANCIONES
% Menú de gestión de canciones
menu_canciones :-
  write('Seleccione una opción:'), nl,
  write('1. Agregar cancion'), nl,
  write('2. Mostrar canciones'), nl,
  write('3. Volver al menú administrativo'), nl,
  read(Eleccion),
  opcion_canciones(Eleccion).

% Predicado que se llama según la elección del usuario en el menú de gestión de canciones
opcion_canciones(1) :-
  insert_canciones,
  menu_canciones. % vuelve al menú de gestión de canciones

opcion_canciones(2) :-
  mostrar_canciones, % muestra todas las películas almacenadas en la base de conocimiento
  menu_canciones. % vuelve al menú de gestión de canciones

opcion_canciones(3) :-
  write('Volviendo al menú administrativo.'), nl,
  menu_administrativo. % vuelve al menú administrativo

%############################################################################################################ USUARIOS
% Menú de gestión de usuarios
menu_usuarios :-
  write('Seleccione una opción:'), nl,
  write('1. Agregar usuario'), nl,
  write('2. Mostrar usuarios'), nl,
  write('3. Volver al menú administrativo'), nl,
  read(Eleccion),
  opcion_usuarios(Eleccion).

% Predicado que se llama según la elección del usuario en el menú de gestión de usuarios
opcion_usuarios(1) :-
  agregar_usuario,
  menu_usuarios. % vuelve al menú de gestión de usuarios

opcion_usuarios(2) :-
  mostrar_usuarios, % muestra todas los usuarios almacenadas en la base de conocimiento
  menu_usuarios. % vuelve al menú de gestión de usuarios

opcion_usuarios(3) :-
  write('Volviendo al menú administrativo.'), nl,
  menu_administrativo. % vuelve al menú administrativo


%############################################################################################################ HISTORIAL
% Menú de Historial

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
