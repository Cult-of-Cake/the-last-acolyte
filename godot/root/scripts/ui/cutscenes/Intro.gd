extends CutsceneBase
class_name Intro

@export var player : Player
@export var camera_rail_1 : PathFollow2D

func run() -> void:
	enter_cutscene_mode()
	player.position = Vector2(-1000.0, -1000.0)
	await tween_object(camera_rail_1, "progress_ratio", 1.0, 8.0)

	player.position = Vector2(222.0, 475.0)
	tween_object(player, "position", Vector2(240.0, 410.0), 2.2)
	await tween_object(cam, "zoom", Vector2(1.7, 1.7), 2.5)

	#exit_cutscene_mode()
