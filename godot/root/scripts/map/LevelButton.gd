extends Sprite2D
class_name LevelButton

@export var level_name : Label
@export var diff_text : Label
@export var stars_obj : Stars
@export var element_objs : Array[SpriteLoader]

func _ready() -> void:
	# TEMP for testing
	initialize("Shipwreck", 4, 2, [Vars.ELEMENT.FIRE, Vars.ELEMENT.WATER])

func initialize(lname : String, diff : int, stars : int, elements : Array[Vars.ELEMENT]) -> void:
	level_name.text = lname
	diff_text.text = str(diff)
	stars_obj.set_num_earned(stars)
	for idx in range(0, elements.size()):
		var elem: Vars.ELEMENT = elements[idx]
		element_objs[idx].set_icon(Vars.element_icons[elem], Vars.element_colours[elem])
