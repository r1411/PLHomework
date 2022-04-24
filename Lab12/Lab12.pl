is_prime(X) :- is_prime(2,X).
is_prime(X, X) :- !.
is_prime(K, X) :- Ost is X mod K, Ost = 0, !, fail. % Число делится на K, число не простое.
is_prime(K, X) :- K1 is K+1, is_prime(K1,X). % Проверяем дальше

% 11. Найти сумму непростых делителей числа (рек. вверх)
snd(X, Result) :- snd(X, X, Result).
snd(_, 2, 1) :- !.
snd(X, CurDel, Result) :- NewDel is CurDel - 1, snd(X, NewDel, R1), Ost is X mod CurDel, (Ost = 0, not(is_prime(CurDel)), Result is R1 + CurDel; Result is R1), !.

% 11. Найти сумму непростых делителей числа (рек. вниз)
snd_d(X, Result) :- snd_d(X, X, 1, Result).
snd_d(_, 2, Result, Result) :- !.
snd_d(X, CurDel, CurSum, Result) :- NewDel is CurDel - 1, Ost is X mod CurDel, (Ost = 0, not(is_prime(CurDel)), NewSum is CurSum + CurDel; NewSum is CurSum), snd_d(X, NewDel, NewSum, Result), !.
