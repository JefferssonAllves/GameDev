extends SceneTree

var failures := 0


func _initialize() -> void:
	call_deferred("_run")


func _run() -> void:
	change_scene_to_file("res://station.tscn")
	await scene_changed
	var station := current_scene
	var player := station.get_node("Traveler") as CharacterBody2D
	await _ticks(4)
	_check(player.is_on_floor(), "O personagem começa sobre o piso")
	var start := player.position
	Input.action_press("move_right")
	await _ticks(25)
	Input.action_release("move_right")
	await _ticks(9)
	_check(player.position.x > start.x + 55, "O movimento responde à entrada")

	var ground_y := player.position.y
	Input.action_press("jump")
	await _ticks(19)
	var full_height := ground_y - player.position.y
	Input.action_release("jump")
	await _ticks(28)
	Input.action_press("jump")
	await _ticks(3)
	Input.action_release("jump")
	await _ticks(12)
	_check(ground_y - player.position.y < full_height - 20, "Soltar o botão reduz a altura")
	Input.action_press("dash")
	await _ticks(4)
	Input.action_release("dash")
	_check(absf(player.velocity.x) < 300, "O impulso só funciona depois da descoberta")

	player.position = Vector2(1472, 344)
	player.velocity = Vector2.ZERO
	await _ticks(4)
	_check(player.impulse_unlocked, "A brasa desbloqueia o impulso")
	player.position.y = 700
	await _ticks(5)
	_check(player.position.distance_to(Vector2(1472, 344)) < 2, "A queda retorna ao marco da brasa")

	# Parta do terraço direito, mantendo o restante da travessia sob os controles normais.
	player.position = Vector2(526, 325)
	await _ticks(4)
	Input.action_press("move_left")
	await _ticks(8)
	Input.action_press("jump")
	await _ticks(15)
	Input.action_press("dash")
	await _ticks(10)
	Input.action_release("dash")
	Input.action_release("jump")
	_check(player.position.x < 365, "O impulso atravessa o vão entre os terraços")
	await _ticks(45)
	Input.action_release("move_left")
	_check(station.complete, "Alcançar o relé com a brasa conclui a estação")
	print("Estação do Vento: %d falhas" % failures)
	quit(0 if failures == 0 else 1)


func _ticks(count: int) -> void:
	for i in range(count):
		await physics_frame


func _check(condition: bool, description: String) -> void:
	if not condition:
		failures += 1
		push_error(description)
