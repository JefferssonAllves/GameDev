extends CharacterBody2D

const WALK_FRAME_X := [72, 124, 176, 228, 280]
const WALK_FPS := 10.0
const RISE_FRAME := Rect2(332, 114, 42, 46)
const FALL_FRAME := Rect2(384, 114, 42, 46)

@export var ground_speed := 240.0
@export var acceleration := 2100.0
@export var dash_speed := 520.0
@export var dash_duration := 0.15
@export var dash_recovery := 0.24
@export var jump_speed := 340.0
@export var jump_gravity := 1150.0

@onready var visual: Node2D = $Visual
@onready var sprite: Sprite2D = $Visual/Sprite
@onready var idle_frame := sprite.region_rect
@onready var spawn := position

var facing := 1.0
var dash_direction := Vector2.ZERO
var dash_remaining := 0.0
var recovery_remaining := 0.0
var jump_height := 0.0
var vertical_speed := 0.0
var walk_time := 0.0


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("reset_arena"):
		_reset()
		return

	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	recovery_remaining = maxf(recovery_remaining - delta, 0.0)

	if dash_remaining <= 0.0:
		if not is_zero_approx(direction.x):
			facing = signf(direction.x)
		if Input.is_action_just_pressed("dash") and recovery_remaining <= 0.0 and jump_height <= 0.0:
			dash_direction = direction.normalized() if direction != Vector2.ZERO else Vector2(facing, 0.0)
			dash_remaining = dash_duration
			recovery_remaining = dash_duration + dash_recovery

	if dash_remaining > 0.0:
		velocity = dash_direction * dash_speed
		dash_remaining = maxf(dash_remaining - delta, 0.0)
	else:
		velocity = velocity.move_toward(direction * ground_speed, acceleration * delta)

	if Input.is_action_just_pressed("jump") and jump_height <= 0.0 and dash_remaining <= 0.0:
		vertical_speed = jump_speed
	if jump_height > 0.0 or vertical_speed > 0.0:
		vertical_speed -= jump_gravity * delta
		jump_height = maxf(jump_height + vertical_speed * delta, 0.0)
		if jump_height == 0.0:
			vertical_speed = 0.0

	visual.position.y = -jump_height
	visual.scale.x = facing
	move_and_slide()
	_update_sprite(delta)


func _update_sprite(delta: float) -> void:
	if jump_height > 0.0:
		walk_time = 0.0
		sprite.region_rect = RISE_FRAME if vertical_speed > 0.0 else FALL_FRAME
	elif get_real_velocity().length_squared() > 1.0:
		var frame := int(walk_time * WALK_FPS)
		sprite.region_rect = Rect2(WALK_FRAME_X[frame], 114, 42, 43)
		walk_time = fposmod(walk_time + delta, WALK_FRAME_X.size() / WALK_FPS)
	else:
		walk_time = 0.0
		sprite.region_rect = idle_frame


func _reset() -> void:
	position = spawn
	velocity = Vector2.ZERO
	facing = 1.0
	dash_remaining = 0.0
	recovery_remaining = 0.0
	jump_height = 0.0
	vertical_speed = 0.0
	visual.position.y = 0.0
	visual.scale.x = 1.0
	walk_time = 0.0
	sprite.region_rect = idle_frame
	reset_physics_interpolation()


func show_fire_hit() -> void:
	visual.modulate = Color(1.0, 0.45, 0.2)
	create_tween().tween_property(visual, "modulate", Color.WHITE, 0.2)
