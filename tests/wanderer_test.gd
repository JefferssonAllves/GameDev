extends SceneTree


func _initialize() -> void:
	call_deferred("_run")


func _run() -> void:
	var arena := (load("res://game/arena.tscn") as PackedScene).instantiate()
	root.add_child(arena)
	var wanderer := arena.get_node_or_null("World/Wanderer") as CharacterBody2D
	if wanderer == null:
		push_error("A arena deve conter o NPC errante.")
		quit(1)
		return

	var sprite := wanderer.get_node("Sprite") as AnimatedSprite2D
	var start := wanderer.position
	var moved_away := false
	var walk_frames := {}
	for tick in range(1800):
		await physics_frame
		await process_frame
		moved_away = moved_away or start.distance_to(wanderer.position) > 35.0
		if sprite.animation == &"walk":
			walk_frames[sprite.frame] = true
		if moved_away and walk_frames.size() > 1 and sprite.animation == &"idle":
			print("NPC errante se desloca, anima a caminhada e faz pausas.")
			quit()
			return

	push_error("O NPC deve sair do ponto inicial, avançar os quadros e fazer pausas.")
	quit(1)
