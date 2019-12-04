# Advent of Code 2019, Prolog edition

I've recently fallen hopelessly enamoured with [Prolog](https://en.wikipedia.org/wiki/Prolog), a (mostly) declarative
logic programming language, and attempting to
solve https://adventofcode.com/2019 puzzles using solely the language, to see where this would lead us.

Some puzzles
can be phrased conveniently as a search in a permutation space (see [a_04a.prolog](a_04a.prolog))
and thus would be a perfect fit for Prolog. On the other hand, there are problems that boil down to emulating a Turing
machine (see [a_02b.prolog](a_02b.prolog)), which proved to be a bit frustrating. The hope is that AoC problems
are diverse enough for patterns to emerge and for me to learn how to deal with different situations in Prolog.

Keep in mind that this is rather personal and that I'm still quite an inexperience Prologer. If you want to follow along,
I'm using `SWI-Prolog version 8.1.13 for x86_64-darwin`. Hopefully each Prolog file is self-contained and has its own
instructions on how to reproduce...
