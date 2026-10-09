prolog
% ============================================================
% Experiment 1: Knowledge Base of Facts in Prolog
% Relationships modelled : likes/2  and  enrolled/2
% Platform               : SWISH Online SWI-Prolog Compiler
% ============================================================
 
% ---------------- CLAUSES: "likes" relationship facts ----------------
likes(ravi, cricket).
likes(ravi, chess).
likes(anita, painting).
likes(anita, cricket).
likes(sameer, football).
likes(priya, chess).
likes(priya, painting).
 
% ---------------- CLAUSES: student-course enrollment facts -----------
enrolled(ravi, ai_ml).
enrolled(ravi, dbms).
enrolled(anita, ai_ml).
enrolled(anita, dsa).
enrolled(sameer, dbms).
enrolled(priya, dsa).
enrolled(priya, ai_ml).
 
% ---------------- A simple rule built on the facts (optional) --------
% classmates(X, Y) is true if X and Y are enrolled in the same course
% and X is not the same person as Y.
classmates(X, Y) :-
    enrolled(X, Course),
    enrolled(Y, Course),
    X \== Y.