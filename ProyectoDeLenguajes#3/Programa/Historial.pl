% Cargar los módulos
:- consult('RegistrarReproduccion.pl').

% Agregar directiva de codificación UTF-8
:- encoding(utf8).

% Regla para mostrar el historial de reproducciones
mostrar_historial :-
    % Encontrar todas las reproducciones almacenadas en la base de conocimientos
    findall(reproduccion(Nombre, TipoProduccion, NombreTitulo, Calificacion), reproduccion(Nombre, TipoProduccion, NombreTitulo, Calificacion), Reproducciones),
    % Verificar si la lista de reproducciones está vacía
    (   Reproducciones = []
    ->  write('No hay reproducciones registradas.')
    ;   % Mostrar cada reproducción en una línea diferente
        imprimir_reproducciones(Reproducciones)
    ).

% Regla auxiliar para imprimir las reproducciones almacenadas
imprimir_reproducciones([]).
imprimir_reproducciones([reproduccion(Nombre, TipoProduccion, NombreTitulo, Calificacion)|T]) :-
    format("Nombre del usuario: ~w~n", [Nombre]),
    format("Tipo de producción: ~w~n", [TipoProduccion]),
    format("Nombre del título: ~w~n", [NombreTitulo]),
    format("Calificación asignada: ~w~n~n", [Calificacion]),
    imprimir_reproducciones(T).

