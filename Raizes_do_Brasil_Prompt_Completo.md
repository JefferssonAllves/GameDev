# RAÍZES DO BRASIL — Prompt mestre de desenvolvimento

> Documento de visão, Game Design Document, direção artística, especificação técnica e plano de produção. Nome provisório. As quantidades e parâmetros são hipóteses de design a validar por prototipagem, não compromissos de produção.

## 1. Instrução principal ao agente de desenvolvimento

Atue como diretor criativo, game designer, programador sênior de Godot 4/GDScript, designer de níveis, diretor de arte 2D, animador e engenheiro de multiplayer. Desenvolva um Metroidvania de ação e aventura lateral 2D, jogável sozinho ou cooperativamente por até quatro pessoas, ambientado em um Brasil fictício. Não copie personagens, sprites, músicas, mapas, interfaces ou código de jogos existentes. Utilize Hollow Knight como referência de exploração interconectada e progressão por habilidades; Cuphead como referência de chefes coreografados, projéteis e transições de fase; Castle Crashers como referência de acessibilidade cooperativa e expressividade cartunesca. A identidade final deve ser original.

Não tente implementar o jogo inteiro em uma única execução. Inspecione o repositório antes de modificar arquivos, preserve funcionalidades existentes, apresente um plano incremental, implemente sistemas testáveis e documente decisões. Não declare um recurso concluído sem verificá-lo. Use placeholders identificados quando a arte definitiva não existir; não confunda código de animação com sprites finais. Priorize um protótipo funcional e depois uma vertical slice com qualidade representativa.

## 2. Visão e pilares

- Exploração significativa: cada desvio pode revelar uma técnica, atalho, personagem, história ou desafio.
- Cooperação real: jogadores interagem entre si e com o cenário, não apenas somam dano.
- Progressão flexível: classes iniciais têm identidade, mas não limitam permanentemente o jogador.
- Chefes memoráveis: padrões legíveis, fases distintas, dificuldade baseada em domínio e preparação.
- Brasil diverso: ambientes urbanos, rurais e naturais, arquitetura, música e cotidiano regional, sem reduzir populações a estereótipos.
- Combate comum moderado: não bloquear cada sala com ondas de inimigos.

Público: jogadores de ação, plataforma e cooperação. Plataformas iniciais: PC Windows e Linux; controle e teclado. Meta de 60 FPS estáveis. Duração pretendida do jogo completo: 20–30 horas, sujeita a testes. Distribuição indicativa: exploração 35%, puzzles e plataforma 25%, chefes 20%, narrativa e progressão 10%, combate comum 10%.

## 3. Narrativa e universo

O país fictício sofre com as Fraturas, fenômeno que altera matéria, clima e máquinas. Uma rede de estações antigas, antes utilizada para conectar comunidades, começa a falhar. Quatro viajantes se unem para descobrir por que as Fraturas surgiram. Cada região tem conflitos independentes e pistas sobre a origem do problema. A ameaça central pode ser uma organização que tenta controlar a energia das Fraturas em benefício próprio; evite apresentar essa hipótese como cânone imutável antes de validar a narrativa.

A história aborda solidariedade, desigualdade, preconceito, pertencimento e exploração ambiental por meio de personagens e consequências concretas, não discursos expositivos. Não associe comunidades reais a vilania por origem, etnia ou religião. Elementos de folclore são opcionais e secundários; os chefes podem ser máquinas, criaturas originais ou manifestações das Fraturas.

Estrutura: prólogo em uma vila nordestina; descoberta da primeira estação; abertura de rotas nacionais; investigação regional em ordem parcialmente livre; convergência das pistas; confronto final e epílogo. NPCs mudam de diálogo após eventos. Missões secundárias devem contar histórias curtas com recompensas úteis e não exigir coleta repetitiva sem propósito.

## 4. Estrutura do mundo

Use perspectiva lateral 2D com eixo X horizontal e Y vertical. Não use profundidade de movimentação de beat 'em up. O mapa nacional funciona como interface de viagem entre estações; cada região contém um grafo de salas interconectadas, com transições por portas, cavernas, elevadores, barcos ou trilhas. Cada sala possui identificador estável, limites de câmera, entradas, saídas, pontos de respawn, requisitos e estado persistente.

Cada região deve ter aproximadamente seis áreas, uma cidade segura, três chefes principais (incluindo o regional), quatro minibosses opcionais e atalhos. Trate isso como teto inicial de planejamento, reduzível conforme custo. O mapa não reproduz escala geográfica real. Caminhos obrigatórios devem aceitar qualquer classe; habilidades de travessia essenciais são compartilhadas pelo grupo. Segredos podem exigir builds específicas, mas devem oferecer alternativas razoáveis. Não exigir retorno longo sem atalho ou recompensa.

| Região | Áreas propostas | Mecânica ambiental | Chefes propostos |
|---|---|---|---|
| Nordeste | Vila das Estações, Caatinga, cânion, gruta, dunas, litoral histórico | Vento, areia, cisternas, plataformas de pedra | Guardião da Seca, Engenho Errante, Farol Partido |
| Norte | Porto ribeirinho, igarapé, copa das árvores, mata inundada, ruínas, estação fluvial | Correntes, cipós, nível da água | Sentinela das Copas, Draga Colossal, Coração do Rio |
| Centro-Oeste | Vila do Cerrado, chapada, campo aberto, veredas, Pantanal, observatório | Água sazonal, correntes ascendentes, mecanismos de irrigação | Colosso da Chapada, Máquina de Drenagem, Sentinela do Horizonte |
| Sudeste | Bairro urbano, metrô, fábrica, Serra do Mar, reservatório, torre | Eletricidade, elevadores, esteiras, circuitos | Locomotiva Fraturada, Autômato Industrial, Núcleo da Torre |
| Sul | Vila serrana, araucárias, cânion, pampa, estação ferroviária, montanha | Neblina, vento, gelo localizado, trilhos | Moinho Errante, Expresso da Serra, Guardião da Geada |

