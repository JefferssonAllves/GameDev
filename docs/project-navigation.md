# Índice de navegação do projeto

Atualizado em 2026-11-19. Este índice manual complementa o Project Map; não é uma saída do analisador.

## Arquivos e responsabilidades

| Caminho | Responsabilidade | Quando consultar |
| --- | --- | --- |
| `AGENTS.md` | Regras para o agente e catálogo das skills disponíveis na sessão de instalação. | Ao iniciar uma tarefa e escolher uma skill. |
| `.project-map/project-map.md` | Mapa gerado dos arquivos suportados pelo Project Map. | Após validar o manifesto, para localizar código e relações indexados. |
| `.project-map/project-map.manifest.json` | Hashes e cache do analisador. | Pelo script; não editar manualmente. |
| `project.godot` | Configuração atual do projeto: cena principal, ações de entrada, camadas de colisão, renderizador Compatibility e plugin do editor. | Antes de alterar configuração ou diagnosticar compatibilidade; a versão declarada não comprova a versão do editor instalado. |
| `game/arena.tscn`, `game/arena.gd` | Arena de teste, blocos de colisão e câmera lateral. | Montagem e teste de fases. |
| `game/player.tscn`, `game/player.gd` | Personagem reutilizável, movimento no chão e colisão dos pés. | Alterações de movimento e apresentação. |
| `game/enemy.tscn`, `game/enemy.gd` | NPC de patrulha e perseguição pelo piso navegável, animado com `sprites/aleatoria/inimigo.png`. | Ajustes de navegação, detecção e animações do inimigo. |
| `tests/enemy_test.gd` | Teste de patrulha, perseguição em torno da banca e animações. | Alterações no NPC ou na navegação da arena. |
| `game/fire_enemy.tscn`, `game/fire_enemy.gd`, `game/fireball.gd` | Segundo NPC e projétil de fogo. | Ajustes de ataque à distância. |
| `tests/movement_test.gd` | Teste automatizado da arena e do personagem. | Ajustes de física, ação e colisão. |
| `addons/godot_mcp/` | Addon do Godot Editor MCP 2026.10.20.1, com licença. | Integração com Codex e playtest. |
| `docs/level-design.md` | Guia para montar colisões e preencher a arte da fase. | Autoria de fases no editor. |
| `docs/brasil-em-retalho.md` | Proposta de design do beat ’em up 2D, personagens, combate e etapas de desenvolvimento. | Para requisitos de jogo; distinguir propostas de funcionalidades implementadas. |
| `icon.svg` | Ícone do projeto. | Mudanças de identidade visual. |
| `icon.svg.import` | Metadados de importação do ícone pelo Godot. | Problemas específicos da importação; preferir regeneração pelo editor. |
| `README.md` | Apresentação breve do repositório. | Contexto inicial. |
| `.agents/README.md` | Procedência, versões, licenças e requisitos das skills locais. | Instalação, atualização ou diagnóstico das integrações. |
| `.agents/skills/` | Skills locais e suas referências, scripts e modelos. | Abrir somente a skill aplicável e as referências necessárias. |
| `.agents/skills/project-memory/`, `context-optimizer/`, `session-handoff/`, `dependency-navigator/`, `memory-maintenance/` | Cinco procedimentos locais de memória, recuperação de contexto, continuidade e impacto. | Selecionar somente a skill correspondente; referências detalhadas sob demanda. |
| `docs/skills/contexto-e-memoria.md` | Arquitetura, uso, evidências e limites de validação dessas cinco skills. | Revisar o conjunto ou avaliar expectativas de economia de contexto. |
| `.agents/scripts/project_map.py` | Project Map 0.3.0, analisador original em Python. | Executar `check`, `map` e `update`; não implementar um segundo gerador. |
| `.agents/licenses/` | Licenças e avisos dos pacotes locais. | Redistribuição ou atualização das skills. |
| `.codex/config.toml` | Configuração deste projeto para o Codex e servidores Context7/Godot MCP. | Problemas de descoberta ou conexão das ferramentas. |
| `.githooks/` | Importa recursos Godot após atualizações Git usando hooks ativados por clone. | Diagnóstico de sprites ou texturas ausentes após pull. |
| `.editorconfig`, `.gitattributes`, `.gitignore` | Formatação, atributos Git e exclusões. | Mudanças de convenção ou inclusão de novos tipos de arquivo. |

## Estado do jogo

A cena principal é `game/arena.tscn`. O jogador e os obstáculos ficam sob `World`, com ordenação por Y. O movimento usa o chão em dois eixos e mantém a altura visual de salto separada da colisão. Consulte o guia da arena para controles e teste.

## Limites de cobertura

O Project Map 0.3.0 analisa Python, JavaScript/TypeScript, Shell e systemd, além de alguns arquivos de configuração conhecidos. **Não indexa GDScript, cenas/recursos Godot, `project.godot`, Markdown ou SVG.** Neste repositório, o mapa automático descreve principalmente ferramentas auxiliares das skills, não a arquitetura do jogo.

Para esses formatos não cobertos, usar este índice e buscas restritas, por exemplo `rg --files -g '*.gd' -g '*.tscn' -g '*.tres' -g 'project.godot'`. Quando houver resultados, ler somente os arquivos relevantes. Relações como sinais, autoloads, cenas herdadas e recursos precisam ser verificadas no código e no editor.

`FRESH` só confirma os arquivos indexados. Mudanças neste documento, em `AGENTS.md` ou em arquivos Godot podem exigir revisão manual mesmo que o mapa continue `FRESH`. Não incluir `.godot/`, credenciais ou diretórios de cache na exploração rotineira.

Memória e handoffs, quando criados, usam por padrão `.agents/memory/` e `.agents/handoffs/`; não são fatos do jogo antes de existir registro sustentado por fonte. Não carregar todos os registros ao iniciar uma tarefa.
