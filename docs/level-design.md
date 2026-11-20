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

## Teste de regressão

```sh
godot --headless --path . -s res://tests/movement_test.gd
```
