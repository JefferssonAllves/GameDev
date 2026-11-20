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

O jogador usa a folha em `sprites/aleatoria/`, com fundo ocultado pelo material da cena. Em solo, a pose alterna entre repouso e cinco quadros de caminhada conforme o deslocamento real. No ar, a subida e a descida têm poses distintas. O nó `Visual` controla a altura e o espelhamento, enquanto a colisão continua nos pés.

## NPC de teste

A cena `game/enemy.tscn` usa `sprites/aleatoria/inimigo.png` para repouso e caminhada. O NPC patrulha entre a posição inicial e o deslocamento `patrol_offset`. Ao detectar o jogador, segue um caminho pelo piso e para a cerca de 36 px. Ao perder o alvo de vista por distância, retorna à patrulha. A perseguição serve para testar movimento e ainda não aplica dano.

A arena começa com um NPC próximo ao jogador, à esquerda e mais ao fundo, longe da banca. Use **F5** para abrir a cena principal. **F6** executa a cena selecionada, então selecione `game/arena.tscn` para ver jogador e inimigo juntos.

Para adicionar outro inimigo, instancie a cena diretamente sob `World`, informe o jogador em `target` e escolha um ponto de patrulha dentro da área navegável. Ao redesenhar o piso, ajuste o contorno do `NavigationPolygon` da raiz. Adicione os `StaticBody2D` que bloqueiam passagens ao grupo `navigation_obstacles`. A arena gera a malha a partir desse contorno e das colisões do grupo ao iniciar.

O segundo NPC usa `sprites/aleatoria/inimigo2.png` e atira a cada 1,6 s enquanto o jogador estiver a até 420 px. Cada projétil segue a posição em que o jogador estava no disparo e some ao encontrar uma parede ou o jogador. O acerto dá um flash laranja, sem reduzir vida nesta arena.

## Teste de regressão

Se o personagem sumir depois de um `git pull`, abra o projeto no editor e espere a importação terminar antes de jogar. Fechar e reabrir o editor força uma nova varredura. O PNG vem pelo Git, e o Godot gera a textura em `.godot/imported/` em cada máquina.

Para importar e testar pelo terminal, execute na raiz do repositório.

```sh
godot --headless --editor --path . --import
godot --headless --path . -s res://tests/movement_test.gd
godot --headless --path . -s res://tests/enemy_test.gd
```
