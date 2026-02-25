@icon("uid://c16bu5hjrnhj7")
extends Control
class_name ActionListenerBase

@export var search_node : Node2D

const DEBUG = true
var actions : Dictionary[String, Callable] = {}

func _input(event: InputEvent) -> void:
	for idx in actions:
		if event.is_action_pressed(idx):
			if DEBUG: print("Matched input! ", event)
			actions[idx].call()
