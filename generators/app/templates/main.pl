:- module(main, [
    main/4
    ]).
%! <module> Main entry for Command Line Interface
%  Contains the main entry and other supportive predicates

% :- use_module(library(...)).

% :- use_module(source(...)).

%%% PUBLIC PREDICATES %%%%%%%%%%%%%%%%%%%%%%%%%%%

main(_PositionalArgs, _CliOptions, _InputStream, OutputStream) :-
    write_banner,
    write(OutputStream, 'Hello Worlds'), nl(OutputStream).

%%%  PRIVATE PREDICATES %%%%%%%%%%%%%%%%%%%%%%%%%    