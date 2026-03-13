extends CutsceneBase
class_name Intro

@export var player : Player
@export var camera_rail_1 : PathFollow2D

func run() -> void:
	enter_cutscene_mode()
	player.position = Vector2(37.0, 627.0)
	var rail_tween := create_tween()
	rail_tween.tween_property(camera_rail_1, "progress_ratio", 1.0, 8.0)
	await rail_tween.finished
	#exit_cutscene_mode()

	
