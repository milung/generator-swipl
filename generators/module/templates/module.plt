:- begin_tests(<%=moduleName%>).
:- use_module(source(<%=modulePath%>)).

% test(predicate, []) :-
%     <%=moduleName%>:predicate(a, a).

% test('context variable retrievable ', 
%     [
%         nondet,
%         true(Value == my_value)
%     ]) 
% :-
%     % prepare
%     <%=moduleName%>:prepare(Something),    
%     % execute
%     <%=moduleName%>:predicate(Something, Value).

% test('multiple variables retrievable', 
%     [
%         all(Value == [my_value, my_value_2])
%     ]) 
% :-
%     % prepare
%     <%=moduleName%>:prepare(Something),
%     % execute
%     <%=moduleName%>:predicate(Something, Value).

% test('context_remove', 
%     [
%         fail
%     ]) :-
%     % prepare
%     <%=moduleName%>:prepare(Something),
%     % execute
%     <%=moduleName%>:predicate(Something).

:- end_tests(<%=moduleName%>).