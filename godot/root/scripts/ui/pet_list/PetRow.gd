extends Node2D
class_name PetRow

@export var sprout_id : int = 0
@export var pet_name : Label
@export var pet_level : Label
@export var affinity : SpriteLoader

func set_id(id : int) -> void:
	sprout_id = id
	update_row()

func update_row() -> void:
	var reg : PetRegistryData = Game.get_pet_data(sprout_id)
	pet_name.text = reg.given_name
	# temporary method for level... unless it's not
	var level : float = max(reg.get_stat(Vars.STAT.ATTACK_ELEMENTAL), reg.get_stat(Vars.STAT.ATTACK_COSMIC))
	pet_level.text = str(int(level))
	var elem : Vars.ELEMENT = reg.get_element()
	affinity.set_icon(Vars.ELEMENT_ICONS[elem], Vars.ELEMENT_COLOURS[elem])
