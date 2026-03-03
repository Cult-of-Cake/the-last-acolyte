extends Creature
class_name Enemy

@export var base_speed: float = 300
@export var path: PathingBase

var speed_multiplier: float = 1.0


func set_speed_multiplier(mult: float) -> void:
	speed_multiplier = mult
	path.speed = base_speed * speed_multiplier