Cada área deve conter uma silhueta visual reconhecível, um marco de orientação, uma mecânica introduzida com segurança, uma aplicação intermediária e uma aplicação avançada. Inclua caminhos opcionais que se reconectam ao caminho principal. O mapa revela salas visitadas, saídas conhecidas e marcadores manuais; não revele todos os segredos automaticamente.

### Exemplo de fluxo regional

Vila → trilha introdutória → cânion (passagem elevada bloqueada) → gruta (obtenção do impulso aéreo) → retorno por atalho → passagem elevada → arena do Guardião → estação de viagem. A área litorânea pode ser explorada antes do chefe para adquirir equipamento que facilita a luta. O jogador não deve ser obrigado a vencer o chefe com uma composição específica.

## 5. Personagens

Quatro personagens originais, com silhuetas, paletas, proporções e animações distintas. Nomes pessoais e histórias são provisórios. O esboço visual anterior sugere cangaceiro, ribeirinha, mateiro e benzedeira; preserve a diversidade de funções, mas não trate os trajes como representação documental de grupos reais.

| Personagem | Identidade inicial | Ataque básico | Técnica inicial | Limitação inicial |
|---|---|---|---|---|
| Capoeirista | Corpo a corpo, mobilidade | Sequência de chutes | Esquiva acrobática e contra-ataque | Alcance curto |
| Combatente viajante | Armas curtas, defesa | Golpes de bastão ou lâmina | Bloqueio direcional | Menor mobilidade durante defesa |
| Mateiro | Longo alcance, precisão | Projétil de arco ou equipamento fictício | Disparo carregado | Vulnerável durante carga |
| Conjuradora | Energia e suporte | Projétil elemental | Barreira temporária | Gestão de energia |

Cada personagem possui ataque leve, ataque forte, técnica equipada, interação, salto, esquiva e habilidades de travessia comuns. Classes não são papéis obrigatórios de tanque, curador e DPS. Permita personagens repetidos com cores alternativas. Cada jogador mantém sua build, aparência e progresso individual conforme regras da sessão.

## 6. Controles, física e sensação de jogo

Mapeie ações por InputMap, nunca por teclas rígidas no código. Teclado sugerido: A/D mover, Espaço saltar, J ataque leve, K forte, L técnica, Shift esquiva, E interação, Tab mapa. Controle: analógico/D-pad, botão inferior salto, esquerdo ataque leve, superior forte, direito interação, ombros técnica e esquiva. Permita remapeamento, deadzone e alternativas de acessibilidade. No coop local, associe cada dispositivo a um slot; não leia input global para todos os personagens.

Parâmetros iniciais em pixels lógicos por segundo: velocidade 230, aceleração 1800, desaceleração 2200, gravidade 1500, impulso de salto -480, queda máxima 850, dash 500 por 0,16 s. Coyote time 0,10 s; jump buffer 0,12 s; salto variável por soltura do botão; controle aéreo ajustável. Esses valores devem ficar em Resources e ser calibrados por testes. Evite alterar a física conforme FPS. Use CharacterBody2D e _physics_process. Plataformas unidirecionais devem permitir descida intencional e impedir atravessamento acidental. Não use root motion para determinar deslocamento de gameplay.

Estados: idle, run, jump_start, rise, apex, fall, land, dash, wall_slide, wall_jump, attack, cast, block, hurt, downed, revive, interact, death. Defina prioridades de transição; dano pode interromper ataques salvo janelas explícitas de superarmadura. Desabilite controle quando necessário, mas evite travamentos prolongados. Separe estado de movimento e estado de ação quando combinações forem válidas.

## 7. Combate e equipamentos

Combate responsivo, com telegráficos claros e hitboxes independentes da arte. Ataques têm antecipação, janela ativa e recuperação; use cancelamentos definidos, não arbitrários. Ataque leve inicial: 3 golpes, cada um com alcance e duração próprios. Ataque forte troca velocidade por impacto. Projéteis possuem velocidade, duração, dano, proprietário e regras de colisão. Ataques de aliados não causam dano entre si por padrão.

Modelo de dano inicial: dano_final = max(1, round(dano_base × multiplicador_da_técnica × multiplicador_elemental × 100/(100+defesa))). Evite resistências que tornem uma build inutilizável. Vida inicial sugerida: 100; energia: 100; recuperação de energia por ações bem-sucedidas e tempo fora de combate. Invulnerabilidade pós-dano: 0,7 s como ponto de partida. Feedback: hitstop breve local, flash discreto, som, partículas e reação visual. Não pause toda a simulação online para produzir hitstop.

Equipamentos: arma principal, técnica ativa, até três acessórios passivos e cosméticos. Use capacidade de acessórios para impedir equipar todas as vantagens. Exemplo: capacidade inicial 3, acessórios custam 1–3. Builds podem favorecer mobilidade, precisão, defesa, energia ou efeitos elementais. Troca em áreas seguras e antes de chefes; não durante ataques. Não depender de grind de XP. Moeda obtida em exploração, missões e chefes; melhorias por materiais de fontes previsíveis. Sem monetização pay-to-win.

## 8. Progressão por habilidades

Diferencie habilidades essenciais de travessia (permanentes, compartilhadas na campanha) e técnicas de combate (equipáveis, individuais). Habilidades essenciais não consomem slots de build. Treinadores ensinam técnicas mediante desafio curto; artefatos desbloqueiam travessia; chefes concedem recompensas únicas; missões oferecem acessórios e opções de especialização.

