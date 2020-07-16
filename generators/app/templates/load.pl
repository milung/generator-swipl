%%% Loads all source modules to be used on top level
:-  prolog_load_context(directory, Dir), 
    asserta(user:file_search_path(project, Dir)),
    directory_file_path(Dir, sources, SourcePath),
    asserta(user:file_search_path(source, SourcePath)),
    directory_file_path(Dir, assets, AssetsPath),
    asserta(user:file_search_path(asset, AssetsPath)).

:- set_prolog_flag(encoding, utf8).

:- use_module(library(settings)).

:- setting(app_version, atom, env(app_version, '0.1.0'), 'version of the system (ENV app_version)').
:- setting(app_name, atom, env(app_name, 'OntologyCLI'), 'version of the system (ENV app_name)').
:- setting(app_authority, atom, env(app_authority, 'unknown'), 'version of the system (ENV app_name)').

:- use_module(library(debug)).
% debugging is enabled for info, warnig, and error levels 
% - use debug and trace for more glanular levels
:- debug(info).
:- debug(info(_)).
:- debug(warning).
:- debug(error).
:- debug(warning(_)).
:- debug(error(_)).

:- use_module(server).
:- use_module(source(routing)).
:- use_module(source(main)).
