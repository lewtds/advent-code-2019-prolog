%    --- Part Two ---
%
%    The air conditioner comes online! Its cold air feels good for a while, but then the TEST alarms start to go off. Since the air conditioner can't vent its heat anywhere but back into the spacecraft, it's actually making the air inside the ship warmer.
%
%    Instead, you'll need to use the TEST to extend the thermal radiators. Fortunately, the diagnostic program (your puzzle input) is already equipped for this. Unfortunately, your Intcode computer is not.
%
%    Your computer is only missing a few opcodes:
%
%        Opcode 5 is jump-if-true: if the first parameter is non-zero, it sets the instruction pointer to the value from the second parameter. Otherwise, it does nothing.
%        Opcode 6 is jump-if-false: if the first parameter is zero, it sets the instruction pointer to the value from the second parameter. Otherwise, it does nothing.
%        Opcode 7 is less than: if the first parameter is less than the second parameter, it stores 1 in the position given by the third parameter. Otherwise, it stores 0.
%        Opcode 8 is equals: if the first parameter is equal to the second parameter, it stores 1 in the position given by the third parameter. Otherwise, it stores 0.
%
%    Like all instructions, these instructions need to support parameter modes as described above.
%
%    Normally, after an instruction is finished, the instruction pointer increases by the number of values in that instruction. However, if the instruction modifies the instruction pointer, that value is used and the instruction pointer is not automatically increased.
%
%    For example, here are several programs that take one input, compare it to the value 8, and then produce one output:
%
%        3,9,8,9,10,9,4,9,99,-1,8 - Using position mode, consider whether the input is equal to 8; output 1 (if it is) or 0 (if it is not).
%        3,9,7,9,10,9,4,9,99,-1,8 - Using position mode, consider whether the input is less than 8; output 1 (if it is) or 0 (if it is not).
%        3,3,1108,-1,8,3,4,3,99 - Using immediate mode, consider whether the input is equal to 8; output 1 (if it is) or 0 (if it is not).
%        3,3,1107,-1,8,3,4,3,99 - Using immediate mode, consider whether the input is less than 8; output 1 (if it is) or 0 (if it is not).
%
%    Here are some jump tests that take an input, then output 0 if the input was zero or 1 if the input was non-zero:
%
%        3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9 (using position mode)
%        3,3,1105,-1,9,1101,0,0,12,4,12,99,1 (using immediate mode)
%
%    Here's a larger example:
%
%    3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,
%    1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,
%    999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99
%
%    The above example program uses an input instruction to ask for a single number. The program will then output 999 if the input value is below 8, output 1000 if the input value is equal to 8, or output 1001 if the input value is greater than 8.
%
%    This time, when the TEST diagnostic program runs its input instruction to get the ID of the system to test, provide it 5, the ID for the ship's thermal radiator controller. This diagnostic test suite only outputs one number, the diagnostic code.
%
%    What is the diagnostic code for system ID 5?


:- dynamic(m/2).

% Expand at compile time prog_mem([1, 2, 3]). into a series of m(0, 1). m(0, 2). m(0, 3). facts.
term_expansion(prog_mem(Cells), Terms) :-
    expand_cells(Cells, Terms, 0).

expand_cells([Cell | CellRest], [m(Index, Cell) | TermsRest], Index) :-
    NextIndex is Index + 1,
    expand_cells(CellRest, TermsRest, NextIndex).

expand_cells([], [], _).


