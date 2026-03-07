extends Node2D
class_name Stars

@export var earned_images : Array[Sprite2D]

var _num_earned : int = 0

func set_num_earned(num : int) -> void:
	_num_earned = num
	update_visuals()

func _ready() -> void:
	update_visuals()

func update_visuals() -> void:
	for idx in range(0, earned_images.size()):
		earned_images[idx].visible = idx < _num_earned
