extends Node2D
class_name PetRow

@export var hatch_id : int = 0
@export var pet_name : Label
@export var pet_level : Label
@export var affinity : SpriteLoader

func _ready() -> void:
	# TEMP for testing
	hatch_id = 1
	var reg : PetRegistryData = Game.get_pet_data(hatch_id)
	print(reg)
	pet_name.text = reg.given_name
	# temporary method for level... unless it's not
	var level : float = max(reg.get_stat(Vars.STAT.ATTACK_ELEMENTAL), reg.get_stat(Vars.STAT.ATTACK_COSMIC))
	pet_level.text = str(int(level))
	var elem : Vars.ELEMENT = reg.get_element()
	affinity.set_icon(Vars.ELEMENT_ICONS[elem], Vars.ELEMENT_COLOURS[elem])
