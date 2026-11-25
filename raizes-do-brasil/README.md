# Raízes do Brasil · Estação do Vento

Abra `project.godot` no Godot 4.7.2 e pressione **F5**. Pelo terminal, na raiz do repositório, execute `godot --path .`.

| Ação | Teclado | Controle |
| --- | --- | --- |
| Mover | A / D | Analógico esquerdo |
| Saltar | Espaço | Botão inferior |
| Impulso no ar após obter a brasa | Shift | Botão direito |
| Voltar ao marco | R | Botão superior |

Siga à direita até a brasa. Volte pelo terraço intermediário e use o impulso para alcançar o relé à esquerda. Segure o salto para ir mais alto.

A demonstração é solo e usa arte geométrica provisória. O progresso dura a partida atual.

## Teste automatizado

```sh
godot --headless --editor --path . --import
godot --headless --path . --fixed-fps 60 -s res://raizes-do-brasil/tests/station_test.gd
```
