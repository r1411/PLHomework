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

%%% 12 (1.48) Для введенного списка построить список с номерами элемента, который повторяется наибольшее число раз.

freq(List, X, Result) :- freq(List, X, 0, Result).
freq([], _, Result, Result) :- !. 
freq([H|T], H, CurCnt, Result) :- NewCnt is CurCnt + 1, freq(T, H, NewCnt, Result), !. 
freq([_|T], X, CurCnt, Result) :- freq(T, X, CurCnt, Result), !. 

% Самый частый элемент списка
most_freq([H|T], Result) :- most_freq([H|T], H, 1, Result).
most_freq([], Result, _, Result) :- !.
most_freq([H|T], CurMaxEl, CurMaxCnt, Result) :- freq([H|T], H, Fr), (Fr > CurMaxCnt, NewME is H, NewMC is Fr; NewME is CurMaxEl, NewMC is CurMaxCnt), most_freq(T, NewME, NewMC, Result), !.

% Построить список с индексами элемента в списке
find_indexes(List, X, Result) :- find_indexes(List, X, 0, [], Result).
find_indexes([], _, _, Result, Result) :- !. 
find_indexes([H|T], X, I, CurList, Result) :- (H is X, join(CurList, [I], NewList); NewList = CurList), I1 is I + 1, find_indexes(T, X, I1, NewList, Result), !. 

task12 :- write('List length: '), read(N), read_list(N, L), most_freq(L, MF), find_indexes(L, MF, L2), write('Most frequent = '), write(MF), nl, write_list(L2).
