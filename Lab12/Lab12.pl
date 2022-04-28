is_prime(1) :- !,fail.
is_prime(X) :- is_prime(2,X).
is_prime(X, X) :- !.
is_prime(K, X) :- Ost is X mod K, Ost = 0, !, fail. % Число делится на K, число не простое.
is_prime(K, X) :- K1 is K+1, is_prime(K1,X). % Проверяем дальше

nod(A, 0, A) :- !.
nod(A, B, X) :- C is A mod B, nod(B, C, X).

fact(N, X, N, X) :- !.
fact(N, X, N1, X1) :- N2 is N1 + 1, X2 is N2 * X1, fact(N, X, N2, X2).
fact(N, X) :- fact(N, X, 0, 1).

read_list(0, []) :- !.
read_list(I, [X|T]) :- read(X), I1 is I - 1, read_list(I1, T).
 
write_list([]) :- !.
write_list([X|T]) :- write(X), nl, write_list(T).

% 11. Найти сумму непростых делителей числа (рек. вверх)
snd(X, Result) :- snd(X, X, Result).
snd(_, 2, 1) :- !.
snd(X, CurDel, Result) :- NewDel is CurDel - 1, snd(X, NewDel, R1), Ost is X mod CurDel, (Ost = 0, not(is_prime(CurDel)), Result is R1 + CurDel; Result is R1), !.

% 11. Найти сумму непростых делителей числа (рек. вниз)
snd_d(X, Result) :- snd_d(X, X, 1, Result).
snd_d(_, 2, Result, Result) :- !.
snd_d(X, CurDel, CurSum, Result) :- NewDel is CurDel - 1, Ost is X mod CurDel, (Ost = 0, not(is_prime(CurDel)), NewSum is CurSum + CurDel; NewSum is CurSum), snd_d(X, NewDel, NewSum, Result), !.

% 12. Найти количество чисел, НЕ являющихся делителями исходного числа, НЕ взамнопростых с ним И взаимно простых с суммой простых цифр этого числа.

sum_prime_digs(X, Result) :- sum_prime_digs(X, 0, Result).
sum_prime_digs(0, Result, Result) :- !.
sum_prime_digs(X, CurSum, Result) :- X1 is X div 10, D is X mod 10, (is_prime(D), NewSum is CurSum + D; NewSum is CurSum), sum_prime_digs(X1, NewSum, Result), !. 

task12(X, Result) :- task12(X, X, 0, Result).
task12(_, 0, Result, Result) :- !.
task12(X, CurDigit, CurCount, Result) :- NewDigit is CurDigit - 1, Check1 is X mod CurDigit, nod(X, CurDigit, Check2), sum_prime_digs(X, SP), nod(SP, CurDigit, Check3), (Check1 =\= 0, Check2 =\= 1, Check3 = 1, NewCount is CurCount + 1; NewCount is CurCount), task12(X, NewDigit, NewCount, Result), !.

% 13. Найдите сумму всех чисел, которые равны сумме факториалов их цифр. Примечание: так как 1! = 1 и 2! = 2 не являются суммами, они не включены.
sumcifr_f(N, Sum) :- sumcifr_f(N, Sum, 0).
sumcifr_f(0, Sum, Sum) :- !.
sumcifr_f(N, Sum, CurSum) :- D is N mod 10, fact(D, D1), NewSum is CurSum + D1, N1 is N div 10, sumcifr_f(N1, Sum, NewSum).


is_cool_number(X) :- sumcifr_f(X, SF), X = SF.

task13(2, Result, Result) :- !.
task13(CurN, CurSum, Result) :- NewN is CurN - 1, (is_cool_number(CurN), NewSum is CurSum + CurN; NewSum is CurSum), task13(NewN, NewSum, Result), !. 
task13(Result) :- task13(200000, 0, Result).

% 14 Построить предикат, получающий длину списка.
len([], Result, Result) :- !.
len([_|T], CurrentLen, Result) :- NewLen is CurrentLen + 1, len(T, NewLen, Result), !.
len([X|T], Result) :- len([X|T], 0, Result).  

%%% 15 (1.5) Дан целочисленный массив и индекс. Определить, является ли элемент по индексу глобальным минимумом.

% Получить элемент списка по индексу
get_elem_by_idx([X|_], 0, X) :- !.
get_elem_by_idx([_|T], Idx, Result) :- Idx1 is Idx - 1, get_elem_by_idx(T, Idx1, Result).

% Получить минимальный элемент списка
list_min([], Result, Result) :- !.
list_min([X|T], CurrentMin, Result) :- (X < CurrentMin, NewMin is X; NewMin is CurrentMin), list_min(T, NewMin, Result), !.
list_min([X|T], Result) :- list_min([X|T], X, Result).

task15 :- write('List length: '), read(N), read_list(N, L), write('Index: '), read(Idx1), list_min(L, Idx2), write('Global min: '), (Idx1 =:= Idx2, write('YES!'); write('NO!')), !.

%%% 16 (1.6) Дан целочисленный массив. Осуществить циклический сдвиг элементов массива влево на три позиции.

% Склеить 2 списка (первые 2 перменных - два списка, третья - результат)
join([], X, X).
join([X|Y], Z, [X|W]) :- join(Y, Z, W).

% Циклический сдвиг списка влево на N
shift_left(Result, 0, Result) :- !.
shift_left([X|T], N, Result) :- N1 is N - 1, join(T, [X], NewList), shift_left(NewList, N1, Result), !.

% Циклический сдвиг списка влево на 3
shift_left_3([X|T], Result) :- shift_left([X|T], 3, Result).

task16 :- write('List length: '), read(N), read_list(N, L), shift_left_3(L, L2), write('Shifted list: '), nl, write_list(L2), !.

%%% 17 (1.18) Дан целочисленный массив. Необходимо найти элементы, расположенные перед первым минимальным.

% Вернуть список, содержащий все элементы исходного до числа Z.
get_before([], _, Result, Result) :- !. % Частный случай, когда Z нет в списке
get_before([X|_], X, Result, Result) :- !.
get_before([X|T], Z, CurList, Result) :- join(CurList, [X], NewList), get_before(T, Z, NewList, Result), !.
get_before([X|T], Z, Result) :- get_before([X|T], Z, [], Result).

task17 :- write('List length: '), read(N), read_list(N, L), list_min(L, Min), get_before(L, Min, L2), write("Result:"), nl, write_list(L2), !.

%%% 18 (1.20) Дан целочисленный массив. Необходимо найти все пропущенные числа.

% Получить максимальный элемент списка
list_max([], Result, Result) :- !.
list_max([X|T], CurrentMax, Result) :- (X > CurrentMax, NewMax is X; NewMax is CurrentMax), list_max(T, NewMax, Result), !.
list_max([X|T], Result) :- list_max([X|T], X, Result).

% Содержится ли элемент Y в списке
contains([Y|_], Y) :- !.
contains([], _) :- !, fail.
contains([_|T], Y) :- contains(T, Y), !.

% Получить все пропущенные элементы списка
build_missing(_, Min, Min, Result, Result) :- !.
build_missing(OrigList, Min, I, AccumList, Result) :- NewI is I - 1, (contains(OrigList, I), join([], AccumList, NewList); join([I], AccumList, NewList)), build_missing(OrigList, Min, NewI, NewList, Result), !.
build_missing(OrigList, Result) :- list_min(OrigList, Min), list_max(OrigList, Max), build_missing(OrigList, Min, Max, [], Result).

task18 :- write('List length: '), read(N), read_list(N, L), build_missing(L, L2), write('Missing: '), nl, write_list(L2), !.
