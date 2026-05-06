%------------Fatos-----------------%

:- dynamic(jogador/7).
:- dynamic(inimigo/5).
%inimigo(capanga, 25, espada, escudo, armadura).
%chefao(testeChefao, 100, maca, armadura, critico, 2).

%----------------------------------%
%jogar(zack),
%jogador(A_NomeDoJogador, B_VidaDoJogador, C_ArmaDoJogador, D_DefesaDojogador, E_DefesaDoJogador, F_AtaqueDoJogador, G_ManaDoJogador),
%inimigo(H_NomeDoInimigo, I_VidaDoInimigo, J_ArmaDoInimigo, K_DefesaDoInimigo, L_DefesaDoInimigo).
%
%------------Regras----------------%
receber(Dano):-
    jogador(Aj_Nome, Bj_Vida, Cj_Arma, Dj_Defesa, Ej_Defesa, Fj_Ataque, Gj_Mana),
    VidaNova is Bj_Vida - Dano,
    retract(jogador(Aj_Nome, Bj_Vida, Cj_Arma, Dj_Defesa, Ej_Defesa, Fj_Ataque, Gj_Mana)),
    assertz(jogador(Aj_Nome, VidaNova, Cj_Arma, Dj_Defesa, Ej_Defesa, Fj_Ataque, Gj_Mana)).


atacar(Dano):-
    inimigo(A_Nome, B_Vida, C_Arma, D_Defesa, E_Defesa),
	NovaVida is B_Vida - Dano,
    retract(inimigo(A_Nome, B_Vida, C_Arma, D_Defesa, E_Defesa)),
    assertz(inimigo(capanga, NovaVida, espada, escudo, armadura)),
    receber(2).

jogar(Nome):-
    assertz(jogador(Nome, 50, espada, escudo, armadura, critico, 3)),
    assertz(inimigo(capanga, 25, adaga, elmo, armadura)),
    atacar(5).