%prog_mem([3,9,8,9,10,9,4,9,99,-1,8]).
%prog_mem([3,9,7,9,10,9,4,9,99,-1,8]).
%prog_mem([3,3,1108,-1,8,3,4,3,99]).
%prog_mem([3,3,1107,-1,8,3,4,3,99]).
%prog_mem([3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9]).
%prog_mem([3,3,1105,-1,9,1101,0,0,12,4,12,99,1]).
%prog_mem([3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,
%          1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,
%          999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99]).
prog_mem([3,225,1,225,6,6,1100,1,238,225,104,0,1101,69,55,225,1001,144,76,224,101,-139,224,224,4,224,1002,223,8,223,1001,224,3,224,1,223,224,223,1102,60,49,225,1102,51,78,225,1101,82,33,224,1001,224,-115,224,4,224,1002,223,8,223,1001,224,3,224,1,224,223,223,1102,69,5,225,2,39,13,224,1001,224,-4140,224,4,224,102,8,223,223,101,2,224,224,1,224,223,223,101,42,44,224,101,-120,224,224,4,224,102,8,223,223,101,3,224,224,1,223,224,223,1102,68,49,224,101,-3332,224,224,4,224,1002,223,8,223,1001,224,4,224,1,224,223,223,1101,50,27,225,1102,5,63,225,1002,139,75,224,1001,224,-3750,224,4,224,1002,223,8,223,1001,224,3,224,1,223,224,223,102,79,213,224,1001,224,-2844,224,4,224,102,8,223,223,1001,224,4,224,1,223,224,223,1,217,69,224,1001,224,-95,224,4,224,102,8,223,223,1001,224,5,224,1,223,224,223,1102,36,37,225,1101,26,16,225,4,223,99,0,0,0,677,0,0,0,0,0,0,0,0,0,0,0,1105,0,99999,1105,227,247,1105,1,99999,1005,227,99999,1005,0,256,1105,1,99999,1106,227,99999,1106,0,265,1105,1,99999,1006,0,99999,1006,227,274,1105,1,99999,1105,1,280,1105,1,99999,1,225,225,225,1101,294,0,0,105,1,0,1105,1,99999,1106,0,300,1105,1,99999,1,225,225,225,1101,314,0,0,106,0,0,1105,1,99999,1107,677,677,224,102,2,223,223,1006,224,329,1001,223,1,223,1108,677,677,224,1002,223,2,223,1006,224,344,1001,223,1,223,107,226,226,224,1002,223,2,223,1006,224,359,101,1,223,223,1008,226,226,224,102,2,223,223,1005,224,374,1001,223,1,223,1107,226,677,224,1002,223,2,223,1006,224,389,1001,223,1,223,1008,677,226,224,1002,223,2,223,1005,224,404,1001,223,1,223,7,677,226,224,102,2,223,223,1005,224,419,1001,223,1,223,1008,677,677,224,1002,223,2,223,1006,224,434,1001,223,1,223,108,226,226,224,102,2,223,223,1006,224,449,1001,223,1,223,108,677,677,224,102,2,223,223,1006,224,464,1001,223,1,223,107,226,677,224,1002,223,2,223,1005,224,479,101,1,223,223,1108,226,677,224,1002,223,2,223,1006,224,494,1001,223,1,223,107,677,677,224,1002,223,2,223,1006,224,509,101,1,223,223,7,677,677,224,102,2,223,223,1006,224,524,1001,223,1,223,1007,226,677,224,1002,223,2,223,1005,224,539,1001,223,1,223,8,226,677,224,1002,223,2,223,1005,224,554,101,1,223,223,8,677,677,224,102,2,223,223,1005,224,569,101,1,223,223,7,226,677,224,102,2,223,223,1006,224,584,1001,223,1,223,1007,226,226,224,102,2,223,223,1006,224,599,1001,223,1,223,1107,677,226,224,1002,223,2,223,1006,224,614,1001,223,1,223,1108,677,226,224,1002,223,2,223,1005,224,629,1001,223,1,223,1007,677,677,224,102,2,223,223,1006,224,644,1001,223,1,223,108,226,677,224,102,2,223,223,1005,224,659,101,1,223,223,8,677,226,224,1002,223,2,223,1006,224,674,1001,223,1,223,4,223,99,226]).


% Now we change the params to all the opcodes to include wrappers that indicate the operand mode: imm(3) or pos(4).

% load/2 takes care of the difference between pos/1 and imm/1
load(pos(Addr), Out) :-
    m(Addr, Out).

load(imm(Value), Value).

save(pos(Addr), Value) :-
    retractall(m(Addr, _)),
    assertz(m(Addr, Value)).

op_input(pos(Addr), IP, NextIp) :-
    retractall(m(Addr, _)),
    assertz(m(Addr, 5)),
    NextIp is IP + 2.

op_output(pos(Addr), IP, NextIP) :-
    m(Addr, Value),
    format('~w~n', [Value]),
    NextIP is IP + 2.

op_add(R1, R2, R3, IP, NextIP) :-
    load(R1, Val1),
    load(R2, Val2),
    Val is Val1 + Val2,
    save(R3, Val),
    NextIP is IP + 4.

op_mult(R1, R2, R3, IP, NextIP) :-
    load(R1, Val1),
    load(R2, Val2),
    Val is Val1 * Val2,
    save(R3, Val),
    NextIP is IP + 4.

op_jump_if_true(R1, R2, IP, NextIP) :-
    load(R1, Val1),
    load(R2, Val2),
    ( Val1 \= 0
    -> NextIP is Val2
    ;
      NextIP is IP + 3
    ).

op_jump_if_false(R1, R2, IP, NextIP) :-
    load(R1, Val1),
    load(R2, Val2),
    ( Val1 = 0 -> NextIP is Val2
    ;
      NextIP is IP + 3
    ).

op_less_than(R1, R2, R3, IP, NextIP) :-
    load(R1, Val1),
    load(R2, Val2),
    NextIP is IP + 4,
    (  Val1 < Val2
    -> save(R3, 1)
    ;  save(R3, 0)
    ).

op_equals(R1, R2, R3, IP, NextIP) :-
    load(R1, Val1),
    load(R2, Val2),
    NextIP is IP + 4,
    (  Val1 = Val2
    -> save(R3, 1)
    ;  save(R3, 0)
    ).

