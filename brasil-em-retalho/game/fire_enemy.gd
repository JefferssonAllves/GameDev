extends CharacterBody2D

const Fireball := preload("res://game/fireball.gd")
const CHASE_SPEED := 105.0
const ATTACK_RANGE := 225.0
const DETECTION_RANGE := 460.0
const CHASE_TIME := 0.8
const WINDUP_TIME := 0.4
const RECOVERY_TIME := 0.35

const IDLE := Rect2(6, 37, 20, 31)
const WALK := [
	Rect2(30, 37, 21, 31), Rect2(53, 37, 21, 31), Rect2(76, 37, 21, 31),
	Rect2(101, 37, 20, 31), Rect2(214, 37, 19, 31), Rect2(235, 37, 19, 31),
	Rect2(258, 37, 22, 31), Rect2(282, 37, 21, 31),
]
const WINDUP := [Rect2(125, 37, 25, 31), Rect2(178, 41, 32, 27)]
const RELEASE := [Rect2(154, 43, 20, 25), Rect2(305, 37, 21, 31), Rect2(328, 37, 20, 31)]

@export var target: CharacterBody2D

@onready var sprite: Sprite2D = $Sprite
@onready var navigation: NavigationAgent2D = $NavigationAgent2D

var chase_left := CHASE_TIME
var attack_time := -1.0
var walk_time := 0.0


func _physics_process(delta: float) -> void:
	if not is_instance_valid(target):
		attack_time = -1.0
		_show_pose(IDLE)
		return

	var aim := global_position.direction_to(target.global_position)
	var distance := global_position.distance_to(target.global_position)
	if attack_time >= 0.0:
		_update_attack(delta, aim)
		return
	if distance > DETECTION_RANGE:
		_show_pose(IDLE)
		return

	chase_left -= delta
	if chase_left <= 0.0 and distance <= ATTACK_RANGE and aim != Vector2.ZERO:
		var ray := PhysicsRayQueryParameters2D.create(global_position, target.global_position, 1)
		if get_world_2d().direct_space_state.intersect_ray(ray).is_empty():
			attack_time = 0.0
			_face(aim)
			_show_pose(WINDUP[0])
			return
	_chase(delta)


func _chase(delta: float) -> void:
	if NavigationServer2D.map_get_iteration_id(navigation.get_navigation_map()) == 0:
		return
	if navigation.target_position.distance_squared_to(target.global_position) > 64.0:
		navigation.target_position = target.global_position
	var waypoint := navigation.get_next_path_position()
	velocity = ((waypoint - global_position) / delta).limit_length(CHASE_SPEED)
	move_and_slide()
	var movement := get_real_velocity()
	if movement.length_squared() <= 1.0:
		_show_pose(IDLE)
		return
	_face(movement)
	walk_time += delta
	_show_pose(WALK[int(walk_time * 12.0) % WALK.size()])


func _update_attack(delta: float, aim: Vector2) -> void:
	var previous_time := attack_time
	attack_time += delta
	if previous_time < WINDUP_TIME:
		_face(aim)
		if attack_time >= WINDUP_TIME and aim != Vector2.ZERO:
			var fireball := Fireball.new()
			fireball.direction = aim
			fireball.material = sprite.material
			fireball.texture_filter = TEXTURE_FILTER_NEAREST
			fireball.position = position
			get_parent().add_child(fireball)
	if attack_time < WINDUP_TIME:
		_show_pose(WINDUP[int(attack_time * WINDUP.size() / WINDUP_TIME)])
	elif attack_time < WINDUP_TIME + RECOVERY_TIME:
		var frame := int((attack_time - WINDUP_TIME) * RELEASE.size() / RECOVERY_TIME)
		_show_pose(RELEASE[mini(frame, RELEASE.size() - 1)])
	else:
		attack_time = -1.0
		chase_left = CHASE_TIME


func _face(direction: Vector2) -> void:
	if absf(direction.x) > 0.01:
		sprite.flip_h = direction.x < 0.0


func _show_pose(region: Rect2) -> void:
	sprite.region_rect = region
	sprite.position.y = -region.size.y * sprite.scale.y / 2.0
