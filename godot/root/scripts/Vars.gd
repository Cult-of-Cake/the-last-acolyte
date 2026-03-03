extends Node

func _ready() -> void:
	init_level_array()
	# TEMP for testing:
	Data.select_save_file(0)
	Data.load_save_file()

class Paths:
	const USER: String = "user://"
	const ROOT: String = "root/"
	const RES: String = "res://" + ROOT

	const RESOURCES: String = RES + "resources/"
	const ASSETS: String = RES + "assets/"
	const SFX: String = ASSETS + "audio/sfx/"

#region Elements

enum ELEMENT { FIRE, EARTH, WATER, AIR, ELECTRIC }
const element_names: Array[String] = ["Fire", "Earth", "Water", "Air", "Electric"]
const element_colours: Array[Color] = [Color.FIREBRICK, Color.PERU, Color.DEEP_SKY_BLUE,
	Color.LIGHT_GRAY, Color.YELLOW]

const element_file_prefix = "PLACEHOLDERS/Laura/Elements/"
const element_file_suffix = ".png"
const element_icons: Array[CompressedTexture2D] = [
	preload(Paths.ASSETS + element_file_prefix + element_names[0] + element_file_suffix),
	preload(Paths.ASSETS + element_file_prefix + element_names[1] + element_file_suffix),
	preload(Paths.ASSETS + element_file_prefix + element_names[2] + element_file_suffix),
	preload(Paths.ASSETS + element_file_prefix + element_names[3] + element_file_suffix),
	preload(Paths.ASSETS + element_file_prefix + element_names[4] + element_file_suffix),
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
var level_list : Dictionary[LEVEL, LevelData]

func init_level_array() -> void:
	# If adding new levels, remember to change the ID in BOTH places
	level_list[LEVEL.DUMMY] = LevelData.new(LEVEL.DUMMY, "Test Level", 1, [])
	level_list[LEVEL.SHIP] = LevelData.new(LEVEL.SHIP, "Shipwreck", 4, [Vars.ELEMENT.WATER, Vars.ELEMENT.AIR])
	level_list[LEVEL.MINES] = LevelData.new(LEVEL.MINES, "The Mines", 2, [Vars.ELEMENT.EARTH])

class LevelData:
	
	# Constant data.  These are set on game init and never change.
	var ID : LEVEL
	var name : String
	var difficulty : int = 1
	var elements : Array[Vars.ELEMENT]
	
	func _init(id : LEVEL, n : String, diff : int, elems : Array[Vars.ELEMENT]) -> void:
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
			Data.save_save_file()
	
#endregion
