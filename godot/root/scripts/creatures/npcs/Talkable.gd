@icon("uid://bbq8h48mfm06g")
extends Node2D
class_name Talkable

@export var dialogue_file : DialogueResource
@export var dialogue_balloon : PackedScene
@export var starting_label : String = "start"

func _ready() -> void:
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)

func talk() -> void:
	if Vars.DIALOGUE_TAKEN:
		LogWrapper.error(self,"Cannot Talk to character when dialogue already running!")
		return
	
	Vars.DIALOGUE_TAKEN = true
	print ("You talked to ", get_parent().name)
	DialogueManager.show_dialogue_balloon_scene(dialogue_balloon,dialogue_file,starting_label)

func _on_dialogue_ended(resource) -> void: 
	Vars.DIALOGUE_TAKEN = false
