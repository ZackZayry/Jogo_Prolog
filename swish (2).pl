%------------Fatos-----------------%

%:- dynamic(jogador/7).
%:- dynamic(inimigo/5).
inimigo(capanga, 25, espada, escudo, armadura).
%chefao(testeChefao, 100, maca, armadura, critico, 2).

%----------------------------------%
%jogar(zack),
%jogador(A_Nome, B_Vida, C_Arma, D_Defesa, E_Defesa, F_Ataque, G_Mana),
%inimigo(A_Nome, B_Vida, C_Arma, D_Defesa, E_Defesa).
%
%------------Regras----------------%
jogar(Nome):-
    assertz(jogador(Nome, 50, espada, escudo, armadura, critico, 3)),
    assertz(inimigo(capanga, 25, espada, escudo, armadura)),
    atacar(5).

atacar(Dano):-
    inimigo(A_Nome, B_Vida, C_Arma, D_Defesa, E_Defesa),
	NovaVida is B_vida - Dano,
    retract(inimigo(A_Nome, B_Vida, C_Arma, D_Defesa, E_Defesa)),
    assertz(inimigo(capanga, NovaVida, espada, escudo, armadura)).