extends Node

const TRAVELER := preload("res://raizes-do-brasil/traveler.tscn")
const ACTIONS := [&"move_left", &"move_right", &"jump", &"dash", &"attack", &"interact", &"restart"]

var enabled := false
var _controller_events: Dictionary = {}


func _ready() -> void:
	for action in ACTIONS:
		var events: Array[InputEvent] = []
		for event in InputMap.action_get_events(action):
			if event is InputEventJoypadButton or event is InputEventJoypadMotion:
				events.append(event)
		_controller_events[action] = events


func configure(device: int) -> void:
	enabled = device >= 0
	for action in ACTIONS:
		var second := StringName("p2_" + String(action))
		if InputMap.has_action(second):
			Input.action_release(second)
			InputMap.erase_action(second)
		var events: Array[InputEvent] = _controller_events[action]
		if enabled:
			Input.action_release(action)
			InputMap.add_action(second, InputMap.action_get_deadzone(action))
		for event in events:
			if enabled:
				InputMap.action_erase_event(action, event)
				var assigned := event.duplicate() as InputEvent
				assigned.device = device
				InputMap.action_add_event(second, assigned)
			elif not InputMap.action_has_event(action, event):
				InputMap.action_add_event(action, event)


func travelers_in(room: Node, first: CharacterBody2D) -> Array[CharacterBody2D]:
	var group: Array[CharacterBody2D] = [first]
	if not enabled:
		return group
	var second := TRAVELER.instantiate() as CharacterBody2D
	second.second_player = true
	second.position = first.position + Vector2(32, 0)
	room.add_child(second)
	group.append(second)
	return group
