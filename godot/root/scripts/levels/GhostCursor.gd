extends Node2D
class_name GhostCursor

@export var barrier : Sprite2D

func mouse_moved_to(coords : Vector2i) -> void:
	position = coords

func set_to_barrier() -> void:
	barrier.visible = true
func unset_barrier() -> void:
	barrier.visible = false

func turn_off() -> void:
	unset_barrier()

func flash_red() -> void:
	var tween := create_tween()
	tween.tween_property(self, "modulate", Color(1, 0, 0), 0.2)
	await tween.finished
	tween = create_tween()
	tween.tween_property(self, "modulate", Color(1, 1, 1), 0.1)
