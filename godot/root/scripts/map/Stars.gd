extends Node2D
class_name Stars

@export var earned_images : Array[Sprite2D]

var num_earned : int = 0:
	set (value):
		#num_earned = value
		update_visuals()

func _ready() -> void:
	update_visuals()

func update_visuals() -> void:
	for idx in range(0, earned_images.size()):
		earned_images[idx].visible = num_earned >= idx
