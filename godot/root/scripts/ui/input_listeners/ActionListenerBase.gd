@icon("uid://c16bu5hjrnhj7")
extends Control
class_name ActionListenerBase

var actions : Dictionary[String, Callable] = {}
var release_actions : Dictionary[String, Callable] = {}

func _input(event: InputEvent) -> void:
	for idx in actions:
		if event.is_action_pressed(idx):
			out.ACTIONS.debug(["Matched input! ", event])
			actions[idx].call()
	for idx in release_actions:
		if event.is_action_released(idx):
			out.ACTIONS.debug(["Released input! ", event])
			release_actions[idx].call()

#region Fast-forward

# Note: If a scene has multiple action listeners, this should only happen in one of them.
func enable_fast_foward() -> void:
	actions[Vars.InputMapConsts.fast_forward] = on_skip_pressed
	release_actions[Vars.InputMapConsts.fast_forward] = on_skip_released

func on_skip_pressed() -> void:
	Engine.time_scale = 20
func on_skip_released() -> void:
	Engine.time_scale = 1

#endregion