| Habilidade | Origem proposta | Exploração | Combate |
|---|---|---|---|
| Impulso aéreo | Gruta nordestina | Cruzar abismos | Desviar de projéteis |
| Pulo duplo | Treinamento | Atingir plataformas | Evitar ondas terrestres |
| Gancho | Oficina | Ancoragens e atalhos | Reposicionamento |
| Escalada | Artefato da mata | Subir paredes marcadas | Evitar chão perigoso |
| Mergulho | Estação fluvial | Salas submersas | Arenas aquáticas |
| Planar | Chapada | Correntes ascendentes | Controlar queda |
| Impacto descendente | Desafio | Romper pisos frágeis | Interromper ataques leves |
| Pulso elétrico | Oficina urbana | Ativar circuitos | Afetar máquinas |

Cada técnica tem ID, descrição, ícone, pré-requisitos, custo, cooldown, tags, efeitos e animação. Árvores são redes pequenas de escolhas, não centenas de nós de bônus percentuais. Exemplo capoeirista: chute giratório → contra-ataque → chute de energia; ramo mobilidade → esquiva aérea → impulso de aliado. A conjuradora pode aprender técnicas físicas e o capoeirista técnicas elementais, preservando diferenças por animação e passivas moderadas. Respec em hub sem punição excessiva.

## 9. Cooperação e multiplayer

Suporte planejado: 1–4 jogadores, coop local e online por host autoritativo; iniciar com dois jogadores locais, depois validar dois online antes de escalar. Não prometer crossplay, matchmaking público ou migração de host no MVP. O modo solo deve completar toda a campanha sem bots obrigatórios.

Mecânicas: impulso de aliado para alcançar plataforma; resgate por interação perto de borda; alavancas simultâneas; transporte conjunto de objetos; redirecionamento de feixes; plataformas temporárias; proteção durante travessias; combos elementais. Água + gelo cria plataforma em pontos autorizados; vento + fogo amplia área de efeito; escudo + impulso permite atravessar perigo sinalizado. Defina matriz de interações explícita, sem combinações emergentes ilimitadas que comprometam testes.

Cada puzzle obrigatório possui solução solo (contrapeso, temporizador, mecanismo alternativo) e coop. Nenhuma solução exige personagem específico. Evite que um jogador fique parado por muito tempo. Puzzles opcionais exclusivos de coop não devem conter itens essenciais nem impedir 100% da campanha solo; registre-os separadamente.

Câmera local compartilhada: enquadre jogadores dentro dos limites da sala, zoom suave com limite de legibilidade; sinalize bordas, ofereça retorno consensual ao grupo em ponto seguro. Transições de sala exigem reunião ou confirmação; não teletransportar aliado durante perigo sem aviso. Online: câmera individual dentro da sala compartilhada; coordenar transições e estado de arena.

Jogador derrubado: janela de resgate inicial de 10 s, interação de 2 s, retorno com 35% de vida. Se todos caírem, reinicie do checkpoint. Solo reinicia sem exigir revive. Escala de vida de chefe sugerida: 1 + 0,55 × (n-1); não multiplique projéteis indiscriminadamente. Ajuste ataques simultâneos, alvos e janelas de recuperação por quantidade de jogadores. Recompensas de progresso são compartilhadas; consumíveis e moeda podem ser individuais para evitar disputa.

Online: host valida dano, inventário, recompensas, portas e transições; clientes enviam inputs ou pedidos validados. Use MultiplayerAPI/ENetMultiplayerPeer para protótipo, MultiplayerSpawner e MultiplayerSynchronizer onde apropriado. Mensagens confiáveis para eventos persistentes; atualizações frequentes de posição por canal não confiável ordenado quando adequado. Interpolação de jogadores remotos; previsão local e reconciliação se necessárias. IDs estáveis, proteção contra RPC inválida, teste de latência e desconexão. Não confiar em cliente para conceder item ou dano. Host desconectado encerra sessão com retorno seguro ao lobby no MVP. Campanha do host controla estado de mundo; convidados preservam recompensas individuais válidas, com política explícita de habilidades essenciais temporárias.

## 10. Chefes e inimigos

Chefes com 3–5 fases, duração alvo de 2–5 minutos em tentativa bem-sucedida. Cada ataque deve ter sinal visual e/ou sonoro, janela de reação, padrão de colisão legível e oportunidade de resposta. Não sobreponha padrões que eliminem todas as rotas seguras. Dificuldade aumenta por combinação de padrões já ensinados, não apenas vida. Transições de fase têm animação própria e não causam dano surpresa. Checkpoint imediatamente antes da arena; reinício rápido. Resistências devem incentivar preparação, nunca exigir build única.

### Guardião da Seca — especificação de referência

Silhueta: colosso de arenito com braços assimétricos, rachaduras luminosas, núcleo visível apenas em momentos de vulnerabilidade. Arena horizontal com duas plataformas laterais e chão central. Paleta ocre, terracota e turquesa para energia; projéteis perigosos contrastam com cenário.

| Fase | Padrões | Sinal | Resposta |
|---|---|---|---|
| 100–70% | Pisão, ondas terrestres, arremesso de pedras | Braço levantado, poeira localizada | Saltar, esquivar, atacar após impacto |
| 70–35% | Rajadas, chuva de fragmentos, plataformas instáveis | Linhas de vento e sombras no chão | Mover entre zonas seguras |
| 35–0% | Núcleo exposto, ondas alternadas, rajadas combinadas | Núcleo pulsa e olhos mudam | Alternar defesa e ataque nas janelas |

