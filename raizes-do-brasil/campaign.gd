extends Node

enum Milestone { START, EMBER, RELAY, GUARDIAN, VICTORY }

const MENU := "res://raizes-do-brasil/title.tscn"
const STATION := "res://raizes-do-brasil/station.tscn"
const GATEHOUSE := "res://raizes-do-brasil/gatehouse.tscn"
const SAVE := "user://raizes-campaign.cfg"

# Abrir uma cena diretamente no editor não inicia uma campanha persistente.
var active := false
var milestone: int = Milestone.START


func saved_milestone() -> int:
	var save := ConfigFile.new()
	if save.load(SAVE) != OK or save.get_value("campaign", "version", 0) != 1:
		return -1
	var value: Variant = save.get_value("campaign", "milestone", -1)
	if typeof(value) != TYPE_INT or value < Milestone.START or value > Milestone.VICTORY:
		return -1
	return value


func begin(saved: int) -> void:
	active = true
	milestone = saved
	var scene := GATEHOUSE if milestone >= Milestone.GUARDIAN else STATION
	get_tree().change_scene_to_file(scene)


func record(reached: int) -> Error:
	if active:
		var save := ConfigFile.new()
		save.set_value("campaign", "version", 1)
		save.set_value("campaign", "milestone", reached)
		var temporary := SAVE + ".tmp"
		var error := save.save(temporary)
		if error != OK:
			return error
		error = DirAccess.rename_absolute(temporary, SAVE)
		if error != OK:
			return error
	milestone = reached
	return OK
