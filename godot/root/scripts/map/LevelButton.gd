extends Sprite2D
class_name LevelButton

@export var level_name : Label
@export var diff_text : Label
@export var stars_obj : Stars
@export var element_1 : SpriteLoader
@export var element_2 : SpriteLoader

func _ready() -> void:
	# TEMP for testing
	initialize("Shipwreck", 4, 2)

func initialize(lname : String, diff : int, stars : int) -> void:
	level_name.text = lname
	diff_text.text = str(diff)
	stars_obj.set_num_earned(stars)
	element_1.set_icon("Fire", Color.FIREBRICK)
	element_2.set_icon("Earth", Color.PERU)