% 1002, 3, 4, 5 -> [mult, pos(3), imm(4), pos(5)] -> mult(pos(3), imm(4), pos(5), [0], [NextIP])
parse_opcode(Addr, OpCode) :-
    m(Addr, IntCode),
    format(atom(Padded), '~`0t~d~5+', [IntCode]),
    atom_chars(Padded, [_, B, C, D, E]),

   (  [D, E] = ['0', '1']
   -> bit_mode(C, Mode1),
      bit_mode(B, Mode2),
      params_mode_opcode(Addr, [op_add | [Mode1, Mode2, pos]], OpCode)
   ;
      [D, E] = ['0', '2']
   -> bit_mode(C, Mode1),
      bit_mode(B, Mode2),
      params_mode_opcode(Addr, [op_mult | [Mode1, Mode2, pos]], OpCode)
   ;
      [D, E] = ['0', '3']
   -> params_mode_opcode(Addr, [op_input | [pos]], OpCode)
   ;
      [D, E] = ['0', '4']
   -> params_mode_opcode(Addr, [op_output | [pos]], OpCode)
   ;
      [D, E] = ['0', '5']
   -> bit_mode(C, Mode1),
      bit_mode(B, Mode2),
      params_mode_opcode(Addr, [op_jump_if_true | [Mode1, Mode2]], OpCode)
   ;
      [D, E] = ['0', '6']
   -> bit_mode(C, Mode1),
      bit_mode(B, Mode2),
      params_mode_opcode(Addr, [op_jump_if_false | [Mode1, Mode2]], OpCode)
   ;
      [D, E] = ['0', '7']
   -> bit_mode(C, Mode1),
      bit_mode(B, Mode2),
      params_mode_opcode(Addr, [op_less_than | [Mode1, Mode2, pos]], OpCode)
   ;
      [D, E] = ['0', '8']
   -> bit_mode(C, Mode1),
      bit_mode(B, Mode2),
      params_mode_opcode(Addr, [op_equals | [Mode1, Mode2, pos]], OpCode)
   ).


bit_mode('0', pos).
bit_mode('1', imm).

poke_mem(Addr, Len, [OutHead | Rest]) :-
    m(Addr, OutHead),
    NextAddr is Addr + 1,
    NextLen is Len - 1,
    poke_mem(NextAddr, NextLen, Rest).

poke_mem(_, 0, []).

params_mode_opcode(Addr, [op_add | [Mode1, Mode2, pos] ], OpCode) :-
    poke_mem(Addr, 4, [_, A, B, C]),
    Term1 =.. [Mode1, A],
    Term2 =.. [Mode2, B],
    OpCode = [op_add, Term1, Term2, pos(C)].

params_mode_opcode(Addr, [op_mult | [Mode1, Mode2, pos] ], OpCode) :-
    poke_mem(Addr, 4, [_, A, B, C]),
    Term1 =.. [Mode1, A],
    Term2 =.. [Mode2, B],
    OpCode = [op_mult, Term1, Term2, pos(C)].

params_mode_opcode(Addr, [op_input | [pos] ], OpCode) :-
    poke_mem(Addr, 2, [_, A]),
    OpCode = [op_input, pos(A)].

params_mode_opcode(Addr, [op_output | [pos] ], OpCode) :-
    poke_mem(Addr, 2, [_, A]),
    OpCode = [op_output, pos(A)].

params_mode_opcode(Addr, [op_jump_if_true | [Mode1, Mode2]], OpCode) :-
    poke_mem(Addr, 3, [_, A, B]),
    Term1 =.. [Mode1, A],
    Term2 =.. [Mode2, B],
    OpCode = [op_jump_if_true, Term1, Term2].

params_mode_opcode(Addr, [op_jump_if_false | [Mode1, Mode2]], OpCode) :-
    poke_mem(Addr, 3, [_, A, B]),
    Term1 =.. [Mode1, A],
    Term2 =.. [Mode2, B],
    OpCode = [op_jump_if_false, Term1, Term2].

params_mode_opcode(Addr, [op_less_than | [Mode1, Mode2, pos]], OpCode) :-
    poke_mem(Addr, 4, [_, A, B, C]),
    Term1 =.. [Mode1, A],
    Term2 =.. [Mode2, B],
    OpCode = [op_less_than, Term1, Term2, pos(C)].

params_mode_opcode(Addr, [op_equals | [Mode1, Mode2, pos]], OpCode) :-
    poke_mem(Addr, 4, [_, A, B, C]),
    Term1 =.. [Mode1, A],
    Term2 =.. [Mode2, B],
    OpCode = [op_equals, Term1, Term2, pos(C)].


interpret_opcode(Addr, done) :- m(Addr, 99).

interpret_opcode(StartAddr, NextAddr) :-
    parse_opcode(StartAddr, OpCode),
    append(OpCode, [StartAddr, NextAddr], Curried),
    ExecutableOpCode =.. Curried,
%    format('~w~w~n', [Curried, ExecutableOpCode]),
    ExecutableOpCode.


interpret(done).
interpret(StartPosition) :-
    interpret_opcode(StartPosition, NextPosition),
    interpret(NextPosition).


:- initialization(main, main).
main :-
    interpret(0).
