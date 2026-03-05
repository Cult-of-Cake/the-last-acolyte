extends Node

func _ready() -> void:
	init_level_array()
	# Purely to get rid of the linter warning that we're not using these:
	var _tempLD : Dictionary[LEVEL, LevelData] = _level_list_internal
	var _tempPRD : Dictionary[int, PetRegistryData] = _pet_list_internal

class Paths:
	const USER: String = "user://"
	const ROOT: String = "root/"
	const RES: String = "res://" + ROOT

	const RESOURCES: String = RES + "resources/"
	const ASSETS: String = RES + "assets/"
	const SFX: String = ASSETS + "audio/sfx/"

#region Elements

enum ELEMENT { FIRE, EARTH, WATER, AIR, ELECTRIC }
const ELEMENT_NAMES : Array[String] = ["Fire", "Earth", "Water", "Air", "Electric"]
const ELEMENT_COLOURS : Array[Color] = [Color.FIREBRICK, Color.PERU, Color.DEEP_SKY_BLUE,
	Color.LIGHT_GRAY, Color.YELLOW]

const ELEMENT_FILE_PREFIX : String = "PLACEHOLDERS/Laura/Elements/"
const ELEMENT_FILE_SUFFIX : String = ".png"
const ELEMENT_ICONS : Array[CompressedTexture2D] = [
	preload(Paths.ASSETS + ELEMENT_FILE_PREFIX + ELEMENT_NAMES[0] + ELEMENT_FILE_SUFFIX),
	preload(Paths.ASSETS + ELEMENT_FILE_PREFIX + ELEMENT_NAMES[1] + ELEMENT_FILE_SUFFIX),
	preload(Paths.ASSETS + ELEMENT_FILE_PREFIX + ELEMENT_NAMES[2] + ELEMENT_FILE_SUFFIX),
	preload(Paths.ASSETS + ELEMENT_FILE_PREFIX + ELEMENT_NAMES[3] + ELEMENT_FILE_SUFFIX),
	preload(Paths.ASSETS + ELEMENT_FILE_PREFIX + ELEMENT_NAMES[4] + ELEMENT_FILE_SUFFIX),
]

#endregion

#region TakinTemplate Audio

class PlaceholderAudio:
	const MENU_DOODLE_2_LOOP: AudioStream = preload(
		Paths.ASSETS + "audio/music/menu_doodle_2_loop/ogg/menu_doodle_2_loop.ogg"
	)
	const CLICK_4: AudioStream = preload(Paths.SFX + "kenny_ui/ogg/click4.ogg")
	const CLICK_5: AudioStream = preload(Paths.SFX + "kenny_ui/ogg/click5.ogg")
	const MOUSECLICK_1: AudioStream = preload(Paths.SFX + "kenny_ui/ogg/mouseclick1.ogg")
	const MOUSERELEASE_1: AudioStream = preload(Paths.SFX + "kenny_ui/ogg/mouserelease1.ogg")

#endregion

#region Level Data

enum LEVEL { DUMMY, SHIP, MINES }
var _level_list_internal : Dictionary[LEVEL, LevelData] # Access functions are in Game

func init_level_array() -> void:
	# If adding new levels, remember to change the ID in BOTH places
	Game.set_level_data(LEVEL.DUMMY, LevelData.new(LEVEL.DUMMY,
		"Test Level", 1, []))
	Game.set_level_data(LEVEL.SHIP, LevelData.new(LEVEL.SHIP,
		"Shipwreck", 4, [Vars.ELEMENT.WATER, Vars.ELEMENT.AIR]))
	Game.set_level_data(LEVEL.MINES, LevelData.new(LEVEL.MINES,
		"The Mines", 2, [Vars.ELEMENT.EARTH]))

class LevelData:

	# Constant data.  These are set on game init and never change.
	var id : LEVEL
	var name : String
	var difficulty : int = 1
	var elements : Array[Vars.ELEMENT]

	func _init(lvl : LEVEL, n : String, diff : int, elems : Array[Vars.ELEMENT]) -> void:
		id = lvl
		name = n
		difficulty = diff
		elements = elems

	# Changeable data.  These save and load to file.
	var stars_earned : int:
		get:
			return Data.map.get_stars(id)
		set (val):
			Data.map.set_stars(id, val)
			Data.save_save_file()

#endregion

#region Pet Data

# Godot doesn't have private variables, and dictionaries don't work with getters/setters.
# But I really need to make sure nobody sets this variable except through the access
# function in Game.
var _pet_list_internal : Dictionary[int, PetRegistryData]

#endregion
