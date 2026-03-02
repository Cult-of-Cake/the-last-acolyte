extends Node

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
