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