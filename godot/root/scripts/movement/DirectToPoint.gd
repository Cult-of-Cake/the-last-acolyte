extends MovementNode
class_name DirectToPoint

@export var speed : float = 200.0
@export var goal_object : Node2D
@export var goal_point : Vector2

func _ready() -> void:
	pass


var current_goal : Vector2

func _physics_process(delta : float) -> void:
	current_goal = goal_object.global_position if goal_object else goal_point
	posn = posn.move_toward(current_goal, speed * delta)
	#print(posn, " ", current_goal)
	move_and_slide()

func _draw() -> void:
	#if Lib.is_debugging(log_stream):
	draw_circle(to_local(current_goal), 1, Color.RED, false)
