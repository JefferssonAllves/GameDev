# Relações de scripts, cenas e recursos Godot

## Índice

- Escolha da semente e evidência
- Relações diretas e inversas
- Buscas e UIDs
- Impacto, cobertura e exemplo

Este guia orienta inspeção de formatos textuais existentes; não substitui documentação da versão do Godot, parse pelo motor ou inventário real do MCP. Para API específica ou edição via editor, consultar documentação e skills próprias quando necessário.

## Semente e identidade

Um símbolo isolado pode existir em várias classes. Começar por arquivo, classe e comportamento. Um caminho `res://` é relativo à raiz do projeto Godot consumidor, que pode ser subdiretório do repositório; não presumir que a raiz Git é a raiz do jogo.

Confirmar qual `project.godot` pertence ao caso. Em repositório com exemplos ou ferramentas, não misturar cenas de projetos distintos. Definir se se pretende renomear sinal, método, arquivo, nó ou nome de ação: cada um tem consumidores diferentes.

Para cada relação, registrar origem e alvo com arquivo, símbolo/seção, linha observada quando útil e revisão. Números de linha envelhecem; manter símbolo/seção também. Guardar como hipótese quando só houver semelhança de nome ou documentação desatualizada.

## Tabela de relações

| Origem | Relação a conferir | Busca inversa / impacto |
| --- | --- | --- |
| `.tscn` | `ext_resource` de Script e propriedade `script` | Cenas que anexam o script; confirmar vínculo por ID local |
| `.tscn` | PackedScene e `instance` | Cenas que instanciam/herdam; overrides podem mudar comportamento |
| `.tscn` / `.tres` | `ext_resource` e `sub_resource` | Recursos consumidores; IDs locais não são caminhos globais |
| `.gd` | `extends`, `class_name`, `preload`, `load` | Classes derivadas, nomes globais e carregadores |
| `.gd` / `.tscn` | Sinal, emissão, `connect` e seção `connection` | Emissores, ligações, receptores e assinaturas |
| `project.godot` | `[autoload]` e caminho do singleton | Usos do nome global, sinais e estado compartilhado |
| Nó / `.gd` | `$`, `%`, NodePath, `get_node`, nó exportado | Hierarquia real, unique names, cena proprietária e instância |
| Grupo | Associação em cena/código e chamadas por nome | Consumidores de `get_nodes_in_group` / `call_group` e contrato de método |
| InputMap | Ação configurada ou adicionada por código | Usos `Input.*`, remapeamento e recursos de binding |
| Animação | Tracks, propriedades e chamadas de método | NodePaths, nomes de propriedade e método serializados |
| Shader/material | Shader, material e uniform | Recursos e scripts que configuram parâmetros |
| Teste/fixture | Cena/script/contrato exercitado | Executor e recursos realmente usados, sem presumir framework |

Essa tabela é uma lista de lugares prováveis, não promessa de sintaxe idêntica em todas as versões. Ler as seções reais do formato encontrado.

## Direção das arestas

Se `arena.tscn` instancia `player.tscn` e esta anexa `player.gd`, há duas arestas diretas distintas. Trocar API do script pode afetar consumidores indiretos; renomear apenas uma variável local não exige percorrer todos os recursos da arena.

Separar:

- **Dependência estrutural:** arquivo/cena inclui outro recurso.
- **Contrato de comportamento:** chamada, sinal, grupo, nome de ação ou propriedade serializada.
- **Estado compartilhado:** autoload ou recurso compartilhado consumido em vários lugares.
- **Hipótese:** coocorrência de nomes sem ligação confirmada.

Não usar volume de matches como contagem de callers. Uma linha pode ter várias relações; comentários e textos de UI podem não ser consumidores. Deduplicar por origem, relação e alvo, preservando locais distintos que precisam de edição.

## Buscas pontuais

Descobrir diretórios reais antes dos exemplos:

```bash
rg --files -g 'project.godot' -g '*.gd' -g '*.gd.uid' -g '*.tscn' -g '*.tres'
rg -n -F -- 'res://scripts/player.gd' cenas
rg -n -F -- 'died' scripts cenas tests
rg -n -F -- 'CombatBus' scripts cenas project.godot
```

