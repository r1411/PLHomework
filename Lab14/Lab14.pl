join([],X,X).
join([X|T],Y,[X|T1]) :- join(T,Y,T1).

count(List, X, Result) :- count(List, X, 0, Result).
count([], _, Result, Result) :- !.
count([X|T], X, CurCnt, Result) :- NewCnt is CurCnt + 1, count(T, X, NewCnt, Result), !.
count([_|T], X, CurCnt, Result) :- count(T, X, CurCnt, Result), !.

len([], Result, Result) :- !.
len([_|T], CurrentLen, Result) :- NewLen is CurrentLen + 1, len(T, NewLen, Result), !.
len([X|T], Result) :- len([X|T], 0, Result).

in_list([], _) :- fail.
in_list([X|_], X).
in_list([_|T] ,X) :- in_list(T, X).

get_by_idx(L,I,El):-get_by_idx(L,I,El,0).
get_by_idx([H|_],K,H,K):-!.
get_by_idx([_|Tail],I,El,Cou):- I =:= Cou,get_by_idx(Tail,Cou,El,Cou);Cou1 is Cou + 1, get_by_idx(Tail,I,El,Cou1).

read_str(A, N) :- read_str(A, N, 0).
read_str(A,N,Flag):-get0(X),r_str(X,A,[],N,0,Flag).
r_str(-1,A,A,N,N,1):-!.
r_str(10,A,A,N,N,0):-!.
r_str(X,A,B,N,K,Flag):-K1 is K+1,append(B,[X],B1),get0(X1),r_str(X1,A,B1,N,K1,Flag).

read_list_str(List) :- read_str(A,_,Flag), read_list_str([A],List,Flag).
read_list_str(List,List,1) :- !.
read_list_str(Cur_list,List,0) :- read_str(A,_,Flag), (not(A = []), append(Cur_list,[A],C_l), read_list_str(C_l,List,Flag); read_list_str(Cur_list,List,Flag)), !.

write_str([]):-!.
write_str([H|Tail]):-put(H),write_str(Tail).

write_str_list(List) :- write_str_list(List, "\n").
write_str_list([], _) :- !.
write_str_list([H|T], Divider) :- write_str(H), write(Divider), write_str_list(T, Divider), !.

%%% Задание 1
% 1.1
task1_1 :- read_str(Str, Len), write_str(Str), write(", "), write_str(Str), write(", "), write_str(Str), write(" "), write(Len).

% 1.2
count_symbols(Str, Search, Result) :- char_code(Search, SCode), count_symbols(Str, SCode, 0, Result).
count_symbols([], _, Result, Result) :- !.
count_symbols([S|T], Search, CurCnt, Result) :- S = Search, NewCnt is CurCnt + 1, count_symbols(T, Search, NewCnt, Result), !.
count_symbols([_|T], Search, CurCnt, Result) :- count_symbols(T, Search, CurCnt, Result), !.

task1_2 :- read_str(Str, _), count_symbols(Str, " ", SpacesCnt), WordsCnt is SpacesCnt + 1, write("Words count: "), write(WordsCnt).

% 1.3
split_str([], _, CurWord, CurWordList, Result) :- join(CurWordList, [CurWord], NewWL), Result = NewWL, !.
split_str([Separator|T], Separator, CurWord, CurWordList, Result) :- join(CurWordList, [CurWord], NewWL), split_str(T, Separator, [], NewWL, Result), !.
split_str([S|T], Separator, CurWord, CurWordList, Result) :- join(CurWord, [S], NewWord), split_str(T, Separator, NewWord, CurWordList, Result), !.
split_str(Str, Separator, Result) :- char_code(Separator, SepCode), split_str(Str, SepCode, [], [], Result).

most_freq_word(Str, Result) :- split_str(Str, " ", Words), most_freq_word(Words, Words, 0, [], Result). 
most_freq_word(Words, [Word|T], CurMaxCnt, _, Result) :- count(Words, Word, Cnt), Cnt > CurMaxCnt, NewMax is Cnt, NewMaxWord = Word, most_freq_word(Words, T, NewMax, NewMaxWord, Result), !.
most_freq_word(Words, [_|T], CurMaxCnt, CurMaxWord, Result) :- most_freq_word(Words, T, CurMaxCnt, CurMaxWord, Result), !.
most_freq_word(_, [], _, Result, Result) :- !.

