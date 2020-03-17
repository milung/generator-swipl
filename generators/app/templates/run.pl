% Invokes main:main/1 or if `--server` option is provided then it starts http server. 
%
%  DO NOT PLACE OTHER CODE HERE
%  instead update server.pl if necessary
%
:- [load].

:- use_module(source(main)).
:- use_module(project(server)).

:- initialization(server_or_main, main).

server_or_main :-
    current_prolog_flag(argv, Argv), 
    argv_options(Argv, _, Options),
    (
        option(server(true), Options),
        !,
        server:server_start
    ;
        main
    ).
    