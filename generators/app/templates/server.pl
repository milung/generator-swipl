:- module(server, [
    server/0, 
    server/1,                  % +Port:number
    serve_assets/1             % +Request:list
]).
%! <module> HTTP server hooks
% Predicates for creating and running http server.

:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/html_write)).

:- multifile 
    user:file_search_path/2,
    http:status_page/3,
    http:location/3.

:- dynamic   
    http:location/3.

% log warning and error debug messages
:- debug(warning).
:- debug(warning(_)).
:- debug(error).
:- debug(error(_)).

% setting for changing the server port by usage of environment variables
:- setting(port, number, env(http_port, 80), 'HTTP port the server is listening on. (ENV http_port)').

% enables to change base_url - usefull for  links where relative address is of no help (e.g. SPA web applications)
:- setting(server_base_url, atom, env(base_url, '/'), 'Base URL of the server, all absolute links are prefixed with this address (ENV base_url)').

% all assets are served with http_reply_file/2
user:file_search_path(assets, './assets').

%! server is det
%  Starts http server listening at the default port specified by the server:port settings. 
server :-     
    setting(port, Port),
    server(Port).

%! server(+Port:number) is det
%  Starts http server listening at the port specified by the argument Port. 
server(Port) :- 
    http_server(http_dispatch, [port(Port)]).

%%% PRIVATE PREDICTES_SECTION %%%%%%%%%%%%%%

http:status_page(not_found(URL), _Context, HTML) :-
    phrase(
        page(
            [ title('Sorry, no such page')], 
            {|html(URL) || <h1>Sorry, no such page <span>URL</span></h1>|} ), 
        HTML).

is_server_dead(Port) :- 
    http_current_worker(Port, _ ), 
    ! .   

%! serve_assets(+Request:list) is det
%  checks for existence of the resource from Request's URI 
%  and serves it to http server. Throws =|http_reply(not_found(Path)|= 
% if asset does not exists
serve_assets( Request) :-
    option(path_info(Asset), Request),
    absolute_file_name(assets(Asset), Absolute),
    exists_file(Absolute),    
    access_file(Absolute, read),
    http_reply_file(assets(Asset), [], Request).
serve_assets(Request) :-
    option(path(Path), Request),
    throw(http_reply(not_found(Path))).

%! server_start_and_wait is det
%  Starts the http server listening at the port specified by the server:port setting and wait
%  indefinetely untiol is_server_dead/1 is not succeded. 
server_start_and_wait :-
    setting(port, Port),
    server(Port),
    repeat,
    sleep(3),
    \+ is_server_dead(Port).

%! server_start is det
%  Prints current server settings and  starts the server
server_start :- 
    setting(user:app_name, AppName),
    setting(user:app_version, Version),
    setting(user:app_authority, Authority),
    format('~n, version ~w, by ~w', [AppName, Version, Authority]), nl, nl,
    list_settings(server), 
    server_start_and_wait.


