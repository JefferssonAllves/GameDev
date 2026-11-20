extends CharacterBody2D

@export var walk_speed := 75.0
@export var pause_duration := 0.7

@onready var navigation: NavigationAgent2D = $NavigationAgent2D
@onready var sprite: AnimatedSprite2D = $Sprite

var waiting := true
var pause_remaining := 0.0


func _physics_process(delta: float) -> void:
	var map := navigation.get_navigation_map()
	if NavigationServer2D.map_get_iteration_id(map) == 0:
		return

	if waiting:
		pause_remaining -= delta
		if pause_remaining > 0.0:
			return
		navigation.target_position = NavigationServer2D.map_get_random_point(
			map, navigation.navigation_layers, true
		)
		waiting = false

	if navigation.is_navigation_finished():
		velocity = Vector2.ZERO
		waiting = true
		pause_remaining = pause_duration
		sprite.play(&"idle")
		return

	var waypoint := navigation.get_next_path_position()
	velocity = ((waypoint - global_position) / delta).limit_length(walk_speed)
	move_and_slide()

	var movement := get_real_velocity()
	if absf(movement.x) > 1.0:
		sprite.flip_h = movement.x < 0.0
	if movement.length_squared() > 1.0:
		sprite.play(&"walk")
	else:
		sprite.play(&"idle")
