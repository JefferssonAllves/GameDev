---
name: context-optimizer
description: Use when a task risks loading unrelated files, repeated tool outputs or oversized instructions, or when the agent needs a focused context package before investigation or implementation. Not for deleting memory or promising runtime cache savings.
---

# Context Optimizer

Otimizar o contexto total necessário para concluir a tarefa, preservando evidência e restrições. Ler menos por chamada só ajuda se não causar releituras ou decisões erradas.

## Seleção progressiva

1. Extrair objetivo atual, resultado verificável e restrições. Conferir instruções aplicáveis; não tentar removê-las ou ignorá-las para economizar tokens.
2. Usar o índice já existente: validar Project Map conforme as regras do repositório e consultar o índice manual para Godot. Sem mapa utilizável, declarar a limitação e localizar fontes diretamente.
3. Localizar caminhos com `rg --files` e símbolos com `rg -n` em diretórios delimitados. Conferir tamanho antes de ler documentos grandes. Ler definições, chamadores e configuração que participam do comportamento pedido, sem carregar vizinhos por proximidade de nome.
4. Formar o pacote: objetivo, restrições, arquivos/trechos e motivo, fatos confirmados, dúvidas e próxima expansão. Para orçamento, truncamento ou repetição, usar [estratégia de recuperação](references/retrieval.md).
5. Expandir quando surgir dependência, contradição, erro ou contrato ainda não explicado. Parar quando puder fundamentar a ação e sua verificação; não declarar cobertura completa se houver lacunas.
6. Reusar trechos recentes ainda válidos. Revalidar após mudança de branch, arquivo, configuração ou objetivo. Persistir um resumo só se houver continuidade real; para isso usar `session-handoff` ou `project-memory`, conforme o tipo de informação.

## Regras de economia

- Uma busca ampla de nomes pode localizar o domínio; a leitura seguinte deve ser restrita. Não executar vários inventários equivalentes.
- Não ler todas as skills nem suas referências. Abrir a skill aplicável e somente o ramo usado.
- Guardar saída extensa em arquivo recuperável antes de imprimi-la; retornar conclusão e caminho. Erros ativos precisam de contexto suficiente, inclusive causa e stack relevantes.
- Não esconder falha em `head`, pipe ou log resumido: conferir status e distinguir ausência de resultados de falha do comando.
- Não inventar contagem de tokens, janela disponível, cache hit ou ganho percentual. Reduzir arquivos/bytes lidos é uma medida local; consumo real depende de telemetria do cliente.

## Saída mínima útil

`Objetivo → restrições → fontes selecionadas com motivo → confirmado/incerto → próxima ação ou condição de expansão`.

Para tarefa simples, bastam poucas linhas. Um pacote não precisa virar mais um arquivo ou checklist permanente. Não sacrificar testes relevantes, validação de entrada ou arquivos afetados por uma alteração de contrato.
