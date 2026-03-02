extends SaveData
class_name MapSaveData

var stars_earned : Dictionary[String, int]

#region Dictionary Functions
func idx(id : LevelManager.LEVEL_ID) -> String:
	return LevelManager.LEVEL_ID.keys()[id]
func clear(_index: int = -1) -> void:
	stars_earned.clear()
#endregion

#region Per-Level data
func set_stars(id : LevelManager.LEVEL_ID, val : int) -> void:
	stars_earned[idx(id)] = val
func get_stars(id : LevelManager.LEVEL_ID) -> int:
	if stars_earned.has(idx(id)):
		return stars_earned[idx(id)]
	else:
		return 0
# Required for saving & loading a dictionary!
func load_stars_earned(arr : Dictionary) -> void:
	for key : String in arr.keys():
		stars_earned[key] = int(arr[key])
#endregion
