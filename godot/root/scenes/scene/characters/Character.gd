
extends Resource 
class_name Character

@export var internal_character_name : String 
@export var dialogue_style : CharacterDialogueStyle

var character_name : String:
	get:
		if(dialogue_style == null):
			return "" 
		if(dialogue_style.display_name_override.is_empty()):
			return internal_character_name
		return dialogue_style.display_name_override
