extends Node2D
class_name GhostCursor

@export var barrier : Sprite2D

func mouse_moved_to(coords : Vector2i) -> void:
	position = coords

func set_to_barrier() -> void:
	barrier.visible = true
