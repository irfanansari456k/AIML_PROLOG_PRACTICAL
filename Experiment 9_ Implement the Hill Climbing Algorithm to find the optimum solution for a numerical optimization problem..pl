% ============================================================
% Hill Climbing Search in Prolog
% ============================================================
% Hill Climbing is a GREEDY local search: from the current node,
% always move to the neighbor with the BEST (lowest) heuristic
% value. It stops as soon as no unvisited neighbor improves on
% the current node's heuristic -- a "local optimum". Unlike BFS
% or A*, it never backtracks, so it can get stuck and fail to
% reach the goal even if a path exists.
 
% ---- Graph definition ----
edge(a,b). edge(a,c).
edge(b,d). edge(b,e).
edge(c,e).
edge(d,f). edge(e,f).
 
connected(X,Y) :- edge(X,Y).
connected(X,Y) :- edge(Y,X).
 
% ---- Heuristic: estimated distance to goal f (lower = closer/better) ----
h(a,6). h(b,4). h(c,4). h(d,3). h(e,1). h(f,0).
 
goal(f).
 
% hill_climb(+Start)
% Entry point / convenience wrapper that prints the result.
hill_climb(Start) :-
    hill_climb(Start, [Start], RevPath),
    !,
    reverse(RevPath, Path),
    format('Hill Climbing Path found: ~w~n', [Path]).
hill_climb(_) :-
    write('Hill Climbing got stuck at a local optimum -- no path found.'), nl.
 
% hill_climb(+CurrentNode, +VisitedSoFar, -ReversedPath)
hill_climb(Node, Visited, Visited) :-
    goal(Node), !.                        % goal reached -> stop
 
hill_climb(Node, Visited, Path) :-
    findall(Next-Hn,
            ( connected(Node,Next), \+ member(Next,Visited), h(Next,Hn) ),
            Neighbors),
    Neighbors \= [],                      % fail (stuck) if no unvisited neighbors remain
    best_neighbor(Neighbors, BestNode, BestH),
    h(Node, HCurrent),
    BestH < HCurrent,                     % only move if it STRICTLY improves the heuristic
    hill_climb(BestNode, [BestNode|Visited], Path).
 
% best_neighbor(+ListOfNode-Heuristic, -BestNode, -BestH)
% Scans all candidate neighbors and picks the one with the smallest
% (best) heuristic value -- the "climb toward the goal" step.
best_neighbor([N-H], N, H) :- !.
best_neighbor([N1-H1|Rest], Best, BestH) :-
    best_neighbor(Rest, N2, H2),
    ( H1 =< H2 -> Best = N1, BestH = H1 ; Best = N2, BestH = H2 ).
 
% ---- Example query ----
% ?- hill_climb(a).
% Hill Climbing Path found: [a, b, e, f]
 
:- initialization(main).
main :- hill_climb(a).