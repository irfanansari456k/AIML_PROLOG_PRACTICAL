% Experiment 5: Student Performance Analysis

% Rule-based classification using Prolog

% student(Name, Mark1, Mark2, Mark3).

student (amit, 92, 88, 90).
student (neha, 75, 68, 72).
student(rahul, 45, 50, 48).
student (priya, 85, 78, 82).
student(rohit, 35, 55, 60).
student (sneha, 65, 58, 70).

% Calculate average marks.

average (M1, M2, M3, Avg):-
Avg is (M1+ M2+ M3) / 3.

% Topper: average >= 80 and every subject >= 60.

topper (Name) :-
student (Name, M1, M2, M3),
average (M1, M2, M3, Avg),