Água reduz temporariamente defesa; impacto rompe placas mais rapidamente; ataques distantes atingem núcleo elevado; pulo duplo e dash facilitam esquivas. Todas as fases devem ser vencíveis com kit básico disponível naquele ponto. No coop, ataques alternam alvos e abrem oportunidades de ajuda sem obrigar classes. Recompensa: acesso à estação e técnica de impacto opcional. Animações: despertar, idle, antecipação de cada ataque, execução, recuperação, stagger, transição de fase, derrota e dissolução de energia.

### Outros arquétipos

Sentinela das Copas: arena vertical, galhos móveis, sementes e vento; Máquina de Drenagem: nível de água alternado e válvulas; Autômato Industrial: esteiras e circuitos; Guardião da Geada: zonas de atrito reduzido e rajadas. Cada um deve ensinar sua mecânica antes da arena. Inimigos comuns: patrulheiro terrestre, criatura saltadora, emissor de projéteis, obstáculo móvel e sentinela defensiva; poucos por sala, com possibilidade de evitar combate. Não gerar ondas infinitas em exploração.

## 11. Direção artística global

Arte 2D desenhada à mão, cartunesca, com contornos expressivos, volumes simplificados e fundos pintados em camadas. A atmosfera combina aventura, humor e mistério, sem imitar diretamente a aparência de personagens das referências. Use formas arredondadas nos protagonistas, formas angulares nos perigos e formas orgânicas nos ambientes. Evite pixel art como linguagem principal, realismo fotográfico, filtros que prejudiquem a leitura e excesso de detalhes nos sprites pequenos.

### Especificação visual

- Resolução lógica de referência: 1280×720, proporção 16:9; suportar outras proporções com enquadramento adequado. Assets desenhados em resolução superior à exibição, com escala consistente.
- Personagens: altura visual aproximada de 96 px lógicos, arquivos mestres de 192–256 px ou maiores; proporção de 3 a 4 cabeças de altura, mãos e pés expressivos, rostos simples e legíveis. Não usar olhos, máscaras ou cabeças que reproduzam personagens de Hollow Knight.
- Contornos externos de 2–3 px lógicos, internos de 1–2 px, variando com peso e iluminação. Linha em tom escuro da paleta em vez de preto absoluto em toda superfície.
- Sombreamento com dois ou três níveis, luz principal superior lateral; luz ambiente regional. Evitar gradientes plásticos em personagens.
- Cenário jogável: contraste e nitidez superiores ao fundo. Superfícies pisáveis têm bordas reconhecíveis; decoração não pode parecer plataforma interativa.
- Texturas: pinceladas discretas, papel e granulação moderada no ambiente, sem ruído excessivo sobre HUD ou projéteis.
- Silhuetas: testar em preto sólido e em tamanho reduzido; cada classe reconhecível sem depender de cor.
- Animação: estética quadro a quadro, poses-chave fortes, arcos naturais, antecipação, follow-through, squash/stretch moderado e smears pontuais. Não aplicar deformações exageradas a todo movimento.

### Paletas regionais de referência

| Região | Fundo | Plano jogável | Acento | Atmosfera |
|---|---|---|---|---|
| Nordeste | #E6C38A | #9E593C | #36B9AD | Luz quente, poeira, sombras secas |
| Norte | #173E3D | #477C50 | #E9C66B | Umidade, luz filtrada, vegetação densa |
| Centro-Oeste | #B7C8AA | #A77A43 | #4B9FA8 | Horizonte amplo, dourado e água |
| Sudeste | #34465A | #697780 | #E7A84B | Contraste urbano, luz elétrica |
| Sul | #A9BEC8 | #48685D | #B77B55 | Neblina, luz fria, interiores quentes |

Essas cores são âncoras, não paletas exclusivas. Projéteis, perigos e elementos interativos usam contraste de luminância, contorno e forma, não apenas cor. Testar daltonismo e escala de cinza.

### Design dos protagonistas

Capoeirista: silhueta leve, pernas expressivas, roupa de treino inspirada na capoeira, faixa de tecido e detalhes de costura. Postura em ginga, centro de gravidade móvel. Ataques com arcos amplos e transferência de peso. Evitar caricatura racial ou transformar tradição cultural em adereço genérico.

Combatente: roupa de viagem com proteção leve, lenço e chapéu opcional inspirado na estética sertaneja do esboço; arma curta claramente separada do corpo; postura firme, ombros largos, bloqueio legível. Não glorificar figuras históricas violentas.

Mateiro: mochila compacta, roupa funcional, botas, equipamento de alcance fictício ou arco, silhueta alongada pela arma. Mão de apoio e direção da mira visíveis; recoil moderado, sem animação que desloque a colisão.

Conjuradora: vestimenta de viajante com camadas de tecido, bolsa de artefatos, foco mágico original; mãos e efeitos indicam a conjuração. Não retratar práticas religiosas reais como malignas ou como magia literal sem contexto.

Criar para cada um: folha de modelo frente, costas, perfil e três quartos; escala comparativa; expressões neutra, alegre, surpresa, esforço, dor e determinação; poses-chave; paleta com variantes P1–P4; detalhes de armas e acessórios; guia de proporções e pontos de articulação. Sprites de gameplay laterais; espelhamento permitido quando acessórios assimétricos não exigirem versões específicas. Cosméticos não alteram hitbox.

### Cenários e composição

Organizar cada sala em fundo distante, fundo intermediário, fundo próximo, camada jogável, props interativos, efeitos e primeiro plano decorativo. Parallax indicativo: 0,08 / 0,25 / 0,55 / 1,0 / 1,15; primeiro plano não deve ocultar jogadores durante combate. Usar Parallax2D ou alternativa compatível com a versão fixada de Godot. Fundos modulares com peças de transição e marcos desenhados especificamente para salas importantes.

