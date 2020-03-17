% Starts the http server. 
%
%  DO NOT PLACE OTHER CODE HERE
%  instead update server.pl if necessary
%
:- [load].

:- use_module(server).

:- initialization(server:server_start, main).
