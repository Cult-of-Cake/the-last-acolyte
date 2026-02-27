extends Sprite2D
class_name LevelButton

@export var level_name : Label
@export var diff_text : Label
@export var stars_obj : Stars

func _ready() -> void:
	# TEMP for testing
	initialize("The Mines", 4, 2)

func initialize(lname : String, diff : int, stars : int):
	level_name.text = lname
	diff_text.text = str(diff)
	stars_obj.num_earned = stars
