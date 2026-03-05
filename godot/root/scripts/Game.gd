extends Node
class_name Game

# This one doesn't need to be global, because it's basically convenience functions
# for stuff in Vars.

# I just feel like some of our data makes more sense under a "Game" class.

# This is the ONLY place where this pet_list should be accessed.
static func get_pet_data(id : int) -> PetRegistryData:
	return Vars._pet_list_internal[id]
static func set_pet_data(reg : PetRegistryData) -> void:
	Vars._pet_list_internal[reg.hatch_id] = reg
	Data.pet.pet_list[reg.hatch_id] = reg.serialize()

# These too; there's a really good chance I'll be updating this to need stuff done on "set" too
static func get_level_data(id : Vars.LEVEL) -> Vars.LevelData:
	return Vars._level_list_internal[id]
static func set_level_data(id : Vars.LEVEL, lvl : Vars.LevelData) -> void:
	Vars._level_list_internal[id] = lvl
