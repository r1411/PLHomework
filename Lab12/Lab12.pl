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
