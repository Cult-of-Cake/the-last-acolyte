@icon("uid://c16bu5hjrnhj7")
extends Control
class_name ActionListenerBase

var actions : Dictionary[String, Callable] = {}

func _input(event: InputEvent) -> void:
	for idx in actions:
		if event.is_action_pressed(idx):
			out.ACTIONS.debug(["Matched input! ", event])
			actions[idx].call()
