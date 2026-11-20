# Brasil em Retalho

Beat ’em up 2D de fantasia brasileira. O [documento de design](docs/brasil-em-retalho.md) reúne o elenco, as regras de combate e as etapas de desenvolvimento.

## Trabalhar no projeto com Codex

1. Clone o repositório ou atualize sua cópia para a branch que contém o projeto.
2. Instale Godot 4.4 ou posterior, Python 3.11 ou posterior e `uv`. Confirme que `uvx --version` funciona no mesmo ambiente em que você abre o Codex.
3. Abra a raiz do repositório em uma nova sessão do Codex e marque o projeto como confiável se solicitado. As habilidades são lidas de `.agents/skills/` e o servidor Godot Editor MCP é configurado em `.codex/config.toml`.
4. Confira com `codex mcp list` se `godot-mcp` está habilitado. Com o projeto Godot aberto e o plugin ativo, peça ao Codex para executar `godot_health_check` e conferir se a conexão com o editor está ativa.

## Integração prevista para o primeiro protótipo

Ao criar o `project.godot`, incluir no Git o addon da mesma versão do servidor configurado no Codex, com a licença correspondente, e registrá-lo como ativo nas configurações do projeto. Assim, quem clonar o repositório recebe as habilidades, a configuração do servidor e o addon juntos.

A entrega inclui testar a conexão local, inspecionar uma cena e capturar uma imagem do jogo rodando. Até o projeto Godot existir, a verificação disponível é a inicialização do servidor MCP.

Veja a [origem das habilidades e os requisitos dos servidores](.agents/README.md).
