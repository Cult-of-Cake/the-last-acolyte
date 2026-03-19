extends Node
class_name PetListManager

func _ready() -> void:
	# TEMP for testing
	var reg : PetRegistryData = PetRegistryData.new(true)
	Game.set_pet_data(reg)
	reg = PetRegistryData.new(true)
	reg.name = "Bernie"
	reg.set_element(Vars.ELEMENT.FIRE)
	Game.set_pet_data(reg)
