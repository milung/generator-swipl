:- module(routing, []).
%! <module> HTTP routing 
%  Predicates for basic routing of http requests

:- encoding(utf8).

:- use_module(library(http/http_dispatch)).
:- use_module(library(http/html_write)).
:- use_module(library(http/http_header)).
:- use_module(library(execution_context)).

:- multifile 
    user:file_search_path/2,
    http:status_page/3,
    http:location/3.

:- dynamic   
    http:location/3.


% default rooting - adapt to project needs
:- http_handler(root('api'), http_redirect(moved, root('api/')), []).
:- http_handler(root('assets'), serve_assets, [prefix]).
:- http_handler(root('browser'), serve_browser, [prefix]).
:- http_handler(root('favicon.ico'), http_reply_file(assets('favicon.ico'), []), []).
:-  http_handler(
        root('openapi.yaml'),
        openapi_spec,
        [id(swagger_config)]).

:-  context_variable_value(server:server_base_url, Base),
    atom_concat('/', BasePath, Base),
    atomic_list_concat([BasePath, 'openapi.yaml' ], Location),
    http_handler(
        root(Location),
        openapi_spec,
        [id(swagger_config)]).

:-  http_handler(root(.),
                http_redirect(see_other, root('swagger_ui')),
                []).    
%%% PUBLIC PREDICATES %%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%  PRIVATE PREDICATES %%%%%%%%%%%%%%%%%%%%%%%%%

openapi_spec(_) :-
    context_variable_value(api:api_base, Server),
    mustache_from_file(assets('openapi.yaml'), [server = Server], Codes),
    %phrase(utf8_codes(Codes), Bytes),
    %length(Bytes, Len),
    format('Content-type: ~w~n~n~s', ['application/yaml', Codes]).

%  serve_assets(+Request:list) is det
%  checks for existence of the resource from Request's URI 
%  and serves it to http server. Throws =|http_reply(not_found(Path)|= 
% if asset does not exists
serve_assets( Request) :-
    option(path_info(Asset), Request),
    absolute_file_name(html(Asset), Absolute),
    exists_file(Absolute),    
    access_file(Absolute, read),
    http_reply_file(assets(Asset), [], Request).
serve_assets(Request) :-
    option(path(Path), Request),
    throw(http_reply(not_found(Path))).


serve_browser( Request) :-
    option(path_info(Asset), Request),
    absolute_file_name(html(hal_browser/Asset), Absolute),
    exists_file(Absolute),    
    access_file(Absolute, read),
    atomic_list_concat([hal_browser, Asset], Path),
    http_reply_file(html(Path), [], Request).
serve_browser(Request) :-
    http_redirect(moved, root(browser/'browser.html#/api/'), Request).