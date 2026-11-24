extends Node2D

const SHEET = preload("res://sprites/aleatoria/PRINCIPAL.png")
# Recortes da folha transparente, com a borda inferior de cada pose nos pés.
const POSES := [
	Rect2(1, 1, 186, 309),
	Rect2(201, 1, 187, 309),
	Rect2(399, 1, 189, 309),
	Rect2(598, 1, 195, 309),
	Rect2(797, 1, 191, 305),
	Rect2(996, 1, 192, 308),
	Rect2(1195, 2, 178, 310),
	Rect2(1, 313, 194, 308),
	Rect2(200, 314, 189, 305),
	Rect2(399, 314, 181, 307),
	Rect2(598, 313, 192, 307),
	Rect2(797, 314, 178, 310),
]
# A folha não tem quadros próprios de combate, salto ou reação.
const CLIPS := [
	[&"repouso", false, 8.0, [0]],
	[&"correr", true, 17.0, [3, 4, 5, 6, 7, 8, 9, 10, 11]],
	[&"pular", false, 18.0, [4, 5, 8, 9]],
	[&"meia_lua", false, 10.0, [0, 3, 4, 3, 0]],
	[&"armada", false, 10.0, [3, 4, 5, 6, 0]],
	[&"queixada", false, 10.0, [0, 7, 8, 7, 0]],
	[&"chute_aereo", false, 10.0, [4, 5, 8, 9]],
	[&"esquiva_frente", false, 18.0, [3, 4, 5]],
	[&"role", false, 18.0, [7, 8, 9, 10]],
	[&"au", false, 14.0, [4, 5, 8, 9]],
	[&"queda", false, 6.0, [8, 7, 0]],
]

@onready var sprite: AnimatedSprite2D = $Sprite

func _ready() -> void:
	var frames := SpriteFrames.new()
	frames.remove_animation(&"default")
	for clip in CLIPS:
		var animation: StringName = clip[0]
		frames.add_animation(animation)
		frames.set_animation_loop(animation, clip[1])
		frames.set_animation_speed(animation, clip[2])
		for pose: int in clip[3]:
			var texture := AtlasTexture.new()
			texture.atlas = SHEET
			texture.region = POSES[pose]
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
