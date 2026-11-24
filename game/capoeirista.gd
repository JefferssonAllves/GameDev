extends Node2D

const SHEET = preload("res://sprites/aleatoria/PRINCIPAL.png")
# Recortes da folha transparente, com a borda inferior de cada pose nos pés.
const POSES := [
	Rect2(1, 1, 186, 309),
	Rect2(294, 1, 188, 309),
	Rect2(587, 1, 189, 309),
	Rect2(880, 1, 195, 309),
	Rect2(1, 358, 191, 305),
	Rect2(294, 358, 192, 308),
	Rect2(587, 358, 178, 310),
	Rect2(880, 358, 195, 308),
	Rect2(1, 715, 192, 307),
	Rect2(294, 715, 189, 305),
	Rect2(587, 715, 181, 307),
	Rect2(880, 715, 178, 310),
	Rect2(1, 1073, 201, 282),
	Rect2(294, 1072, 208, 288),
	Rect2(587, 1073, 204, 302),
	Rect2(880, 1072, 216, 324),
	Rect2(1, 1429, 179, 305),
	Rect2(294, 1429, 177, 305),
	Rect2(587, 1430, 205, 294),
	Rect2(880, 1429, 216, 289),
	Rect2(1, 1786, 291, 354),
	Rect2(294, 1786, 232, 355),
	Rect2(587, 1786, 222, 351),
	Rect2(880, 1787, 214, 344),
	Rect2(1, 2144, 205, 346),
	Rect2(294, 2144, 207, 348),
	Rect2(587, 2144, 214, 343),
	Rect2(880, 2143, 216, 339),
]

const CLIPS := [
	[&"repouso", false, 8.0, [0]],
	[&"correr", true, 17.0, [3, 4, 5, 6, 7, 8, 9, 10, 11]],
	[&"pular", false, 18.0, [12, 13, 14, 15]],
	[&"aterrissar", false, 24.0, [19, 18, 16]],
	[&"meia_lua", false, 14.0, [27, 26, 23, 22, 20, 21, 24, 25]],
	[&"armada", false, 16.0, [26, 23, 22, 20, 21, 24, 25]],
	[&"queixada", false, 10.0, [0, 7, 8, 7, 0]],
	[&"chute_aereo", false, 16.0, [12, 23, 20, 21, 14]],
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
	var texture := sprite.sprite_frames.get_frame_texture(sprite.animation, sprite.frame) as AtlasTexture
	if texture != null:
		# O quadro estendido inclui o rastro à frente. Compense a largura para apoiar o pé.
		sprite.offset.x = 38.0 if texture.region == POSES[20] else 0.0
		sprite.offset.y = -texture.get_height() / 2.0
