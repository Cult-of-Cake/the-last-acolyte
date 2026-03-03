extends Node2D
class_name MapButtonLoader

var MapLevelTemplate : PackedScene = preload("res://root/scenes/scene/map/map_button.tscn")

@export var id : Vars.LEVEL
@export var level_scene : PackedScene

func _ready() -> void:

	var data : Vars.LevelData = Vars.level_list[id]
	var level : MapButton = MapLevelTemplate.instantiate()
	level.initialize(data.name, data.difficulty, level_scene, data.stars_earned, data.elements)

	add_child(level)
