% =========================================================
% DEPTH FIRST SEARCH (DFS) IN PROLOG
% =========================================================
% ---------------------------------------------------------
% STEP 1: Define the graph using facts
% edge(X, Y) means there is a direct connection from X to Y
% ---------------------------------------------------------
edge(a, b).
edge(a, c).
edge(b, d).
edge(c, d).
edge(d, e).
edge(b, e).
% ---------------------------------------------------------
% STEP 2: dfs/2 - the main predicate the user calls
% dfs(StartNode, VisitedList)
% We start with an empty "Visited so far" list = []
% ---------------------------------------------------------
dfs(StartNode, Visited) :-
dfs(StartNode, [], Visited). % call helper predicate with empty accumulator
% ---------------------------------------------------------
% STEP 3: dfs/3 - the helper (worker) predicate
% dfs(CurrentNode, VisitedSoFar, FinalVisitedList)
% ---------------------------------------------------------
% Base rule: if the current node is ALREADY visited,
% do nothing more, just return the same Visited list.
dfs(Node, Visited, Visited) :-
member(Node, Visited), % check if Node is already in Visited
!. % cut: stop here, don't try other rules
% Main rule: if Node is NOT visited yet
dfs(Node, Visited, FinalVisited) :-
\+ member(Node, Visited), % make sure Node is not already visited
append(Visited, [Node], Visited1), % add current Node to Visited list
findall(Next, edge(Node, Next), Neighbours), % get ALL neighbours of Node
dfs_list(Neighbours, Visited1, FinalVisited). % recursively visit them
% Parameter 1 — Neighbours = list of nodes to process (input)
%Parameter 2 — Visited1 = visited-list so far, going in (input)
%Parameter 3 — FinalVisited = visited-list after processing all of Neighbours (output)
%dfs_list([b, c], [a], FinalVisited)
%Neighbours = [b, c] 
%Visited1 = [a] 
%FinalVisited = whatever [a] grows into after b and c are both processed → turns out to be [a, b, d, e, c]
% ---------------------------------------------------------
% STEP 4: dfs_list/3 - visits a LIST of neighbour nodes
% one by one, passing the updated Visited list each time
% ---------------------------------------------------------
% Base case: empty list of neighbours -> nothing to do
dfs_list([], Visited, Visited).
% Recursive case: visit first neighbour, then rest of the list
dfs_list([Node | RestNodes], Visited, FinalVisited) :-
dfs(Node, Visited, Visited1), % explore this neighbour fully first (DEPTH first)
dfs_list(RestNodes, Visited1, FinalVisited). % then move to next neighbour

% [Node | RestNodes] splits the incoming list into two pieces: Node = the first item, 
% RestNodes = everything else.