% Склеить 2 списка (первые 2 перменных - два списка, третья - результат)
join([], X, X).
join([X|Y], Z, [X|W]) :- join(Y, Z, W).

read_list(0, []) :- !.
read_list(I, [X|T]) :- read(X), I1 is I - 1, read_list(I1, T).
 
write_list([]) :- !.
write_list([X|T]) :- write(X), nl, write_list(T).

%%% 11 (1.42) Дан целочисленный массив. Найти все элементы, которые меньше среднего арифметического элементов массива.

list_avg(List, Result) :- list_avg(List, 0, 0, Result).
list_avg([], CurSum, CurCnt, Result) :- Result is CurSum / CurCnt.
list_avg([H|T], CurSum, CurCnt, Result) :- NewSum is CurSum + H, NewCnt is CurCnt + 1, list_avg(T, NewSum, NewCnt, Result), !.

filter_less_than(List, X, Result) :- filter_less_than(List, X, [], Result).
filter_less_than([], _, Result, Result) :- !.
filter_less_than([H|T], X, CurList, Result) :- (H < X,  join(CurList, [H], NewList); NewList = CurList), filter_less_than(T, X, NewList, Result), !.

task11 :- write('List length: '), read(N), read_list(N, L), list_avg(L, Avg), filter_less_than(L, Avg, L2), write('Avg = '), write(Avg), nl, write_list(L2).
