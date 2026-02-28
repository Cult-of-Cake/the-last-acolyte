extends Node

const asset_dir = "res://root/assets/"

enum ELEMENT { FIRE, EARTH, WATER, AIR, ELECTRIC }
const element_names: Array[String] = ["Fire", "Earth", "Water", "Air", "Electric"]
const element_colours: Array[Color] = [Color.FIREBRICK, Color.PERU, Color.DEEP_SKY_BLUE,
	Color.LIGHT_GRAY, Color.YELLOW]

const element_file_prefix = "PLACEHOLDERS/Laura/Elements/"
const element_file_suffix = ".png"
const element_icons: Array[CompressedTexture2D] = [
	preload(asset_dir + element_file_prefix + element_names[0] + element_file_suffix),
	preload(asset_dir + element_file_prefix + element_names[1] + element_file_suffix),
	preload(asset_dir + element_file_prefix + element_names[2] + element_file_suffix),
	preload(asset_dir + element_file_prefix + element_names[3] + element_file_suffix),
	preload(asset_dir + element_file_prefix + element_names[4] + element_file_suffix),
]
