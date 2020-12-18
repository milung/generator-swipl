%% start your debugging session by loading 'debug' file. 

:- use_module(prolog/<%=packageName%>).
:- ['tests/<%=packageName%>.plt'].

:- set_test_options([run(make)]).

:- current_prolog_flag(gui, true)
-> guitracer
; true.
