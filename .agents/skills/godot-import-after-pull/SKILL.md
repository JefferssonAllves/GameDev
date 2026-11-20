---
name: godot-import-after-pull
description: Use quando um pull trouxer imagens, sprites ou outros recursos do Godot, ao preparar um clone novo ou quando faltar uma textura importada em .godot/imported.
---

# Importação de recursos do Godot após o pull

O Git entrega os arquivos-fonte. O Godot gera o cache `.godot/` em cada clone.

1. Na raiz do projeto, confira `git config --get core.hooksPath`.
2. Se o caminho estiver vazio, execute `sh .githooks/setup` com o Godot 4.7 disponível no PATH como `godot` ou `godot4`. No Windows, use Git Bash. A configuração é feita uma vez por clone. Se houver outro caminho de hooks, preserve-o e informe o conflito.
3. Com `.githooks` ativo, pulls que atualizam a branch por merge ou rebase executam a importação. Espere o comando terminar e confira a saída. Um pull bem-sucedido por si só não comprova a importação.
4. Para atualizar um cache já desatualizado, execute `sh .githooks/import-godot`. Se aparecer erro, confira o caminho e a capitalização do recurso versionado e rode novamente após corrigir a causa.
5. Valide carregando a cena afetada ou executando seu teste. Ao publicar arte, inclua os arquivos-fonte, as referências e os metadados de importação necessários. Mantenha `.godot/` fora do Git.