Nordeste: mandacarus, pedras, casas coloridas, cisternas, dunas e falésias; movimento sutil de bandeiras, poeira e vegetação. Norte: copas altas, raízes, reflexos de água, palafitas, embarcações, insetos luminosos. Centro-Oeste: gramíneas, chapadas, veredas, áreas alagadas, aves distantes. Sudeste: fachadas, trilhos, concreto, fiação, mata atlântica e máquinas. Sul: araucárias, campos, serras, neblina e arquitetura regional variada. Não resumir cada região a um único bioma ou tipo de morador.

TileSet com grade lógica sugerida de 32 px; arquivos fonte em escala 2×. Criar blocos centrais, bordas, cantos internos/externos, rampas, plataformas unidirecionais, paredes escaláveis, pisos frágeis e transições. Usar atlas com margem/extrusão para evitar vazamento de textura. Colisão definida manualmente por categoria; nunca inferida automaticamente de todo pixel opaco. Decoração sem colisão em camada própria. Salas especiais podem usar ilustração única combinada com colisões modulares.

## 12. Animação — especificação de produção

Simulação a 60 Hz, arte com cadência variável de 8–24 desenhos por segundo. FPS de animação não determina física. Reutilizar poses quando fizer sentido, sem interpolação automática que deforme mãos ou pés. Produzir spritesheets uniformes ou frames individuais com pivô consistente; exportar PNG RGBA transparente, sem textos, sem fundo e sem margens variáveis. Manter arquivo editável de origem (Krita, Aseprite ou ferramenta equivalente). Não depender de geração automática de spritesheets para obter consistência: revisar e corrigir manualmente cada frame.

### Biblioteca mínima por personagem

| Animação | Frames sugeridos | FPS | Loop | Direção de movimento |
|---|---:|---:|---|---|
| Idle | 8 | 8 | Sim | Respiração leve, pés fixos |
| Walk | 12 | 12 | Sim | Passos curtos, contato e passagem claros |
| Run | 12 | 16 | Sim | Inclinação e passada maior |
| Turn | 4 | 16 | Não | Transferência de peso |
| Jump start | 4 | 16 | Não | Compressão e extensão |
| Rise | 4 | 12 | Opcional | Pernas recolhem naturalmente |
| Apex | 3 | 10 | Não | Pose de suspensão |
| Fall | 4 | 12 | Sim | Corpo estabiliza, roupa acompanha |
| Land | 5 | 18 | Não | Absorção de impacto |
| Double jump | 8 | 20 | Não | Gesto distinto do salto inicial |
| Dash | 6 | 24 | Não | Inclinação e rastro separado |
| Wall slide | 6 | 10 | Sim | Mão ou pé em contato |
| Wall jump | 6 | 18 | Não | Impulso para fora da parede |
| Climb | 10 | 12 | Sim | Alternância de mãos e pés |
| Swim | 10 | 12 | Sim | Braçadas ou pernadas |
| Attack 1 | 8 | 20 | Não | Golpe rápido |
| Attack 2 | 9 | 20 | Não | Continuação do combo |
| Attack 3 | 12 | 24 | Não | Finalização com recuperação |
| Heavy attack | 14 | 20 | Não | Antecipação forte e impacto |
| Cast | 12 | 18 | Não | Preparação, emissão e retorno |
| Block | 5 | 15 | Não | Guarda; pose sustentada separada |
| Hurt | 6 | 18 | Não | Recuo curto e leitura clara |
| Downed | 8 | 12 | Não | Queda controlada |
| Downed idle | 6 | 8 | Sim | Sinal de resgate |
| Revive | 10 | 15 | Não | Recuperação progressiva |
| Interact | 8 | 12 | Não | Mão alcança mecanismo |
| Assist boost | 10 | 20 | Não | Agachar, impulsionar, recuperar |
| Victory | 12 | 12 | Opcional | Celebração própria da classe |

Ajustar durações ao design de combate. Não implementar todos os frames antes de validar movimentação com placeholders. Prioridade inicial: idle, run, jump, fall, land, dash, ataque, hurt e downed.

### Ciclo de caminhada detalhado

Produzir 12 desenhos em loop: 1 contato esquerdo; 2 absorção; 3 início da passagem; 4 passagem com pé direito próximo ao centro; 5 elevação; 6 extensão direita; 7 contato direito; 8 absorção; 9 início da passagem; 10 passagem; 11 elevação; 12 extensão esquerda. Movimento das pernas pequeno e fluido, sem abertura exagerada. Quadril oscila discretamente, cabeça estabilizada, braços em oposição, roupas atrasam um ou dois desenhos. Pés plantados não deslizam; ajustar distância da passada e velocidade de reprodução à velocidade real. Frame 12 conecta ao 1 sem salto de pose. Ginga do capoeirista é idle próprio, não substitui a caminhada.

### Chute do capoeirista

Sequência de 12 desenhos: preparação (1–3), transferência de peso (4–5), extensão do chute (6–7), contato visual (8), recolhimento (9–10), recuperação (11–12). Janela ativa inicial nos desenhos 6–8, convertida para ticks de simulação e ajustada por testes. Pé de apoio mantém contato; quadril gira antes da extensão; tronco contrabalança. Rastro separado, sem desenhar a trajetória dentro da hitbox. Variantes: meia-lua, chute ascendente e giratório, com antecipações distinguíveis.

### Pipeline e integração

