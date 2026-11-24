extends Node2D

const SHEET = preload("res://sprites/aleatoria/PRINCIPAL.png")
# Regiões em pixels. Os rótulos da folha ficam fora dos quadros.
const CLIPS := [
	[&"repouso", true, 8.0, [
		Rect2(6, 32, 173, 107),
		Rect2(179, 32, 170, 107),
		Rect2(349, 32, 168, 107),
		Rect2(517, 32, 173, 107),
		Rect2(690, 32, 170, 107),
		Rect2(859, 32, 170, 107),
		Rect2(1029, 32, 168, 107),
		Rect2(1197, 32, 168, 107),
		Rect2(1365, 32, 173, 107),
		Rect2(6, 174, 173, 104),
		Rect2(179, 174, 170, 104),
		Rect2(349, 174, 168, 104),
	]],
	[&"correr", true, 17.0, [
		Rect2(6, 746, 182, 101),
		Rect2(189, 746, 179, 101),
		Rect2(368, 746, 187, 101),
		Rect2(555, 746, 189, 101),
		Rect2(744, 746, 200, 101),
	]],
	[&"pular", false, 18.0, [
		Rect2(445, 893, 187, 144),
		Rect2(632, 893, 136, 144),
		Rect2(1226, 880, 205, 157),
		Rect2(768, 893, 229, 144),
	]],
	[&"meia_lua", false, 10.0, [
		Rect2(106, 1075, 229, 195),
		Rect2(334, 1075, 186, 195),
		Rect2(520, 1075, 166, 195),
		Rect2(686, 1075, 166, 195),
	]],
	[&"armada", false, 10.0, [
		Rect2(334, 1075, 186, 195),
		Rect2(520, 1075, 166, 195),
		Rect2(686, 1075, 166, 195),
		Rect2(853, 1075, 194, 195),
	]],
	[&"queixada", false, 10.0, [
		Rect2(6, 440, 189, 106),
		Rect2(195, 440, 205, 106),
		Rect2(400, 440, 208, 106),
		Rect2(106, 1075, 229, 195),
		Rect2(334, 1075, 186, 195),
	]],
	[&"chute_aereo", false, 10.0, [
		Rect2(632, 893, 136, 144),
		Rect2(1226, 880, 205, 157),
		Rect2(768, 893, 229, 144),
		Rect2(334, 1075, 186, 195),
	]],
	[&"esquiva_frente", false, 18.0, [
		Rect2(616, 440, 230, 106),
		Rect2(846, 440, 216, 106),
	]],
	[&"role", false, 18.0, [
		Rect2(189, 584, 168, 130),
		Rect2(357, 584, 139, 130),
		Rect2(496, 584, 126, 130),
		Rect2(622, 584, 114, 130),
	]],
	[&"au", false, 14.0, [
		Rect2(445, 893, 187, 144),
		Rect2(632, 893, 136, 144),
		Rect2(1226, 880, 205, 157),
		Rect2(768, 893, 229, 144),
	]],
	[&"queda", false, 6.0, [
		Rect2(8, 584, 181, 130),
		Rect2(189, 584, 168, 130),
		Rect2(357, 584, 139, 130),
		Rect2(496, 584, 126, 130),
		Rect2(622, 584, 114, 130),
	]],
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
		for region: Rect2 in clip[3]:
			var texture := AtlasTexture.new()
			texture.atlas = SHEET
			texture.region = region
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
