extends movement_node
class_name wasd_mover

const SPEED = 150.0
const HIGHSPEED = 300.0
const ACCEL = 20.0

func _physics_process(delta: float) -> void:
	
	 # Inputs
	var sprinting = Input.is_action_pressed("move_sprint")
	var direction := Input.get_vector("move_left", "move_right","move_up", "move_down")
	
	var velocity = motion_obj.velocity
	
	# Main motion
	if !sprinting:
		velocity = lerp(velocity, direction * SPEED, ACCEL * delta)
	else:
		velocity = lerp(velocity, direction * HIGHSPEED, ACCEL * delta)
	
	# Visuals
	#if abs(velocity.x) > abs (velocity.y):
		#if velocity.x > 0: 
			#get_node("Right").visible = true
		#elif velocity.x < 0:
			#get_node("Left").visible = true
	#elif abs(velocity.y) > abs (velocity.x):
		#if velocity.y > 0:
			#get_node("Facing").visible = true
		#elif velocity.y < 0:
			#get_node("Away").visible = true
	#else:
		#get_node("Facing").visible = true
	
	motion_obj.velocity = velocity
	motion_obj.move_and_slide()
