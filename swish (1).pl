%------------Fatos-----------------%

:- dynamic(jogador/7).
inimigo(testeInimigo, 25, espada, escudo, armadura).
chefao(testeChefao, 100, maca, armadura, critico, 2).

%----------------------------------%
%jogar(zack), jogador(A_Nome, B_Vida, C_Arma, D_Defesa, E_Defesa, F_Ataque, G_Mana).
%
%------------Regras----------------%
jogar(Nome):-
    assertz(jogador(Nome, 50, espada, escudo, armadura, critico, 3)).