Usar AnimatedSprite2D/SpriteFrames para ciclos quadro a quadro e AnimationPlayer para eventos visuais, props e sequências. AnimationTree é opcional para transições compatíveis; não misturar controladores concorrentes sobre a mesma propriedade. Gameplay controla estados e janelas de dano por dados/ticks; animação reage ao estado, não decide autoridade online. Cada clipe possui nome estável, duração, loop, pivô, tags e eventos visuais. Metadados em Resource ou JSON validado; pontos de emissão de projéteis e armas em Marker2D. Hitboxes e hurtboxes independentes da imagem. Espelhar marcadores junto ao personagem.

Padrão de nomes: `capoeirista_run_000.png`, `capoeirista_run_001.png`; atlas `capoeirista_run.png`; clipe `run`. Para spritesheets, grade fixa, ordem esquerda→direita e cima→baixo, número de frames declarado, células vazias finais ignoradas. Não redimensionar cada frame individualmente. Testar transparência, alinhamento, contagem, loop e importação antes de integrar.

### Animação de chefes e cenário

Chefes têm escala visual maior (aprox. 250–500 px lógicos, conforme arena), partes articuladas quando útil e animações quadro a quadro para ataques-chave. Criar folha de silhueta por fase, poses de antecipação, execução, recuperação, dano, transformação e derrota. Efeitos de projéteis separados do corpo. Transições usam mudanças de postura, rachaduras, iluminação e partículas; não apenas mudança de cor. Elementos ambientais: água em ciclos de 8–16 frames, folhas 6–12, fumaça 8–16, bandeiras 8–12, máquinas com rotação e translação por AnimationPlayer. Sincronizar perigos ao relógio de simulação, não à decoração.

## 13. VFX, iluminação e câmera

Efeitos com início, pico e dissipação. Ataques físicos usam arcos curtos, poeira e impacto; magia usa formas geométricas e partículas com identidade elemental. Projéteis perigosos têm núcleo nítido e contorno; partículas decorativas nunca imitam projéteis. Água: gotas e ondas; fogo: formas ascendentes; vento: linhas curvas; eletricidade: segmentos angulares. Limitar partículas simultâneas e usar pooling para projéteis frequentes após medir desempenho. Luz 2D seletiva, sem depender de normal maps em todos os assets. Screen shake curto, configurável e desligável; sem flashes intensos obrigatórios. Câmera com suavização, deadzone, look-ahead discreto e limites por sala. Não aplicar zoom brusco em saltos.

## 14. Interface e experiência do usuário

Menu principal: cenário animado discreto, título original, Jogar, Continuar, Cooperativo, Configurações e Sair. Seleção de personagens com retrato, sprite animado, função inicial, descrição curta e confirmação individual. Lobby com slots P1–P4, dispositivo, pronto e conexão. HUD: vida em corações ou segmentos, energia, técnica equipada, moeda e indicadores de aliados; em coop local, cantos distintos e cores com símbolos P1–P4. Barra de chefe central inferior ou superior, com marcadores de fase. Não mostrar informação redundante.

Mapa regional: salas conectadas, posição atual, checkpoints, portas bloqueadas conhecidas e marcadores. Inventário: categorias, comparação de atributos, custo de capacidade e descrição de efeito. Árvore de habilidades: nós descobertos, pré-requisitos e prévia de animação opcional. Diálogos: retratos expressivos, caixa de texto, avanço e histórico; não interromper ação perigosa. Pause local congela simulação quando permitido; online abre menu sem congelar outros jogadores. Configurações: volumes separados, remapeamento, legendas, tamanho de texto, intensidade de efeitos, tremor, modo de contraste, assistência de plataforma e dificuldade. Navegação completa por controle e teclado, foco visível, fontes licenciadas e suporte a acentos portugueses. Idioma inicial pt-BR; strings externas para localização futura.

## 15. Áudio

Trilha original com instrumentos e ritmos regionais pesquisados e contextualizados, sem reproduzir músicas protegidas. Nordeste pode usar sanfona, zabumba e triângulo; outras regiões recebem arranjos próprios sem reduzir diversidade musical a clichês. Temas de exploração suaves, camadas dinâmicas de tensão, chefes com variações por fase e hubs com música acolhedora. Ambientes com vento, água, fauna, máquinas e vozes distantes discretas. SFX distintos para salto, aterrissagem, dash, acerto, bloqueio, dano, item, interação, perigo e revive. Sons de antecipação não dependem exclusivamente de áudio para comunicar perigo. Usar buses Master, Music, SFX, Ambience, UI; evitar clipping e excesso de sons simultâneos. Loops sem cortes perceptíveis; registrar licenças e autoria.

## 16. Arquitetura Godot 4

Fixar versão estável instalada e registrar no README. GDScript tipado quando prático, composição em vez de heranças profundas, Resources para dados, sinais para comunicação desacoplada. Não criar autoload para todo sistema. Evitar dependências externas sem justificativa. Estrutura proposta:

```text
project.godot
AGENTS.md
README.md
docs/
  design/ art/ animation/ architecture/ decisions/ tests/
assets/
  characters/ enemies/ bosses/ environments/ tilesets/ ui/ vfx/ audio/ fonts/
scenes/
  boot/ menus/ players/ enemies/ bosses/ world/ interactables/ ui/
scripts/
  core/ player/ combat/ abilities/ coop/ network/ world/ save/ ui/
data/
  characters/ abilities/ items/ attacks/ bosses/ regions/ localization/
tests/
  unit/ integration/ scenarios/
tools/
```

