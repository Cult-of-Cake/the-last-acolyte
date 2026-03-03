extends Talkable
class_name SceneChanger

@export var new_scene : PackedScene

func talk() -> void:
	print ("You interacted with ", get_parent().name)
	if new_scene != null:
		get_tree().change_scene_to_packed(new_scene)
		
		# This transition looks nice, but I'm doing something wrong because then it crashes:
		#var scene_manager_options: SceneManagerOptions = ResourceReference.get_scene_manager_options(
			#"fade_play"
		#)
		#SceneManager.change_scene(new_scene,
			#scene_manager_options.create_fade_out_options(),
			#scene_manager_options.create_fade_in_options(),
			#scene_manager_options.create_general_options())
