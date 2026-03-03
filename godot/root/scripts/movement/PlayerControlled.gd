extends MovementNode
class_name PlayerControlled

@export var speed : float = 150.0
@export var highspeed : float = 300.0
const ACCEL : float = 20.0

func _physics_process(delta : float) -> void:

	# Inputs
	var sprinting : bool = Input.is_action_pressed("move_sprint")
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")

	# Main motion
	if !sprinting:
		velocity = lerp(velocity, direction * speed, ACCEL * delta)
	else:
		velocity = lerp(velocity, direction * highspeed, ACCEL * delta)

	move_and_slide()
