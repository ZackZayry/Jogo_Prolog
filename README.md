Relatório – Jogo RPG em Prolog

Nome: Zack Zayry Gomes da Silva
CIÊNCIA DA COMPUTAÇÃO/CAMP/VIDE - VIDEIRA - BACHARELADO

1. Introdução
Este trabalho apresenta o desenvolvimento de um jogo textual em Prolog utilizando conceitos de Programação em Lógica. O objetivo do projeto foi criar um sistema interativo simples de RPG (Role Playing Game), permitindo ao jogador enfrentar inimigos, explorar ambientes, coletar itens e sobreviver até atingir a vitória.
A linguagem Prolog foi utilizada devido à sua forte capacidade de representação de conhecimento por meio de fatos, regras e inferência lógica. O projeto explora conceitos como:
Base de conhecimento dinâmica;
Regras lógicas;
Manipulação de estados;
Controle de fluxo;
Listas;
Predicados dinâmicos.
O jogo possui um sistema de combate, exploração de ambientes e gerenciamento de atributos do jogador, oferecendo uma experiência interativa totalmente baseada em texto.

2. Descrição do Jogo
O jogo inicia quando o predicado:
jogar(Nome).
é executado.
O jogador começa com:
25 pontos de vida;
espada curta;
escudo;
armadura básica;
dano inicial;
mana.
Durante a partida, o jogador pode:
Atacar inimigos;
Explorar ambientes;
Curar-se;
Coletar itens;
Visualizar relatórios completos.
O objetivo principal é derrotar 3 inimigos antes que a vida do jogador chegue a zero.
Os ambientes disponíveis são:
floresta;
caverna;
castelo;
lago;
vila abandonada.
Cada ambiente possui eventos específicos, como:
surgimento de inimigos;
obtenção de armas lendárias;
aumento de defesa;
áreas neutras sem eventos.


3. Modelagem do Conhecimento
A modelagem do conhecimento foi realizada utilizando fatos dinâmicos e regras lógicas.
3.1 Predicados Dinâmicos
Os seguintes predicados foram definidos como dinâmicos:
:- dynamic(jogador/7).
:- dynamic(inimigo/5).
:- dynamic(inimigos_derrotados/1).
:- dynamic(inimigos_derrotados_fix/1).
:- dynamic(local_atual/1).
:- dynamic(historico/1).
Eles permitem alterações durante a execução do jogo.

3.2 Representação do Jogador
O jogador é representado pelo fato:
jogador(Nome, Vida, Arma, Defesa1, Defesa2, Ataque, Dano).
Exemplo:
jogador(zack, 25, espadaCurta, escudoDeMao, armadura, critico, 3).
Atributos:


3.3 Representação dos Inimigos
Os inimigos seguem a estrutura:
inimigo(Nome, Vida, Dano, Defesa, Multiplicador).
Exemplo:
inimigo(capanga, 10, 2, elmo, 1).

3.4 Histórico e Ambientes
Os ambientes são armazenados em lista:
ambientes([floresta, caverna, castelo, lago, vilaAbandonada]).
O histórico de exploração é salvo em:
historico(Lista).
Isso permite verificar locais já visitados.


4. Regras Principais
4.1 Inicialização do Jogo
jogar(Nome)
Cria o jogador, gera o primeiro inimigo e inicia o loop principal.

4.2 Sistema de Combate
Ataque
atacar
O jogador causa dano ao inimigo e recebe dano em troca.

Receber Dano
receber(Dano)
Reduz a vida do jogador.

Eliminar Inimigo
matarInimigo
Remove o inimigo atual da base de conhecimento.

4.3 Sistema de Cura
curar
Adiciona 5 pontos de vida ao jogador.

4.4 Sistema de Itens
Item comum
pegarItem
Troca a arma atual por um machado de duas mãos e dobra o dano.
Item lendário
pegarItemLendario
Entrega a espada do Olimpo e multiplica o dano por 5.

4.5 Exploração
explorar_um
Permite visitar um ambiente ainda não explorado.
Cada local executa um evento específico através do predicado:
evento(Local)

4.6 Sistema de Vitória e Derrota
Vitória
O jogador vence ao derrotar 3 inimigos:
inimigos_derrotados(3)

Derrota
O jogo termina caso:
Vida =< 0


5. Exemplos de Consultas e Resultados
5.1 Iniciar o jogo
Consulta:
?- jogar(zack).
Resultado:


5.2 Ver status do jogador
Consulta:
?- status_jogador.
Resultado esperado:


5.3 Explorar ambiente
Consulta:
?- explorar_um.
Resultado possível:


5.4 Atacar inimigo
Consulta:
?- atacar.
Resultado esperado:

5.5 Ver histórico
Consulta:
?- ver_historico.
Resultado:


5.6 Relatório completo
Consulta:
?- relatorio.
Resultado resumido:



6. Conclusão
O desenvolvimento deste jogo permitiu aplicar diversos conceitos fundamentais da Programação em Lógica utilizando Prolog. O sistema demonstrou como fatos dinâmicos e regras podem representar estados de jogo e tomadas de decisão.
Entre os principais conceitos aplicados destacam-se:
manipulação dinâmica da base de conhecimento;
utilização de listas;
recursão;
controle lógico;
inferência baseada em regras.
O projeto também mostrou que Prolog pode ser utilizado além de aplicações acadêmicas tradicionais, permitindo a construção de sistemas interativos e jogos simples.
Como melhorias futuras, poderiam ser adicionados:
sistema de inventário;
múltiplos tipos de inimigos;
magias;
sistema de níveis;
missões;
mapas mais complexos;
interface gráfica.
Conclui-se que o trabalho atingiu seus objetivos ao criar um jogo funcional e demonstrar de forma prática os recursos da linguagem Prolog.

