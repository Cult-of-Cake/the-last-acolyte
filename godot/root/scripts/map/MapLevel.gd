extends Sprite2D
class_name MapLevel

@export var level_name : Label
@export var diff_text : Label
@export var stars_obj : Stars
@export var element_objs : Array[SpriteLoader]

func initialize(lname : String, diff : int, stars : int, elements : Array[Vars.ELEMENT]) -> void:
	level_name.text = lname
	diff_text.text = str(diff)
	stars_obj.set_num_earned(stars)
	
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

class IconLoader:
	var show_when : int
	var obj : SpriteLoader
	func _init(n : int, o : SpriteLoader)-> void:
		show_when = n
		obj = o
