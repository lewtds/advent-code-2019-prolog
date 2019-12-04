:- dynamic(m/2).

% Expand at compile time prog_mem([1, 2, 3]). into a series of m(0, 1). m(0, 2). m(0, 3). facts.
term_expansion(prog_mem(Cells), Terms) :-
    expand_cells(Cells, Terms, 0).

expand_cells([Cell | CellRest], [m(Index, Cell) | TermsRest], Index) :-
    NextIndex is Index + 1,
    expand_cells(CellRest, TermsRest, NextIndex).

expand_cells([], [], _).


reset(Noun, Verb) :-
    retractall(m(_, _)),
    expand_term(prog_mem([1,Noun,Verb,3,1,1,2,3,1,3,4,3,1,5,0,3,
                          2,1,13,19,1,9,19,23,1,6,23,27,2,27,9,
                          31,2,6,31,35,1,5,35,39,1,10,39,43,1,
                          43,13,47,1,47,9,51,1,51,9,55,1,55,9,
                          59,2,9,59,63,2,9,63,67,1,5,67,71,2,
                          13,71,75,1,6,75,79,1,10,79,83,2,6,83,
                          87,1,87,5,91,1,91,9,95,1,95,10,99,2,
                          9,99,103,1,5,103,107,1,5,107,111,2,
                          111,10,115,1,6,115,119,2,10,119,123,
                          1,6,123,127,1,127,5,131,2,9,131,135,
                          1,5,135,139,1,139,10,143,1,143,2,147,
                          1,147,5,0,99,2,0,14,0]), Terms),
    assertz_many(Terms).

assertz_many([Head|Rest]) :-
    assertz(Head),
    assertz_many(Rest).

assertz_many([]).


add(IndexA, IndexB, IndexOut) :-
    m(IndexA, A),
    m(IndexB, B),
    Out is A + B,
    retractall(m(IndexOut, _)),
    assertz(m(IndexOut, Out)).


mult(IndexA, IndexB, IndexOut) :-
    m(IndexA, A),
    m(IndexB, B),
    Out is A * B,
    retractall(m(IndexOut, _)),
    assertz(m(IndexOut, Out)).

interpret_opcode(Pos, NextPos) :- m(Pos, 1),
    Pos1 is Pos + 1,
    Pos2 is Pos + 2,
    Pos3 is Pos + 3,
    m(Pos1, IndexA),
    m(Pos2, IndexB),
    m(Pos3, IndexOut),
    add(IndexA, IndexB, IndexOut),
    NextPos is Pos + 4.

interpret_opcode(Pos, NextPos) :- m(Pos, 2),
    Pos1 is Pos + 1,
    Pos2 is Pos + 2,
    Pos3 is Pos + 3,
    m(Pos1, IndexA),
    m(Pos2, IndexB),
    m(Pos3, IndexOut),
    mult(IndexA, IndexB, IndexOut),
    NextPos is Pos + 4.

interpret_opcode(Pos, done) :- m(Pos, 99).


interpret(StartPosition, Out) :-
    interpret_opcode(StartPosition, NextPosition),
    (  NextPosition = done
    -> m(0, Out)
    ;  interpret(NextPosition, Out)).

% Note that the end result seems to increase linearly with Noun and Verb so it might be much faster to figure out
% a mathematical relation and solve for Noun-Verb pair.
% Also, an interleaved search might give the answer faster than sequential search.
find(Noun, Verb) :-
    between(0, 99, Noun),
    between(0, 99, Verb),
    reset(Noun, Verb),
    interpret(0, Out),
    Out = 19690720, !.
