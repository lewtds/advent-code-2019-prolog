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
