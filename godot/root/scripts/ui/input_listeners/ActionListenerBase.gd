@icon("uid://c16bu5hjrnhj7")
extends Control
class_name ActionListenerBase

@export var search_node : Node2D

var log_stream : Lib.LOG = Lib.LOG.ACTIONS

const DEBUG = true
var actions : Dictionary[String, Callable] = {}

func _input(event: InputEvent) -> void:
	for idx in actions:
		if event.is_action_pressed(idx):
			Lib.debug(log_stream, ["Matched input! ", event])
			actions[idx].call()
