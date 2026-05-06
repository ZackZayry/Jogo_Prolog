%------------Fatos-----------------%

:- dynamic(jogador/7).
inimigo(testeInimigo, 25, espada, escudo, armadura).
chefao(testeChefao, 100, maca, armadura, critico, 2).

%----------------------------------%
%jogador(1Nome, 2Vida, 3Arma, 4Defesa, 5Defesa2, 6Ataque, 7Mana)
%jogador(A,B,C,D,E,F,G)
%
%------------Regras----------------%
jogar(Nome):-
    asserta(jogador(Nome, 50, espada, escudo, armadura, critico, 3)).