% Load the required library for large integers
:- use_module(library(clpfd)).

% Base predicate to start the minbases calculation
minbases([], []).
minbases([X | XS], [Result | Results]) :-
    find_div(X, 1, Divisors),
    find_suitable_bases(X, Divisors, Bases),
    test_base(X, Bases, 0, Result),
    minbases(XS, Results).

% Predicate to find divisors
find_div(N, D, []) :-
    D > sqrt_large(N), !.
find_div(N, D, [D | Divisors]) :-
    N mod D #= 0,
    NextD #= D + 1,
    find_div(N, NextD, Divisors).
find_div(N, D, Divisors) :-
    N mod D #\= 0,
    NextD #= D + 1,
    find_div(N, NextD, Divisors).

% Helper predicate to calculate square root for large integers
sqrt_large(N, Sqrt) :-
    sqrt(N, FloatSqrt),
    Sqrt is floor(FloatSqrt).

% Predicate to find suitable bases
find_suitable_bases(1, _, [2]).
find_suitable_bases(2, _, [3]).
find_suitable_bases(N, [L | LS], [X | Bases]) :-
    X is N // L - 1,
    find_div(X, 1, Divisors),
    find_suitable_bases(N, LS, SubBases),
    append([X | Divisors], SubBases, Bases).
find_suitable_bases(_, [], []).

% Predicate to test base
test_base(_, [], Min, Min).
test_base(Number, [Base | Bases], CurrentMin, Min) :-
    gate(Number, Base, Result),
    (Result #= 0 ->
        test_base(Number, Bases, CurrentMin, Min)
    ; (CurrentMin #= 0 ->
        test_base(Number, Bases, Base, Min)
    ; (CurrentMin #> Base ->
        test_base(Number, Bases, Base, Min)
    ;
        test_base(Number, Bases, CurrentMin, Min)
    ))).

% Predicate for gate logic
gate(X, Y, 0) :-
    (X #= 1 ; X #= 2), !.
gate(X, Y, 0) :-
    A #= X mod Y,
    (A #= 0 -> true ; (X mod A #= 0 ->
        convert(X // Y, X mod Y, A, Result),
        Result #= 0)).
gate(_, _, 1).

% Predicate for convert logic
convert(_, _, Critical, 0) :- Critical #\= 0.
convert(First, _, _, Base) :- First #= 0.
convert(First, Second, Critical, Result) :-
    convert(First // Base, First mod Base, Critical, Result).
