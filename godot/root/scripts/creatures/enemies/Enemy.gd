extends Creature
class_name Enemy

@export var base_speed : float = 300
@export var true_speed : float = 300

var spawn_obj : StartPoint
var goal_obj : Area2D

func initialize(spawner : StartPoint, end_goal : Area2D) -> void:
	position = spawner.position
	spawn_obj = spawner
	goal_obj = end_goal
	spawner.add_child(self)

var speed_multiplier: float = 1.0

func set_speed_multiplier(mult : float) -> void:
	speed_multiplier = mult
	true_speed = base_speed * speed_multiplier

func reset_speed() -> void:
	set_speed_multiplier(1.0)
