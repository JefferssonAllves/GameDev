extends CharacterBody2D

const SPEED := 230.0
const GRAVITY := 1500.0
const JUMP := 480.0

var facing := 1.0
var impulse_unlocked := false
var _impulse_available := false
var _dash_left := 0.0
var _coyote_time := 0.0
var _jump_buffer := 0.0
var _stride := 0.0


func _physics_process(delta: float) -> void:
	var grounded := is_on_floor()
	var direction := Input.get_axis("move_left", "move_right")
	_coyote_time = 0.10 if grounded else maxf(0.0, _coyote_time - delta)
	_jump_buffer = 0.12 if Input.is_action_just_pressed("jump") else maxf(0.0, _jump_buffer - delta)
	if grounded:
		_impulse_available = true
	if _dash_left <= 0.0:
		if not is_zero_approx(direction):
			facing = signf(direction)
		velocity.x = move_toward(velocity.x, direction * SPEED, delta * (2200.0 if is_zero_approx(direction) else 1800.0))
		velocity.y = minf(velocity.y + GRAVITY * delta, 850.0)
		if _jump_buffer > 0.0 and _coyote_time > 0.0:
			velocity.y = -JUMP
			_jump_buffer = 0.0
			_coyote_time = 0.0
		if Input.is_action_just_released("jump") and velocity.y < -170.0:
			velocity.y = -170.0
		if impulse_unlocked and _impulse_available and not grounded and Input.is_action_just_pressed("dash"):
			_impulse_available = false
			_dash_left = 0.18
	if _dash_left > 0.0:
		_dash_left = maxf(0.0, _dash_left - delta)
		velocity = Vector2(facing * 650.0, 0.0)
	move_and_slide()
	if is_on_wall():
		_dash_left = 0.0
	_stride += absf(get_real_velocity().x) * delta * 0.07
	queue_redraw()


func return_to(checkpoint: Vector2) -> void:
	position = checkpoint
	velocity = Vector2.ZERO
	_dash_left = 0.0
	_coyote_time = 0.0
	_jump_buffer = 0.0
	_impulse_available = false
	reset_physics_interpolation()


func _draw() -> void:
	var step := sin(_stride) * 7.0 if is_on_floor() and absf(velocity.x) > 10.0 else 0.0
	draw_set_transform(Vector2.ZERO, 0.0, Vector2(facing, 1.0))
	if _dash_left > 0.0:
		for i in range(3):
			draw_line(Vector2(-62 + i * 11, -30 + i * 8), Vector2(-20, -30 + i * 8), Color("#eeb669"), 2.0)
	draw_line(Vector2(-6, -21), Vector2(-8 + step, -2), Color("#323c55"), 8.0, true)
	draw_line(Vector2(7, -20), Vector2(7 - step, -2), Color("#323c55"), 8.0, true)
	draw_polygon(PackedVector2Array([Vector2(-8,-38), Vector2(9,-38), Vector2(15,-20), Vector2(-12,-20)]), PackedColorArray([Color("#c76243")]))
	draw_line(Vector2(-6, -35), Vector2(-22, -28 + step * 0.5), Color("#e28e51"), 6.0, true)
	draw_circle(Vector2(2, -46), 10.0, Color("#b46748"))
	draw_circle(Vector2(-4, -51), 8.0, Color("#251e30"))
	draw_rect(Rect2(-12, -53, 28, 4), Color("#f3c46b"))
	draw_circle(Vector2(8, -45), 1.7, Color("#251e30"))
