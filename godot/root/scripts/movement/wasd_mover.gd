extends movement_node
class_name wasd_mover

const SPEED = 150.0
const HIGHSPEED = 300.0
const ACCEL = 20.0

func _physics_process(delta: float) -> void:
	
	 # Inputs
	var sprinting : bool = Input.is_action_pressed("move_sprint")
	var direction := Input.get_vector("move_left", "move_right","move_up", "move_down")
	
	# Main motion
	if !sprinting:
		velocity = lerp(velocity, direction * SPEED, ACCEL * delta)
	else:
		velocity = lerp(velocity, direction * HIGHSPEED, ACCEL * delta)
	
	motion_obj.move_and_slide()
