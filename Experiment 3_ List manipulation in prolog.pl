===========================================================
%Experiment 3: List manipulation in prolog
%Operations: append, reverse , search(member)
%==========================================================


%---- 1. Append Two Lists----
my_append([],L2,L2).
my_append([H|T1],L2,[H|T3]):-
    my_append(T1, L2,T3).

%---- 2. Reverse a list (accumulator-based)----
my_reverse(List, Reversed):-
    reverse_acc(List,[], Reversed).

reverse_acc([],Acc,Acc). %Base Case
reverse_acc([H|T], Acc,Reversed):-
    reverse_acc(T,[H|Acc],Reversed).

%----3.Search for an element in a list----
my_member(X,[X|_]).
my_member(X,[_|T]):-
    my_member(X,T).

%---- Driver predicate to demonstrate all three----
run_demo:- 
    L1 = [1,2,3],
    L2 = [4,5,6],
    my_append(L1,L2,L3),
    format('Append: ~w ++ ~w  = ~w~n', [L1,L2,L3]),
    
    my_reverse(L3,R),
    format('Reverse of ~w = ~w~n',[L3,R]),
    
    ( my_member(5,L3)
    -> format('Search: 5 found in ~w~n', [L3])
    ;  format('Search: 5 found in ~w~n', [L3])
    ),
    (   my_member(9,L3)
    ->  format('Search: 9 found in ~w~n', [L3])
    ;   format('Search: 9 not found in ~w~n', [L3]) ).