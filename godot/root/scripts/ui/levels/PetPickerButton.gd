extends Control
class_name PetPickerButton

@export var sprite_rect : TextureRect
@export var name_label : Label
@export var key_label : Label

func init(pet : Tower) -> void:
	sprite_rect.texture = pet.sprite_img
	name_label.text = pet.data.given_name
	hide_from_bar()

func display_on_bar(n : int) -> void:
	key_label.text = "%i" % n
	visible = true

func hide_from_bar() -> void:
	visible = false
