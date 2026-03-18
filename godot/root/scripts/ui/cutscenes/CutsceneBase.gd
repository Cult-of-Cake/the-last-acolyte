@icon("uid://bel6ltrhis41")
extends Node2D
class_name CutsceneBase

static var logger := Lib.EasyLog.new(Lib.LOG.DIALOGUE)

@export var cam : Camera2D
@export var run_on_ready : bool = false

signal dialogue_done

func _ready() -> void:
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	if run_on_ready:
		run()

func run() -> void:
	pass # Override me
func _on_dialogue_ended(_resource : DialogueResource) -> void:
	dialogue_done.emit()

# This saves us from having to make a bunch of temporary tween variables when
# we want to do several things in a row
func tween_object(obj : Node2D, prop : String, new_val : Variant, duration : float) -> void:
	var my_tween := create_tween()
	my_tween.tween_property(obj, prop, new_val, duration)
	await my_tween.finished

#region Switching in and out of cutscene mode

var prev_cam : Camera2D

func enter_cutscene_mode() -> void:
	prev_cam = get_viewport().get_camera_2d()
	swap_cameras(prev_cam, cam)

func exit_cutscene_mode() -> void:
	swap_cameras(cam, prev_cam)

# If we load from the menu instead of directly, new_c is "recently freed" and throws
# an exception... not entirely sure why.  Or what sets our camera correctly afterward.
# But it means we have to check is_instance_valid before acting.
func swap_cameras(old_c : Camera2D, new_c : Variant) -> void:
	if is_instance_valid(old_c) and old_c is Camera2D:
		old_c.enabled = false
	if is_instance_valid(new_c) and new_c is Camera2D:
		new_c.enabled = true
		new_c.make_current()

#endregion
