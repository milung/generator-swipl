%%% Loads all source modules to be used on top level


%  Project load search paths
:-  prolog_load_context(directory, Dir), 
    asserta(user:file_search_path(project, Dir)),
    directory_file_path(Dir, sources, SourcePath),
    asserta(user:file_search_path(source, SourcePath)),
    directory_file_path(Dir, assets, AssetsPath),
    asserta(user:file_search_path(asset, AssetsPath)).

:- set_prolog_flag(encoding, utf8).

% standard modules for  project
:- use_module(library(settings)).
:- use_module(library(apply)).
:- use_module(library(prolog_pack)).
:- use_module(library(readutil)).
:- use_module(library(filesex)).
:- use_module(library(debug)).

%  Package management. Loads all packages specified in the 'packages.pl'
install_package(package(Name, _)) :-
    pack_property(Name, directory(_) ),
    !.
 install_package(package(Name, Url)) :-
    absolute_file_name(project('.packages'), PackageDir),
    pack_install(Name, [url(Url), package_directory(PackageDir), interactive(false)]).

:-  absolute_file_name(project('.packages'), PackageDir),
    make_directory_path(PackageDir),
    read_file_to_terms(project('packages.pl'), Dependencies, []),
    maplist(install_package, Dependencies),
    attach_packs(PackageDir).

%  Standard settings
:- setting(app_version, atom, env(app_version, '0.1.0'), 'version of the system (ENV app_version)').
:- setting(app_name, atom, env(app_name, 'OntologyCLI'), 'version of the system (ENV app_name)').
:- setting(app_authority, atom, env(app_authority, 'unknown'), 'version of the system (ENV app_name)').




% debugging is enabled for info, warnig, and error levels 
% - use debug and trace for more glanular levels
:- debug(info).
:- debug(info(_)).
:- debug(warning).
:- debug(error).
:- debug(warning(_)).
:- debug(error(_)).

% bootstrap the execution
:- use_module(server).
:- use_module(source(routing)).
:- use_module(source(main)).
