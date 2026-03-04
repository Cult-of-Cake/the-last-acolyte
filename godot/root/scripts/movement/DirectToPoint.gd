extends MovementNode
class_name DirectToPoint

@export var speed : float = 200.0
@export var goal_object : Node2D
@export var goal_point : Vector2

func _ready() -> void:
	pass

func _physics_process(delta : float) -> void:
	var current_goal : Vector2 = goal_object.global_position if goal_object else goal_point
	posn = posn.move_toward(current_goal, speed * delta)
	#print(posn, " ", current_goal)
	move_and_slide()

#func _draw() -> void:
	#if Lib.is_debugging(log_stream):
		#var rect : Rect2 = Rect2(to_local(_origin) - leash, leash * 2)
		#draw_rect(rect, Color.BISQUE, false)
		#draw_circle(to_local(_goal), 1, Color.BISQUE, false)
