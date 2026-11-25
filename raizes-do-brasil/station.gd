extends Node2D

const GROUND := [
	Rect2(0, 452, 570, 88), Rect2(675, 452, 345, 88), Rect2(1125, 452, 795, 88),
	Rect2(80, 310, 245, 20), Rect2(500, 325, 173, 20), Rect2(720, 390, 145, 18),
	Rect2(1210, 396, 95, 18), Rect2(1360, 344, 196, 20), Rect2(1590, 399, 140, 20),
]
const EMBER := Vector2(1472, 311)
const RELAY := Vector2(159, 273)
const START := Vector2(125, 452)

const EMBER_CHECKPOINT := Vector2(1472, 344)
const RELAY_CHECKPOINT := Vector2(159, 310)

var checkpoint := START
var complete := false
var _clock := 0.0
var travelers: Array[CharacterBody2D]

@onready var traveler = $Traveler
@onready var camera: Camera2D = $Camera
@onready var objective: Label = $Interface/Objective


func _ready() -> void:
	travelers = LocalCoop.travelers_in(self, traveler)
	for rect: Rect2 in GROUND:
		var body := StaticBody2D.new()
		body.position = rect.get_center()
		var collider := CollisionShape2D.new()
		var shape := RectangleShape2D.new()
		shape.size = rect.size
		collider.shape = shape
		body.add_child(collider)
		add_child(body)
	objective.text = "Estação do Vento  ·  Siga os marcos dourados até a brasa."
	if Campaign.active and Campaign.milestone >= Campaign.Milestone.EMBER:
		_unlock_ember()
		if Campaign.milestone >= Campaign.Milestone.RELAY:
			_restore_relay()
		for member in travelers:
			member.return_to(checkpoint + Vector2(32 if member.second_player else 0, 0))


func _physics_process(_delta: float) -> void:
	var center_x := _group_center_x()
	var nearby := 0
	var enter_requested := false
	for member in travelers:
		if member.position.y > 640.0 or member.just_pressed(&"restart"):
			member.return_to(checkpoint)
		var left := maxf(15.0, center_x - 410.0) if LocalCoop.enabled else 15.0
		var right := minf(1905.0, center_x + 410.0) if LocalCoop.enabled else 1905.0
		member.position.x = clampf(member.position.x, left, right)
		var center: Vector2 = member.position - Vector2(0, 23)
		if not traveler.impulse_unlocked and center.distance_to(EMBER) < 33.0:
			_unlock_ember()
			_save_milestone(Campaign.Milestone.EMBER)
		if traveler.impulse_unlocked and not complete and center.distance_to(RELAY) < 35.0:
			_restore_relay()
			_save_milestone(Campaign.Milestone.RELAY)
		if center.distance_to(RELAY) < 75.0:
			nearby += 1
			enter_requested = enter_requested or member.just_pressed(&"interact")

	if complete and enter_requested:
		if nearby < travelers.size():
			objective.text = "Reúnam os dois viajantes junto ao relé."
			return
		_save_milestone(Campaign.Milestone.GUARDIAN)
		get_tree().change_scene_to_file(Campaign.GATEHOUSE)


func _unlock_ember() -> void:
	for member in travelers:
		member.impulse_unlocked = true
	checkpoint = EMBER_CHECKPOINT
	objective.text = "Impulso aéreo liberado! Volte pelos terraços e cruze o vão com Shift no ar."


func _restore_relay() -> void:
	complete = true
	checkpoint = RELAY_CHECKPOINT
	objective.text = "Estação religada  ·  E / LB junto ao relé abre a Casa das Comportas."


func _save_milestone(stage: int) -> void:
	if Campaign.record(stage) != OK:
		objective.text += "  ·  Falha ao salvar."


func _group_center_x() -> float:
	if travelers.size() == 1:
		return traveler.position.x
	return (travelers[0].position.x + travelers[1].position.x) * 0.5


func _process(delta: float) -> void:
	camera.position.x = _group_center_x()
	_clock += delta
	queue_redraw()


func _draw() -> void:
	for i in range(18):
		var sky := Color("#251f39").lerp(Color("#d88359"), i / 17.0)
		draw_rect(Rect2(0, i * 30, 1920, 30), sky)
	draw_circle(Vector2(420, 206), 76, Color("#f2ba73"), true, -1.0, true)
	for i in range(7):
		var x := i * 329.0 - 160.0
		_polygon([Vector2(x, 455), Vector2(x + 50, 330), Vector2(x + 142, 273 + 16 * (i % 3)),
			Vector2(x + 207, 281 + 16 * (i % 3)), Vector2(x + 342, 456)], Color("#634258"))
	for i in range(9):
		var x := i * 248.0 + 24.0
		draw_line(Vector2(x, 242 + i % 3 * 14), Vector2(x + 80, 232 + i % 3 * 14), Color(1.0, 0.77, 0.55, 0.23), 1.0)
	draw_rect(Rect2(0, 476, 1920, 64), Color("#382538"))
	for rect: Rect2 in GROUND:
		draw_rect(rect, Color("#573340"))
		draw_rect(Rect2(rect.position, Vector2(rect.size.x, 5)), Color("#e1a26c"))
		draw_line(rect.position + Vector2(0, 13), rect.position + Vector2(rect.size.x, 13), Color("#98594c"), 2.0)
		for dx in range(22, int(rect.size.x), 43):
			var point := rect.position + Vector2(dx, 9)
			draw_line(point, point + Vector2(6, 4), Color("#ba795d"), 1.0)
	for x in [62.0, 405.0, 911.0, 1171.0, 1635.0, 1820.0]:
		draw_line(Vector2(x, 452), Vector2(x, 407), Color("#39534d"), 7.0)
		draw_polyline(PackedVector2Array([Vector2(x - 13, 418), Vector2(x - 13, 431), Vector2(x, 434),
			Vector2(x + 15, 425), Vector2(x + 15, 413)]), Color("#39534d"), 5.0)
	for point in [Vector2(535, 436), Vector2(975, 436), Vector2(1240, 380), Vector2(1382, 328)]:
		draw_line(point - Vector2(8, 0), point + Vector2(8, 0), Color("#f2ba73"), 2.0)
		draw_circle(point, 3.0, Color("#ffe0a6"))
	_draw_relay(RELAY, complete)
	if not is_instance_valid(traveler) or not traveler.impulse_unlocked:
		var gem := EMBER + Vector2(0, sin(_clock * 3.2) * 4.0)
		draw_circle(gem, 23.0, Color(1.0, 0.7, 0.33, 0.25))
		_polygon([gem + Vector2(0,-15), gem + Vector2(10,0), gem + Vector2(0,15),
			gem + Vector2(-10,0)], Color("#ffe09f"))


func _draw_relay(center: Vector2, lit: bool) -> void:
	var metal := Color("#6dbaa5") if lit else Color("#bb886a")
	draw_rect(Rect2(center - Vector2(22, 23), Vector2(44, 60)), Color("#30263c"))
	draw_arc(center, 18, 0, TAU, 32, metal, 3.0, true)
	for i in range(3):
		var angle := i * TAU / 3.0 + (_clock * 3.0 if lit else 0.0)
		draw_line(center, center + Vector2.from_angle(angle) * 15.0, metal, 3.0, true)


func _polygon(points: Array[Vector2], color: Color) -> void:
	draw_colored_polygon(PackedVector2Array(points), color)
