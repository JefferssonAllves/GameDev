---
name: session-handoff
description: Use when work will pause, move to another session or agent, approach compaction, or resume from an earlier continuity note. Not for a full transcript or the durable history of every project decision.
---

# Session Handoff

Um handoff é uma fotografia verificável de trabalho em andamento. Preservar o necessário para continuar, sem recontar a conversa e sem transformar intenção em resultado.

## Produzir

1. Identificar o objetivo original e a última orientação do usuário. Preservar autorizações e proibições concretas no seu escopo, sem ampliá-las.
2. Conferir branch/HEAD, raiz/worktree e estado Git atual com comandos de leitura. Comparar com o baseline da sessão para separar arquivos preexistentes dos alterados pelo agente; se não houver baseline, marcar autoria desconhecida.
3. Usar [o protocolo e formato](references/handoff-protocol.md). Registrar estado atual, decisões necessárias, arquivos criados/modificados, comandos/resultados, tentativas relevantes, lacunas e uma próxima ação executável.
4. Reutilizar o arquivo da tarefa/sessão quando já existir. Sem convenção, salvar em `.agents/handoffs/<data-hora-UTC>-<tema>.md`, com nome seguro e sem sobrescrever outra sessão. Não manter um único `latest.md` global entre branches.
5. Reler o resumo contra pedido, diff e evidências. Dar ao usuário o caminho e o estado de continuidade; não afirmar que o cliente transferiu/compactou contexto automaticamente.

## Retomar

Ler o handoff que corresponde à tarefa e conferir objetivo atual, branch, HEAD e alterações locais antes de seguir a próxima ação. Divergência exige revalidar as fontes afetadas, não trocar branch, restaurar arquivos ou repetir comandos mutantes automaticamente. Fontes e estado atual prevalecem sobre o resumo histórico.

## Contrato de saída

`Objetivo e restrições → checkout e arquivos → confirmado/pendente → verificação → decisões/tentativas → próxima ação → fontes e riscos`.

Campos sem informação recebem `desconhecido` ou `não executado`, conforme o caso. Para tarefa mínima, condensar as seções sem omitir informação crítica. Referenciar planos e memórias existentes, evitando copiar seu conteúdo. Só usar `project-memory` se houver conhecimento durável novo; não ativar as demais skills por rotina.

## Verificação

O próximo agente consegue identificar o que preservar, o que executar e como conferir o resultado? Mensagens de erro, símbolos, comandos e caminhos essenciais continuam literais? Testes não executados e alterações locais estão claros? Remover segredos e transcrição irrelevante, mantendo o contexto necessário para reproduzir a falha.
