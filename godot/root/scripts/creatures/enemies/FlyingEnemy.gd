extends Enemy
class_name FlyingEnemy

@export var move_obj : DirectToPoint

func _ready() -> void:
	move_obj = Lib.Objects.find_child_of_type(self, DirectToPoint)

func initialize(spawner : MapPoint, end_goal : MapPoint) -> void:
	super(spawner, end_goal)
	move_obj.goal_object = goal_obj
