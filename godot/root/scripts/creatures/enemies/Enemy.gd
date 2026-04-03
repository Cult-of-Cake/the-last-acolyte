extends Creature
class_name Enemy

@export var base_speed : float = 300
@export var true_speed : float = 300

var spawn_obj : MapPoint
var goal_obj : MapPoint

func initialize(spawner : MapPoint, end_goal : MapPoint) -> void:
	spawn_obj = spawner
	goal_obj = end_goal
	spawner.add_child(self)
	global_position = spawner.position

var speed_multiplier: float = 1.0

func set_speed_multiplier(mult : float) -> void:
	speed_multiplier = mult
	true_speed = base_speed * speed_multiplier

func reset_speed() -> void:
	set_speed_multiplier(1.0)

#TODO: This function will almost certainly be completely replaced later.
# Some enemies may just stop moving and start attacking.
# Some will do damage based on their stats.
# And we may want to use signals or something instead of this.
# But I want to have something in place to test damage to the endpoint and ending the level.

func on_collide_endpoint(endpoint : EndPoint) -> void:
	endpoint.take_damage(50)
	self.queue_free()