Player.tscn: CharacterBody2D, CollisionShape2D, VisualRoot, AnimatedSprite2D, AnimationPlayer, Hurtbox Area2D, AttackOrigin Marker2D, InteractionDetector, MovementController, CombatController, AbilityController, HealthComponent, InputSource. Room.tscn: Node2D, TileMapLayer conforme versão, parallax, spawn markers, doors, hazards, interactables, camera bounds, room controller. Boss.tscn: controlador de fases, health, pattern scheduler, attack emitters, visual root, hurtboxes e arena controller. UI em CanvasLayer com Control e Containers responsivos.

Autoloads sugeridos: GameSession (estado da sessão), SceneRouter (transições), SaveService (persistência), AudioService (buses e música), NetworkSession (conexão). Evitar referências circulares. Resources: CharacterDefinition, AbilityDefinition, AttackDefinition, ItemDefinition, BossPhaseDefinition, RoomDefinition, RegionDefinition. IDs estáveis, não caminhos de nós como identidade persistente. Separar apresentação de regras. Usar sinais como `health_changed`, `ability_unlocked`, `player_downed`, `room_completed`, `boss_phase_changed`.

Camadas de colisão documentadas: mundo, jogadores, inimigos, hurtboxes de jogador, hurtboxes de inimigo, ataques aliados, ataques hostis, interações, perigos, plataformas. Validar máscaras explicitamente. Não usar colisão entre jogadores que permita bloquear aliados em passagens; interações de impulso usam áreas próprias.

## 17. Persistência e checkpoints

Salvar em `user://` com versão de schema, gravação temporária e substituição segura, backup e validação. Dados: perfil, personagem, build, moeda, inventário, habilidades, salas descobertas, chefes derrotados, missões, checkpoint, configurações. Separar progresso de campanha do host e perfil individual. Não serializar nós vivos. Checkpoints em hubs e antes de chefes; salvar ao obter recompensa importante, evitando duplicação após reconexão. Testar arquivo ausente, corrompido, versão anterior e interrupção de gravação. Não sobrescrever save válido com dados inválidos.

## 18. Desempenho, qualidade e acessibilidade

Meta de 60 FPS em hardware intermediário, com orçamento de frame de 16,67 ms; medir em máquina-alvo real, não presumir desempenho. Carregar salas sob demanda; pré-carregar assets essenciais da próxima transição quando apropriado. Limitar luzes, partículas e projéteis ativos; desativar processamento de objetos fora de alcance quando seguro. Usar profiler antes de otimizar. Testar quatro jogadores, chefe com muitos projéteis e transições repetidas. Não sacrificar legibilidade para efeitos.

Testes mínimos: movimento em diferentes FPS, salto no limite, buffer, dash contra parede, plataforma unidirecional, dano único por ataque, invulnerabilidade, cooldown, desbloqueio persistente, puzzle solo e coop, revive, escala de chefe, troca de sala, reconexão, save/load, navegação por controle, contraste de projéteis e ausência de softlocks. Testar campanha com cada personagem e sem acessórios opcionais. Online: simular latência de 50/100/200 ms, perda de pacotes e desconexão; verificar consistência de recompensas e estados. Usar testes automatizados quando possível e roteiro manual reproduzível. Registrar limitações reais.

## 19. Plano de produção

1. Fundação: configurar projeto, InputMap, arquitetura, documentação e sala de teste.
2. Protótipo de movimentação: um personagem placeholder, física, câmera, plataformas e estados.
3. Coop local: dois jogadores, dispositivos, câmera, transição e revive.
4. Combate: hitboxes, dano, projéteis, técnicas e um inimigo.
5. Exploração: três áreas conectadas, checkpoint, mapa, habilidade de travessia e atalho.
6. Puzzles: quatro desafios com solução solo e coop.
7. Chefe: Guardião da Seca com três fases, reinício rápido e duas builds viáveis.
8. Arte da vertical slice: model sheets, sprites finais prioritários, tileset nordestino, fundos, VFX, HUD e áudio.
9. Persistência e acessibilidade: saves, configurações, controle e testes de regressão.
10. Online: protótipo autoritativo de dois jogadores, validação de latência e estados; expandir para quatro somente após estabilidade.
11. Expansão: produzir demais regiões em lotes, reutilizando sistemas e pipeline, não repetindo salas mecanicamente.
12. Polimento: balanceamento, otimização, localização, revisão cultural, QA e empacotamento.

### Critérios de aceite do MVP

Uma cidade segura, três áreas exploráveis interconectadas, dois personagens distintos, coop local de dois jogadores, seis habilidades, quatro puzzles, um miniboss e um chefe de três fases. Campanha de 30–60 minutos como meta. Deve ser possível iniciar, escolher personagem, explorar, desbloquear habilidade, retornar por atalho, resolver desafios sozinho ou em dupla, vencer chefe, salvar, fechar e continuar. Não pode haver bloqueio permanente por escolha de classe, duplicação de recompensa ou crash reproduzível no fluxo principal. Arte final representativa em pelo menos uma área e dois personagens; demais placeholders identificados. Online é marco posterior, não condição para o primeiro MVP local.

## 20. Instruções para Codex e agentes de arte

Crie AGENTS.md com convenções, comandos de execução, mapa de diretórios, limites de escopo e regras de validação. Mantenha `docs/architecture/overview.md`, `docs/decisions/` e backlog com IDs. Antes de cada tarefa, leia apenas os documentos relevantes e inspecione os arquivos afetados. Não reescreva sistemas funcionais sem necessidade. Entregue diffs pequenos, explique decisões, execute testes disponíveis e registre falhas. Não invente resultados de testes nem alegue ter gerado arte que não existe. Se faltar ferramenta de geração ou edição de imagem, entregue especificação de asset e placeholder funcional, solicitando integração posterior. Não instalar plugins ou baixar assets sem autorização e verificação de licença.

