extends Node2D
class_name Creature

const DEBUG : bool = false

func get_posn() -> Vector2:
	var motion_obj : movement_node = Lib.Objects.find_child_of_type(self, movement_node, true)
	var posn : Vector2
	#if DEBUG: print (name, " motion obj: ", motion_obj)
	if motion_obj == null:
		posn = global_position
	else:
		posn = motion_obj.posn
	queue_redraw()
	return posn

func debug_colour() -> Color:
	return Color.WHITE

func _draw() -> void:
	# Draw functions need to be converted to local
	# But the general advice is to otherwise always use global
	if DEBUG: draw_circle(to_local(get_posn()), 5, debug_colour(), true)
