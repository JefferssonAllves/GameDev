extends Node2D

const SPEED := 280.0
const SCENARIO_AND_PLAYER_MASK := 3

var direction := Vector2.RIGHT
var lifetime := 2.0


func _draw() -> void:
	draw_circle(Vector2(0, -24), 9.0, Color.ORANGE_RED)
	draw_circle(Vector2(0, -24), 5.0, Color.GOLD)


func _physics_process(delta: float) -> void:
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