task1_3 :- read_str(Str, _), most_freq_word(Str, X), write('Most frequent word: '), write_str(X).

% 1.4
slice([H|T], Start, End, Result) :- slice([H|T], Start, End, 0, [], Result).
slice([H|T], Start, End, I, CurList, Result) :- I >= Start, I < End, join(CurList, [H], NewList), I1 is I + 1, slice(T, Start, End, I1, NewList, Result), !.
slice([_|T], Start, End, I, CurList, Result) :- I1 is I + 1, slice(T, Start, End, I1, CurList, Result), !.
slice([], _, _, _, Result, Result) :- !.

write_str_loop(_, 0) :- !. 
write_str_loop(Str, Cnt) :- write_str(Str), Cnt1 is Cnt - 1, write_str_loop(Str, Cnt1), !. 

task1_4 :- read_str(Str, Len), task1_4(Str, Len).
task1_4(Str, Len) :- Len > 5, slice(Str, 0, 3, First3), L3 is Len - 3, slice(Str, L3, Len, Last3), write_str(First3), write(" "), write_str(Last3).
task1_4([Ch|_], Len) :- write_str_loop([Ch], Len).

% 1.5
find_indexes(List, X, Result) :- find_indexes(List, X, 0, [], Result).
find_indexes([], _, _, Result, Result) :- !.
find_indexes([X|T], X, I, CurList, Result) :- join(CurList, [I], NewList), I1 is I + 1, find_indexes(T, X, I1, NewList, Result), !.
find_indexes([_|T], X, I, CurList, Result) :- I1 is I + 1, find_indexes(T, X, I1, CurList, Result), !.

task1_5 :- read_str(Str, Len), L1 is Len - 1, slice(Str, L1, Len, [LastSym|_]), find_indexes(Str, LastSym, Result), write(Result).

%%% Задача 2
% 2.1
max_len_in_list([], Result, Result) :- !.
max_len_in_list([H|T], CurMax, Result) :- len(H, NewMax), NewMax > CurMax, max_len_in_list(T, NewMax, Result), !.
max_len_in_list([_|T], CurMax, Result) :- max_len_in_list(T, CurMax, Result), !.
max_len_in_list(List, Result) :- max_len_in_list(List, 0, Result).

task2_1 :- see('Lab14/file1.txt'), read_list_str(StrList), seen, max_len_in_list(StrList, MaxLen), write("Max str len: "), write(MaxLen), nl.

% 2.2
count_no_spaces([], Result, Result) :- !.
count_no_spaces([H|T], CurCnt, Result) :- count_symbols(H, " ", SC), SC = 0, NewCnt is CurCnt + 1, count_no_spaces(T, NewCnt, Result), !.
count_no_spaces([_|T], CurCnt, Result) :- count_no_spaces(T, CurCnt, Result), !.
count_no_spaces(Strings, Result) :- count_no_spaces(Strings, 0, Result), !.

task2_2 :- see('Lab14/file1.txt'), read_list_str(StrList), seen, count_no_spaces(StrList, Cnt), write('Strings with no spaces: '), write(Cnt), nl.

% 2.3
cnt_sym_in_list([], _, Result, Result) :- !.
cnt_sym_in_list([H|T], Sym, CurCnt, Result) :- count_symbols(H, Sym, Cnt), NewCnt is CurCnt + Cnt, cnt_sym_in_list(T, Sym, NewCnt, Result), !.
cnt_sym_in_list(List, Sym, Result) :- cnt_sym_in_list(List, Sym, 0, Result), !.

write_many_a([], _) :- !.
write_many_a([H|T], Avg) :- count_symbols(H, "a", Cnt1), count_symbols(H, "A", Cnt2), Cnt is Cnt1 + Cnt2, Cnt > Avg, write_str(H), nl, write_many_a(T, Avg), !.
write_many_a([_|T], Avg) :- write_many_a(T, Avg), !.

