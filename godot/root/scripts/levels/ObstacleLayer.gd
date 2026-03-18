extends TileMapLayer
class_name ObstacleLayer

var impassible: Dictionary
var barriers: Dictionary

var navigator : PathNavigator = PathNavigator.new()

func place_barrier(coordinates: Vector2i) -> void:
	barriers[coordinates] = load(Vars.Paths.PREFABS + "level_entities/other/barricade.tscn").instantiate()
	add_child(barriers[coordinates])
	barriers[coordinates].global_position = to_global(map_to_local(coordinates))
