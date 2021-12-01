% -*- mode: Prolog -*-
% HOWTO:
% swipl
% ?- [solution].
% count_larger_measurements(real, N).
% N = 1655 .

input(empty, []).

input(easy1, [1, 2, 3]).

input(easy2, [3, 2, 1]).

input(easy3, [1, 3, 2, 1]).

input(test, [199,
             200,
             208,
             210,
             200,
             207,
             240,
             269,
             260,
             263]).

input(real, Measurements) :-
    open('real-input.txt', read, Stream),
    read_lines(Stream, Measurements),
    close(Stream).

count_larger_measurements(InputType, LargerMeasurements) :-
    input(InputType, Input),
    do_count_larger_measurements(Input, LargerMeasurements).

do_count_larger_measurements([], 0).
do_count_larger_measurements([_], 0).

do_count_larger_measurements([A, B], N) :-
    B > A,
    N is 1.

do_count_larger_measurements([_, _], N) :-
    N is 0.

do_count_larger_measurements([A, B | XS], N) :-
    B > A,
    do_count_larger_measurements([B | XS], M),
    N is M + 1.

do_count_larger_measurements([_, B | XS], N) :-
    do_count_larger_measurements([B | XS], N).

read_lines(Stream, []) :-
    at_end_of_stream(Stream).

read_lines(Stream, [X|L]) :-
    \+ at_end_of_stream(Stream),
    readMeasurement(Stream, X),
    read_lines(Stream, L).

readMeasurement(Stream, Measurement) :-
    readWord(Stream, Word),
    atom_number(Word, Measurement).

readWord(InStream,W):-
    get_code(InStream,Char),
    checkCharAndReadRest(Char,Chars,InStream),
    atom_codes(W,Chars).

checkCharAndReadRest(10,[],_):-  !.

checkCharAndReadRest(32,[],_):-  !.

checkCharAndReadRest(-1,[],_):-  !.

checkCharAndReadRest(end_of_file,[],_):-  !.

checkCharAndReadRest(Char,[Char|Chars],InStream):-
    get_code(InStream,NextChar),
    checkCharAndReadRest(NextChar,Chars,InStream).
