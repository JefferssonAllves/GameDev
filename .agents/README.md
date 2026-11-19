# Skills locais do projeto

Instaladas em `.agents/skills/`, sem alterações em `~/.agents`, `~/.codex` ou outros projetos. Os arquivos auxiliares e referências de cada skill foram preservados. Licenças e avisos ficam em `.agents/licenses/`.

| Pacote | Commit de origem | Conteúdo |
| --- | --- | --- |
| Superpowers | [22f0b463e7a5](https://github.com/obra/superpowers/tree/22f0b463e7a5e579904dd6211a520321035526f7) | Todas as 15 skills de `skills/` |
| Context7 | [f1872ebb2f3d](https://github.com/upstash/context7/tree/f1872ebb2f3d943b293bb86fdc0c2905988820d9) | `skills/context7-mcp` |
| Godot MCP | [c62050c2b9b7](https://github.com/hybridindie/godot-mcp/tree/c62050c2b9b7b43fd559c6626f407c85a6ab1527) | As três skills de `skills/`, release estável `2026.10.20.1` |
| Game Feel | [c6ca6c41c839](https://github.com/gamedev-skills/awesome-gamedev-agent-skills/tree/c6ca6c41c839b68319ffc08430b99ab768debc32) | `skills/disciplines/game-feel` |

## Uso

Reabra o projeto no Codex para carregar as skills. A configuração dos servidores MCP fica em `.codex/config.toml` e só é carregada em projetos confiáveis. Nenhuma credencial é versionada.

- **Context7:** servidor remoto oficial. Caso o serviço exija autenticação ou aplique limites, autentique pelo cliente; não grave tokens no Git.
- **Godot MCP:** requer Python 3.11+ e `uv` no PATH. `uvx` resolve a versão fixada no cache ao iniciar, sem instalação global do pacote. Para controlar o editor, instale o addon da mesma release no projeto e ative-o em Project Settings → Plugins. As skills e a configuração MCP não substituem esse addon. Instruções: https://github.com/hybridindie/godot-mcp/tree/2026.10.20.1#quick-start

## Pendências de origem

`player-movement-2d` e `combat-movement` não foram encontradas com esses nomes exatos. Aguardam os links de origem; nenhuma skill de nome parecido foi instalada no lugar delas.
