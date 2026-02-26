@icon("uid://bbq8h48mfm06g")
extends Node2D
class_name Talkable

@export var dialogue_file : DialogueResource
@export var dialogue_balloon : PackedScene
@export var starting_label : String = "start"

func talk() -> void:
	print ("You talked to ", get_parent().name)
	DialogueManager.show_dialogue_balloon_scene(dialogue_balloon,dialogue_file,starting_label)
