domains
    city = symbol
    city_list = city*
 
predicates
    road(city, city)
    connected(city, city)
    member_city(city, city_list)
    travel(city, city, city_list, city_list)
 
clauses
    road(bhilai, raipur).
    road(raipur, durg).
    road(durg, bhilai).
    road(raipur, bilaspur).
    road(bilaspur, korba).
    road(durg, rajnandgaon).
 
    connected(X, Y) :- road(X, Y).
    connected(X, Y) :- road(Y, X).
 
    member_city(X, [X | _]) :- !.
    member_city(X, [_ | T]) :- member_city(X, T).
 
    travel(X, X, Visited, Visited) :- !.
    travel(X, Y, Visited, Path) :-
        connected(X, Z),
        not(member_city(Z, Visited)),
        travel(Z, Y, [Z | Visited], Path).
 
goal
    travel(bhilai, korba, [bhilai], Path),
    write("Recommended route from Bhilai to Korba: "),
    write(Path), nl.
goal
    travel(bhilai, rajnandgaon, [bhilai], Path2),
    write("Recommended route from Bhilai to Rajnandgaon: "),
    write(Path2), nl.