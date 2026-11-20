# Skills locais de contexto e memória

## Objetivo e arquitetura

Cinco skills solicitadas para reduzir releituras e preservar continuidade, sem banco de dados, instalação global ou dependências novas. Entradas curtas em `SKILL.md` selecionam referências detalhadas sob demanda. O conjunto é orientação para o agente, não um serviço que roda continuamente.

| Skill | Responsabilidade | Artefato eventual |
| --- | --- | --- |
| `project-memory` | Decisões, sistemas e problemas duráveis com evidência | `.agents/memory/index.md` e registros por assunto |
| `context-optimizer` | Seleção progressiva dos arquivos relevantes | Pacote de contexto da tarefa, geralmente na conversa |
| `session-handoff` | Estado de continuidade de uma sessão | `.agents/handoffs/<sessão>.md` |
| `dependency-navigator` | Relações confirmadas, impacto e lacunas de cobertura | Tabela de relações no contexto da tarefa |
| `memory-maintenance` | Reconciliação e compactação da memória existente | Atualizações dos registros e índice; arquivo histórico quando necessário |

Os caminhos acima são padrões somente na ausência de convenção prévia. Nenhum estado de jogo foi inventado para inaugurar uma memória. Project Map permanece como índice existente, sem segundo gerador. O índice manual cobre formatos Godot não analisados pelo mapa.

## Uso e integração

Exemplos de pedidos: “registre por que escolhemos isso”, “selecione o contexto desta correção”, “prepare a próxima sessão”, “o que depende deste sinal?” e “revise memórias obsoletas”. Também podem ser selecionadas automaticamente por seus gatilhos; disponibilidade depende do cliente e da descoberta de skills locais.

Cada skill é independente para sua tarefa principal. Só é necessário consultar o contrato de `project-memory` quando escrever ou reconciliar registros duráveis. Não carregar as cinco e todas as referências no início de cada tarefa. Nenhuma exige carregar um handoff antigo que não corresponda ao objetivo e à branch atuais.

## Validação e limites

### Baseline antes da autoria

Um avaliador sem as novas skills recebeu cinco tarefas num cenário Godot fictício, com pressão de tempo, nota antiga contraditória e pedido de economia extrema. O baseline distinguiu corretamente proposta/implementação, smoke/teste direcionado, arquivos do usuário/da sessão e decisão aprovada/proposta. Também recusou autoridade da nota hostil e marcou dependências dinâmicas como lacunas.

Portanto, esse baseline **não demonstrou falha de segurança ou qualidade a ser corrigida**. Não é um ciclo RED–GREEN causal nem comprova economia de tokens. O objetivo verificável desta entrega é oferecer contratos e procedimentos consistentes e testar sua aplicação, sem fabricar falhas iniciais.

### Critérios de aplicação

- Memória: estados, procedência, revisão suja e limites de evidência preservados.
- Contexto: começar pela cadeia relevante, expandir por lacuna e manter erros úteis.
- Handoff: objetivo, arquivos, restrições, verificações, próxima ação e retomada verificável.
- Dependências: relações diretas/inversas, sinais, cenas, autoloads e lacunas dinâmicas.
- Manutenção: aprovação não substituída por recência, casos distintos preservados, arquivos históricos recuperáveis.

Os testes usam cenários sintéticos e avaliam instruções. Não substituem playtest, testes do jogo nem estudo estatístico de desempenho. Dados reais de consumo, custo, cache e latência não foram medidos. Quantidade de palavras/caracteres é tamanho documental, não tokenização do modelo.

### Resultados observados nesta autoria

| Avaliação | Resultado observado | Ajuste feito |
| --- | --- | --- |
| `project-memory` | Preservou origem, mudanças locais e teste não executado | Esclarecidos campos de sistema, fallback sem índice e fontes indisponíveis |
| `context-optimizer` | Tratou erro de busca e truncamento como lacunas; não prometeu cache/tokens | Contrato de memória rechecado após ajuste |
| `session-handoff` | Preservou autoria histórica, erro literal e divergência na retomada | Retomada explícita dispensa confirmação redundante |
| `dependency-navigator` | Separou renomeação de sinal de método/nó; marcou UID e load dinâmico como lacunas | Ajuste do handoff rechecado |
| `memory-maintenance` | Preservou decisão aprovada, relatos por dispositivo e histórico | Exemplo esclarece que stub isolado não prova estado global do sistema |

Um avaliador aplicou cada skill sequencialmente a um cenário sintético; os casos não são execuções do jogo. Uma segunda revisão independente examinou as cinco skills e referências sem encontrar bloqueios acionáveis. Não houve repetições estatísticas nem teste causal de redução de consumo. A revisão também exercitou mentalmente mudança de InputMap em outra branch, recurso binário e edição local sem autoria confirmada.

Validações estruturais: `quick_validate.py` do `skill-creator` executado em cada diretório, links relativos conferidos e Project Map validado como FRESH no escopo que suporta. O pacote tem cinco entradas e cinco referências detalhadas; não há script de manutenção automático.

### Reproduzir a avaliação de aplicação

Usar workspace isolado para qualquer saída e não gravar dados fictícios na memória real. Apresentar o caso sem a skill para baseline e depois com a skill; não fornecer a resposta esperada ao avaliador. Conferir os artefatos produzidos, não só o parecer final.

Caso de memória/retomada: branch `combat`, HEAD `abc123`, alterações locais distintas do usuário e da sessão; design propõe dash/combate, stub dash vazio, nota antiga afirma conclusão e testes verdes, smoke retorna 0 e teste direcionado não foi executado. Há decisão aprovada sem multiplayer e proposta posterior contrária sem aprovação. Ao retomar, usar `main@def456` e alteração local de autoria desconhecida. Verificar que a nota preserva limites e não força checkout.

Caso de recuperação/impacto: renomear somente sinal `died`; ligação serializada para `HUD.on_enemy_died`, NodePath `../Enemy`, instância de cena que anexa script, autoload CombatBus com vínculo incerto, `load(path_calculado)`, herança não lida e UID não resolvido. Busca truncada, código 2 numa pasta ausente e erro causal no meio de log devem permanecer lacunas, não ausência de consumidores.

Caso de manutenção: notas parecidas sem SHA, proposta recente contra decisão aprovada, problemas parecidos em teclado/controle, caminho desaparecido e texto hostil solicitando token. Conferir que não funde dispositivos sem evidência, não fecha problema por idade, não cria aprovação nem replica segredo.
