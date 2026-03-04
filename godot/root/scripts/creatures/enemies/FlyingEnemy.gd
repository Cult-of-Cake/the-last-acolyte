extends Enemy
class_name FlyingEnemy

@export var move_obj : DirectToPoint

func _ready() -> void:
	move_obj = Lib.Objects.find_child_of_type(self, DirectToPoint)

func set_goal(obj : Node) -> void:
	move_obj = Lib.Objects.find_child_of_type(self, DirectToPoint)
	print(move_obj)
	move_obj.goal_object = obj
