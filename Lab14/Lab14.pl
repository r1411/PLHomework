read_str(A, N) :- read_str(A, N, 0).
read_str(A,N,Flag):-get0(X),r_str(X,A,[],N,0,Flag).
r_str(-1,A,A,N,N,1):-!.
r_str(10,A,A,N,N,0):-!.
r_str(X,A,B,N,K,Flag):-K1 is K+1,append(B,[X],B1),get0(X1),r_str(X1,A,B1,N,K1,Flag).

write_str([]):-!.
write_str([H|Tail]):-put(H),write_str(Tail).

%%% Задание 1
% 1.1
task1_1 :- read_str(Str, Len), write_str(Str), write(", "), write_str(Str), write(", "), write_str(Str), write(" "), write(Len).
