# Brasil em Retalho

Documento de design inicial de um beat ’em up 2D de fantasia brasileira. O título, o elenco e os números de combate são propostas para prototipagem. O primeiro alvo é PC, com campanha solo e cooperação local para duas pessoas em uma etapa posterior.

## Visão do jogo

Quatro personagens brasileiros atravessam ruas, feiras e cais tomados por criaturas de papel que apagam a memória dos lugares. Cada lutador transforma uma referência cultural brasileira em uma decisão de combate. Lia espera a abertura do adversário, Bento alterna ataques para compor um verso, Dandara escolhe onde firmar o compasso e Iara desenha trajetórias entre faixas da arena.

A referência de gênero é a ação lateral com movimento em profundidade, combos acessíveis e encontros em sequência de Castle Crashers. Personagens, cenários, arte, música e interface são originais. A primeira entrega completa é a Feira da Virada, uma fase solo de 8 a 12 minutos com Lia, Bento, três inimigos e um chefe.

## Mundo e história

Em Santa Aurora, cidade fictícia do litoral baiano, a tipógrafa Celina testa uma prensa capaz de imprimir lembranças. Seu assistente Nilo tenta acelerar o registro da Feira da Virada. A prensa ganha vida, arranca palavras das placas e transforma folhas em criaturas. Cada nova impressão apaga parte da história de uma rua.

Lia ensaiava com seu grupo, Bento preparava uma banca de folhetos, Dandara organizava uma apresentação e Iara montava uma oficina de pipas. Os quatro recuperam as matrizes roubadas. Cada capítulo restaura um trecho da cidade e revela uma decisão de Nilo que pode ser reparada.

O tom é de aventura de bairro, com fantasia e humor de situação. Uma placa sem letras pode apontar em três direções. Depois do combate, seu nome volta ao letreiro e a feirante retoma a conversa. Mudanças no cenário e falas breves contam a história durante a campanha.

## Ciclo e regras de combate

O jogador escolhe um personagem, entra no trecho, lê a posição e os sinais dos inimigos, se alinha, combina golpes e esquivas, carrega seu especial e recupera uma matriz no fim do capítulo.

- A arena usa dois eixos no chão e altura separada para saltos e lançamentos. Golpes conferem posição horizontal, profundidade e altura. Sombras marcam o ponto de contato com o chão.
- O personagem pode mover, atacar com leve, pesado ou golpe à distância, esquivar, saltar, atacar no ar, usar especial e interagir. As opções serão remapeáveis na versão distribuível.
- Ataques têm preparação, janela ativa e recuperação. O pesado deixa uma abertura maior quando erra. Um golpe comum atinge cada alvo uma vez por execução. Golpes múltiplos especificam o intervalo entre acertos.
- O protótipo começa com 120 ms de antecipação de comando e 140 ms de invulnerabilidade de esquiva. Cada combo define quando aceita o próximo golpe. Após uma queda, há proteção breve ao levantar.
- Inimigos fortes resistem à interrupção durante ações sinalizadas. Lançamentos consecutivos têm limite por alvo, reiniciado ao aterrissar.
- Animação, silhueta, contorno e som comunicam ataque, guarda e vulnerabilidade. A primeira fase ensina a alinhar, trocar de faixa e aproveitar a recuperação inimiga.

## Personagens

Velocidade relativa à referência 100. Danos por acerto do primeiro leve, do pesado neutro e do golpe básico à distância. Alcance à distância em larguras de personagem.

| Personagem | Vida | Velocidade | Leve | Pesado | Dano à distância | Alcance à distância |
|---|---:|---:|---:|---:|---:|---:|
| Lia | 95 | 120 | 8 | 18 | 5 | 2,0 |
| Bento | 105 | 95 | 9 | 19 | 12 | 5,0 |
| Dandara | 130 | 80 | 11 | 25 | 8 | 3,0 |
| Iara | 85 | 110 | 7 | 16 | 14 | 5,5 |

L representa leve, P representa pesado e D representa ataque à distância.

### Lia — Capoeira e leitura do adversário

Professora de um projeto de bairro, Lia tenta reunir sua turma depois da confusão. A **Ginga** ganha uma carga quando ela esquiva na janela final de um ataque sinalizado. Com duas cargas, o especial circula um inimigo próximo e finaliza do outro lado. O jogador decide entre sair cedo ou se arriscar para carregar a resposta.

