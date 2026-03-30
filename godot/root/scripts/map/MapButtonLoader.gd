extends Node2D
class_name MapButtonLoader

const MAP_LEVEL_TEMPLATE : PackedScene = preload(Vars.Paths.PREFABS + "map/map_button.tscn")

@export var id : Vars.LEVEL
@export var level_scene : PackedScene

func _ready() -> void:

	var level : MapButton = MAP_LEVEL_TEMPLATE.instantiate()
	var data : Vars.LevelData = Game.get_level_data(id)
	level.initialize(data.name, data.difficulty, level_scene, data.stars_earned, data.elements)

	add_child(level)
