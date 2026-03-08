extends TileMapLayer
class_name ObstacleLayer

var impassible: Dictionary
var barriers: Dictionary

var navigator : PathNavigator = PathNavigator.new()

signal left_click(coords: Vector2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("left_click"):
		left_click.emit(get_global_mouse_position())

func place_barrier(coordinates: Vector2i) -> void:
	barriers[coordinates] = load("res://root/scenes/scene/level_entities/other/barricade.tscn").instantiate()
	add_child(barriers[coordinates])
	barriers[coordinates].global_position = to_global(map_to_local(coordinates))
