extends Node2D
class_name MapButton

var MapLevelTemplate : PackedScene = preload("res://root/scenes/scene/map/map_level.tscn")

@export var ID : Vars.LEVEL

func _ready() -> void:
	
	var data : Vars.LevelData = Vars.level_list[ID]
	var level : MapLevel = MapLevelTemplate.instantiate()
	level.initialize(data.name, data.difficulty, data.stars_earned, data.elements)
	
	add_child(level)
