extends SaveData
class_name PetSaveData

var num_sprouted : int = 0
var pet_list : Dictionary[int, String] # The real list (in Vars) updates this when changed

#region Dictionary Functions
func clear(_index: int = -1) -> void:
	num_sprouted = 0
	pet_list.clear()
#endregion

#region Per-Pet data
# Required for saving & loading a dictionary!
func load_pet_list(arr : Dictionary) -> void:
	for key : String in arr.keys():
		var data : Dictionary = JSON.parse_string(arr[key])
		var reg : PetRegistryData = PetRegistryData.new()
		reg.set_from_dict(data)
		var stats_string : String = data.get("stats")
		reg.load_stats(JSON.parse_string(stats_string))
		Game.set_pet_data(reg)
#endregion
