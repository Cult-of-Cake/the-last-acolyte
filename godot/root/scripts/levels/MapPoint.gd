extends Area2D
class_name MapPoint

@export var health_tracker : HealthTracker

var coordinates : Vector2i
var default_path : Path

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta : float) -> void:
	pass

func calculate_coordinates(tilemap : TileMapLayer) -> void:
	var local : Vector2i = tilemap.to_local(global_position)
	coordinates = tilemap.local_to_map(local)

func take_damage(amount : float) -> void:
	if health_tracker:
		health_tracker.take_damage(amount)
