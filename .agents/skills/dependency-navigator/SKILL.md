---
name: dependency-navigator
description: Use when locating scripts, scenes, resources or callers related to a behavior, or assessing the impact of changing a symbol, path, signal or resource. Especially relevant to Godot relationships omitted by a general source map.
---

# Dependency Navigator

Localizar o conjunto afetado por um contrato, confirmando relações nas fontes. Uma lista de nomes parecidos não é um grafo de dependências.

## Procedimento

1. Definir a semente: comportamento, caminho, símbolo, sinal, nó, autoload ou recurso. Identificar a alteração pretendida e a plataforma/versão que importa.
2. Validar Project Map e consultar cobertura/índice manual conforme as regras do projeto. Reutilizar grafo existente se disponível e pertinente; não instalar outro analisador nem gerar grafo novo para uma busca simples.
3. Localizar a definição e suas relações diretas. Depois buscar consumidores inversos: chamadores, referências de cena, serialização, configuração e testes. Conferir cada relação no arquivo real.
4. Em Godot, usar [a navegação de relações](references/godot-relations.md): scripts anexados, `ext_resource`, cenas instanciadas/herdadas, recursos, sinais, autoloads, grupos, caminhos de nós e UIDs. Tratar nomes calculados como lacunas até confirmar runtime ou construção do caminho.
5. Expandir somente pelo contrato afetado. Uma renomeação de sinal não exige renomear método receptor ou nó sem outro motivo. Separar dependência relevante de simples coocorrência textual.
6. Entregar `origem → relação → alvo | evidência | confiança | impacto`, seguido dos arquivos a revisar/testar e limites de cobertura. Usar caminhos e símbolos reais; se não foram inspecionados, atribuir a informação à fonte que a relatou.

## Parada e confiança

Encerrar quando definições, consumidores do contrato e integrações relevantes estiverem explicados; registrar fronteiras ainda dinâmicas. Relações `confirmada estaticamente`, `observada em runtime` e `hipótese` têm forças diferentes. Resultado vazio numa busca limitada não prova ausência global; truncamento ou erro não são resultado vazio.

## Limites

Não editar código como efeito colateral de uma pergunta sobre impacto. Não executar projeto nem conectar editor só para enumerar relações estáticas. Quando a confirmação runtime for necessária e autorizada, selecionar as skills Godot correspondentes e as ferramentas realmente disponíveis.

Não ler caches `.godot/` por rotina nem fingir resolver `uid://` sem evidência. Não marcar mapa FRESH como cobertura de GDScript/cenas. Para impacto amplo, indicar os níveis e fronteiras examinados, em vez de prometer grafo completo do projeto.
