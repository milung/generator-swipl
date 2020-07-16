:- module(common, [
    write_banner/0
    ]).
%! <module> Common utility functions for executing the project


%%% PUBLIC PREDICATES %%%%%%%%%%%%%%%%%%%%%%%%%%%

write_banner :-
    setting(user:app_name, AppName),
    setting(user:app_version, Version),
    setting(user:app_authority, Authority),
    format('~w, version ~w, by ~w', [AppName, Version, Authority]), 
    nl, nl.

%%%  PRIVATE PREDICATES %%%%%%%%%%%%%%%%%%%%%%%%%    