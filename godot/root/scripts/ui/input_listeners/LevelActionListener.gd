extends ActionListenerBase
class_name LevelActionListener

signal left_click(coords: Vector2)

@export var tiles : TileMapLayer
@export var map : Map
@export var cursor : GhostCursor

enum CLICK_MODE { NONE, BARRIERS, TOWERS }
var current_mode : CLICK_MODE

var tile_scale : Vector2i

func _ready() -> void:

	tile_scale = tiles.scale.x * tiles.tile_set.tile_size
	set_mode(CLICK_MODE.NONE)

	# Prepare listeners
	left_click.connect(on_click)

	# Placement shortcut keys
	actions["lvl_ui_barrier"] = on_key_barrier
	actions["lvl_ui_favourite"] = on_key_favourite
	actions["lvl_ui_tribe"] = on_key_tribe
	#actions["lvl_ui_affinity"] = on_key_affinity
	actions["lvl_ui_element"] = on_key_element
	#actions["lvl_ui_cosmic"] = on_key_cosmic
	actions["lvl_ui_reset_filters"] = on_key_reset_filters
	actions["lvl_ui_pick_01"] = on_key_T1
	actions["lvl_ui_pick_02"] = on_key_T2
	actions["lvl_ui_pick_03"] = on_key_T3
	actions["lvl_ui_pick_04"] = on_key_T4
	actions["lvl_ui_pick_05"] = on_key_T5

func _input(event: InputEvent) -> void:
	if event is InputEventMouse:
		var mouse_posn := get_global_mouse_position()
		if event is InputEventMouseMotion:
			on_mouse_moved(mouse_posn)
		else:
			if event.is_action_released("left_click"):
				left_click.emit(mouse_posn)
	else:
		super(event)



#region Click

func set_mode(mode : CLICK_MODE) -> void:
	current_mode = mode
	match mode:
		CLICK_MODE.BARRIERS:
			cursor.set_to_barrier()
		CLICK_MODE.TOWERS:
			cursor.set_to_tower()
		_:
			cursor.unset()
	out.ACTIONS.debug((["Set mode to: ", mode]))

func on_click(coords : Vector2) -> void:
	var placed : bool = false
	match current_mode:
		CLICK_MODE.BARRIERS:
			placed = map.place_barrier(coords)
		CLICK_MODE.TOWERS:
			placed = map.place_barrier(coords, true)
	if !placed:
		cursor.flash_red()


#endregion

#region Movement

var prev_tile : Vector2i

func on_mouse_moved(mouse_posn : Vector2i) -> void:
	var new_tile := tiles.local_to_map(tiles.to_local(mouse_posn)) * tile_scale
	if new_tile != prev_tile:
		prev_tile = new_tile
		cursor.mouse_moved_to(new_tile)

#endregion

#region Tower Filter

var placing_tower : int

func on_key_barrier() -> void:
	if current_mode == CLICK_MODE.BARRIERS:
		set_mode(CLICK_MODE.NONE)
	else:
		set_mode(CLICK_MODE.BARRIERS)

func on_key_favourite() -> void:
	SignalBus.lvl_pet_filter_cycle_favourite.emit()
func on_key_tribe() -> void:
	SignalBus.lvl_pet_filter_cycle_tribe.emit()
func on_key_element() -> void:
	SignalBus.lvl_pet_filter_cycle_affinity.emit()
func on_key_reset_filters() -> void:
	SignalBus.lvl_pet_filter_reset.emit()
func on_key_T1() -> void:
	on_numbered_key(0)
func on_key_T2() -> void:
	on_numbered_key(1)
func on_key_T3() -> void:
	on_numbered_key(2)
func on_key_T4() -> void:
	on_numbered_key(3)
func on_key_T5() -> void:
	on_numbered_key(4)
func on_numbered_key(posn : int) -> void:
	set_mode(CLICK_MODE.TOWERS)
	placing_tower = posn
	SignalBus.lvl_pet_pick.emit(posn)

#endregion
