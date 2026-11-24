extends SceneTree

func _initialize() -> void:
	call_deferred("_run")

func _run() -> void:
	var arena := (load("res://game/arena.tscn") as PackedScene).instantiate()
	var npc := (load("res://game/enemy.tscn") as PackedScene).instantiate() as CharacterBody2D
	var player := arena.get_node("World/Player") as CharacterBody2D
	npc.position = Vector2(680, 370)
	npc.target = player
	arena.get_node("World").add_child(npc)
	root.add_child(arena)
	await _ticks(3)
	var sprite := npc.get_node("Sprite") as AnimatedSprite2D
	var start := npc.position
	await _ticks(30)
	if npc.position.distance_to(start) < 12 or sprite.animation != &"walk":
		push_error("O inimigo deve patrulhar e animar a caminhada.")
		quit(1)
		return
	player.position = Vector2(360, 370)
	await _ticks(230)
	var distance := npc.position.distance_to(player.position)
	if distance > 44 or distance < 25 or sprite.animation != &"idle":
		push_error("O inimigo deve contornar a banca e parar perto do jogador. Distância %s, posição %s, animação %s" % [distance, npc.position, sprite.animation])
		quit(1)
		return
	player.position = Vector2(1200, 300)
	await _ticks(230)
	if npc.position.distance_to(start) > 155 or sprite.animation != &"walk":
		push_error("O inimigo deve retornar à patrulha quando perde o alvo.")
		quit(1)
		return
	print("Patrulha, perseguição, obstáculos e animações verificados.")
	quit()

func _ticks(count: int) -> void:
	for index in range(count):
		await physics_frame
		await process_frame
