extends Node2D

const SHEET := preload("res://sprites/aleatoria/inimigo2.png")
const FIRE_FRAME_X := [209, 227, 245]
const SPEED := 280.0
const SCENARIO_AND_PLAYER_MASK := 3

var direction := Vector2.RIGHT
var lifetime := 2.0
var animation_time := 0.0


func _draw() -> void:
	var frame := int(animation_time * 15.0) % FIRE_FRAME_X.size()
	draw_texture_rect_region(SHEET, Rect2(-10, -36, 20, 20), Rect2(FIRE_FRAME_X[frame], 89, 16, 16))


func _physics_process(delta: float) -> void:
	animation_time += delta
	queue_redraw()
	lifetime -= delta
	if lifetime <= 0.0:
		queue_free()
		return

	# A trajetória usa o plano dos pés, assim como as colisões da arena.
	var destination := global_position + direction * SPEED * delta
	var ray := PhysicsRayQueryParameters2D.create(global_position, destination, SCENARIO_AND_PLAYER_MASK)
	ray.hit_from_inside = true
	var hit := get_world_2d().direct_space_state.intersect_ray(ray)
	if hit.is_empty():
		global_position = destination
		return

	var collider: Object = hit.collider
	if collider.has_method("show_fire_hit"):
		collider.show_fire_hit()
	queue_free()
