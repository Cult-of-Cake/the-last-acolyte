extends SaveData
class_name PetSaveData

var num_hatched : int = 0
var pet_list : Dictionary[int, String] # The real list (in Vars) updates this when changed

#region Dictionary Functions
func clear(_index: int = -1) -> void:
	num_hatched = 0
	pet_list.clear()
#endregion

#region Per-Pet data
# Required for saving & loading a dictionary!
func load_pet_list_str(arr : Dictionary) -> void:
	for key : String in arr.keys():
		var data : Dictionary = JSON.parse_string(arr[key])
		var reg : PetRegistryData = PetRegistryData.new()
		reg.set_from_dict(data)
		Game.set_pet_data(reg)
#endregion
