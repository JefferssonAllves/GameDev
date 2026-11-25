# Raízes do Brasil · Estação do Vento

Abra `project.godot` no Godot 4.7.2 e pressione **F5** para abrir o menu. Pelo terminal, na raiz do repositório, execute `godot --path .`.

| Ação | Teclado | Controle |
| --- | --- | --- |
| Mover | A / D | Analógico esquerdo |
| Saltar | Espaço | Botão inferior |
| Impulso no ar após obter a brasa | Shift | Botão direito |
| Chutar | J | Botão esquerdo |
| Interagir com o relé | E | Ombro esquerdo |
| Voltar ao marco | R | Botão superior |

Siga à direita até a brasa. Volte pelo terraço intermediário e use o impulso para alcançar o relé à esquerda. Segure o salto para ir mais alto.

Ao religar o relé, pressione **E** para abrir a Casa das Comportas. O Guardião lança ondas com aviso no chão e expõe o núcleo após cada sequência. Salte sobre as ondas e chute o núcleo aberto. Cada fase aumenta a quantidade e a velocidade das ondas. **R** reinicia o duelo.

Este primeiro arco usa arte geométrica provisória. Para jogar em dupla, conecte um controle antes de iniciar e ative **Cooperativo local** no menu. P1 usa o teclado e P2 usa o controle. A câmera acompanha o ponto médio da dupla, o impulso é compartilhado e ambos precisam chegar ao relé para abrir a Casa das Comportas. Próximo a um aliado derrubado, segure **E / LB** por dois segundos para reanimá-lo. A dupla tem dez segundos para o resgate. O menu oferece **Novo jogo** e **Continuar**. O progresso é salvo ao obter a brasa, religar o relé, entrar na Casa das Comportas e derrotar o Guardião. Continuar antes da vitória na Casa das Comportas reinicia o duelo.

## Teste automatizado

```sh
godot --headless --editor --path . --import
godot --headless --path . --fixed-fps 60 -s res://raizes-do-brasil/tests/station_test.gd
```
