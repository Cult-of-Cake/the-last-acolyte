@icon("uid://dgc05lcforj3r")
extends Node2D
class_name MovementNode

@export var motion_obj : Node2D

static var log_stream : Lib.LOG = Lib.LOG.MOVEMENT

var velocity : Vector2 :
	get:
		return motion_obj.velocity
	set (value):
		motion_obj.velocity = value

var posn : Vector2 :
	get:
		return motion_obj.global_position
	set (value):
		motion_obj.global_position = value

func move_and_slide() -> void:
	motion_obj.move_and_slide()
