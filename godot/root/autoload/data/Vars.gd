extends Node

func _ready() -> void:
	init_level_array()
	init_scene_manager_options()
	LL.init_log_streams()
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
	const PREFABS: String = RES + "scenes/scene/"
	const LEVELS: String = PREFABS + "levels/"
	const ENEMIES: String = PREFABS + "level_entities/enemies/"

const NO_COLOUR : Color = Color(-99, -99, -99, 0)

#region Dialogue

var DIALOGUE_TAKEN := false

class DialogueLabels:
	const LoadScene : String = "LoadMap"

#endregion

#region Collision Layers / Masks

enum HUB_LAYERS { WALLS, PLAYER, ROOFS }

#endregion

#region Elements

enum ELEMENT { SPECIAL, FIRE, EARTH, WATER, AIR, ELECTRIC }
const ELEMENT_NAMES : Array[String] = [ "", "Fire", "Earth", "Water", "Air", "Electric" ]
const ELEMENT_COLOURS : Array[Color] = [ Color.TRANSPARENT, Color.FIREBRICK, Color.PERU,
	Color.DEEP_SKY_BLUE, Color.LIGHT_GRAY, Color.YELLOW ]

const ELEMENT_FILE_PREFIX : String = "PLACEHOLDERS/Laura/Elements/"
const ELEMENT_FILE_SUFFIX : String = ".png"
const ELEMENT_ICONS : Array[CompressedTexture2D] = [
	null,
	preload(Paths.ASSETS + ELEMENT_FILE_PREFIX + ELEMENT_NAMES[1] + ELEMENT_FILE_SUFFIX),
	preload(Paths.ASSETS + ELEMENT_FILE_PREFIX + ELEMENT_NAMES[2] + ELEMENT_FILE_SUFFIX),
	preload(Paths.ASSETS + ELEMENT_FILE_PREFIX + ELEMENT_NAMES[3] + ELEMENT_FILE_SUFFIX),
	preload(Paths.ASSETS + ELEMENT_FILE_PREFIX + ELEMENT_NAMES[4] + ELEMENT_FILE_SUFFIX),
	preload(Paths.ASSETS + ELEMENT_FILE_PREFIX + ELEMENT_NAMES[5] + ELEMENT_FILE_SUFFIX),
]

#endregion

#region Roles

enum ROLE { DAMAGE, BOOST, SLOW }

#endregion

#region Enemies

const basic_enemy = preload(Paths.ENEMIES + "FollowEnemy.tscn")
const flying_enemy = preload(Paths.ENEMIES + "FlyingEnemy.tscn")

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
var _level_list_internal : Dictionary[LEVEL, LevelData] # Access functions below

func init_level_array() -> void:
	# If adding new levels, remember to change the ID
	set_level_data(LevelData.new(LEVEL.DUMMY,
		"Test Level", 1, []))
	set_level_data(LevelData.new(LEVEL.SHIP,
		"Shipwreck", 4, [Vars.ELEMENT.WATER, Vars.ELEMENT.AIR]))
	set_level_data(LevelData.new(LEVEL.MINES,
		"The Mines", 2, [Vars.ELEMENT.EARTH]))

# This is the only place that this dictionary should be accessed directly.
func get_level_data(id : Vars.LEVEL) -> Vars.LevelData:
	return _level_list_internal[id]
func set_level_data(lvl : Vars.LevelData) -> void:
	_level_list_internal[lvl.id] = lvl

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

#region Scenes

var scene_fade_in : SceneManager.Options
var scene_fade_out : SceneManager.Options
var scene_options : SceneManager.GeneralOptions

func init_scene_manager_options() -> void:
	scene_fade_in = SceneManager.create_options()
	scene_fade_out = SceneManager.create_options()
	scene_options = SceneManager.create_general_options(Color.BLACK, 0.0, false, false)

# TODO Merge this gracefully with the changes to Path in v1-Enemies
class SceneList:
	#const MAP : PackedScene = preload("res://root/scenes/scene/map/map_scene.tscn")
	const MAP : String = "map_scene" # Per SceneManager plugin window

#endregion

#region Pet Data

# Godot doesn't have private variables, and dictionaries don't work with getters/setters.
# But I really need to make sure nobody sets this variable except through the access function.
var _pet_list_internal : Dictionary[int, PetRegistryData]

# This is the ONLY place where this pet_list should be accessed directly.
func get_pet_data(id : int) -> PetRegistryData:
	return _pet_list_internal[id]
func set_pet_data(reg : PetRegistryData) -> void:
	_pet_list_internal[reg.hatch_id] = reg
	Data.pet.pet_list[reg.hatch_id] = reg.serialize()

# These are strings instead of an enum so that we can change the order without breaking old saves
class STAT:
	# The usual
	const SPEED : String = "speed"
	const MAX_HP : String = "max_hp"
	const HP_REGEN_AMOUNT : String = "hp_regen"
	const CRIT_CHANCE : String = "crit_chance"
	const CRIT_MULTIPLIER : String = "crit_mult"
	# Be careful with this one, it probably shouldn't ever go beyond, say, 2
	const RANGE_MULTIPLIER : String = "range_mult"
	# All towers will have powers that use both of these, albeit usually more of one:
	const ATTACK_ELEMENTAL : String = "att_elem"
	const ATTACK_COSMIC : String = "att_cosm"
	const DEFENSE_ELEMENTAL : String = "def_elem"
	const DEFENSE_COSMIC : String = "def_cosm"
	# Optional (e.g. Player has MP, Pets have rage, boss enemies have armour
	const MAX_MP : String = "att_cosm"
	const MP_REGEN_AMOUNT : String = "att_cosm"
	const MAX_RAGE : String = "att_cosm"
	const RAGE_REGEN_AMOUNT : String = "att_cosm"
	const HEAL_AMOUNT : String = "att_cosm"
	const ARMOUR : String = "att_cosm"
	const ARMOUR_PENETRATION : String = "att_cosm"

#endregion
