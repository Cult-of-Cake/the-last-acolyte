extends ActionListenerBase
class_name HubActionListener

func _ready() -> void:
	# Prepare listeners
	# Technically we could just do a big 'ol switch in _input, but this lets us do things like
	# output when any input is in the dictionary
	actions["hub_interact"] = on_interact_pressed

	# OTher setup
	talkables_setup()

#region Actions

func on_interact_pressed() -> void:

	var witch : Vector2 = %Player.get_posn()
	var closest : NPC = null
	for npc in talkables:
		var dist : float = witch.distance_to(npc.get_posn())
		Lib.debug(log_stream, ["Checking NPC ", npc.name, ", distance is ", dist])
		if dist < TALK_DISTANCE:
			if closest == null or dist < witch.distance_to(closest.get_posn()):
				Lib.debug(log_stream, ["Setting ", npc.name, " as closest"])
				closest = npc
	# Found it!
	if closest == null:
		Lib.debug(log_stream, ["Nobody nearby"])
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
				Lib.debug(log_stream, ["Found ", node.name])
				talkables.append(node)

#endregion
