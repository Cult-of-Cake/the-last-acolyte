extends Node
class_name Game

# This one doesn't need to be global, it's just convenience functions for Vars.
# I just feel like some of our data makes more sense under a "Game" class.

static func get_pet_data(id : int) -> PetRegistryData:
	return Vars.get_pet_data(id)
static func set_pet_data(reg : PetRegistryData) -> void:
	Vars.set_pet_data(reg)

static func get_level_data(id : Vars.LEVEL) -> Vars.LevelData:
	return Vars.get_level_data(id)
static func set_level_data(lvl : Vars.LevelData) -> void:
	Vars.set_level_data(lvl)
