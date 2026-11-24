extends Node2D

const SHEET = preload("res://sprites/aleatoria/PRINCIPAL.png")
# Recortes da folha transparente, com a borda inferior de cada pose nos pés.
const POSES := [
	Rect2(1, 1, 186, 309),
	Rect2(220, 1, 188, 309),
	Rect2(439, 1, 189, 309),
	Rect2(658, 1, 195, 309),
	Rect2(1, 327, 191, 305),
	Rect2(220, 327, 192, 308),
	Rect2(439, 327, 178, 310),
	Rect2(658, 327, 195, 308),
	Rect2(1, 653, 192, 307),
	Rect2(220, 653, 189, 305),
	Rect2(439, 653, 181, 307),
	Rect2(658, 653, 178, 310),
	Rect2(1, 980, 201, 282),
	Rect2(220, 979, 208, 288),
	Rect2(439, 980, 204, 302),
	Rect2(658, 979, 216, 324),
	Rect2(1, 1305, 179, 305),
	Rect2(220, 1305, 177, 305),
	Rect2(439, 1306, 205, 294),
	Rect2(658, 1305, 216, 289),
]

const CLIPS := [
	[&"repouso", false, 8.0, [0]],
	[&"correr", true, 17.0, [3, 4, 5, 6, 7, 8, 9, 10, 11]],
	[&"pular", false, 18.0, [12, 13, 14, 15]],
	[&"aterrissar", false, 24.0, [19, 18, 16]],
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
