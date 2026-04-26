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
		_:
			cursor.turn_off()
	out.ACTIONS.debug((["Set mode to: ", mode]))

func on_click(coords : Vector2) -> void:
	match current_mode:
		CLICK_MODE.BARRIERS:
			var placed : bool = map.place_barrier(coords)
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
# F turns favourites-only on or off
# T cycles tribe, then back to all
# E cycles affinity through the elements, then back to all
# C cycles affinity through the cosmics, then back to all
# A cycles either affinity - elements then cosmics - then back to all
# 1 through 9 places the 1st through 9th displayed tower
# X resets all filters

var NO_FILTER : int = -1
var FAVES_FILTER_DEFAULT : bool = true
var TRIBE_FILTER_DEFAULT : int = NO_FILTER
var AFFINITY_FILTER_DEFAULT : int = NO_FILTER
var faves_filter : bool = FAVES_FILTER_DEFAULT
var tribe_filter : int = TRIBE_FILTER_DEFAULT
var affinity_filter : int = AFFINITY_FILTER_DEFAULT
var placing_tower : int

@export var barrier_button : ImageCycler
@export var faves_button : ImageCycler
@export var tribe_button : ImageCycler
@export var affinity_button : ImageCycler

func on_key_barrier() -> void:
	if current_mode == CLICK_MODE.BARRIERS:
		set_mode(CLICK_MODE.NONE)
		barrier_button.show_none()
	else:
		set_mode(CLICK_MODE.BARRIERS)
		barrier_button.set_to_image(0)

func on_key_favourite() -> void:
	faves_filter = !faves_filter
	if faves_filter:
		faves_button.set_to_image(0)
	else:
		faves_button.show_none()

func on_key_tribe() -> void:
	if tribe_filter == NO_FILTER:
		tribe_filter = 1
	else:
		tribe_filter += 1
		if tribe_filter >= Vars.ROLE.size() - 1:
			tribe_filter = NO_FILTER

# A is being used by WASD anyway, let's just figure this out if/when cosmic gets added
#func on_key_affinity() -> void:
	#if affinity_filter == NO_FILTER:
		#affinity_filter = 1
	#else:
		#affinity_filter += 1
		#if affinity_filter >= Vars.ELEMENT.size() - 1: #TODO: + COSMIC - 1 ?
			## If we end up with an AFFINITY enum that just has all, maybe we update
			## the later functions instead to use AFFINITY.size / 2 ?
			#affinity_filter = NO_FILTER

func on_key_element() -> void:
	if affinity_filter == NO_FILTER:
		affinity_filter = 0
	else:
		affinity_filter += 1
		if affinity_filter >= Vars.ELEMENT.size() - 1:
			affinity_filter = NO_FILTER
	out.ACTIONS.debug(["Affinity filter: ", affinity_filter])
	# And update the icon
	if affinity_filter == NO_FILTER:
		affinity_button.show_all()
	else:
		affinity_button.set_to_image(affinity_filter)

func on_key_reset_filters() -> void:
	faves_filter = FAVES_FILTER_DEFAULT
	tribe_filter = TRIBE_FILTER_DEFAULT
	affinity_filter = AFFINITY_FILTER_DEFAULT

#endregion
