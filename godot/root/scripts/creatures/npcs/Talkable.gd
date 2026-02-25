extends Node2D
class_name Talkable

func talk() -> void:
	print ("You talked to ", get_parent().name)
