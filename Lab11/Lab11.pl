man(voeneg).
man(ratibor).
man(boguslav).
man(velerad).
man(duhovlad).
man(svyatoslav).
man(dobrozhir).
man(bogomil).
man(zlatomir).

woman(goluba).
woman(lubomila).
woman(bratislava).
woman(veslava).
woman(zhdana).
woman(bozhedara).
woman(broneslava).
woman(veselina).
woman(zdislava).

% parent(родитель, ребенок)

parent(voeneg,ratibor).
parent(voeneg,bratislava).
parent(voeneg,velerad).
parent(voeneg,zhdana).

parent(goluba,ratibor).
parent(goluba,bratislava).
parent(goluba,velerad).
parent(goluba,zhdana).

parent(ratibor,svyatoslav).
parent(ratibor,dobrozhir).
parent(lubomila,svyatoslav).
parent(lubomila,dobrozhir).

parent(boguslav,bogomil).
parent(boguslav,bozhedara).
parent(bratislava,bogomil).
parent(bratislava,bozhedara).

parent(velerad,broneslava).
parent(velerad,veselina).
parent(veslava,broneslava).
parent(veslava,veselina).

parent(duhovlad,zdislava).
parent(duhovlad,zlatomir).
parent(zhdana,zdislava).
parent(zhdana,zlatomir).

% 11 Является ли X дочерью Y
daughter(X, Y) :- woman(X), parent(Y, X),!.
% 11 Вывести всех дочерей X
daughter(X) :- parent(X, Y), woman(Y), write(Y), nl, fail.

% 12 Является ли X мужем Y
husband(X, Y) :- man(X), woman(Y), parent(X, Child), parent(Y, Child),!.
% 12 Вывести мужа X
husband(X) :- woman(X), man(Man), parent(X, Child), parent(Man, Child), write(Man),nl,!.

% 13 Является ли X внуком Y
grand_so(X, Y) :- man(X), parent(Y, X_Parent), parent(X_Parent, X),!.
% 13 Вывести всех внуков X
grand_sons(X) :- parent(X, X_Child), parent(X_Child, Grand_Child), man(Grand_Child), write(Grand_Child), nl, fail.

% Являются ли X и Y бабушкой и внучкой
grand_ma_and_da(X, Y) :-
    woman(X), woman(Y), parent(X, Y_Parent), parent(Y_Parent, Y),!.

% 14 Являются ли X и Y бабушкой и внучкой (или внучкой и бабушкой)
grand_ma_and_da_both(X, Y) :-
    grand_ma_and_da(X, Y),!;
    grand_ma_and_da(Y, X),!.

% 15 Минимальная цифра числа (рек. вверх)
min_d_up(0, 9) :- !.
min_d_up(X, Dig) :- X1 is X div 10, min_d_up(X1, D1), D2 is X mod 10, (D1<D2, Dig is D1; Dig is D2), !.

% 16 Минимальная цифра числа (рек. вниз)
min_d_down(0, Result, Result) :- !.
min_d_down(X, Result, CurrentMin) :- X1 is X div 10, D1 is X mod 10, (D1 < CurrentMin, NCM is D1; NCM is CurrentMin), min_d_down(X1, Result, NCM), !.
min_d_down(X, Result) :- Temp is X mod 10, min_d_down(X, Result, Temp).

% 17 Найти количество цифр числа, меньших 3 (рек. вверх)
km3_up(0, 0) :- !.
km3_up(X, Result) :- X1 is X div 10, km3_up(X1, Res1), D is X mod 10, (D < 3, Result is Res1 + 1; Result is Res1), !.

% 18 Найти количество цифр числа, меньших 3 (рек. вниз)
km3_down(0, Result, Result) :- !.
km3_down(X, Result, CurCnt) :- X1 is X div 10, D is X mod 10, (D < 3, NCC is CurCnt + 1; NCC is CurCnt), km3_down(X1, Result, NCC), !.
km3_down(X, Result) :- km3_down(X, Result, 0).

% 19 Фибоначчи (рек. вверх) 
fib_up(1, 1) :- !.
fib_up(2, 1) :- !.
fib_up(N, X) :- N1 is N - 1, N2 is N-2, fib_up(N1, X1), fib_up(N2, X2), X is X1 + X2.

% 20 Фибоначчи (рек. вниз)
fib_down(_, Result, N, N, Result) :- !.
fib_down(X2, X1, I, N, Result) :-  X is X1 + X2, I1 is I + 1, fib_down(X1, X, I1, N, Result).
fib_down(N, X) :- fib_down(0, 1, 1, N, X). 