task2_3 :- 
    see('Lab14/file1.txt'), read_list_str(StrList), seen, len(StrList, Len), cnt_sym_in_list(StrList, "a", Cnt1), cnt_sym_in_list(StrList, "A", Cnt2), 
    CntA is Cnt1 + Cnt2, Avg is CntA / Len, write("Avg A per str: "), write(Avg), nl, write_many_a(StrList, Avg).

% 2.4
str_list_to_words_list([], Result, Result) :- !.
str_list_to_words_list([H|T], CurList, Result) :- split_str(H, " ", StrWords), join(CurList, StrWords, NewList), str_list_to_words_list(T, NewList, Result), !.
str_list_to_words_list(StrList, Result) :- str_list_to_words_list(StrList, [], Result).

most_freq_word_in_list(Words, Result) :- most_freq_word(Words, Words, 0, [], Result).

task2_4 :- see('Lab14/file2.txt'), read_list_str(StrList), seen, str_list_to_words_list(StrList, WordsList), most_freq_word_in_list(WordsList, MF), write_str(MF).

% 2.5
get_repeating_words([], _, Result, Result) :- !.
get_repeating_words([H|T], PrevWords, CurList, Result) :- in_list(PrevWords, H), join(CurList, [H], NewList), join(PrevWords, [H], NewWords), get_repeating_words(T, NewWords, NewList, Result), !.
get_repeating_words([H|T], PrevWords, CurList, Result) :- join(PrevWords, [H], NewWords), get_repeating_words(T, NewWords, CurList, Result), !.
get_repeating_words(Words, Result) :- get_repeating_words(Words, [], [], Result).

% Содержится ли в List хотя бы один элемент второго списка
contains(_, []) :- fail.
contains(List, [X|_]) :- in_list(List, X), !.
contains(List, [_|XT]) :- contains(List, XT).

write_no_rep_words([], _) :- !.
write_no_rep_words([H|T], RepWords) :- split_str(H, " ", StrWords), not(contains(RepWords, StrWords)), write_str(H), nl, write_no_rep_words(T, RepWords), !.
write_no_rep_words([_|T], RepWords) :- write_no_rep_words(T, RepWords), !.

task2_5 :- 
    see('Lab14/file3.txt'), read_list_str(StrList), seen, str_list_to_words_list(StrList, Words), get_repeating_words(Words, RepWords), 
    tell('Lab14/out_2_5.txt'), write_no_rep_words(StrList, RepWords), told.

%%% Задача 3
% 3.6 Дана строка в которой записаны слова через пробел. Перемешать в каждом слове все символы в случайном порядке кроме первого и последнего.

% Перестановка элементов списка в случайном порядке
shuffle_list(List, Result) :- shuffle_list(List, [], Result).
shuffle_list([], Result, Result) :- !.
shuffle_list(List, CurList, Result) :- 
    len(List, Len), random(0, Len, S), S1 is S + 1, get_by_idx(List, S, X), slice(List, 0, S, Part1), slice(List, S1, Len, Part2), 
    join(Part1, Part2, ListWithout), join(CurList, [X], NewList), shuffle_list(ListWithout, NewList, Result), !.

% Перемешать в каждом слове все символы в случайном порядке кроме первого и последнего.
shuffle_words(Words, Result) :- shuffle_words(Words, [], Result).
shuffle_words([], Result, Result) :- !.
shuffle_words([H|T], CurList, Result) :-
    len(H, WordLen), WL1 is WordLen - 1, get_by_idx(H, 0, L), get_by_idx(H, WL1, R), slice(H, 1, WL1, Part), shuffle_list(Part, NewPart), 
    join([L], NewPart, Temp), ((WordLen =\= 1, join(Temp, [R], NewWord)); (NewWord = Temp)), join(CurList, [NewWord], NewList), shuffle_words(T, NewList, Result), !.

task3_6 :- read_str(Str, _), split_str(Str, " ", StrWords), shuffle_words(StrWords, NewWords), write_str_list(NewWords, " ").
