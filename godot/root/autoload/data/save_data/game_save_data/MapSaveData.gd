extends SaveData
class_name MapSaveData

var levels_played : Dictionary[LevelManager.LEVEL_ID, LevelSaveData]

class LevelSaveData:
	var stars_earned : int = 0

#region Dictionary Functions
func has_level(id : LevelManager.LEVEL_ID) -> bool:
	return levels_played.has(id)
func get_level(id : LevelManager.LEVEL_ID) -> LevelSaveData:
	if !has_level(id):
		levels_played[id] = LevelSaveData.new()
	return levels_played[id]
func clear(_index: int = -1) -> void:
	levels_played.clear()
#endregion

#region Per-Level data
func set_stars(id : LevelManager.LEVEL_ID, val : int) -> void:
	levels_played[id].stars_earned = val
func get_stars(id : LevelManager.LEVEL_ID) -> int:
	var level : LevelSaveData = get_level(id)
	Lib.debug(LevelManager.log_stream, ["Found level"])
	Lib.debug(LevelManager.log_stream, ["Stars ", level.stars_earned])
	return level.stars_earned
#endregion
