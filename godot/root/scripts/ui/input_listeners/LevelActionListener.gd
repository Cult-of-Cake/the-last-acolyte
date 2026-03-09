extends ActionListenerBase
class_name LevelActionListener

enum CLICK_MODE { BARRIERS }
var current_mode : CLICK_MODE

func _ready() -> void:
	
	set_mode(CLICK_MODE.BARRIERS)
	# Prepare listeners
	# TODO: We need to figure out how we want to do this.  Likely a keyboard shortcut for
	# some actions, but also a UI for everything, and the keyboard shortcuts will likely
	# reflect how the UI is set up.  For example if barrier is just a special tower/pet,
	# then maybe "ctrl" gets you to your pets and "1" is barrier.  If not, myabe it's "B".
	#actions["level_barrier"] = set_mode#(CLICK_MODE.BARRIERS)
	tile_map.left_click.connect(place_barrier)

#region Click

@export var tile_map : ObstacleLayer
@export var map : Map

func set_mode(mode : CLICK_MODE) -> void:
	current_mode = mode

func place_barrier(coords : Vector2) -> void:
	map.place_barrier(coords)



#endregion
