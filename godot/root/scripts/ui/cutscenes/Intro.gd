extends CutsceneBase
class_name Intro

@export var player : Player

func run() -> void:
	enter_cutscene_mode()
	player.position = Vector2(37.0, 627.0)
	
	
	#exit_cutscene_mode()
