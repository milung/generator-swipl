%% start your debugging session by loading 'debug' file. 

:- [load].

% debug settings to make debugging more fancy
:- use_module(library('http/http_error')).

:- load_settings('app.settings.pl', [undefined(load)]).
:- load_settings('debug.settings.pl', [undefined(load)]).

:- load_test_files([]).
