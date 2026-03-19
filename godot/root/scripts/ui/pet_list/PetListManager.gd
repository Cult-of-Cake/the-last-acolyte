extends Node
class_name PetListManager

func _ready() -> void:
	# TEMP for testing
	sprout_seed()
	sprout_seed()

func sprout_seed() -> void:
	var reg := PetRegistryData.new(true)
	var elem : Vars.ELEMENT = Vars.ELEMENT.values().pick_random()
	reg.set_element(elem)
	reg.given_name = Vars.RandomNames.pick(elem)
	reg.name = reg.given_name # Might as well name the node too
	Game.set_pet_data(reg)
	
