extends Talkable
class_name SceneChanger

@export var new_scene : PackedScene

func talk() -> void:
	load_scene()

func load_scene() -> void:
	if new_scene != null:
		get_tree().change_scene_to_packed(new_scene)
	
