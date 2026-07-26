extends Control
class_name PetPickerButton

@export var sprite_rect : TextureRect
@export var name_label : Label
@export var key_label : Label
@export var button : BaseButton

var btn_posn : int = 0

func init(pet : Tower) -> void:
	sprite_rect.texture = pet.icon_img
	name_label.text = pet.data.given_name
	hide_from_bar()

func display_on_bar(n : int, labelvis : bool = true) -> void:
	btn_posn = n
	key_label.text = "%s" % n
	visible = true
	# Not all numbers are actually mapped, e.g. 10+ never will be
	key_label.visible = labelvis

func hide_from_bar() -> void:
	visible = false

func on_click() -> void:
	# We're handling these actions via signal of a keypress, so just simulate that signal
	out.ACTIONS.debug("Clicked pet ", btn_posn)
	var padded_posn : String = "%02d" % btn_posn
	FilterManager.fake_event_signal("lvl_ui_pick_" + padded_posn)
	
