extends SaveData
class_name MapSaveData

# I was planning to do a dictionary of a custom class, but after a fight with the save system
# in which I assumed my problem was that custom classes weren't possible, I did it this way.
# And actually, it doesn't seem worth it to try to find out if they ARE possible because
# this ends up being rather nice and clean.
var stars_earned : Dictionary[String, int]

#region Dictionary Functions
func idx(id : Vars.LEVEL) -> String:
	return Vars.LEVEL.keys()[id]
func clear(_index: int = -1) -> void:
	stars_earned.clear()
#endregion

#region Per-Level data
func set_stars(id : Vars.LEVEL, val : int) -> void:
	stars_earned[idx(id)] = val
func get_stars(id : Vars.LEVEL) -> int:
	if stars_earned.has(idx(id)):
		return stars_earned[idx(id)]
	else:
		return 0
# Required for saving & loading a dictionary!
func load_stars_earned(arr : Dictionary) -> void:
	for key : String in arr.keys():
		stars_earned[key] = int(arr[key])
#endregion
