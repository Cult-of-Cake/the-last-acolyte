extends Creature
class_name NPC

var talkable : Talkable

func _ready() -> void:
	var t := find_child("Talkable") as Talkable
	if t:
		talkable = t
	on_visibility_changed()

func update_visibility(vis : bool) -> void:
	visible = vis
	on_visibility_changed()

func on_visibility_changed() -> void:
	if talkable:
		talkable.enabled = visible

func debug_colour() -> Color:
	return Color.SADDLE_BROWN
