extends Node2D
class_name ImageCycler

@export var has_an_all : bool
@export var has_a_none : bool
@export var sprite_list : Array[CanvasItem]
@export var hide_alpha : float = 0

var NONE : int = -1
var ALL : int = -9
@export var showing : int

func _ready() -> void:
	update_display()

func set_to_image(n : int) -> void:
	showing = clampi(n, 0, sprite_list.size() - 1)
	update_display()

func show_all() -> void:
	showing = ALL
	update_display()

func show_none() -> void:
	showing = NONE
	update_display()

# There might be a more efficient way to do this, but this wins out for readability
func cycle() -> void:
	if showing == NONE:
		showing = 0
	elif showing == ALL:
		if has_a_none:
			showing = NONE
		else:
			showing = 0
	else:
		showing += 1
		if showing >= sprite_list.size():
			if has_an_all:
				showing = ALL
			elif has_a_none:
				showing = NONE
			else:
				showing = 0
	update_display()

func update_display() -> void:
	var i : int = 0
	for img in sprite_list:
		var show_me : bool = (showing == ALL or showing == i)
		print("Show ", get_parent().name, "(", showing, "): ", i, " = ", show_me)
		var colour : Color = img.modulate
		if show_me:
			colour.a = 1
		else:
			colour.a = hide_alpha
		img.modulate = colour
		i += 1
