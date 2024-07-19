find_divs(C,Root, X, [X]):-
    C > Root. 


find_divs(C,Root, X, [C | Divisors]):- 
    C =< Root,
    X mod C =:= 0,
    K is C + 1,
    find_divs(K,Root, X, Divisors).

find_divs(C,Root, X, Divisors) :- 
    C =<Root,
    X mod C =\= 0,
    K is C + 1,
    find_divs(K,Root, X, Divisors).

find_divisors(X, Divisors) :-
    Root is floor(sqrt(X)),
    find_divs(1,Root,X,Divisors).
%---------------------------------------------------------

connect([],L2,L2).
connect([H1|T1],L2,[H1|S]):-
   connect(T1,L2,S).

%---------------------------------------------------------
find_suitable_bases(1,_,[2]).
find_suitable_bases(2,_,[3]).
find_suitable_bases(_,[],[]).
find_suitable_bases(X,[0|T],S):- find_suitable_bases(X,T,S).
find_suitable_bases(X,[H|T],B):-
    A is ((X div H) - 1),
    A =\= 0 ->(
    connect(S,C,B),
    find_divisors(A,S),
    find_suitable_bases(X,T,C)
    );
    find_suitable_bases(X,T,B).

start_finding_suitable_bases(X,S):-
    find_divisors(X,Z),
    find_suitable_bases(X,Z,S).

%---------------------------------------------------------

initialise(X,S):-
    start_finding_suitable_bases(X,Z),
    start_analising(X,Z,0,S).

%---------------------------------------------------------
start_analising(_,[],M,M).
start_analising(X,[0|T],M,S):- start_analising(X,T,M,S).
start_analising(X,[1|T],M,S):- start_analising(X,T,M,S).
start_analising(X,[H|T],M,S):-
    Crucial is X mod H , 
    Crucial =\= 0->(
    analise(X,Crucial,H,R),
    R =:= 1 -> 
    (
        M =:= 0 -> 
        (
            start_analising(X,T,H,S)
            );

        H =< M ->
        (
            start_analising(X,T,H,S)
            )
            ;
            start_analising(X,T,M,S)
        );
    start_analising(X,T,M,S)
        );
    start_analising(X,T,M,S).


analise(0,C,B,1):-
    C > 0,
    B > 0.
analise(A,0,B,0):- A>0,B>0.
analise(A,B,0,0):- A>0,B>0.
analise(A,B,1,0):-  A>0,B>0.
analise(X,C,B,R):-
    B>0,X>0,
    A is X mod B,
    A =:= C ->
    (
        N is X div B,
        analise(N,C,B,R)
        );
    R is 0.

%---------------------------------------------

minbases([],[]).
minbases([Head|Tail],[X|N]):-
    initialise(Head,X),
    minbases(Tail,N).  
