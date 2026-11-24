extends Node2D

@onready var backdrop: Sprite2D = $Backdrop


func _ready() -> void:
	_refresh_backdrop()
	$NavigationRegion2D.bake_navigation_polygon(false)


func _refresh_backdrop() -> void:
	# No projeto local, o cache de importação pode estar atrasado após uma troca.
	# Na exportação, o WebP original normalmente só existe como textura importada.
	var source_path := backdrop.texture.resource_path
	if not FileAccess.file_exists(source_path):
		return

	var image := Image.new()
	if image.load_webp_from_buffer(FileAccess.get_file_as_bytes(source_path)) != OK:
		push_warning("Não foi possível atualizar a imagem de fundo: " + source_path)
		return

	backdrop.texture = ImageTexture.create_from_image(image)