### Prompt-base para produção de sprites

> Criar sprite 2D original para Raízes do Brasil, perspectiva lateral, personagem [ID], ação [CLIPE], seguindo rigorosamente a folha de modelo aprovada. Estética desenhada à mão, contorno escuro expressivo, proporção de 3–4 cabeças, paleta fixa, sombreamento em 2–3 níveis, fundo transparente. Preservar rosto, roupa, acessórios, escala, pivô e direção em todos os desenhos. Gerar [N] frames em células uniformes, sem texto ou bordas, com poses [DESCRIÇÃO]. Não cortar extremidades. Não incluir cenário ou efeitos de partículas no sprite corporal. Manter movimento fluido e leitura em 96 px lógicos. Revisar consistência quadro a quadro e corrigir antes de exportar.

### Prompt-base para cenários

> Criar ambiente lateral 2D original da região [REGIÃO], área [ÁREA], inspirado em referências geográficas e arquitetônicas reais sem copiar fotografias. Separar fundo distante, intermediário, próximo, terreno jogável e primeiro plano. Usar paleta regional, iluminação coerente, silhuetas fortes e contraste que destaque plataformas. Reservar espaço para personagens e projéteis. Produzir peças modulares e variações, sem texto, HUD ou personagens incorporados. Exportar camadas transparentes quando necessário e documentar escala e pontos de conexão.

### Prompt-base para chefes

> Criar chefe original [ID], silhueta reconhecível, escala e paleta definidas, com folha de modelo e três ou mais fases visualmente distintas. Para cada ataque, desenhar antecipação, execução, recuperação e pose de vulnerabilidade. Separar corpo, projéteis e efeitos. Garantir leitura de perigo e espaço seguro. Não reproduzir chefes de jogos existentes. Entregar frames alinhados, pivôs consistentes e metadados de clipes.

## 21. Primeira tarefa a executar

Não iniciar pela produção de todas as regiões. Inspecione o projeto existente. Se vazio, crie projeto Godot 4 mínimo, documentação e uma sala cinza de teste com plataformas, um personagem controlável, câmera e física configurável. Implemente e valide caminhada, corrida, salto variável, queda, aterrissagem e dash. Prepare a arquitetura para input por jogador. Use placeholders simples, sem fingir que representam a arte final. Apresente arquivos criados, comandos de execução, resultados efetivamente observados, pendências e próxima tarefa. Só avance para combate e cooperação após a movimentação ser aprovada.

## 22. Decisões abertas

Nome definitivo, narrativa final, identidade e nomes dos quatro protagonistas, modelo de distribuição comercial, orçamento artístico, versão exata de Godot, hardware mínimo, escopo online, dificuldade e quantidade final de conteúdo devem ser confirmados durante produção. O esboço visual é referência de composição, não cânone: a presença de figuras folclóricas e a aparência de cangaceiro não são requisitos obrigatórios. A prioridade é uma identidade original e um protótipo verificável.

## 23. Primeiro recorte jogável — Estação do Vento

O projeto principal da branch `teste`, com código em `raizes-do-brasil/`, concretiza o primeiro teste de movimentação. A estação foi isolada do projeto Brasil em Retalho para permitir mudanças na física e na direção visual sem interferir no jogo anterior.

O protótipo usa uma única área contínua. A ida pelo chão ensina a distância do pulo antes de entregar a Brasa do Vento. A volta pelos terraços recontextualiza o caminho. O jogador sobe pelo acesso à direita e usa o impulso aéreo para alcançar o relé no terraço da esquerda. A brasa cria um marco de retorno após quedas. Religado o relé, a resposta do cenário e o objetivo na tela confirmam o fim da demonstração.

Para este recorte, medir se o salto curto e o salto longo são distinguíveis, se o impulso pode ser descoberto pelo cenário e se o retorno é compreensível após uma queda. Arte geométrica provisória produzida no próprio projeto. Após validar essa base, expandir para salas conectadas e prototipar combate e cooperação local conforme os marcos de produção.

### Expansão do primeiro arco — Casa das Comportas

O relé religado abre a Casa das Comportas. O Guardião da Seca protege o núcleo entre sequências de ondas. A leitura do aviso, o salto e a habilidade recém-aprendida ajudam a chegar ao núcleo no tempo de vulnerabilidade. Cada fase aumenta a quantidade e a velocidade das ondas. A derrota devolve água à vila e conclui o arco. Este recorte concentra o teste de plataforma e combate em duas cenas com um caminho completo até a vitória.

A campanha completa ainda requer a vila navegável, mais áreas interconectadas, personagens, equipamentos, puzzles solo e cooperativos, salvamento e arte representativa. Coop local precede a validação online. O teste automatizado verifica transição de sala, dano, reinício, invulnerabilidade do núcleo, três fases e vitória.

O menu da campanha oferece Novo jogo e Continuar. O primeiro arco salva marcos em `user://raizes-campaign.cfg` com versão de formato e gravação temporária. A brasa e o relé restauram o ponto de retorno correspondente. O duelo recomeça ao retomar a Casa das Comportas, e a vitória fica registrada.

### Cooperativo local inicial

O primeiro arco aceita dois jogadores na mesma máquina. O menu separa teclado e controle em dois conjuntos de ações. A câmera compartilhada limita a distância da dupla, o impulso é desbloqueado para ambos e a entrada na Casa das Comportas exige reunir o grupo no relé. O duelo tem vida individual e mantém o chute de cada jogador. O resgate exige proximidade e interação por dois segundos. O salvamento continua por marcos da campanha e o modo solo ou em dupla é escolhido no menu.
