# Recuperação e orçamento de contexto

## Índice

- Modos e ordem de leitura
- Receitas de busca
- Saídas extensas e truncamento
- Orçamento e medição
- Critérios de expansão e exemplo

## Modos

| Situação | Primeira leitura | Expansão justificada |
| --- | --- | --- |
| Pergunta pontual | Definição e contrato citado | Uso ambíguo ou divergência da documentação |
| Correção | Erro/reprodução, função e chamadores | Cadeia causal ainda incompleta |
| Renomeação/API | Declaração, usos e testes | Configuração, serialização, strings e recursos |
| Nova funcionalidade | Requisito e implementação vizinha reaproveitável | Integrações que o contrato modifica |
| Retomada | Handoff correspondente e estado Git atual | Referências afetadas ou desatualizadas |
| Auditoria solicitada | Escopo e inventário explícitos | Cobertura integral autorizada; leitura organizada por domínio |

Instruções do ambiente já carregadas não podem ser retiradas por esta skill. Um AGENTS extenso é custo estático: abrir menos código ajuda no contexto adicional, mas não desfaz tokens já enviados. Se houver pedido para reduzir o próprio guia, propor referências sob demanda sem remover restrições essenciais; não alterar a configuração ou o guia por iniciativa de uma tarefa distinta.

## Receitas de busca

Usar diretórios reais descobertos no repositório. Os nomes abaixo ilustram uma organização possível; se não existirem, localizar primeiro com `rg --files`.

```bash
# Localizar caminhos por formato; não ler seu conteúdo ainda.
rg --files -g '*.gd' -g '*.tscn' -g '*.tres' -g 'project.godot'
# Uma busca focada pode precisar de -uu em uma pasta oculta conhecida.
rg -n -F 'died' scripts cenas tests
# Ler um intervalo depois de localizar o símbolo e seus limites.
sed -n '30,100p' scripts/enemy.gd
# Conferir tamanho antes de abrir documento extenso.
wc -lc docs/design.md
```

Para recuperar texto literal de arquivo oculto/ignorado conhecido, usar `rg -n -F -- 'termo' caminho/exato`. Para descoberta em `.agents/memory`, fornecer esse diretório explicitamente e, se necessário, `-uu` apenas nele. Não usar `rg -uuu .` para contornar exclusões do projeto inteiro.

`rg` retorna 1 quando não há resultados e 2 em erro. Diretório inexistente, falta de acesso ou expressão inválida não provam ausência de referências. Corrigir o escopo ou registrar a limitação. Uma referência pode estar em arquivo ignorado relevante; conferir exclusões e caminhos conhecidos antes de concluir que não há uso.

Usar `-F` para símbolos literais e `--` quando a consulta puder parecer opção. Para regex, conferir o padrão antes de interpretar ausência. Busca com limite por arquivo ou saída truncada não sustenta enumeração completa de consumidores.

## Saídas extensas e truncamento

Antes de chamar uma ferramenta, pedir o menor resultado útil: nomes, intervalos, campos selecionados ou resumo nativo. Quando só houver log completo, salvar em local permitido e restrito e ler trechos por erro/ID. Não salvar credenciais nem informações privadas desnecessárias.

Se a ferramenta já despejou um log grande, copiá-lo para arquivo não o remove do histórico do modelo. A economia é nas próximas leituras; descrever isso corretamente. Não prometer apagar mensagens, editar o prompt de sistema, controlar KV-cache ou disparar compactação quando o cliente não fornece essa capacidade.

Quando uma ferramenta informar truncamento:

1. Identificar qual parte falta: início, meio, final ou arquivos inteiros.
2. Recuperar esse trecho por intervalo ou consulta mais específica.
3. Preservar mensagem de erro, causa, local e contexto que explica o próximo teste.
4. Resumir apenas depois de confirmar a informação necessária.

Não substituir erro ativo por “falhou, ver log” se a investigação usa sua mensagem. Pode remover progresso repetido, banner, linhas idênticas e resultados de tentativas já resolvidas desde que os originais sejam recuperáveis quando relevantes.

Ao redirecionar comando de teste para log, conferir o status do teste, não apenas o do comando que lê o log. Se usar pipeline em Bash, ativar `pipefail` ou inspecionar os códigos apropriados; não tratar `head`/`tee` como prova de sucesso do produtor.

## Orçamento e medição

Sem orçamento explícito, não impor número arbitrário de tokens ou de arquivos. Planejar três camadas:

1. **Essencial:** pedido atual, restrições e evidência que determina a ação.
2. **Suporte:** chamadores, testes, contratos e recursos alcançados pelo comportamento.
3. **Reserva:** detalhes de dependência ou log que só serão lidos se surgir lacuna.

Uma tarefa de API pode exigir muitas chamadas relacionadas. Uma correção de palavra pode exigir só um arquivo. Correção e completude definem o limite, não uma meta rígida de compressão.

Para avaliar ganho, comparar a mesma tarefa e mesmos critérios. Registrar, se disponíveis:

| Medida | O que sustenta | O que não sustenta |
| --- | --- | --- |
| Arquivos e trechos abertos | Alcance da recuperação | Tokens exatos |
| Bytes/caracteres retornados | Volume textual aproximado | Custo ou latência do modelo |
| Releituras e chamadas repetidas | Retrabalho observável | Qualidade sem conferir resultado |
| Telemetria real de tokens | Consumo reportado naquele runtime | Generalização a outros modelos/clientes |
| Testes/critério de aceitação | Qualidade no escopo exercitado | Ausência de todos os defeitos |

Não instalar tokenizador ou instrumentação só para produzir número decorativo. Se o usuário pedir benchmark, definir workload e método antes de medir. A forma de tokenizar português, código e nomes varia; `caracteres/4` é estimativa grosseira, não medição.

## Expansão e invalidação

Expandir uma camada quando houver consumidor não lido, estado global, recurso carregado, caso de erro não explicado, teste contraditório ou mudança de contrato. Antes de uma segunda busca equivalente sem resultado, variar hipótese de nomenclatura, formato ou escopo em vez de repetir toda a árvore.

Invalidar o trecho recuperado quando seu arquivo mudar, o usuário corrigir o objetivo ou ocorrer troca de branch/versão. Um mapa FRESH não garante que GDScript, cenas ou notas estejam cobertos. O status de frescor da memória também não substitui conferência do código atual.

## Exemplo de pacote — cenário fictício

Pedido: corrigir atualização do HUD ao morrer um inimigo.

- Objetivo: reproduzir morte e verificar atualização do HUD.
- Restrições: preservar alteração preexistente do jogador; sem commit/push conforme pedido atual.
- Seleção: `scripts/enemy.gd::take_hit`, ligação em `cenas/arena.tscn`, método receptor do HUD e `tests/test_enemy.gd`; localizar os caminhos reais antes de abrir.
- Confirmado: existe um smoke com retorno 0 no cenário; não comprova o teste.
- Dúvida: receptor, ordem de remoção e eventual autoload ainda não inspecionados.
- Expansão: ler CombatBus se participar da cadeia de dano; jogador se sua emissão determinar a falha.
- Parada da busca: causa e consumidores do contrato conhecidos, reprodução e verificação pertinente disponíveis; registrar qualquer carregamento dinâmico ainda sem resolver.

Não ler `.godot/` ou todos os sprites para investigar sinal. Um erro de importação concreto pode justificar inspeção pontual de metadados; isso é uma expansão motivada, não uma permissão para varrer cache.
