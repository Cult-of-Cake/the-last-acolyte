extends ActionListenerBase
class_name PetScreenActionListener

func _ready() -> void:
	actions["ui_pet_list"] = toggle_pet_list

#region Actions

func toggle_pet_list() -> void:
	Lib.load_scene(Vars.SceneList.HUB)

#endregion
