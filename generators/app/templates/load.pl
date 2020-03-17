%%% Loads all source modules to be used on top level
:-  prolog_load_context(directory, Dir), 
    asserta(user:file_search_path(project, Dir)),
    directory_file_path(Dir, sources, SourcePath),
    asserta(user:file_search_path(source, SourcePath)),
    directory_file_path(Dir, assets, AssetsPath),
    asserta(user:file_search_path(asset, SourcePath)).

:- use_module(library(settings)).

:- use_module(server).
:- use_module(source(routing)).
:- use_module(source(main)).
