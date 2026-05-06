%------------Fatos-----------------%
:- dynamic(jogador/7).
:- dynamic(inimigo/5).
:- dynamic(inimigos_derrotados/1).
:- dynamic(inimigos_derrotados_fix/1).
:- dynamic(local_atual/1).
:- dynamic(historico/1).
%----------------------------------%
%jogar(zack),
%jogador(A_NomeDoJogador, B_VidaDoJogador, C_ArmaDoJogador, D_DefesaDojogador, E_DefesaDoJogador, F_AtaqueDoJogador, G_ManaDoJogador).
%inimigo(H_NomeDoInimigo, I_VidaDoInimigo, J_ArmaDoInimigo, K_DefesaDoInimigo).
%jogador(_,_,_,_,_,_,_).
%inimigo(_,_,_,_).

%------------Estado Inicial------------%
inimigos_derrotados(0).
local_atual(floresta).
historico([]).

%------------Regras----------------%
jogar(Nome) :-
    assertz(jogador(Nome, 25, espadaCurta, escudoDeMao, armadura, critico, 3)),
    novoInimigoInicio(1),
    assertz(inimigos_derrotados_fix(0)),
    write('=== Jogo iniciado! Boa sorte, '), write(Nome), write('! ==='), nl,
    loop.

curar:-
    jogador(Aj_Nome, Bj_Vida, Cj_Arma, Dj_Defesa, Ej_Defesa, Fj_Ataque, Gj_Dano),
    VidaNova is Bj_Vida + 5,
    retract(jogador(Aj_Nome, Bj_Vida, Cj_Arma, Dj_Defesa, Ej_Defesa, Fj_Ataque, Gj_Dano)),
    assertz(jogador(Aj_Nome, VidaNova, Cj_Arma, Dj_Defesa, Ej_Defesa, Fj_Ataque, Gj_Dano)).

blindar:-
    jogador(Aj_Nome, Bj_Vida, Cj_Arma, Dj_Defesa, Ej_Defesa, Fj_Ataque, Gj_Dano),
    VidaNova is Bj_Vida + 50,
    retract(jogador(Aj_Nome, Bj_Vida, Cj_Arma, Dj_Defesa, Ej_Defesa, Fj_Ataque, Gj_Dano)),
    assertz(jogador(Aj_Nome, VidaNova, Cj_Arma, capaceteDeJava, armaduraDeJhyton, Fj_Ataque, Gj_Dano)).

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

pegarItemLendario:-
    jogador(Aj_Nome, Bj_Vida, Cj_Arma, Dj_Defesa, Ej_Defesa, Fj_Ataque, Gj_Dano),
    NovaArma = espadaDoOlimpo,
    NovoDano is Gj_Dano * 5,
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

ambientes([floresta, caverna, castelo, lago, vilaAbandonada]).

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

explorar:-
    ambientes(Lista),
    member(Local, Lista),
    visitar(Local),
    fail.
explorar.

explorar_um:-
    once((
        ambientes(L),
        member(Local, L),
        \+ ja_visitou(Local),
        visitar(Local)
    )).

explorar_um :-
    write('Todos os ambientes ja foram explorados.'), nl.

evento(floresta):-
    write('Voce encontrou um inimigo na floresta!'), nl,
    novoInimigoInicio(5).

evento(caverna):-
    write('Voce encontrou uma arma celestial!!'), nl,
    pegarItemLendario.

evento(vilaAbandonada):-
    write('Voce encontrou um capacete do java e uma armadura do Jython...'), nl,
    blindar.

evento(castelo):-
    write('Um inimigo poderoso guarda o castelo!'), nl,
    novoInimigoInicio(15).

evento(lago):-
    write('O lago esta calmo. Nada acontece aqui...'), nl.

evento(floresta,       'Encontro com inimigo (Mult 5)').
evento(caverna,        'Item encontrado: machado de duas maos').
evento(vilaAbandonada, 'Descanso: +5 de vida').
evento(castelo,        'Inimigo elite (Mult 15)').
evento(lago,           'Nada acontece').

todos_eventos(L):-
    findall(Local-Desc, evento(Local, Desc), L).

registrar_historico(Local):-
    historico(H),
    append(H, [Local], NovoH),
    retract(historico(H)),
    assertz(historico(NovoH)).

ver_historico:-
    historico(H),
    write('Historico de visitas: '), write(H), nl.

total_visitas(T):-
    historico(H),
    length(H, T).

ja_visitou(Local):-
    historico(H),
    member(Local, H).

%------------Loop Principal------------%
acao_curar :-
    jogador(_, Vida, _, _, _, _, _),
    (   Vida >= 25
    ->  write('Vida ja esta cheia.'), nl
    ;   curar,
        jogador(_, VidaNova, _, _, _, _, _),
        write('Curado! Vida agora: '), write(VidaNova), nl
    ).

acao_item :-
    jogador(_, _, machadoDeDuasMaos, _, _, _, _),
    !,
    write('Voce ja carrega o machado de duas maos.'), nl.

acao_item :-
    pegarItem,
    jogador(_, _, Arma, _, _, _, Dano),
    write('Item equipado: '), write(Arma),
    write(' | Dano: '), write(Dano), nl.

incrementar_derrotados :-
    retract(inimigos_derrotados(N)),
    N1 is N + 1,
    assertz(inimigos_derrotados(N1)).

proxima_onda :-
    inimigos_derrotados_fix(Qtd),
    N is Qtd + 1,
    retract(inimigos_derrotados_fix(Qtd)),
    assertz(inimigos_derrotados_fix(N)),
    Mult is 1 + (N * 3),
    write('Um novo inimigo aparece!'), nl,
    novoInimigoInicio(Mult).

acao_atacar :-
    \+ inimigo(_, _, _, _, _),
    !,
    write('Nenhum inimigo presente. Explore para encontrar um.'), nl.

acao_atacar :-
    atacar,
    inimigo(_, VidaInimigo, _, _, _),
    (   VidaInimigo =< 0
    ->  write('Inimigo derrotado!'), nl,
        matarInimigo,
        incrementar_derrotados,
        inimigos_derrotados(N),
        write('Inimigos derrotados: '), write(N), write('/3'), nl,
        (N < 3 -> proxima_onda ; true)
    ;   write('Inimigo ainda vivo. Vida restante: '), write(VidaInimigo), nl
    ).