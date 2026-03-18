@tool
extends Node

var logger := Lib.EasyLog.new(Lib.LOG.DIALOGUE)

@export var character_file_list : Array[Character]
static var character_dict : Dictionary[String,Character]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for ch : Character in character_file_list:
			character_dict[ch.internal_character_name] = ch
			# in case the overloaded name is used in dialogue
			# we can also include nicknames
			character_dict[ch.character_name.to_lower()] = ch
	logger.debug(character_dict.keys())
