% Invokes main:main/1 or if `--server` option is provided then it starts http server. 
%
%  DO NOT PLACE OTHER CODE HERE
%  instead update server.pl if necessary
%
:- [load].

:- use_module(source(main)).
:- use_module(project(server)).

:- multifile
    %! cli_option(+OptionKey:atom, +Type:atom, +OptionSpec:list(term), +Help)
    %  Multifile hook into CLI to declare option spec for opt_parse module.
    %  shortflags and longflags are automatically derived from the OptionKey if not
    %  overriden by by entry in OptionSpec. Help can be atom or list (of lines). 
    cli_option/4.

:- setting(app_version, atom, env(app_version, '0.1.0'), 'version of the system (ENV app_version)').
:- setting(app_name, atom, env(app_name, '<%=applicationName%>'), 'version of the system (ENV app_name)').
:- setting(app_authority, atom, env(app_authority, 'unknown'), 'version of the system (ENV app_name)').

:- initialization(server_or_main, main).
%%% PUBLIC PREDICATES %%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%  PRIVATE PREDICATES %%%%%%%%%%%%%%%%%%%%%%%%%

cli_option(help, boolean, [], 'prints usage help').
cli_option(input, atom, [], 'the input file to process; if not specified then the current intput is used').
cli_option(output, atom, [], 'the output file where resurt is written; if not specified then the current output is used').

cli_options( OptionsSpec):-
    findall(cli_option(Opt, Type, Spec, Help), cli_option(Opt, Type, Spec, Help), Options),
    options_specs(Options, OptionsSpec).

input_stream(Options, RestOptions, Stream) :-
    select_option( input(File), Options, RestOptions ),
    nonvar(File),
    open(File, read, Stream).
input_stream(Options, Options, user_input).

main(Argvs) :-
    cli_options(OptionsSpec), 
    opt_parse(OptionsSpec, Argvs, OptionsParse, Positional, []),  
    options_remove_free(OptionsParse, Options),
    (
        print_help(Options, OptionsSpec),
        !
    ;
        input_stream(Options, Options1, Input), 
        output_stream(Options1, RestOptions, Output), 
        main(Positional, RestOptions, Input, Output),
        close(Input),
        close(Output)
    ).

options_remove_free( [Option | OptionsParse], [Option | Options]) :-
    Option =.. [_, Arg],
    nonvar(Arg),
    options_remove_free( OptionsParse,  Options).
options_remove_free( [Option | OptionsParse], Options)  :-
    Option =.. [_, Arg],
    var(Arg),
    options_remove_free( OptionsParse,  Options).
options_remove_free( [], []).

option_spec(
    cli_option(Key, Type, Options, Help), 
    [opt(Key), type(Type), help(HelpList), longflags(LongFlags), shortflags(ShortFlags) |Spec]) :-
    (
        is_list(Help),
        HelpList = Help
    ;
        \+ is_list(Help),
        HelpList = [ Help ]        
    ),
    select_option(longflags(LongFlags), Options, Spec0, [Key] ),
    atom_chars(Key, [ Short | _]),
    select_option(shortflags(ShortFlags), Spec0, Spec,  [ Short ]),
    !.    
    
options_specs([Option | Options], [Spec|Specs]) :-
    option_spec(Option, Spec),
    options_specs(Options, Specs).
options_specs([], []).

output_stream(Options, RestOptions, Stream) :-
    select_option(output(File), Options, RestOptions ),
    open(File, write, Stream).
output_stream(Options, Options, user_output).

print_help(Options, OptionsSpec) :-
    memberchk(help(true), Options),
    opt_help(OptionsSpec, Help),
    setting(app_name, AppName),
    setting(app_version, Version),
    setting(app_authority, Authority),
    format('~n, version ~w, by ~w', [AppName, Version, Authority]), nl, nl,
    write_ln('Usage:'),
    writeln(Help).

server_or_main :-
    current_prolog_flag(argv, Argv), 
    argv_options(Argv, _, Options),
    (
        option(server(true), Options),
        !,
        server:server_start
    ;
        main
    ).