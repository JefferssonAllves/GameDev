extends Node2D

enum State { WAIT, WARNING, SWEEP, EXPOSED, WON }

const START := Vector2(165, 452)
const CORE := Vector2(704, 416)
const MAX_HEALTH := 9
const MAX_LIFE := 4

var health := MAX_HEALTH
var life: int:
	get:
		return int(lives.get(traveler, MAX_LIFE))
var travelers: Array[CharacterBody2D]
var lives: Dictionary = {}
var downed: Dictionary = {}
var revive_progress: Dictionary = {}
var state := State.WAIT
var remaining := 1.3
var hit_grace: Dictionary = {}
var wave_x := 0.0
var wave_direction := -1.0
var wave_count := 0
var wave_hits: Dictionary = {}

@onready var traveler = $Traveler
@onready var status: Label = $Interface/Status


func _ready() -> void:
	travelers = LocalCoop.travelers_in(self, traveler)
	for member in travelers:
		member.impulse_unlocked = true
		member.kick.connect(_on_kick)
		lives[member] = MAX_LIFE
		hit_grace[member] = 0.0
	if Campaign.active and Campaign.milestone == Campaign.Milestone.VICTORY:
		health = 0
		state = State.WON
	_update_status()


func _physics_process(delta: float) -> void:
	for member in travelers:
		member.position.x = clampf(member.position.x, 20.0, 940.0)
		if state == State.WON and member.just_pressed(&"interact"):
			get_tree().change_scene_to_file(Campaign.MENU)
			return
		if state != State.WON and member.just_pressed(&"restart"):
			_restart()
			return
		hit_grace[member] = maxf(0.0, float(hit_grace[member]) - delta)
	if state == State.WON:
		return
	if _update_revives(delta):
		return
	remaining -= delta
	if state == State.SWEEP:
		wave_x += wave_direction * (560.0 + _phase() * 80.0) * delta
		for member in travelers:
			if downed.has(member) or wave_hits.has(member) or hit_grace[member] > 0.0:
				continue
			if absf(member.position.x - wave_x) < 26.0 and member.position.y > 424.0:
				wave_hits[member] = true
				lives[member] -= 1
				if lives[member] == 0:
					downed[member] = 10.0
					member.set_physics_process(false)
					member.modulate.a = 0.45
					if downed.size() == travelers.size():
						_restart()
						return
				hit_grace[member] = 0.75
				_update_status()
	if remaining > 0.0:
		return
	match state:
		State.WAIT:
			wave_count = _phase()
			_warn()
		State.WARNING:
			wave_x = CORE.x
			wave_hits.clear()
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
	var target: CharacterBody2D = traveler
	if downed.has(target):
		target = travelers[1]
	wave_direction = -1.0 if target.position.x <= CORE.x else 1.0
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
	downed.clear()
	revive_progress.clear()
	for member in travelers:
		lives[member] = MAX_LIFE
		hit_grace[member] = 0.0
		member.modulate.a = 1.0
		member.set_physics_process(true)
		member.return_to(START + Vector2(32 if member.second_player else 0, 0))
	_enter(State.WAIT, 1.3)


func _update_revives(delta: float) -> bool:
	for member in downed.keys():
		var helper := travelers[0] if member == travelers[1] else travelers[1]
		downed[member] -= delta
		if downed[member] <= 0.0:
			_restart()
			return true
		if helper.position.distance_to(member.position) > 68.0 or not helper.holding(&"interact"):
			revive_progress[member] = 0.0
			continue
		revive_progress[member] = float(revive_progress.get(member, 0.0)) + delta
		if revive_progress[member] >= 2.0:
			downed.erase(member)
			revive_progress.erase(member)
			lives[member] = 2
			hit_grace[member] = 0.75
			member.modulate.a = 1.0
			member.return_to(Vector2(member.position.x, START.y))
			member.set_physics_process(true)
			_update_status()
	return false


func _update_status() -> void:
	if state == State.WON:
		status.text = "A água voltou à vila.  ·  Arco concluído.  ·  E / LB para voltar ao menu."
		return
	var hint: String = ["Aproxime-se do Guardião.", "Onda iminente. Prepare o salto!",
		"Salte sobre a onda.", "Núcleo aberto. Aproxime-se e chute!"][state]
	var life_status := "Vida %d/%d" % [life, MAX_LIFE]
	if travelers.size() == 2:
		life_status = "P1 %d/%d   ·   P2 %d/%d" % [life, MAX_LIFE, lives[travelers[1]], MAX_LIFE]
		if not downed.is_empty():
			hint = "Segure E / LB junto ao aliado para reanimá-lo."
	status.text = "%s   ·   Guardião %d/%d   ·   Fase %d   ·   %s" % [life_status, health, MAX_HEALTH, _phase(), hint]


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
