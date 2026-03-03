extends Sprite2D
class_name MapButton

@export var button : TextureButton
@export var level_name : Label
@export var diff_text : Label
@export var stars_obj : Stars
@export var element_objs : Array[SpriteLoader]
@export var level_scene : PackedScene

func initialize(lname : String, diff : int, level : PackedScene, stars : int, elements : Array[Vars.ELEMENT]) -> void:
	# Main data
	level_name.text = lname
	diff_text.text = str(diff)
	stars_obj.set_num_earned(stars)
	level_scene = level
	
	# Element icons
	# element_objs should have 1 object that we'll want to display if # of elements is 1,
	# then 2 *more* objects for if it's 2, etc.  They are sized and positioned accordingly.
	# So the array size should be 1, 3, 6, 10, etc
	# We hide or display each of these objects based on that assumption.
	var check_size : int = 1
	var found_at_size : int = 1
	var actual_size : int = elements.size()
	for idx in range(0, element_objs.size()):
		var obj : SpriteLoader = element_objs[idx]
		obj.visible = check_size == actual_size
		if obj.visible:
			var elem : Vars.ELEMENT = elements[idx + 1 - check_size]
			obj.set_icon(Vars.element_icons[elem], Vars.element_colours[elem])
		# If we've gone through all the objects at this size, start checking the next size
		if found_at_size >= check_size:
			found_at_size = 1
			check_size += 1
		else:
			found_at_size += 1
	
	# And action
	button.pressed.connect(on_pressed)

func on_pressed() -> void:
	get_tree().change_scene_to_packed(level_scene)
