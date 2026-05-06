%------------Fatos-----------------%

:- dynamic(jogador/7).
:- dynamic(inimigo/4).

%----------------------------------%
%jogar(zack),
%jogador(A_NomeDoJogador, B_VidaDoJogador, C_ArmaDoJogador, D_DefesaDojogador, E_DefesaDoJogador, F_AtaqueDoJogador, G_ManaDoJogador).
%inimigo(H_NomeDoInimigo, I_VidaDoInimigo, J_ArmaDoInimigo, K_DefesaDoInimigo).
%jogador(_,_,_,_,_,_,_).
%inimigo(_,_,_,_).
%------------Regras----------------%
curar:-
    jogador(Aj_Nome, Bj_Vida, Cj_Arma, Dj_Defesa, Ej_Defesa, Fj_Ataque, Gj_Dano),
    VidaNova is Bj_Vida + 5,
    retract(jogador(Aj_Nome, Bj_Vida, Cj_Arma, Dj_Defesa, Ej_Defesa, Fj_Ataque, Gj_Dano)),
    assertz(jogador(Aj_Nome, VidaNova, Cj_Arma, Dj_Defesa, Ej_Defesa, Fj_Ataque, Gj_Dano)).

receber(Dano):-
    jogador(Aj_Nome, Bj_Vida, Cj_Arma, Dj_Defesa, Ej_Defesa, Fj_Ataque, Gj_Dano),
    VidaNova is Bj_Vida - Dano,
    retract(jogador(Aj_Nome, Bj_Vida, Cj_Arma, Dj_Defesa, Ej_Defesa, Fj_Ataque, Gj_Dano)),
    assertz(jogador(Aj_Nome, VidaNova, Cj_Arma, Dj_Defesa, Ej_Defesa, Fj_Ataque, Gj_Dano)).

pegarItem:-
    jogador(Aj_Nome, Bj_Vida, Cj_Arma, Dj_Defesa, Ej_Defesa, Fj_Ataque, Gj_Dano),
    NovaArma = machadoDeDuasMaos,
    NovoDano is Gj_Dano* 2,
    retract(jogador(Aj_Nome, Bj_Vida, Cj_Arma, Dj_Defesa, Ej_Defesa, Fj_Ataque, Gj_Dano)),
    assertz(jogador(Aj_Nome, Bj_Vida, NovaArma, Dj_Defesa, Ej_Defesa, Fj_Ataque, NovoDano)).

novoInimigo(Mult):-
    assertz(inimigo(capanga, 1, 2, D_Defesa)),
    inimigo(A_Nome, B_Vida, C_Arma, D_Defesa),
    retract(inimigo(A_Nome, B_Vida, C_Arma, D_Defesa)),
    NovaVida is 10 * Mult,
    NovoDano is Mult * C_Arma,
    assertz(inimigo(capanga(Mult), NovaVida, NovoDano, elmo)).

matarInimigo:-
    inimigo(A_Nome, B_Vida, C_Arma, D_Defesa),
    retract(inimigo(A_Nome, B_Vida, C_Arma, D_Defesa)).

atacar(Dano):-
    inimigo(A_Nome, B_Vida, C_Arma, D_Defesa),
	NovaVida is B_Vida - Dano,
    retract(inimigo(A_Nome, B_Vida, C_Arma, D_Defesa)),
    assertz(inimigo(capanga, NovaVida, adaga, elmo)),
    receber(2).

jogar(Nome):-
    assertz(jogador(Nome, 50, espadaCurta, escudoDeMao, armadura, critico, 3)),
    novoInimigo(10).