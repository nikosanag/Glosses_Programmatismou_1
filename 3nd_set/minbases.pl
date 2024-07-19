connect([],L,L).
connect([],L,L).
connect([H|T],L,[H|R]):-
    connect(T,L,R).

find_divisors(Candidate,Limit,Number,[Number,A,B]):-
    Candidate>Limit,Number>0,A is Number div 2, A>0,B is Number div 3,B>0.

find_divisors(Candidate,Limit,Number,[Number,A]):-
    Candidate>Limit,Number>0,A is Number div 2, A>0,B is Number div 3,B=:=0.

find_divisors(Candidate,Limit,Number,[Number,B]):-
    Candidate>Limit,Number>0,A is Number div 2, A=:=0,B is Number div 3,B>0.

find_divisors(Candidate,Limit,Number,[Number]):-
    Candidate>Limit,Number>0,A is Number div 2, A=:=0,B is Number div 3,B=:=0.

find_divisors(Candidate,Limit,Number,[Candidate|Result]):-
    Candidate =< Limit , Number>0,
    Number mod Candidate =:= 0 ,
    Next is Candidate + 1,
    find_divisors(Next,Limit,Number,Result).      
    
find_divisors(Candidate,Limit,Number,Result):-
    Candidate =< Limit ,Number>0,
    Number mod Candidate =\= 0, 
    Next is Candidate + 1,
    find_divisors(Next,Limit,Number,Result). 



divisors(0,[]).
divisors(Number,List_with_divisors):-
    Number>0, 
    Limit is floor(sqrt(Number)),
    find_divisors(1,Limit,Number,List_with_divisors). 
    


multiple_suitable_bases(0,[]).
multiple_suitable_bases(1,[2]).
multiple_suitable_bases(2,[3]).
multiple_suitable_bases(Number,Result):-
    Number>0,
    divisors(Number,Divs),
    suitable_bases(Number,Divs,Result).



suitable_bases(_,[],[]).
suitable_bases(Number,[Head|Tail],R):-
    Head>0,Number>0,  
    A is ((Number div Head) - 1) ,
    divisors(A,List_of_suitable_bases),
    suitable_bases(Number,Tail,Rest),
    connect(List_of_suitable_bases,Rest,R).



analise(0,A,B,1):- 
    A>0,B>0.
analise(Number,Crucial,Base,Is_it):-
    Number>0,Crucial>0,Base>1,
    A is Number mod Base, 
    A =:= Crucial ->
    (   
        B is Number div Base,
        analise(B,Crucial,Base,Is_it)
        );
    Is_it is 0.




total_analiser(Number,Product):-
    Number>0, 
    multiple_suitable_bases(Number,Candidate_list),
    worker(Number,Candidate_list,0,Product).


worker(_,[],M,M).
worker(Number,[Head|Tail],Least,Product):-
    Head>1,Crucial is Number mod Head,
    analise(Number,Crucial,Head,Is_it),
    Is_it =:= 1 ->
    (
    Least =:= 0 ->
    (
        worker(Number,Tail,Head,Product)
        )
        ;
    Head =< Least -> 
    (   worker(Number,Tail,Head,Product)
        )
        ;
        worker(Number,Tail,Least,Product)
    )
    ;
    worker(Number,Tail,Least,Product).



minbases([],[]):- !.
minbases([Head],[Min]):-
    Head>0,
    total_analiser(Head,Min),
    !.
    
minbases([Head|Tail],Result):-
    Head>0,
    total_analiser(Head,Min),
    minbases(Tail,Rest),
    connect([Min],Rest,Result),
    !.