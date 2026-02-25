extends Control
class_name HubActionListener

@export var search_node : Node2D

const DEBUG = true
var actions : Dictionary[String, Callable] = {}

func _ready() -> void:
	# Prepare listeners
	# Technically we could just do a big 'ol switch in _input, but this lets us do things like
	# output when any input is in the dictionary
	actions["hub_interact"] = on_interact_pressed

	# OTher setup
	talkables_setup()

func _input(event: InputEvent) -> void:
	for idx in actions:
		if event.is_action_pressed(idx):
			if DEBUG: print("Matched input! ", event)
			actions[idx].call()

#region Actions

func on_interact_pressed() -> void:
	var witch : Vector2 = %Player.get_posn()
	var closest : NPC = null
	for npc in talkables:
		var dist : float = witch.distance_to(npc.get_posn())
		if DEBUG: print("Checking NPC ", npc.name, ", distance is ", dist)
		if dist < TALK_DISTANCE:
			if closest == null or dist < witch.distance_to(closest.get_posn()):
				if DEBUG: print("Setting ", npc.name, " as closest")
				closest = npc
	# Found it!
	if closest == null:
			if DEBUG: print("Nobody nearby")
	else:
		var talk_node : Talkable = Lib.Objects.find_child_of_type(closest, Talkable)
		if talk_node == null:
			push_error("Talkable NPC went missing after being added to talkables array")
		else:
			talk_node.talk()


#endregion

#region Talkables

const TALK_DISTANCE : int = 50
var talkables : Array[NPC] = []

func talkables_setup() -> void:
	for node in search_node.get_children():
		if typeof(node) == typeof(Pet):
			if Lib.Objects.has_child_of_type(node, Talkable):
				if DEBUG: print("Found ", node.name)
				talkables.append(node)

#endregion
