%    --- Day 1: The Tyranny of the Rocket Equation ---
%
%    Santa has become stranded at the edge of the Solar System while delivering presents to other planets! To accurately calculate his position in space, safely align his warp drive, and return to Earth in time to save Christmas, he needs you to bring him measurements from fifty stars.
%
%    Collect stars by solving puzzles. Two puzzles will be made available on each day in the Advent calendar; the second puzzle is unlocked when you complete the first. Each puzzle grants one star. Good luck!
%
%    The Elves quickly load you into a spacecraft and prepare to launch.
%
%    At the first Go / No Go poll, every Elf is Go until the Fuel Counter-Upper. They haven't determined the amount of fuel required yet.
%
%    Fuel required to launch a given module is based on its mass. Specifically, to find the fuel required for a module, take its mass, divide by three, round down, and subtract 2.
%
%    For example:
%
%        For a mass of 12, divide by 3 and round down to get 4, then subtract 2 to get 2.
%        For a mass of 14, dividing by 3 and rounding down still yields 4, so the fuel required is also 2.
%        For a mass of 1969, the fuel required is 654.
%        For a mass of 100756, the fuel required is 33583.
%
%    The Fuel Counter-Upper needs to know the total fuel requirement. To find it, individually calculate the fuel needed for the mass of each module (your puzzle input), then add together all the fuel values.
%
%    What is the sum of the fuel requirements for all of the modules on your spacecraft?
%
%    Your puzzle answer was 3403509.

mass_fuel(Mass, Fuel) :- Fuel is floor(Mass / 3) - 2.

total_mass_fuel(Masses, Fuel) :-
    maplist(mass_fuel, Masses, Fuels),
    sum_list(Fuels, Fuel).

:- initialization(main, main).
main :-
    Data = [114106, 87170, 133060, 70662, 134140, 125874, 50081, 133117, 100409, 95098, 70251, 134043, 87501, 85034, 110678, 80615, 64647, 88555, 106387, 143755, 101246, 142348, 92684, 62051, 94894, 65873, 78473, 64042, 147982, 145898, 85591, 121413, 132163, 94351, 80080, 73554, 106598, 135174, 147951, 132517, 50925, 115752, 114022, 73448, 50451, 56205, 81474, 90028, 124879, 137452, 91036, 87221, 126590, 130592, 91503, 148689, 86526, 105924, 52411, 146708, 149280, 52100, 80024, 115412, 91204, 132726, 59837, 129863, 140980, 109574, 103013, 84105, 138883, 144861, 126708, 140290, 54417, 138154, 125187, 91537, 90338, 61150, 61702, 95888, 100484, 82115, 122141, 63986, 138234, 54150, 57651, 124570, 88460, 112144, 112334, 119114, 58220, 143221, 86568, 148706],
    total_mass_fuel(Data, Fuel),
    write(Fuel).
