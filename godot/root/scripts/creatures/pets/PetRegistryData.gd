extends SaveData
class_name PetRegistryData

var hatch_id : int = 0
var given_name : String = "~Rick~"

func _init(hatching_new : bool = false) -> void:
	if hatching_new:
		Data.pet.num_hatched += 1
	hatch_id = Data.pet.num_hatched

# This works because we extend SaveData
func serialize() -> String:
	_init_export_vars()
	return JSON.stringify(get_as_dict())
