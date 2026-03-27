extends CutsceneBase
class_name Intro

@export var player : Player
@export var camera_rail_1 : PathFollow2D
@export var narrator : NPC
@export var god_tree : NPC

func run() -> void:
	await narrator.ready
	await god_tree.ready
	
	out.DIALOGUE.info("Playing cutscene " + name)
	enter_cutscene_mode()
	player.position = Vector2(-1000.0, -1000.0)
	
	narrator.talkable.talk_from_label("intro_01")
	await dialogue_done
	
	await tween_object(camera_rail_1, "progress_ratio", 1.0, 8.0)
	
	narrator.talkable.talk_from_label("intro_02")
	await dialogue_done

	player.position = Vector2(222.0, 475.0)
	tween_object(player, "position", Vector2(240.0, 410.0), 2.2)
	await tween_object(cam, "zoom", Vector2(1.7, 1.7), 2.5)

	god_tree.talkable.talk_from_label("intro")
	await dialogue_done

	exit_cutscene_mode()
	out.DIALOGUE.debug("Finished cutscene " + name)
