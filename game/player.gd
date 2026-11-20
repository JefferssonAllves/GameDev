extends CharacterBody2D

@export var ground_speed := 240.0
@export var acceleration := 2100.0
@export var dash_speed := 520.0
@export var dash_duration := 0.15
@export var dash_recovery := 0.24
@export var jump_speed := 340.0
@export var jump_gravity := 1150.0

@onready var visual: Node2D = $Visual
@onready var spawn := position

var facing := 1.0
var dash_direction := Vector2.ZERO
var dash_remaining := 0.0
var recovery_remaining := 0.0
var jump_height := 0.0
var vertical_speed := 0.0


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
	reset_physics_interpolation()
