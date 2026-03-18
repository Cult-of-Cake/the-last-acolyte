extends Node2D
class_name WaveManager

var spawn_timer : Timer

@export var map : Map
@export var map_scale : float = 1.0

func _ready() -> void:
	spawn_timer = Timer.new()
	spawn_timer.timeout.connect(_on_timer_timeout)
	add_child(spawn_timer)
	spawn_timer.start()

func _on_timer_timeout() -> void:
	var newguy : Enemy = get_next_enemy().instantiate()
	newguy.scale *= map_scale
	newguy.initialize(map.start_point, map.end_point)

# TODO: At some point, we'll have actual wave patterns, stored somewhere.
# But for now, I'm just putting something together that lets us test some things.

var simple_pattern : Array[PackedScene] = [
	Vars.basic_enemy, Vars.basic_enemy, Vars.basic_enemy, Vars.basic_enemy,
	Vars.flying_enemy, Vars.flying_enemy
]
var posn_in_pattern : int = 0

func get_next_enemy() -> PackedScene:
	var next : PackedScene = simple_pattern[posn_in_pattern]
	posn_in_pattern += 1
	posn_in_pattern %= simple_pattern.size() # Loop to the start after reaching the end
	return next
