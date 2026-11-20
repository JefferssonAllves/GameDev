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
	arena.get_node("World/FireEnemy").set_physics_process(false)
	var player := arena.get_node("World/Player") as CharacterBody2D
	await _ticks(2)
	var spawn := player.position
	var sprite := player.get_node("Visual/Sprite") as AnimatedSprite2D
	var idle_animation := sprite.animation

	Input.action_press("move_right")
	Input.action_press("move_down")
	await _ticks(20)
	_check(player.position.x > spawn.x and player.position.y > spawn.y, "Movimento diagonal")
	_check(is_equal_approx(player.velocity.length(), 240.0), "Diagonal normalizada")
	_check(sprite.animation != idle_animation, "Movimento usa os quadros de caminhada")
	var walk_frame := sprite.frame
	await _ticks(8)
	_check(sprite.frame != walk_frame, "Caminhada alterna quadros")
	Input.action_release("move_down")
	Input.action_press("run")
	await _ticks(10)
	_check(sprite.animation == &"corrida_e_esquiva" and player.velocity.length() > 240.0, "Corrida acelera e toca a sequência de corrida")
	Input.action_release("run")

	player.position = Vector2(410, 370)
	await _ticks(75)
	_check(absf(player.position.x - 445.0) < 0.3, "Obstáculo bloqueia a passagem")
	Input.action_press("jump")
	await _ticks(5)
	_check(player.get_node("Visual").position.y < 0.0, "Salto desloca o visual")
	_check(absf(player.position.x - 445.0) < 0.3, "Salto preserva a colisão dos pés")
	var rise_frame := sprite.frame
	_check(sprite.animation == &"saltos_e_acrobacias", "Subida usa pose aérea")
	Input.action_release("jump")
	await _ticks(18)
	_check(player.get_node("Visual").position.y < 0.0 and sprite.frame != rise_frame, "Descida usa outra pose aérea")

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
	_check(sprite.animation == idle_animation, "Reinício restaura a pose de repouso")
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

	Input.action_press("reset_arena")
	await _ticks(2)
	Input.action_release("reset_arena")
	var enemy := arena.get_node("World/Enemy") as CharacterBody2D
	enemy.set_physics_process(false)
	enemy.position = spawn + Vector2(46, 0)
	var enemy_start := enemy.position
	Input.action_press("kick")
	await _ticks(3)
	Input.action_release("kick")
	_check(sprite.animation == &"ginga_e_chutes", "Chute toca a sequência de ataque")
	await _ticks(30)
	_check(enemy.position.x > enemy_start.x, "Chute empurra um inimigo próximo à frente")

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
