extends Node2D

const SHEET = preload("res://sprites/aleatoria/PRINCIPAL.png")
const SHEET_GRID := Vector2i(4, 7)
const KICK_IMPACT_POSE := 20

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

var kick_impact_texture: AtlasTexture

@onready var sprite: AnimatedSprite2D = $Sprite

func _ready() -> void:
	var atlas: Texture2D = SHEET
	var image := Image.new()
	var path: String = SHEET.resource_path
	if FileAccess.file_exists(path):
		var error := image.load_png_from_buffer(FileAccess.get_file_as_bytes(path))
		if error == OK and _fits_grid(image):
			atlas = ImageTexture.create_from_image(image)
	if atlas == SHEET:
		image = SHEET.get_image()

	var cell_size := image.get_size() / SHEET_GRID
	var poses: Array[AtlasTexture] = []
	for row in range(SHEET_GRID.y):
		for column in range(SHEET_GRID.x):
			var cell := Rect2i(Vector2i(column, row) * cell_size, cell_size)
			var bounds := image.get_region(cell).get_used_rect()
			var texture := AtlasTexture.new()
			texture.atlas = atlas
			texture.region = Rect2(cell.position + bounds.position, bounds.size) if bounds.has_area() else Rect2(cell)
			texture.filter_clip = true
			poses.append(texture)
	kick_impact_texture = poses[KICK_IMPACT_POSE]

	var frames := SpriteFrames.new()
	frames.remove_animation(&"default")
	for clip in CLIPS:
		var animation: StringName = clip[0]
		frames.add_animation(animation)
		frames.set_animation_loop(animation, clip[1])
		frames.set_animation_speed(animation, clip[2])
		for pose: int in clip[3]:
			frames.add_frame(animation, poses[pose])
	sprite.sprite_frames = frames
	sprite.frame_changed.connect(_align_feet)
	sprite.animation_changed.connect(_align_feet)
	sprite.play(&"repouso")


func _fits_grid(image: Image) -> bool:
	var size := image.get_size()
	return size.x >= SHEET_GRID.x and size.y >= SHEET_GRID.y \
		and size.x % SHEET_GRID.x == 0 and size.y % SHEET_GRID.y == 0


func _align_feet() -> void:
	var texture := sprite.sprite_frames.get_frame_texture(sprite.animation, sprite.frame) as AtlasTexture
	if texture != null:
		# O quadro estendido inclui o rastro à frente. Compense a largura para apoiar o pé.
		sprite.offset.x = 38.0 if texture == kick_impact_texture else 0.0
		sprite.offset.y = -texture.get_height() / 2.0
