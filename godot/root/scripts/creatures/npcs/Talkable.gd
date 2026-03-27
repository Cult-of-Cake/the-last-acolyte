@icon("uid://bbq8h48mfm06g")
extends Node2D
class_name Talkable

@export var dialogue_file : DialogueResource
@export var dialogue_balloon : PackedScene
@export var starting_label : String = "start"
@export var auto_on_collision : Area2D

var enabled : bool = true

func _ready() -> void:
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	if auto_on_collision != null:
		auto_on_collision.body_entered.connect(_on_auto_trigger)

func talk() -> void:
	talk_from_label(starting_label)

func talk_from_label(jump_to : String) -> void:
	if !enabled:
		return
	if jump_to == "" or jump_to == null:
		return

	out.DIALOGUE.debug("You talked to ", get_parent().name)

	if Vars.DIALOGUE_TAKEN:
		out.DIALOGUE.warn("Cannot Talk to character when dialogue already running!")
		return
	Vars.DIALOGUE_TAKEN = true

	DialogueManager.show_dialogue_balloon_scene(dialogue_balloon, dialogue_file, jump_to)

func _on_dialogue_ended(_resource : DialogueResource) -> void: 
	Vars.DIALOGUE_TAKEN = false

func _on_auto_trigger(_body : Node2D) -> void:
	# Actually, we only scan for the layer we care about.
	# But I'm going to leave this here because I know I'll need it again.
	#if body.get_collision_layer_value(Vars.HUB_LAYERS.PLAYER):
	talk()

# To be overridden
func load_scene() -> void:
	pass
