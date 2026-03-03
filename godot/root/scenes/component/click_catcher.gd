extends Node2D

signal left_click(coords)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _process(delta):
	if Input.is_action_just_pressed("left_click"):
		left_click.emit(get_global_mouse_position())
