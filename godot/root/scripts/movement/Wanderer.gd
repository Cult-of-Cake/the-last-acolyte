extends MovementNode
class_name Wanderer

const SPEED = 10.0
const NO_GOAL = Vector2(-.99, -.99)
const DEBUG = false

var _origin : Vector2
var _goal : Vector2 = NO_GOAL
var _waiting : bool = false
var _heading : float			# Used to determine if we've reached our goal - ie if our heading has radically changed
var delay : Timer

@export var leash : Vector2 = Vector2(100, 100)

func _ready() -> void:
	_origin = posn
	
	# And set up a Timer.  We use this to pause after every movement.
	delay = Timer.new()
	delay.timeout.connect(get_new_goal)
	add_child(delay)
	delay.start()

func _physics_process(delta: float) -> void:
	if _waiting: return
	
	# A radical shift in heading means we bypassed or nearly bypassed our goal
	# And for the rare occasion that we got our target near-exact, check distance too
	var _curr_heading : float = posn.angle_to_point(_goal)
	#if DEBUG: print(_curr_heading, " originally ", _heading, " -> ", abs(_curr_heading - _heading))
	if abs(_curr_heading - _heading) > 0.1 or posn.distance_to(_goal) < 3:
		# Wait a moment, then find a new goal!
		begin_waiting()
		return
	
	# Main motion
	posn = posn.move_toward(_goal, SPEED * delta)
	move_and_slide()

func begin_waiting() -> void:
		if DEBUG: print ("Waiting")
		_waiting = true
		delay.wait_time = randf_range(1, 7)
		delay.start()
	
func get_new_goal() -> void:
	delay.stop()
	_goal = _origin + Vector2(randf_range(-leash.x, leash.x), randf_range(-leash.y, leash.y))
	_heading = posn.angle_to_point(_goal)
	
	if DEBUG:
		print("Done waiting. Goal position is now ", _goal)
		queue_redraw()
	_waiting = false
	
func _draw() -> void:
	if DEBUG:
		var rect : Rect2 = Rect2(to_local(_origin) - leash, leash * 2)
		draw_rect(rect, Color.BISQUE, false)
		draw_circle(to_local(_goal), 1, Color.BISQUE, false)
