extends Node2D

@onready var player: CharacterBody2D = $World/Player
@onready var camera: Camera2D = $Camera2D


func _process(_delta: float) -> void:
	camera.position.x = player.position.x
