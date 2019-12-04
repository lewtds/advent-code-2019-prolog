% --- Day 4: Secure Container ---
%
% You arrive at the Venus fuel depot only to discover it's protected by a password. The Elves had written the password on a sticky note, but someone threw it out.
%
% However, they do remember a few key facts about the password:
%
%    It is a six-digit number.
%    The value is within the range given in your puzzle input.
%    Two adjacent digits are the same (like 22 in 122345).
%    Going from left to right, the digits never decrease; they only ever increase or stay the same (like 111123 or 135679).
%
% Other than the range rule, the following are true:
%
%    111111 meets these criteria (double 11, never decreases).
%    223450 does not meet these criteria (decreasing pair of digits 50).
%    123789 does not meet these criteria (no double).
%
% How many different passwords within the range given in your puzzle input meet these criteria?
%
% Your puzzle input is 178416-676461.

password(Password) :-
    [A, B, C, D, E, F] = Password,
    between(1, 9, A),
    between(0, 9, B),
    between(0, 9, C),
    between(0, 9, D),
    between(0, 9, E),
    between(0, 9, F),
    A =< B, B =< C, C =< D, D =< E, E =< F,
    (A = B; B = C; C = D; D = E; E = F).

password_between(P, Lower, Upper) :-
    password(P),
    P @>= Lower,
    P @=< Upper.

:- initialization(main, main).
main(Argv) :-
    setof(P, password_between(P, [1, 7, 8, 4, 1, 6], [6, 7, 6, 4, 6, 1]), Ps),
    length(Ps, L),
    write(L).
