extends Region
class_name SpeedRegion

const log_stream : Lib.LOG = Lib.LOG.MOVEMENT
@export var speed_multiplier : float = 1.0

func _ready() -> void:
	super()
	#Lib.enable_debug(log_stream)
	Lib.debug(log_stream, ["Running ", name])

func _on_body_entered(body : Node2D) -> void:
	Lib.debug(log_stream, ["Entered ", body.get_class()])
	var enemy : Enemy
	if body is CollisionTypeChecker:
		enemy = body.true_body
	else:
		enemy = Lib.Objects.find_child_of_type(body, Enemy, true)
	if enemy != null:
		Lib.debug(log_stream, ["Setting enemy speed ", speed_multiplier])
		enemy.set_speed_multiplier(speed_multiplier)

func _on_body_exited(body : Node2D) -> void:
	Lib.debug(log_stream, ["Exited"])
	var enemy : Enemy
	if body is CollisionTypeChecker:
		enemy = body.true_body
	else:
		enemy = Lib.Objects.find_child_of_type(body, Enemy, true)
	if enemy != null:
		Lib.debug(log_stream, ["Reset"])
		enemy.reset_speed()
