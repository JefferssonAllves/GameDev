extends Node2D

const SHEET = preload("res://sprites/aleatoria/Sprite Sheet de Capoeira em Pixel Art.webp")
# Cada fileira usa limites horizontais próprios para não capturar os rótulos.
const REPOUSO := [202, 327, 454, 582, 706, 835, 964, 1091, 1197]
const CORRIDA := [213, 360, 523, 680, 840, 1018, 1188, 1337, 1475]
const ATAQUES := [187, 286, 394, 521, 640, 721, 802, 898, 1025, 1133, 1240, 1355, 1483, 1608, 1702, 1825, 1969, 2079, 2157]
const SALTO := [217, 351, 506, 667, 822, 960, 1118, 1276, 1426, 1520]
var rows := [
	[&"repouso", 0, 146, REPOUSO, true, 8.0],
	[&"correr", 298, 109, CORRIDA, true, 17.0],
	[&"pular", 578, 130, SALTO, false, 18.0],
	[&"meia_lua", 422, 128, ATAQUES.slice(0, 6), false, 10.0],
	[&"armada", 422, 128, ATAQUES.slice(9, 15), false, 10.0],
	[&"queixada", 422, 128, ATAQUES.slice(13), false, 10.0],
	[&"chute_aereo", 422, 128, ATAQUES.slice(5, 10), false, 10.0],
	[&"esquiva_frente", 578, 130, SALTO.slice(0, 4), false, 18.0],
	[&"role", 578, 130, SALTO.slice(5), false, 18.0],
	[&"au", 578, 130, SALTO, false, 14.0],
	[&"queda", 578, 130, SALTO.slice(6), false, 6.0],
]

@onready var sprite: AnimatedSprite2D = $Sprite

func _ready() -> void:
	var frames := SpriteFrames.new()
	frames.remove_animation(&"default")
	for row in rows:
		var animation: StringName = row[0]
		frames.add_animation(animation)
		frames.set_animation_loop(animation, row[4])
		frames.set_animation_speed(animation, row[5])
		var bounds: Array = row[3]
		for index in range(bounds.size() - 1):
			var texture := AtlasTexture.new()
			texture.atlas = SHEET
			texture.region = Rect2(bounds[index], row[1], bounds[index + 1] - bounds[index], row[2])
			texture.filter_clip = true
			frames.add_frame(animation, texture)
	sprite.sprite_frames = frames
	sprite.frame_changed.connect(_align_feet)
	sprite.animation_changed.connect(_align_feet)
	sprite.play(&"repouso")


func _align_feet() -> void:
	var texture := sprite.sprite_frames.get_frame_texture(sprite.animation, sprite.frame)
	if texture != null:
		sprite.offset.y = -texture.get_height() / 2.0
