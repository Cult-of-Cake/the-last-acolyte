extends Region
class_name SpeedRegion

@export var speed_multiplier : float = 1.0

func _ready() -> void:
	super()
	#Lib.enable_debug(log_stream)
	out.MOVEMENT.debug(["Running ", name])

func _on_body_entered(body : Node2D) -> void:
	out.MOVEMENT.debug(["Entered ", body.get_class()])
	var enemy : Enemy
	if body is CollisionTypeChecker:
		enemy = body.true_body
	else:
		enemy = Lib.Objects.find_child_of_type(body, Enemy, true)
	if enemy != null:
		out.MOVEMENT.debug(["Setting enemy speed ", speed_multiplier])
		enemy.set_speed_multiplier(speed_multiplier)

func _on_body_exited(body : Node2D) -> void:
	out.MOVEMENT.debug("Exited")
	var enemy : Enemy
	if body is CollisionTypeChecker:
		enemy = body.true_body
	else:
		enemy = Lib.Objects.find_child_of_type(body, Enemy, true)
	if enemy != null:
		out.MOVEMENT.debug("Reset")
		enemy.reset_speed()