Esses comandos são consultas de exemplo, não comandos de teste do jogo. Se `tests` não existir, remover esse argumento e localizar o executor real. Conferir erro de busca; não inferir ausência de testes do código 2.

Uma primeira busca por símbolos em formatos pertinentes pode ser ampla. As leituras seguintes devem perseguir relações reais. Para caminhos dinâmicos, localizar quem constrói a variável, seus possíveis valores, diretório e configuração. Se os valores dependem de runtime, manter a lacuna e propor verificação direcionada.

### UIDs e recursos não textuais

Uma referência pode conter `uid://...` e caminho textual simultaneamente, ou somente UID. Conferir arquivos `.uid` versionados, cabeçalhos de recursos textuais e fontes de metadados já presentes. Não inventar a correspondência por nome de arquivo.

Se o UID não resolver estaticamente, registrar `alvo não resolvido`. A confirmação pelo editor/motor, quando disponível e autorizada, pode resolver a identidade. Não vasculhar todo `.godot/` nem editar seu cache manualmente. Um recurso binário pode exigir inspeção pelo motor; `rg` não prova ausência de referências dentro dele.

Um caminho válido não prova que o arquivo será carregado naquela execução; um recurso referenciado pode ser inativo. Um UID quebrado merece investigação se estiver no caminho de reprodução, mas não é automaticamente a causa de todo defeito observado.

## Impacto e condição de parada

Perguntar qual contrato muda e percorrer consumidores até uma fronteira estável. Para renomeação pública, procurar tanto referências em código quanto serializadas. Para mudança interna, focar comportamento e testes que a exercitam. Para remoção, conferir inicialização, carregamento, fallback e dados persistidos pertinentes.

Se existir ciclo, registrar uma vez e não expandir infinitamente. Se a busca gerar muitos consumidores independentes, agrupá-los por subsistema e preservar a lista completa em artefato recuperável, sem truncar silenciosamente. Não persistir um novo mapa paralelo por rotina.

Formato de saída recomendado:

```text
origem | relação | alvo | evidência | confiança | impacto
```

Concluir com arquivos a alterar, verificações relevantes e lacunas. Uma análise estática pode delimitar impacto sem executar jogo; declarar esse limite em vez de marcar validação runtime como aprovada.

## Exemplo de impacto — cenário fictício

Alteração: renomear sinal `died` de Enemy.

| Origem | Relação | Alvo | Evidência do cenário | Impacto |
| --- | --- | --- | --- | --- |
| `enemy.gd::take_hit` | Emite | `died` | Descrição fornecida | Conferir declaração e emissões reais |
| `arena.tscn` | Conecta | `HUD.on_enemy_died` | Seção `connection` informada | Atualizar nome do sinal na ligação |
| HUD | Resolve nó | `../Enemy` | `get_node` informado | Contexto relevante; não muda por renomear somente o sinal |
| `project.godot` | Registra autoload | CombatBus | Configuração informada | Confirmar participação; nome não prova relação com died |
| Carregador | `load(path_calculado)` | Desconhecido | Expressão informada | Lacuna dinâmica, sem cobertura completa |

O método receptor pode continuar chamado `on_enemy_died`; o contrato é a conexão com assinatura compatível. Não renomear o nó Enemy ou o autoload só para alinhar nomes. Buscar conexões adicionais em código e cenas, inclusive herdadas, e testes que aguardam o sinal.

## Armadilhas

- `FRESH` do mapa geral: validar Coverage antes de inferir relação Godot.
- Mesmo basename: confirmar caminho `res://` e projeto consumidor.
- `ext_resource("1")`: ID só faz sentido na tabela daquele arquivo.
- Sinal textual encontrado: conferir se é declaração, emissão, ligação ou simples texto.
- Autoload e grupos: não supor dependência direta entre todos os seus consumidores.
- Nó removido/renomeado: conferir NodePaths serializados e tracks, além de chamadas de código.
- Diretório de testes ausente: registrar mecanismo não localizado, sem criar framework por iniciativa de navegação.
