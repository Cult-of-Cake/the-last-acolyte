extends SaveData
class_name MapSaveData

var stars_earned : Dictionary[String, int]
	#: set (val):
		#Lib.debug(LevelManager.log_stream, ["SETTING!"])
		#stars_earned = val

var test : int = 0

#region Dictionary Functions
func idx(id : LevelManager.LEVEL_ID) -> String:
	return LevelManager.LEVEL_ID.keys()[id]
func clear(_index: int = -1) -> void:
	stars_earned.clear()
#endregion

#region Per-Level data
func load_stars_earned(arr : Dictionary) -> void:
	for key : String in arr.keys():
		Lib.debug(LevelManager.log_stream, ["Loading ", key, " val ", arr[key]])
		stars_earned[key] = int(arr[key])
func set_stars(id : LevelManager.LEVEL_ID, val : int) -> void:
	stars_earned[idx(id)] = val
func get_stars(id : LevelManager.LEVEL_ID) -> int:
	#Lib.debug(LevelManager.log_stream, ["Props ", self.get_property_list()])
	Lib.debug(LevelManager.log_stream, ["Checking ", stars_earned, " for ", idx(id)])
	Lib.debug(LevelManager.log_stream, ["Has? ", stars_earned.has(idx(id))])
	Lib.debug(LevelManager.log_stream, ["Has? ", stars_earned.has("DUMMY")])
	if stars_earned.has(idx(id)):
		Lib.debug(LevelManager.log_stream, ["Found"])
		return stars_earned[idx(id)]
	else:
		Lib.debug(LevelManager.log_stream, ["Using default"])
		return 0
#endregion
