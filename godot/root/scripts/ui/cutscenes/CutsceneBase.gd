@icon("uid://bel6ltrhis41")
extends Node2D
class_name CutsceneBase

@export var cam : Camera2D
@export var run_on_ready : bool = false

var prev_cam : Camera2D

func _ready() -> void:
	if run_on_ready:
		run()

func run() -> void:
	pass

# This saves us from having to make a bunch of temporary tween variables when
# we want to do a bunch of things in a row
func tween_object(obj : Node2D, prop : String, new_val : Variant, duration : float) -> void:
	var my_tween := create_tween()
	my_tween.tween_property(obj, prop, new_val, duration)
	await my_tween.finished

func enter_cutscene_mode() -> void:
	prev_cam = get_viewport().get_camera_2d()
	swap_cameras(prev_cam, cam)

func exit_cutscene_mode() -> void:
	swap_cameras(cam, prev_cam)

func swap_cameras(old_c : Camera2D, new_c : Camera2D) -> void:
	old_c.enabled = false
	new_c.enabled = true
	new_c.make_current()
