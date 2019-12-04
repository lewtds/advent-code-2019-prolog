% --- Part Two ---
%
% An Elf just remembered one more important detail: the two adjacent matching digits are not part of a larger group of matching digits.
%
% Given this additional criterion, but still ignoring the range rule, the following are now true:
%
%    112233 meets these criteria because the digits never decrease and all repeated digits are exactly two digits long.
%    123444 no longer meets the criteria (the repeated 44 is part of a larger group of 444).
%    111122 meets the criteria (even though 1 is repeated more than twice, it still contains a double 22).
%
% How many different passwords within the range given in your puzzle input meet all of the criteria?
%
% Your puzzle input is still 178416-676461.

password(Password) :-
    [A, B, C, D, E, F] = Password,
    between(1, 9, A),
    between(0, 9, B),
    between(0, 9, C),
    between(0, 9, D),
    between(0, 9, E),
    between(0, 9, F),
    A =< B, B =< C, C =< D, D =< E, E =< F,
    (A = B, B \= C;
     B = C, B \= A, C \=D;
     C = D, C \= B, D \= E;
     D = E, D \= C, E \= F;
     E = F, E \= D).

password_between(P, Lower, Upper) :-
    password(P),
    P @>= Lower,
    P @=< Upper.

:- initialization(main, main).
main(_) :-
    setof(P, password_between(P, [1, 7, 8, 4, 1, 6], [6, 7, 6, 4, 6, 1]), Ps),
    length(Ps, L),
    write(L).
