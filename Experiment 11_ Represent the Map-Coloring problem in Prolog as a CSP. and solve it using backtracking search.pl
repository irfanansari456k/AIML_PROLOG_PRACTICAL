color(red).
color(green).
color(blue).

different(X,Y) :- X \= Y.

map(A,B,C,D) :-
    color(A),
    color(B),
    color(C),
    color(D),

    different(A,B),
    different(A,C),
    different(B,C),
    different(B,D),
    different(C,D).

% map(A,B,C,D).