%------------Fatos-----------------%

:- dynamic(jogador/7).
:- dynamic(inimigo/4).
%inimigo(capanga, 25, espada, escudo, armadura).
%chefao(testeChefao, 100, maca, armadura, critico, 2).

%----------------------------------%
%jogar(zack),
%jogador(A_NomeDoJogador, B_VidaDoJogador, C_ArmaDoJogador, D_DefesaDojogador, E_DefesaDoJogador, F_AtaqueDoJogador, G_ManaDoJogador),
%inimigo(H_NomeDoInimigo, I_VidaDoInimigo, J_ArmaDoInimigo, K_DefesaDoInimigo).
%
%------------Regras----------------%
curar:-
    jogador(Aj_Nome, Bj_Vida, Cj_Arma, Dj_Defesa, Ej_Defesa, Fj_Ataque, Gj_Mana),
    VidaNova is Bj_Vida +5,
    retract(jogador(Aj_Nome, Bj_Vida, Cj_Arma, Dj_Defesa, Ej_Defesa, Fj_Ataque, Gj_Mana)),
    assertz(jogador(Aj_Nome, VidaNova, Cj_Arma, Dj_Defesa, Ej_Defesa, Fj_Ataque, Gj_Mana)).

receber(Dano):-
    jogador(Aj_Nome, Bj_Vida, Cj_Arma, Dj_Defesa, Ej_Defesa, Fj_Ataque, Gj_Mana),
    VidaNova is Bj_Vida - Dano,
    retract(jogador(Aj_Nome, Bj_Vida, Cj_Arma, Dj_Defesa, Ej_Defesa, Fj_Ataque, Gj_Mana)),
    assertz(jogador(Aj_Nome, VidaNova, Cj_Arma, Dj_Defesa, Ej_Defesa, Fj_Ataque, Gj_Mana)).

pegarItem:-
    jogador(Aj_Nome, Bj_Vida, Cj_Arma, Dj_Defesa, Ej_Defesa, Fj_Ataque, Gj_Mana),
    NovaArma = machadoDeDuasMaos,
    retract(jogador(Aj_Nome, Bj_Vida, Cj_Arma, Dj_Defesa, Ej_Defesa, Fj_Ataque, Gj_Mana)),
    assertz(jogador(Aj_Nome, Bj_Vida, NovaArma, Dj_Defesa, Ej_Defesa, Fj_Ataque, Gj_Mana)).

atacar(Dano):-
    inimigo(A_Nome, B_Vida, C_Arma, D_Defesa),
	NovaVida is B_Vida - Dano,
    retract(inimigo(A_Nome, B_Vida, C_Arma, D_Defesa)),
    assertz(inimigo(capanga, NovaVida, espada, escudo)),
    receber(2).

jogar(Nome):-
    assertz(jogador(Nome, 50, espadaCurta, escudoDeMao, armadura, critico, 3)),
    assertz(inimigo(capanga, 25, adaga, elmo)),
    curar.