# Arena de teste da Feira da Virada

Abra `game/arena.tscn` no Godot e pressione **F6** para testar a arena. A cena também abre com **F5**.

| Ação | Teclado | Controle |
| --- | --- | --- |
| Movimento lateral e em profundidade | WASD ou setas | Analógico esquerdo ou direcional |
| Saltar | Espaço | A |
| Esquivar | Shift | B |
| Voltar ao ponto inicial | R | Start |

## Montar uma fase no editor

1. Duplique `game/arena.tscn` e abra a cópia. Mantenha o personagem diretamente sob `World`, que tem ordenação por Y.
2. Dentro de `World`, duplique uma parede ou obstáculo para criar um novo bloqueio. Cada bloqueio é um `StaticBody2D` na camada **Cenário** com um filho `CollisionPolygon2D`. Edite os pontos do polígono no viewport para desenhar a base que toca o chão.
3. Para mobília que precisa ocultar ou revelar o jogador conforme sua posição, ponha a origem do corpo na borda frontal da base. A arte vai em `Visual`, filho desse corpo. Os pés do jogador e essa origem determinam o que aparece na frente. Para piso e fachadas de fundo, use `Backdrop`.
4. Mantenha o início do jogador em uma área livre. Se mudar a largura da fase, ajuste `limit_left` e `limit_right` na câmera junto com as paredes laterais.
5. Execute com **Debug → Visible Collision Shapes**. Teste a passagem pelos dois lados dos obstáculos e confira os corredores com a área dos pés do jogador. Na arena atual, o retângulo dos pés mede 30 × 18 px. O salto e a esquiva continuam respeitando os bloqueios da fase.

A banca e o caixote demonstram a separação. É possível ocultar ou trocar seus nós `Visual` mantendo os polígonos físicos. A instância de `game/player.tscn` permite ajustar velocidade, aceleração, salto e esquiva pelo Inspetor.

## NPC de teste

A cena `game/enemy.tscn` usa `sprites/aleatoria/inimigo.png` para repouso e caminhada. O NPC patrulha entre a posição inicial e o deslocamento `patrol_offset`. Ao detectar o jogador, segue um caminho pelo piso e para a cerca de 36 px. Ao perder o alvo de vista por distância, retorna à patrulha. A perseguição serve para testar movimento e ainda não aplica dano.

A arena começa com um NPC próximo ao jogador, à esquerda e mais ao fundo, longe da banca. Use **F5** para abrir a cena principal. **F6** executa a cena selecionada, então selecione `game/arena.tscn` para ver jogador e inimigo juntos.

Para adicionar outro inimigo, instancie a cena diretamente sob `World`, informe o jogador em `target` e escolha um ponto de patrulha dentro da área navegável. Ao redesenhar o piso, ajuste o contorno do `NavigationPolygon` da raiz. Adicione os `StaticBody2D` que bloqueiam passagens ao grupo `navigation_obstacles`. A arena gera a malha a partir desse contorno e das colisões do grupo ao iniciar.

O segundo NPC usa a folha `sprites/aleatoria/inimigo2.png`. Ele detecta o jogador a até 460 px, persegue pelo caminho navegável e prepara o disparo a até 225 px quando tem linha de visão. A folha fornece poses de repouso, oito quadros de perseguição, duas poses de preparação, três de disparo e recuperação e três quadros para a bola de fogo. O NPC para durante o ataque e retoma a perseguição após se recuperar. O projétil mantém a direção do disparo e o acerto dá um flash laranja.

A cena `game/wanderer.tscn` usa a folha fornecida em `sprites/aleatoria/mario.png` para repouso e caminhada. É um NPC neutro que escolhe destinos aleatórios na malha da arena e faz uma pausa ao chegar. Ele contorna os obstáculos e muda o lado do sprite conforme anda. Instancie sob `World` e ajuste `walk_speed` e `pause_duration` no Inspetor.

O Nerd (`game/reader.tscn`) fica parado à direita da banca com o livro aberto. A animação de leitura inclina levemente a pose em torno dos pés e repete a cada 2,4 s. A folha `sprites/aleatoria/nerd.png` preserva os créditos de seus sprites originais e da edição no cabeçalho.

O Capoeirista é o jogador. A folha `sprites/aleatoria/Sprite Sheet de Capoeira em Pixel Art.webp` fornece as poses de repouso, corrida, ataques e salto. Parado, o jogador usa a fileira de repouso. Qualquer deslocamento no chão usa a fileira de corrida, com cadência ajustada à velocidade. Segure **Ctrl / clique no analógico esquerdo** para correr. **Espaço / A** percorre a fileira de salto conforme a velocidade vertical. **Shift / B** esquiva e, com corrida, rola.

| Ação | Teclado | Controle |
| --- | --- | --- |
| Chute. No ar, chute aéreo. Com corrida, chute giratório. | J | X |
| Queixada com o efeito de empurrão da rasteira | K | Y |
| Acrobacia com quadros do salto | L | LB |

Chute e queixada empurram os inimigos próximos à frente. Um projétil de fogo no chão ativa a queda e a levantada e interrompe o golpe atual. A arena ainda não tem sistema de vida.

## Teste de regressão

Se o personagem sumir depois de um `git pull`, abra o projeto no editor e espere a importação terminar antes de jogar. Para automatizar a importação de recursos como `inimigo2.png` após atualizações pelo Git, ative os hooks seguindo o [README](../README.md). O PNG vem pelo Git, e o Godot gera a textura em `.godot/imported/` em cada máquina.

Se o log citar `mario.png` seguido de um erro em `wanderer.tscn`, confira se `git config --local --get core.hooksPath` retorna `.githooks`. Neste caso, o PNG estava versionado e faltava a textura gerada. Executar `sh .githooks/setup` corrigiu o clone afetado. Em um segundo clone, um `git pull --ff-only` importou o PNG automaticamente e o teste do NPC errante passou.

Para importar e testar pelo terminal, execute na raiz do repositório.

```sh
godot --headless --editor --path . --import
godot --headless --path . -s res://tests/movement_test.gd
godot --headless --path . -s res://tests/enemy_test.gd
godot --headless --path . --fixed-fps 60 -s res://tests/wanderer_test.gd
```
