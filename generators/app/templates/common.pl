:- module(common, [
    write_banner/0
    ]).
%! <module> Common utility functions for executing the project

:- multifile prolog:message//1.

%%% PUBLIC PREDICATES %%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%  PRIVATE PREDICATES %%%%%%%%%%%%%%%%%%%%%%%%%    

prolog:message(program_version) -->
    {
        setting(app_name, AppName),
        setting(app_version, Version),
        setting(app_authority, Authority)
    },
    [AppName, ' version ', Version, ' by ',  Authority].