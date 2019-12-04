%    --- Part Two ---
%
%    During the second Go / No Go poll, the Elf in charge of the Rocket Equation Double-Checker stops the launch sequence. Apparently, you forgot to include additional fuel for the fuel you just added.
%
%    Fuel itself requires fuel just like a module - take its mass, divide by three, round down, and subtract 2. However, that fuel also requires fuel, and that fuel requires fuel, and so on. Any mass that would require negative fuel should instead be treated as if it requires zero fuel; the remaining mass, if any, is instead handled by wishing really hard, which has no mass and is outside the scope of this calculation.
%
%    So, for each module mass, calculate its fuel and add it to the total. Then, treat the fuel amount you just calculated as the input mass and repeat the process, continuing until a fuel requirement is zero or negative. For example:
%
%        A module of mass 14 requires 2 fuel. This fuel requires no further fuel (2 divided by 3 and rounded down is 0, which would call for a negative fuel), so the total fuel required is still just 2.
%        At first, a module of mass 1969 requires 654 fuel. Then, this fuel requires 216 more fuel (654 / 3 - 2). 216 then requires 70 more fuel, which requires 21 fuel, which requires 5 fuel, which requires no further fuel. So, the total fuel required for a module of mass 1969 is 654 + 216 + 70 + 21 + 5 = 966.
%        The fuel required by a module of mass 100756 and its fuel is: 33583 + 11192 + 3728 + 1240 + 411 + 135 + 43 + 12 + 2 = 50346.
%
%    What is the sum of the fuel requirements for all of the modules on your spacecraft when also taking into account the mass of the added fuel? (Calculate the fuel requirements for each module separately, then add them all up at the end.)
%
%    Your puzzle answer was 5102369.

fuel_subfuel(Fuel, List, [0 | List]) :-
    NextSub is floor(Fuel / 3) - 2, NextSub =< 0, !.

fuel_subfuel(Fuel, List, OutList) :-
    NextSub is floor(Fuel / 3) - 2,
    NextList = [NextSub | List],
    fuel_subfuel(NextSub, NextList, OutList).

add(X,Y,Sum):- Sum is X+Y.
sum(Xs,Sum):- foldl(add, Xs, 0, Sum).


total_fuel(InitialFuel, TotalFuel) :-
    fuel_subfuel(InitialFuel, [], SubFuels),
    sum(SubFuels, SubFuel),
    TotalFuel is InitialFuel + SubFuel.


mass_fuel(Mass, TotalFuel) :-
    Fuel is floor(Mass / 3) - 2,
    total_fuel(Fuel, TotalFuel).

map_mass_fuel([], Initial, Initial).
map_mass_fuel([Head | Rest], Initial, Sum) :-
    mass_fuel(Head, Fuel),
    NextSum is Initial + Fuel,
    map_mass_fuel(Rest, NextSum, Sum).


:- initialization(main, main).
main :-
    Data = [114106, 87170, 133060, 70662, 134140, 125874, 50081, 133117, 100409, 95098, 70251, 134043, 87501, 85034, 110678, 80615, 64647, 88555, 106387, 143755, 101246, 142348, 92684, 62051, 94894, 65873, 78473, 64042, 147982, 145898, 85591, 121413, 132163, 94351, 80080, 73554, 106598, 135174, 147951, 132517, 50925, 115752, 114022, 73448, 50451, 56205, 81474, 90028, 124879, 137452, 91036, 87221, 126590, 130592, 91503, 148689, 86526, 105924, 52411, 146708, 149280, 52100, 80024, 115412, 91204, 132726, 59837, 129863, 140980, 109574, 103013, 84105, 138883, 144861, 126708, 140290, 54417, 138154, 125187, 91537, 90338, 61150, 61702, 95888, 100484, 82115, 122141, 63986, 138234, 54150, 57651, 124570, 88460, 112144, 112334, 119114, 58220, 143221, 86568, 148706],
    map_mass_fuel(Data, 0, Fuel),
    write(Fuel).