O combo **L → L → P** termina em rasteira que derruba inimigos leves. **Esquiva → L** dá um contra-ataque curto com avanço. Seu arco de vento tem baixo dano e interrompe a preparação de inimigos leves próximos. [Dossiê da Roda de Capoeira e do Ofício dos Mestres de Capoeira, Iphan](https://portal.iphan.gov.br/uploads/publicacao/DossieCapoeiraWeb.pdf)

### Bento — Literatura de cordel e composição

Bento escreve, imprime e vende folhetos. A prensa publicou um final que ele ainda estava escrevendo. Sua **Estrofe** tem três espaços. Acertar um ataque de cada tipo em até seis segundos completa o recurso, em qualquer ordem. O especial imprime folhas que avançam em faixa larga.

O combo **L → P → D** carimba o chão para empurrar o alvo na direção da folha lançada. O projétil para no primeiro inimigo e tem recuperação suficiente para tornar arriscado usá-lo de perto. Bento decide quando alternar golpes e quando preservar distância. [Literatura de Cordel, Iphan](https://bcr.iphan.gov.br/bens-culturais/literatura-de-cordel/)

### Dandara — Maracatu Nação e compasso

Percussionista do Recife, Dandara quer recuperar as anotações de ensaio que viraram cartazes ambulantes. O **Compasso** sinaliza a janela do próximo golpe no HUD. Dois encaixes de tempo carregam uma batida que abre espaço e, em dupla, concede proteção breve contra interrupção aos aliados na área.

O combo **P → L → P** firma posição e empurra vários oponentes no final. Funciona em ritmo livre e recompensa o tempo marcado com carga. Uma onda baixa viaja pelo chão em alcance médio e tem recuperação longa. Dandara decide entre terminar a sequência e sair de uma ameaça. Desenvolver a apresentação cultural com praticantes. [Maracatu Nação, Iphan](https://bcr.iphan.gov.br/bens-culturais/maracatu-nacao/)

### Iara — Pipas e controle de trajetória

Artista de São Paulo, Iara conserta brinquedos e ensina a montar pipas. Com **Linha no Vento**, pode corrigir uma vez a trajetória de uma pipa lançada. Acertar na ida e na volta carrega o especial, que desenha um arco entre pontos e cruza faixas vizinhas.

No combo **D → L → P**, Iara lança a pipa, ganha tempo com um golpe curto e recua no pesado para orientar a volta. Ela pode se mover e atacar de perto enquanto o projétil está no ar. A escolha é corrigir cedo para garantir a ida ou guardar o ajuste para a volta.

## Campanha e Feira da Virada

| Capítulo | Situação | Mecânica |
|---|---|---|
| Feira da Virada | A prensa tomou as barracas e fechou a praça | Contornar obstáculos e conquistar faixas de ataque |
| Cais das Cartas | Folhas roubadas flutuam entre trapiches | Alternar faixas antes que plataformas fechem a passagem |
| Oficina da Última Edição | A prensa recompõe o bairro em painéis móveis | Ler o rearranjo e explorar a abertura depois de cada impressão |

Na entrada da feira, o jogador experimenta comandos em segurança. Um **Cartaz Solto** entra, dobra o corpo e avança, ensinando o tempo da esquiva. No corredor surge o **Tabuleiro**, que protege a frente e ensina a contornar. Na praça, o **Carimbo** marca o chão antes de atacar. Cada adversário aparece sozinho antes de ser misturado aos demais, com até quatro inimigos ativos. A placa recuperada na praça abre o galpão e marca o ponto de retorno.

O **Fiscal da Prensa** inclina o corpo e anuncia a faixa da investida. Fica vulnerável enquanto se desamassa. Abaixo de 50% de vida passa a marcar uma segunda faixa, mantendo uma rota livre. Lia aproveita as investidas para carregar Ginga e Bento usa a recuperação para compor a Estrofe. Os dois conseguem vencer com ataques básicos e esquiva.

No encerramento, a matriz devolve os nomes às barracas. Os resultados mostram tempo, tentativas e especiais usados, com opções de repetir ou voltar à seleção.

## Progressão, apresentação e base técnica

- Lia e Bento ficam disponíveis desde o início da demo. Na campanha, concluir um capítulo libera o seguinte. Repetições podem liberar finalizações alternativas, como empurrar em vez de lançar. Os golpes iniciais bastam para concluir a campanha.
- A arte usa fachadas pintadas, cores de feira, textura de papel e lutadores com silhuetas distintas. Protótipos começam com formas simples. A primeira fase define escala e acabamento.
- Trilha e sons de feira ganham camadas nos encontros. Os alertas sonoros têm equivalente visual. A opção de movimento reduzido controla tremores e flashes. Música e efeitos têm controles independentes.
- Cada herói tem ocupação, relações e motivações próprias. O material ligado a práticas culturais vivas prevê consulta e crédito aos participantes.
- Godot é a opção de motor proposta. Fichas de personagem guardam atributos e ações. Dados de golpe guardam alcance, dano e tempos. Dados de encontro guardam posições, ondas e condições de encerramento. Um controlador comum gerencia movimento, estados e dano recebido. As habilidades próprias gerenciam seus recursos e regras.

## Etapas de desenvolvimento

### 1. Movimento e arena de teste

**Contexto.** Validar como o jogador lê a profundidade da arena, os limites e a orientação do lutador antes de produzir animações finais.

**Desenvolver.** Uma arena cinza com dois obstáculos, câmera lateral, ordem visual pelos pés, teclado e controle. Implementar aceleração ou desaceleração, diagonal normalizada, orientação, salto com sombra e esquiva com recuperação. Permitir reinício rápido e comparação dos perfis de velocidade.

**Entrega e aceite.** Sala executável onde é possível contornar obstáculos, saltar, esquivar e voltar à posição inicial. A diagonal respeita a velocidade configurada e a ordem visual acompanha os pés.

**Estado do protótipo.** A arena inicial da Feira da Virada implementa deslocamento nos dois eixos do chão, aceleração e desaceleração, orientação, salto visual, esquiva com recuperação, câmera lateral e reinício. O corpo físico fica nos pés e continua bloqueado pelo cenário enquanto o visual salta. A velocidade inicial é 240 px/s e pode ser ajustada na cena do personagem. O teste automatizado cobre diagonal, bloqueio, contorno, salto, limite superior, reinício e esquiva. O [guia da arena](level-design.md) descreve a autoria dos obstáculos e a troca de arte.

### 2. Combate básico e primeiro inimigo

**Contexto.** Validar reconhecimento de golpe, alinhamento em profundidade e tempo de resposta.

**Desenvolver.** Vida, áreas de acerto e recepção, leve, pesado, ataque à distância, combo de três ações, empurrão, queda e derrota. Criar boneco de treino e Cartaz Solto com perseguição, aviso e ataque. Adicionar visualização de colisões e registro de dano.

**Entrega e aceite.** Treino e um encontro reiniciável com dois Cartazes Soltos. Um golpe desalinhado erra, um golpe alinhado causa o dano esperado uma vez e o jogador consegue evitar a investida, responder e reiniciar depois de perder.

### 3. Lia e Bento jogáveis

**Contexto.** Comparar decisões de combate na mesma sala e verificar se a referência cultural altera a forma de jogar.

**Desenvolver.** Seleção dos dois heróis, atributos, combos, golpes à distância e especiais. Adicionar HUD das cargas de Ginga e espaços de Estrofe, feedback de carga e consumo e um desafio curto que ensina cada habilidade.

**Entrega e aceite.** Arena de comparação vencível com os dois heróis. Em teste sem orientação verbal, jogadores identificam como carregar o especial e explicam uma diferença tática além de velocidade ou dano.

### 4. Primeira fase completa

**Contexto.** Reunir o combate em uma sessão com introdução, escalada, chefe e recompensa.

**Desenvolver.** Entrada, corredor, praça e galpão. Adicionar Tabuleiro, Carimbo, Fiscal da Prensa, ponto de retorno antes do chefe, derrota, vitória, resultados e retorno à seleção. Aplicar primeiro acabamento de arte e som.

**Entrega e aceite.** Demo solo com meta de 8 a 12 minutos e fechamento jogável com Lia e Bento. O retorno ao chefe restaura vida, posição, inimigos e estado do encontro. A fase ensina cada ameaça isoladamente e a segunda fase do chefe tem uma rota de esquiva visível.

### 5. Elenco completo e cooperação local

**Contexto.** Adicionar ritmo e controle de trajetória ao elenco e validar como as habilidades se combinam em dupla.

**Desenvolver.** Dandara, Iara e seus desafios introdutórios. Adicionar entrada do segundo jogador, seleção independente, câmera compartilhada, HUD individual, queda e reanimação. Ajustar quantos inimigos aparecem e quantos atacam ao mesmo tempo.

**Entrega e aceite.** Feira da Virada com quatro personagens em solo ou dupla. Validar controles independentes, câmera acompanhando os dois jogadores, pausa e recuperação ao reconectar um controle, reanimação, derrota da dupla e vitória contra o chefe.

### 6. Campanha inicial e distribuição

**Contexto.** Expandir a demo para três capítulos e completar o fluxo de jogar, salvar e retomar.

**Desenvolver.** Cais das Cartas e Oficina da Última Edição, cada um com regra de arena e chefe. Adicionar seleção de fase, salvamento, áudio, remapeamento, movimento reduzido e créditos. Ajustar valores de combate com sessões registradas em solo e em dupla.

**Entrega e aceite.** Versão para PC que pode ser instalada e concluída do início ao fim. O progresso permanece após encerrar o jogo. É possível repetir capítulos com outro lutador, recuperar-se de derrota e terminar a campanha com qualquer personagem. Os créditos cobrem as referências e colaborações usadas.
