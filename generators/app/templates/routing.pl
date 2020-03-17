:- module(routing, []).
%! <module> HTTP routing 
%  Predicates for basic routing of http requests

:- use_module(library(http/http_dispatch)).
:- use_module(project(server), [serve_assets/1]).

:- multifile 
    user:file_search_path/2,
    http:status_page/3,
    http:location/3.

:- dynamic   
    http:location/3.

% default rooting - adapt to project needs
:- http_handler(root('assets'), serve_assets, [prefix]).
:- http_handler(root('favicon.ico'), http_reply_file(assets('favicon.ico'), []), []).
:- http_handler(root(.), hello_world_handler, []).

%%%%%%%%%%%%% PRIVATE SECTION %%%%%%%%%%%%%

%! hello_world_handler(+Request:list) is det
%  http server handler to reply with hello world page 
hello_world_handler(_) :-
    reply_html_page([
        title('Hello World from Prolog!')],
        [
            h1([style='text-align: center;'], 'Hello world'), 
            p([style='text-align: center;'],  'Update your `load.pl` file with source modules and adapt `server.pl` to add additional handlers')
        ]).