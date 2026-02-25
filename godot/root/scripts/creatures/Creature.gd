extends Node2D
class_name Creature

func get_posn() -> Vector2:
	var motion_obj : movement_node = Lib.Objects.find_child_of_type(self, movement_node, true)
	if motion_obj == null:
		return position
	else:
		return motion_obj.posn
