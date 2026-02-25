extends Node2D
class_name Creature

const DEBUG : bool = true

func get_posn() -> Vector2:
	var motion_obj : movement_node = Lib.Objects.find_child_of_type(self, movement_node, true)
	var posn : Vector2
	print ("motion obj ", motion_obj)
	if motion_obj == null:
		posn = position
	else:
		posn = motion_obj.posn
	queue_redraw()
	return posn

func debug_colour() -> Color:
	return Color.WHITE

func _draw() -> void:
	if DEBUG: draw_circle(get_posn(), 5, debug_colour(), true)
