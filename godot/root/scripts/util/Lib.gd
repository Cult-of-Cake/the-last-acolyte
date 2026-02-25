extends Node
class_name Lib

#region Objects
class Objects:

	static func find_child_of_type(parent : Node, type : Variant, recursive : bool = false) -> Node2D:
		for child in parent.get_children():
			#print ("TYPE: Checking if ", child.name, " (", child.get_class(), ") is type ", type)
			if is_instance_of(child, type):
				return child
			if recursive:
				var grandchild : Node2D = find_child_of_type(child, type, true)
				if grandchild != null:
					return grandchild
		return null
	static func has_child_of_type(parent : Node, type : Variant) -> bool:
		var found : Node = find_child_of_type(parent, type)
		return found != null

#endregion
