% Склеить 2 списка (первые 2 перменных - два списка, третья - результат)
join([], X, X).
join([X|Y], Z, [X|W]) :- join(Y, Z, W).

% Наличие элемента в списке
in_list([El|_], El).
in_list([_|Tail], El) :- in_list(Tail, El).

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

%%% 13 (1.54) Для введенного списка построить список из элементов, встречающихся в исходном более трех раз.

% Найти элементы, встречающиеся более <MinFreq> раз
filter_by_freq(List, MinFreq, Result) :- filter_by_freq(List, MinFreq, [], Result).
filter_by_freq([], _, Result, Result) :- !.
filter_by_freq([H|T], MinFreq, CurList, Result) :- freq([H|T], H, Fr), Fr > MinFreq, not(in_list(CurList, H)), join(CurList, [H], NewList), filter_by_freq(T, MinFreq, NewList, Result), !.
filter_by_freq([_|T], MinFreq, CurList, Result) :- filter_by_freq(T, MinFreq, CurList, Result), !.

task13 :- write('List length: '), read(N), read_list(N, L), filter_by_freq(L, 3, L2), write('New list: '), nl, write_list(L2).

%%% 14 
task14 :-
    Hair = [_, _, _],
    in_list(Hair,[belokurov,_]),
    in_list(Hair,[chernov,_]),
    in_list(Hair,[rizhov,_]),
    in_list(Hair,[_,ginger]),
    in_list(Hair,[_,blond]),
    in_list(Hair,[_,brunette]),
    not(in_list(Hair,[belokurov,blond])),
    not(in_list(Hair,[belokurov,brunette])),
    not(in_list(Hair,[chernov,brunette])),
    not(in_list(Hair,[rizhov,ginger])),
    write(Hair), !.

%%% 15 [Имя, Платье, Туфли]
task15 :-
    Dress = [_, _, _],
    in_list(Dress, [anya, _, _]),
    in_list(Dress, [natasha, _, _]),
    in_list(Dress, [valya, _, _]),
    in_list(Dress, [_, white, _]),
    in_list(Dress, [_, green, _]),
    in_list(Dress, [_, blue, _]),
    in_list(Dress, [_, _, white]),
    in_list(Dress, [_, _, green]),
    in_list(Dress, [_, _, blue]),
    in_list(Dress, [anya, A, A]),               % У Ани цвета платья и туфлей совпадали.
    not(in_list(Dress, [natasha, B, B])),       % У Наташи цвета платья и туфлей НЕ совпадали.
    not(in_list(Dress, [valya, C, C])),         % У Вали цвета платья и туфлей НЕ совпадали.
    in_list(Dress, [natasha, _, green]),        % Наташа была в зеленых туфлях.
    not(in_list(Dress, [valya, _, white])),     % Туфли Вали не были белыми
    not(in_list(Dress, [valya, white, _])),     % Платье Вали не было белым
    write(Dress), !.

%%% 16 [Фамилия, Профессия, Колво_Братьев, Возраст]
task16 :-
    Zavod = [_, _, _],
    in_list(Zavod, [_, slesar, 0, 0]),
    in_list(Zavod, [_, tokar, _, 1]),
    in_list(Zavod, [_, svarshik, _, _]),
    in_list(Zavod, [borisov, _, 1, _]),
    in_list(Zavod, [ivanov, _, _, _]),
    in_list(Zavod, [semenov, _, _, 2]),
    in_list(Zavod, [Person1, slesar, _, _]),
    in_list(Zavod, [Person2, tokar, _, _]),
    in_list(Zavod, [Person3, svarshik, _, _]),
    write('slesar = '),write(Person1), nl, write('tokar = '), write(Person2), nl, write('svarshick = '), write(Person3), !.
