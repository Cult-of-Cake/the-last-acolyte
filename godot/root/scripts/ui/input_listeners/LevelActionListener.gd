extends ActionListenerBase
class_name LevelActionListener

signal left_click(coords: Vector2)

@export var tiles : PlacementLayer
@export var map : Map
@export var cursor : GhostCursor

enum CLICK_MODE { BARRIERS }
var current_mode : CLICK_MODE

var tile_scale : Vector2i

func _ready() -> void:

	tile_scale = tiles.scale.x * tiles.tile_set.tile_size
	set_mode(CLICK_MODE.BARRIERS)

	# Prepare listeners
	left_click.connect(place_barrier)

	# TODO: We need to figure out how we want to do this.  Likely a keyboard shortcut for
	# some actions, but also a UI for everything, and the keyboard shortcuts will likely
	# reflect how the UI is set up.  For example if barrier is just a special tower/pet,
	# then maybe "ctrl" gets you to your pets and "1" is barrier.  If not, maybe it's "B".
	#actions["level_barrier"] = set_mode#(CLICK_MODE.BARRIERS)

func _input(event: InputEvent) -> void:
	if event is InputEventMouse:
		var mouse_posn := get_global_mouse_position()
		if event is InputEventMouseMotion:
			on_mouse_moved(mouse_posn)
		else:
			if event.is_action_released("left_click"):
				left_click.emit(mouse_posn)

#region Click

func set_mode(mode : CLICK_MODE) -> void:
	current_mode = mode
	match mode:
		CLICK_MODE.BARRIERS:
			cursor.set_to_barrier()

func place_barrier(coords : Vector2) -> void:
	map.place_barrier(coords)

#endregion

#region Movement

var prev_tile : Vector2i

func on_mouse_moved(mouse_posn : Vector2i) -> void:
	var new_tile := tiles.local_to_map(tiles.to_local(mouse_posn)) * tile_scale
	if new_tile != prev_tile:
		prev_tile = new_tile
		cursor.mouse_moved_to(new_tile)

#endregion
