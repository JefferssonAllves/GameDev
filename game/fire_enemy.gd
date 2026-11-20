extends Node2D

const Fireball := preload("res://game/fireball.gd")
const SHOT_INTERVAL := 1.6
const ATTACK_RANGE := 420.0

@export var target: CharacterBody2D

@onready var sprite: Sprite2D = $Sprite

var cooldown := SHOT_INTERVAL


func _physics_process(delta: float) -> void:
	if not is_instance_valid(target):
		return
	var aim := target.global_position - global_position
	if aim.length_squared() > ATTACK_RANGE * ATTACK_RANGE or aim.is_zero_approx():
		return
	sprite.flip_h = aim.x < 0.0
	cooldown -= delta
	if cooldown > 0.0:
		return

	cooldown = SHOT_INTERVAL
	var fireball := Fireball.new()
	fireball.direction = aim.normalized()
	get_parent().add_child(fireball)
	fireball.global_position = global_position
