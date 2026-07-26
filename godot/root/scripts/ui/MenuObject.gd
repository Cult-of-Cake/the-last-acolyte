extends Control
class_name MenuObject

@export var blocking_objects : Array[Control]

func swallowing_click() -> bool:
	var mouse : Vector2 = get_global_mouse_position()
	for obj in blocking_objects:
		if obj.get_global_rect().has_point(mouse):
			return true
	return false
