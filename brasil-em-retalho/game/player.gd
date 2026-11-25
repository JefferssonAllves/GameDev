extends CharacterBody2D

@export var ground_speed := 240.0
@export var acceleration := 2100.0
@export var dash_speed := 520.0
@export var dash_duration := 0.15
@export var dash_recovery := 0.24
@export var jump_speed := 340.0
@export var jump_gravity := 1150.0

@onready var visual: Node2D = $Visual
@onready var sprite: AnimatedSprite2D = $Visual/Sprite
@onready var spawn := position

var facing := 1.0
var dash_direction := Vector2.ZERO
var dash_remaining := 0.0
var recovery_remaining := 0.0
var jump_height := 0.0
var landing_remaining := 0.0
var vertical_speed := 0.0
var move_clip: StringName = &""
var strike_pending := false
var dodge_clip: StringName = &"esquiva_frente"


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("reset_arena"):
		_reset()
		return

	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	recovery_remaining = maxf(recovery_remaining - delta, 0.0)

	var running := Input.is_action_pressed("run")
	if dash_remaining <= 0.0 and move_clip == &"":
		if not is_zero_approx(direction.x):
			facing = signf(direction.x)
		if Input.is_action_just_pressed("dash") and recovery_remaining <= 0.0 and jump_height <= 0.0:
			dash_direction = direction.normalized() if direction != Vector2.ZERO else Vector2(facing, 0.0)
			dodge_clip = &"role" if running else &"esquiva_frente"
			dash_remaining = dash_duration
			recovery_remaining = dash_duration + dash_recovery

	if move_clip == &"" and dash_remaining <= 0.0:
		_read_move_inputs(running)

	if dash_remaining > 0.0:
		velocity = dash_direction * dash_speed
		dash_remaining = maxf(dash_remaining - delta, 0.0)
	else:
		var speed := ground_speed * (1.45 if running else 1.0)
		var desired := direction * speed if move_clip == &"" or jump_height > 0.0 else Vector2.ZERO
		velocity = velocity.move_toward(desired, acceleration * delta)

	landing_remaining = maxf(landing_remaining - delta, 0.0)
	if Input.is_action_just_pressed("jump") and jump_height <= 0.0 and dash_remaining <= 0.0 and move_clip == &"":
		landing_remaining = 0.0
		vertical_speed = jump_speed
	if jump_height > 0.0 or vertical_speed > 0.0:
		vertical_speed -= jump_gravity * delta
		jump_height = maxf(jump_height + vertical_speed * delta, 0.0)
		if jump_height == 0.0:
			vertical_speed = 0.0
			landing_remaining = 0.10

	visual.position.y = -jump_height
	visual.scale.x = facing
	move_and_slide()
	_update_sprite()


func _read_move_inputs(running: bool) -> void:
	if Input.is_action_just_pressed("kick"):
		if jump_height > 0.0:
			_start_move(&"chute_aereo", true)
		else:
			_start_move(&"armada" if running else &"meia_lua", true)
	elif jump_height <= 0.0:
		if Input.is_action_just_pressed("sweep"):
			_start_move(&"queixada", true)
		elif Input.is_action_just_pressed("acrobatics"):
			_start_move(&"au", false)


func _start_move(clip: StringName, strikes: bool) -> void:
	move_clip = clip
	strike_pending = strikes
	sprite.speed_scale = 1.0
	sprite.play(clip, 1.4)
	sprite.set_frame_and_progress(0, 0.0)


func _update_sprite() -> void:
	if move_clip != &"":
		if strike_pending and sprite.frame >= sprite.sprite_frames.get_frame_count(move_clip) / 2:
			strike_pending = false
			_strike()
		if sprite.is_playing():
			return
		move_clip = &""
	if jump_height > 0.0:
		sprite.play(&"pular")
		sprite.pause()
		var relative_speed := vertical_speed / jump_speed
		if relative_speed > 0.30:
			sprite.frame = 0
		elif relative_speed >= -0.25:
			sprite.frame = 1
		elif relative_speed >= -0.72:
			sprite.frame = 2
		else:
			sprite.frame = 3
	elif dash_remaining > 0.0:
		sprite.play(dodge_clip)
		sprite.pause()
		var last := sprite.sprite_frames.get_frame_count(dodge_clip) - 1
		sprite.frame = clampi(roundi((1.0 - dash_remaining / dash_duration) * last), 0, last)
	elif landing_remaining > 0.0:
		sprite.speed_scale = 1.0
		sprite.play(&"aterrissar")
	else:
		var speed := get_real_velocity().length()
		var clip: StringName = &"correr" if speed > 1.0 else &"repouso"
		if sprite.animation != clip or not sprite.is_playing():
			sprite.play(clip)
		sprite.speed_scale = clampf(speed / (ground_speed * 1.45), 0.65, 1.15) if clip == &"correr" else 1.0


func _strike() -> void:
	for enemy in get_tree().get_nodes_in_group("capoeira_targets"):
		var offset: Vector2 = enemy.global_position - global_position
		if offset.x * facing >= 0.0 and absf(offset.x) <= 85.0 and absf(offset.y) <= 32.0:
			enemy.move_and_collide(Vector2(facing * 24.0, 0.0))


func _reset() -> void:
	position = spawn
	velocity = Vector2.ZERO
	facing = 1.0
	dash_remaining = 0.0
	recovery_remaining = 0.0
	jump_height = 0.0
	landing_remaining = 0.0
	vertical_speed = 0.0
	visual.position.y = 0.0
	visual.scale.x = 1.0
	move_clip = &""
	strike_pending = false
	sprite.speed_scale = 1.0
	sprite.play(&"repouso")
	sprite.set_frame_and_progress(0, 0.0)
	reset_physics_interpolation()


func show_fire_hit() -> void:
	if jump_height <= 0.0 and dash_remaining <= 0.0:
		_start_move(&"queda", false)
	visual.modulate = Color(1.0, 0.45, 0.2)
	create_tween().tween_property(visual, "modulate", Color.WHITE, 0.2)
