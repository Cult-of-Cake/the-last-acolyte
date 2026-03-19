extends Node
class_name PetListManager

const row_template = preload(Vars.Paths.PREFABS + "hub/pet_row.tscn")

@export var row_container : Control

func _ready() -> void:
	# TEMP for testing
	for _seed in range(0, 5):
		sprout_seed()
	
	for sprout_id in Game.get_pet_ids():
		#var pet : PetRegistryData = Game.get_pet_data(sprout_id)
		var new_row := row_template.instantiate()
		new_row.get_node("PetRow").set_id(sprout_id)
		row_container.add_child(new_row)

func sprout_seed() -> void:
	var reg := PetRegistryData.new(true)
	var elem : Vars.ELEMENT = Vars.ELEMENT.values().pick_random()
	reg.set_element(elem)
	reg.given_name = Vars.RandomNames.pick(elem)
	reg.name = reg.given_name # Might as well name the node too
	Game.set_pet_data(reg)
	
