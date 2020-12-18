:- begin_tests(<%=packageName%>).
:- use_module(source(<%=packageName%>)).

% test(predicate, []) :-
%     <%=packageName%>:predicate(a, a).

% test('context variable retrievable ', 
%     [
%         nondet,
%         true(Value == my_value)
%     ]) 
% :-
%     % prepare
%     <%=packageName%>:prepare(Something),    
%     % execute
%     <%=packageName%>:predicate(Something, Value).

% test('multiple variables retrievable', 
%     [
%         all(Value == [my_value, my_value_2])
%     ]) 
% :-
%     % prepare
%     <%=packageName%>:prepare(Something),
%     % execute
%     <%=packageName%>:predicate(Something, Value).

% test('context_remove', 
%     [
%         fail
%     ]) :-
%     % prepare
%     <%=packageName%>:prepare(Something),
%     % execute
%     <%=packageName%>:predicate(Something).

:- end_tests(<%=packageName%>).