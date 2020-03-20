:- module(main, [
    main/1
    ]).
:- use_module(library(http/html_write), [reply_html_page/2]).

:- encoding(utf8).

%%% PUBLIC PREDICATES %%%%%%%%%%%%%%%%%%%%%%%%%%%

main(_Argv) :-
    hello_world_cli.

%%%  PRIVATE PREDICATES %%%%%%%%%%%%%%%%%%%%%%%%%        

hello_world_cli :-
    writeln('Hello world').