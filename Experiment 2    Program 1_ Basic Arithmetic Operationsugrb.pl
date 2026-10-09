Experiment 2
   Program 1: Basic Arithmetic Operations
   ============================================================ */
 
DOMAINS
  num = integer
 
PREDICATES
  arithmetic(num, num)
 
CLAUSES
  arithmetic(A, B) :-
    Sum = A + B,
    Diff = A - B,
    Prod = A * B,
    Quot = A / B,
    Rem = A mod B,
    write("Sum = ", Sum), nl,
    write("Difference = ", Diff), nl,
    write("Product = ", Prod), nl,
    write("Quotient = ", Quot), nl,
    write("Remainder = ", Rem), nl.
 
GOAL
  arithmetic(20, 6).