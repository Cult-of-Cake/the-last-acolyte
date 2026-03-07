extends TileMapLayer

var impassible: Dictionary
var barriers: Dictionary

var navigator = PathNavigator.new()

signal left_click(coords: Vector2)

# Called when the node enters the scene tree for the first time.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("left_click"):
		left_click.emit(get_global_mouse_position())

func place_barrier(coordinates: Vector2i) -> void:
	barriers[coordinates] = load("res://root/scenes/scene/level_entities/other/barricade.tscn").instantiate()
	add_child(barriers[coordinates])
	barriers[coordinates].global_position = to_global(map_to_local(coordinates))
