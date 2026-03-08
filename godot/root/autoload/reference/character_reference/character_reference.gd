@tool
extends Node


@export var character_file_list : Array[Character]
static var character_dict : Dictionary[String,Character]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for char in character_file_list:
			character_dict[char.internal_character_name] = char
			# in case the overloaded name is used in dialogue
			# we can also include nicknames
			character_dict[char.character_name.to_lower()] = char
	print(character_dict.keys())
