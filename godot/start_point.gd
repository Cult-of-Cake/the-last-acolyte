extends Area2D

var thePath

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
func calculate_path():
	#%MainPathfinder.target_position = %EndPoint.global_position
	#print(%MainPathfinder.is_target_reachable())
	#var path_points
	#var path_tiles = []
	#if(%MainPathfinder.is_target_reachable()):
		#path_points = %MainPathfinder.get_current_navigation_path()
		#for point in path_points:
			#var local_coords = %SimpleTiles.to_local(point)
			#var map_coords = %SimpleTiles.local_to_map(local_coords)
			#if !path_tiles.has(map_coords):
				#path_tiles.append(map_coords)
		##At this point we have at most a set of coordinates associated with each tile, no more.
		#thePath = Path2D.new()
		#thePath.curve = Curve2D.new()
		#for coords in path_tiles:
			#var local_coords = %SimpleTiles.map_to_local(coords)
			#var global_coords = %SimpleTiles.to_global(local_coords)
			##Then add it to the new path2d
			#thePath.curve.add_point(global_coords)
			#get_parent().add_child(thePath)
		#var newguy = load("res://dummySprite.tscn").instantiate()
		#thePath.add_child(newguy)
	var start_coords = %SimpleTiles.to_local(%StartPoint.global_position)
	start_coords = %SimpleTiles.local_to_map(start_coords)
	var end_coords = %SimpleTiles.to_local(%EndPoint.global_position)
	end_coords = %SimpleTiles.local_to_map(end_coords)
	var pathfinder = PathNavigator.new()
	var point_list = pathfinder.navigate(start_coords, end_coords, %SimpleTiles, null)
	thePath = Path2D.new()
	thePath.curve = Curve2D.new()
	thePath.name = "thePath"
	for point in point_list:
		var local_coords = %SimpleTiles.map_to_local(point)
		var global_coords = %SimpleTiles.to_global(local_coords)
		thePath.curve.add_point(global_coords)
	get_parent().add_child(thePath)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
