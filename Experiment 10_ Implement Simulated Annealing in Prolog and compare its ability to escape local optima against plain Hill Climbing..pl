% ============================================================
% Simulated Annealing in Prolog
% ============================================================
% Simulated Annealing is a probabilistic local search: like Hill
% Climbing, it usually favors moving to a better neighbor, but it
% can also ACCEPT a WORSE move with probability exp(-Delta/Temp).
% This lets it escape local optima that would trap plain Hill
% Climbing. As Temperature cools each iteration, the search
% becomes progressively greedier (less likely to accept bad moves).
 
:- use_module(library(random)).
 
% ---- Graph definition ----
edge(a,b). edge(a,c).
edge(b,d). edge(b,e).
edge(c,e).
edge(d,f). edge(e,f).
 
connected(X,Y) :- edge(X,Y).
connected(X,Y) :- edge(Y,X).
 
% ---- Heuristic ("energy" to minimize; 0 = goal reached) ----
h(a,6). h(b,4). h(c,4). h(d,3). h(e,1). h(f,0).
 
goal(f).
 
% simulated_annealing(+Start, +InitialTemp, +CoolingRate, +MinTemp)
% CoolingRate is a fraction in (0,1); Temp is multiplied by it each step.
simulated_annealing(Start, T0, Cooling, MinT) :-
    h(Start, H0),
    sa_loop(Start, [Start], H0, T0, Cooling, MinT, RevPath, FinalH),
    reverse(RevPath, Path),
    format('Simulated Annealing Path: ~w  (final heuristic = ~w)~n', [Path, FinalH]).
 
% sa_loop(+Node,+VisitedPath,+CurrentH,+Temp,+Cooling,+MinTemp,-Path,-FinalH)
 
% Case 1: goal reached -- stop immediately.
sa_loop(Node, Visited, _, _, _, _, Visited, 0) :-
    goal(Node), !.
 
% Case 2: still searching, and temperature has not yet cooled below MinTemp.
sa_loop(Node, Visited, HCurrent, Temp, Cooling, MinT, Path, FinalH) :-
    Temp > MinT,
    findall(Next-Hn,
            ( connected(Node,Next), \+ member(Next,Visited), h(Next,Hn) ),
            Neighbors),
    Neighbors \= [],                        % if truly stuck, fall through to Case 3 via backtracking
    !,
    random_member(Next-HNext, Neighbors),   % pick a RANDOM neighbor (not necessarily the best one!)
    Delta is HNext - HCurrent,              % negative Delta = improvement in heuristic
    ( Delta =< 0
    -> Accept = true                        % always accept a move that improves (or ties) the heuristic
    ;  Prob is exp(-Delta / Temp),          % otherwise accept with probability exp(-Delta/Temp)
       random(R),
       Accept = (R < Prob)
    ),
    NewTemp is Temp * Cooling,              % cool the temperature down each iteration
    ( Accept == true
    -> sa_loop(Next, [Next|Visited], HNext, NewTemp, Cooling, MinT, Path, FinalH)
    ;  sa_loop(Node, Visited, HCurrent, NewTemp, Cooling, MinT, Path, FinalH)   % reject -> stay put, just cool down
    ).
 
% Case 3: ran out of temperature budget (or got stuck with no unvisited
% neighbors) without reaching the goal -- report the best point reached.
sa_loop(_, Visited, HCurrent, _, _, _, Visited, HCurrent) :-
    write('Cooled down / stuck without reaching goal -- returning best point found.'), nl.
 
% ---- Example query ----
% ?- simulated_annealing(a, 10.0, 0.9, 0.01).
% Simulated Annealing Path: [a, b, e, f]  (final heuristic = 0)
% NOTE: this algorithm is randomized -- the exact path and run length
% will vary between runs/executions.
 
:- initialization(main).
main :-
    set_random(seed(42)),               % fixed seed so the demo run is repeatable
    simulated_annealing(a, 10.0, 0.9, 0.01).