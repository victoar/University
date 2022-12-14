insertElem(H,E,1,List):-
    List =  [E|H].
insertElem([],_,K,[]):-
    K\=1.
insertElem([H|T],E,K,[H|List]):-
    K\=1,
    K1 is K-1,
    insertElem(T,E,K1,List).


insertToPosition([],_,[]).
insertToPosition(H,E,R):-
insertElem(H,E,16,R1),
insertElem(R1,E,8,R2),
insertElem(R2,E,4,R3),
insertElem(R3,E,2,R).



insertInList([],[]).
insertInList([H],H).
insertInList([H1,H2|T],R):-
   is_list(H2),
   insertToPosition(H2,H1,R1),
   insertInList(T, R|R1).
insertInList([_,H2|T],R):-
   not(is_list(H2)),
   insertInList([H2|T],R).

