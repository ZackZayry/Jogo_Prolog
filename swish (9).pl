%------------Fatos-----------------%
:- dynamic(jogador/7).
:- dynamic(inimigo/5).
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
    NovoDano is Gj_Dano * 2,
    retract(jogador(Aj_Nome, Bj_Vida, Cj_Arma, Dj_Defesa, Ej_Defesa, Fj_Ataque, Gj_Dano)),
    assertz(jogador(Aj_Nome, Bj_Vida, NovaArma, Dj_Defesa, Ej_Defesa, Fj_Ataque, NovoDano)).

novoInimigoInicio(Mult):-
    assertz(inimigo(capanga, 1, 2, D_Defesa, Mult)),
    inimigo(A_Nome, B_Vida, C_Arma, D_Defesa, Mult),
    retract(inimigo(A_Nome, B_Vida, C_Arma, D_Defesa, Mult)),
    NovaVida is 10 * Mult,
    NovoDano is Mult * C_Arma,
    assertz(inimigo(capanga, NovaVida, NovoDano, elmo, Mult)).

matarInimigo:-
    inimigo(A_Nome, B_Vida, C_Arma, D_Defesa, Mult),
    retract(inimigo(A_Nome, B_Vida, C_Arma, D_Defesa, Mult)).

atacar:-
    jogador(_,_,_,_,_,_,Gj_Dano),
    inimigo(A_Nome, B_Vida, C_Arma, D_Defesa, Mult),
    DanoAtual = C_Arma,
    NovaVida is B_Vida - Gj_Dano,
    retract(inimigo(A_Nome, B_Vida, C_Arma, D_Defesa, Mult)),
    assertz(inimigo(capanga, NovaVida, DanoAtual, D_Defesa, Mult)),
    receber(C_Arma).

jogar(Nome):-
    assertz(jogador(Nome, 50, 'espada curta', 'escudo de mao', armadura, critico, 3)).

status_jogador:-
    jogador(Nome, Vida, Arma, Def1, Def2, Ataque, Dano),
    write('=== STATUS DO JOGADOR ==='), nl,
    write('Nome:   '), write(Nome),   nl,
    write('Vida:   '), write(Vida),   nl,
    write('Arma:   '), write(Arma),   nl,
    write('Defesa: '), write(Def1), write(' / '), write(Def2), nl,
    write('Ataque: '), write(Ataque), nl,
    write('Dano:   '), write(Dano),   nl.

status_inimigo:-
    inimigo(Nome, Vida, Arma, Defesa, Mult),
    write('=== STATUS DO INIMIGO ==='), nl,
    write('Nome:         '), write(Nome),   nl,
    write('Vida:         '), write(Vida),   nl,
    write('Dano:         '), write(Arma),   nl,
    write('Defesa:       '), write(Defesa), nl,
    write('Multiplicador:'), write(Mult),   nl.
status_inimigo:-
    write('Nenhum inimigo presente.'), nl.

%------------2º Parte---------------------------%

:- dynamic(local_atual/1).
:- dynamic(historico/1).


ambientes([floresta, caverna, vilaAbandonada, castelo, lago]).

local_atual(floresta).
historico([]).

visitar(Local):-
    local_atual(Atual),
    write('Saindo de: '), write(Atual), nl,
    write('Indo para: '), write(Local), nl,
    atualizar_local(Local),
    registrar_historico(Local),
    evento(Local).

atualizar_local(Novo):-
    retract(local_atual(_)),
    assertz(local_atual(Novo)).