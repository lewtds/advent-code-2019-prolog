%    --- Part Two ---
%
%    "Good, the new computer seems to be working correctly! Keep it nearby during this mission - you'll probably use it again. Real Intcode computers support many more features than your new one, but we'll let you know what they are as you need them."
%
%    "However, your current priority should be to complete your gravity assist around the Moon. For this mission to succeed, we should settle on some terminology for the parts you've already built."
%
%    Intcode programs are given as a list of integers; these values are used as the initial state for the computer's memory. When you run an Intcode program, make sure to start by initializing memory to the program's values. A position in memory is called an address (for example, the first value in memory is at "address 0").
%
%    Opcodes (like 1, 2, or 99) mark the beginning of an instruction. The values used immediately after an opcode, if any, are called the instruction's parameters. For example, in the instruction 1,2,3,4, 1 is the opcode; 2, 3, and 4 are the parameters. The instruction 99 contains only an opcode and has no parameters.
%
%    The address of the current instruction is called the instruction pointer; it starts at 0. After an instruction finishes, the instruction pointer increases by the number of values in the instruction; until you add more instructions to the computer, this is always 4 (1 opcode + 3 parameters) for the add and multiply instructions. (The halt instruction would increase the instruction pointer by 1, but it halts the program instead.)
%
%    "With terminology out of the way, we're ready to proceed. To complete the gravity assist, you need to determine what pair of inputs produces the output 19690720."
%
%    The inputs should still be provided to the program by replacing the values at addresses 1 and 2, just like before. In this program, the value placed in address 1 is called the noun, and the value placed in address 2 is called the verb. Each of the two input values will be between 0 and 99, inclusive.
%
%    Once the program has halted, its output is available at address 0, also just like before. Each time you try a pair of inputs, make sure you first reset the computer's memory to the values in the program (your puzzle input) - in other words, don't reuse memory from a previous attempt.
%
%    Find the input noun and verb that cause the program to produce the output 19690720. What is 100 * noun + verb? (For example, if noun=12 and verb=2, the answer would be 1202.)
%
%    Your puzzle answer was 4925.

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


interpret(done, Out) :- m(0, Out).
interpret(StartPosition, Out) :-
    interpret_opcode(StartPosition, NextPosition),
    interpret(NextPosition, Out).

% Note that the end result seems to increase linearly with Noun and Verb so it might be much faster to figure out
% a mathematical relation and solve for Noun-Verb pair.
% Also, an interleaved search might give the answer faster than sequential search.
find(Noun, Verb) :-
    between(0, 99, Noun),
    between(0, 99, Verb),
    reset(Noun, Verb),
    interpret(0, Out),
    Out = 19690720, !.

% TODO Pretty inefficient solution
% 4925       12.87 real        13.09 user         0.08 sys
% On MBP2016 2,7 GHz Intel Core i7
:- initialization(main, main).
main :-
    find(Noun, Verb),
    write(Noun),
    write(Verb).
