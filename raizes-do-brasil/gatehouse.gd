extends Node2D

enum State { WAIT, WARNING, SWEEP, EXPOSED, WON }

const START := Vector2(165, 452)
const CORE := Vector2(704, 416)
const MAX_HEALTH := 9
const MAX_LIFE := 4

var health := MAX_HEALTH
var life := MAX_LIFE
var state := State.WAIT
var remaining := 1.3
var hit_grace := 0.0
var wave_x := 0.0
var wave_direction := -1.0
var wave_count := 0
var wave_hit := false

@onready var traveler = $Traveler
@onready var status: Label = $Interface/Status


func _ready() -> void:
	traveler.impulse_unlocked = true
	traveler.kick.connect(_on_kick)
	if Campaign.active and Campaign.milestone == Campaign.Milestone.VICTORY:
		health = 0
		state = State.WON
	_update_status()


func _physics_process(delta: float) -> void:
	traveler.position.x = clampf(traveler.position.x, 20.0, 940.0)
	if state == State.WON:
		if Input.is_action_just_pressed("interact"):
			get_tree().change_scene_to_file(Campaign.MENU)
		return
	if Input.is_action_just_pressed("restart"):
		_restart()
		return
	hit_grace = maxf(0.0, hit_grace - delta)
	remaining -= delta
	if state == State.SWEEP:
		wave_x += wave_direction * (560.0 + _phase() * 80.0) * delta
		if not wave_hit and hit_grace <= 0.0 and absf(traveler.position.x - wave_x) < 26.0 and traveler.position.y > 424.0:
			wave_hit = true
			life -= 1
			if life == 0:
				_restart()
				return
			hit_grace = 0.75
			_update_status()
	if remaining > 0.0:
		return
	match state:
		State.WAIT:
			wave_count = _phase()
			_warn()
		State.WARNING:
			wave_x = CORE.x
			wave_hit = false
			_enter(State.SWEEP, 1.15)
		State.SWEEP:
			wave_count -= 1
			if wave_count > 0:
				_warn()
			else:
				_enter(State.EXPOSED, 2.65)
		State.EXPOSED:
			_enter(State.WAIT, 0.5)


func _warn() -> void:
	wave_direction = -1.0 if traveler.position.x <= CORE.x else 1.0
	_enter(State.WARNING, 0.77 - 0.09 * _phase())


func _phase() -> int:
	return 1 if health > 6 else (2 if health > 3 else 3)


func _on_kick(foot: Vector2, direction: float) -> void:
	var offset := CORE - (foot - Vector2(0, 26))
	if state != State.EXPOSED or offset.x * direction < -10.0 or absf(offset.x) > 72.0 or absf(offset.y) > 47.0:
		return
	health -= 1
	if health == 0:
		_enter(State.WON, 0.0)
		if Campaign.record(Campaign.Milestone.VICTORY) != OK:
			status.text += "  ·  Falha ao salvar."
	else:
		_update_status()


func _enter(next_state: State, duration: float) -> void:
	state = next_state
	remaining = duration
	_update_status()


func _restart() -> void:
	health = MAX_HEALTH
	life = MAX_LIFE
	hit_grace = 0.0
	traveler.return_to(START)
	_enter(State.WAIT, 1.3)


func _update_status() -> void:
	if state == State.WON:
		status.text = "A água voltou à vila.  ·  Arco concluído.  ·  E / LB para voltar ao menu."
		return
	var hint: String = ["Aproxime-se do Guardião.", "Onda iminente. Prepare o salto!",
		"Salte sobre a onda.", "Núcleo aberto. Aproxime-se e chute!"][state]
	status.text = "Vida %d/%d   ·   Guardião %d/%d   ·   Fase %d   ·   %s" % [life, MAX_LIFE, health, MAX_HEALTH, _phase(), hint]


func _process(_delta: float) -> void:
	queue_redraw()


func _draw() -> void:
	draw_rect(Rect2(0, 0, 960, 540), Color("#192937"))
	draw_rect(Rect2(0, 148, 960, 304), Color("#263e47"))
	for x in range(48, 960, 118):
		draw_rect(Rect2(x, 148, 24, 304), Color("#304953"))
		draw_rect(Rect2(x - 7, 150, 38, 12), Color("#45656a"))
	draw_rect(Rect2(0, 452, 960, 88), Color("#16252d"))
	draw_line(Vector2(0, 452), Vector2(960, 452), Color("#83b4a1"), 3.0)
	var water := Color("#6dc7ba") if state == State.WON else Color("#406277")
	draw_rect(Rect2(775, 170, 52, 282), water)
	for y in range(180, 445, 27):
		draw_line(Vector2(785, y), Vector2(815, y + 9), water.lightened(0.22), 2.0)
	var shell := Color("#68454b").lerp(Color("#ab704f"), (_phase() - 1) / 2.0) if state != State.WON else Color("#4b786b")
	draw_rect(Rect2(CORE.x - 51, 271, 102, 181), shell)
	draw_arc(Vector2(CORE.x, 320), 44, PI, TAU, 22, Color("#cf9b6c"), 5.0, true)
	draw_line(Vector2(CORE.x - 46, 375), Vector2(CORE.x + 46, 375), Color("#38313d"), 6.0)
	var lamp := Color("#83dbb4") if state in [State.EXPOSED, State.WON] else Color("#edaa66")
	draw_circle(CORE, 20.0, lamp.darkened(0.65))
	draw_circle(CORE, 12.0, lamp)
	if state == State.WARNING:
		draw_line(Vector2(CORE.x, 445), Vector2(0 if wave_direction < 0 else 960, 445), Color("#fbc176"), 3.0)
	if state == State.SWEEP:
		draw_colored_polygon(PackedVector2Array([Vector2(wave_x - 24, 452), Vector2(wave_x - 9, 434), Vector2(wave_x + 5, 422), Vector2(wave_x + 25, 452)]), Color("#f2ad68"))
