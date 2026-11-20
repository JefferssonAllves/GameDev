extends SceneTree

var failures := 0


func _initialize() -> void:
	call_deferred("_run")


func _run() -> void:
	var scene := load("res://game/arena.tscn") as PackedScene
	if scene == null:
		_check(false, "A cena de teste deve existir")
		quit(1)
		return

	var arena := scene.instantiate()
	root.add_child(arena)
	var player := arena.get_node("World/Player") as CharacterBody2D
	await _ticks(2)
	var spawn := player.position

	Input.action_press("move_right")
	Input.action_press("move_down")
	await _ticks(20)
	_check(player.position.x > spawn.x and player.position.y > spawn.y, "Movimento diagonal")
	_check(is_equal_approx(player.velocity.length(), 240.0), "Diagonal normalizada")
	Input.action_release("move_down")

	player.position = Vector2(410, 370)
	await _ticks(75)
	_check(absf(player.position.x - 445.0) < 0.3, "Obstáculo bloqueia a passagem")
	Input.action_press("jump")
	await _ticks(5)
	_check(player.get_node("Visual").position.y < 0.0, "Salto desloca o visual")
	_check(absf(player.position.x - 445.0) < 0.3, "Salto preserva a colisão dos pés")
	Input.action_release("jump")

	Input.action_press("move_up")
	await _ticks(110)
	_check(player.position.x > 585, "É possível contornar o obstáculo")
	_check(absf(player.position.y - 249.0) < 0.3, "Parede superior contém o jogador")
	Input.action_release("move_up")
	Input.action_release("move_right")

	Input.action_press("reset_arena")
	await _ticks(2)
	Input.action_release("reset_arena")
	_check(player.position.is_equal_approx(spawn), "Reinício restaura a posição")
	Input.action_press("dash")
	await _ticks(4)
	_check(player.position.x > spawn.x + 22, "Esquiva acelera na direção do personagem")
	Input.action_release("dash")
	await _ticks(45)
	_check(player.velocity.is_zero_approx(), "Esquiva termina sem deslize contínuo")

	player.position = Vector2(425, 370)
	Input.action_press("dash")
	await _ticks(12)
	Input.action_release("dash")
	_check(absf(player.position.x - 445.0) < 0.3, "Esquiva também colide com a banca")

	print("Movimentação e colisões: %d falhas" % failures)
	quit(0 if failures == 0 else 1)


func _ticks(count: int) -> void:
	for index in range(count):
		await physics_frame
		await process_frame


func _check(condition: bool, description: String) -> void:
	if not condition:
		failures += 1
		push_error(description)
