extends CharacterBody2D

@export var target: Node2D
@export var patrol_offset := Vector2(120, 0)
@export var patrol_speed := 85.0
@export var chase_speed := 145.0
@export var detection_radius := 395.0
@export var lose_radius := 500.0
@export var stop_distance := 36.0

@onready var origin := global_position
@onready var navigation: NavigationAgent2D = $NavigationAgent2D
@onready var sprite: AnimatedSprite2D = $Sprite

var chasing := false
var patrol_outbound := true
var repath_time := 0.0


func _physics_process(delta: float) -> void:
	if NavigationServer2D.map_get_iteration_id(navigation.get_navigation_map()) == 0:
		return

	var was_chasing := chasing
	var distance := global_position.distance_to(target.global_position) if is_instance_valid(target) else INF
	chasing = distance <= (lose_radius if chasing else detection_radius)
	repath_time -= delta
	var destination := origin + patrol_offset if patrol_outbound else origin

	if chasing:
		destination = target.global_position
		if absf(destination.x - global_position.x) > 1.0:
			sprite.flip_h = destination.x < global_position.x
	elif global_position.distance_to(destination) <= navigation.target_desired_distance:
		patrol_outbound = not patrol_outbound
		destination = origin + patrol_offset if patrol_outbound else origin
		repath_time = 0.0

	if was_chasing != chasing or repath_time <= 0.0:
		if navigation.target_position.distance_squared_to(destination) > 16.0 or was_chasing != chasing:
			navigation.target_position = destination
		repath_time = 0.15

	velocity = Vector2.ZERO
	if not navigation.is_navigation_finished() and (not chasing or distance > stop_distance):
		var waypoint := navigation.get_next_path_position()
		velocity = ((waypoint - global_position) / delta).limit_length(chase_speed if chasing else patrol_speed)

	move_and_slide()
	var movement := get_real_velocity()
	if movement.length_squared() > 1.0:
		if absf(movement.x) > 1.0:
			sprite.flip_h = movement.x < 0.0
		sprite.play(&"walk")
	else:
		sprite.play(&"idle")
