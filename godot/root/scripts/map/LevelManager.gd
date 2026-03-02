extends Node2D
class_name LevelManager

enum LEVEL_ID { DUMMY }
var level_list : Dictionary[LEVEL_ID, LevelData]
const log_stream : Lib.LOG = Lib.LOG.SAVE_SYSTEM

func _ready() -> void:
	Lib.enable_debug(log_stream)
	init_level_array()
	Data.select_save_file(0)
	
	var dummy : LevelData = level_list[LEVEL_ID.DUMMY]
	Lib.debug(log_stream, ["Dummy level has ", dummy.stars_earned, " stars"])
	dummy.stars_earned = 3
	Lib.debug(log_stream, ["Dummy level has ", dummy.stars_earned, " stars"])
	Data.save_save_file()

#region Level Init

func init_level_array() -> void:
	level_list[LEVEL_ID.DUMMY] = LevelData.new(LEVEL_ID.DUMMY, "Test Level", 1, [])


#endregion


class LevelData:
	
	# Constant data.  These are set on game init and never change.
	var ID : LEVEL_ID
	var name : String
	var difficulty : int = 1
	var elements : Array[Vars.ELEMENT]
	
	func _init(id : LEVEL_ID, n : String, diff : int, elems : Array[Vars.ELEMENT]) -> void:
		ID = id
		name = n
		difficulty = diff
		elements = elems
	
	# Changeable data.  These save and load to file.
	var stars_earned : int:
		get:
			return Data.map.get_stars(ID)
		set (val):
			Data.map.set_stars(ID, val)
	
