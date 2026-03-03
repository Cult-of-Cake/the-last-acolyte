extends Node2D
class_name MapButtonLoader

var MapLevelTemplate : PackedScene = preload("res://root/scenes/scene/map/map_button.tscn")

@export var ID : Vars.LEVEL

func _ready() -> void:
	
	var data : Vars.LevelData = Vars.level_list[ID]
	var level : MapButton = MapLevelTemplate.instantiate()
	level.initialize(data.name, data.difficulty, data.stars_earned, data.elements)
	
	add_child(level)
