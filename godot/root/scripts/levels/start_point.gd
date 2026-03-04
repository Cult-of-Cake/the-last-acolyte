extends Area2D
class_name StartPoint

# IMPORTANT: Take Paul's version of this!!!

@export var navigation_layer: TileMapLayer
@export var start_point: Node2D  # TODO: Array
@export var end_point: Node2D  # TODO: Array

var thePath


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func calculate_path():
	var start_coords : Vector2 = navigation_layer.to_local(start_point.global_position)
	start_coords = navigation_layer.local_to_map(start_coords)
	var end_coords : Vector2 = navigation_layer.to_local(end_point.global_position)
	end_coords = navigation_layer.local_to_map(end_coords)
	var pathfinder = PathNavigator.new()
	var point_list = pathfinder.navigate(start_coords, end_coords, navigation_layer, null)
	thePath = Path2D.new()
	thePath.curve = Curve2D.new()
	thePath.name = "thePath"
	for point in point_list:
		var local_coords = navigation_layer.map_to_local(point)
		var global_coords = navigation_layer.to_global(local_coords)
		thePath.curve.add_point(global_coords)
	get_parent().add_child(thePath)
	if %Enemy:
		%Enemy.add_to_path(thePath)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
