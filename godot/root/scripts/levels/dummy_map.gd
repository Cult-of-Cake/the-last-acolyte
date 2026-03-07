extends Node2D

var the_path : Path
var paths : Array[Path]

@onready var tile_map : TileMapLayer = %SimpleTiles
@onready var navigator : PathNavigator = PathNavigator.new()
#Paths should be objects that keep a list of the involved tiles so they can check if added walls or obstacles interfere


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.delete_path.connect(delete_path)
	
	tile_map.left_click.connect(tile_clicked)
	var start_coords:Vector2 = get_node("StartPoints").get_node("StartPoint").get_global_position()
	var start_map:Vector2 = tile_map.local_to_map(tile_map.to_local(start_coords))
	var end_coords:Vector2 = get_node("EndPoints").get_node("EndPoint").get_global_position()
	var end_map:Vector2 = tile_map.local_to_map(tile_map.to_local(end_coords))
	calculate_path(start_map, end_map)
	
	get_node("StartPoints").get_node("StartPoint").calculate_coordinates(tile_map)
	get_node("EndPoints").get_node("EndPoint").calculate_coordinates(tile_map)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func calculate_path(start_coords: Vector2i, end_coords : Vector2i) -> void:
	var pathfinder:PathNavigator = PathNavigator.new()
	var point_list:Array[Vector2i] = pathfinder.navigate(start_coords, end_coords, %SimpleTiles)
	var thePath:Path = Path.new()
	thePath.curve = Curve2D.new()
	thePath.name = "thePath"
	if point_list:
		for point in point_list:
			thePath.map_points[point] = true
			var local_coords:Vector2 = %SimpleTiles.map_to_local(point)
			var global_coords:Vector2 = %SimpleTiles.to_global(local_coords)
			thePath.curve.add_point(global_coords)
	add_child(thePath)
	paths.append(thePath)
	thePath.is_default = true
	get_node("StartPoints").get_node("StartPoint").default_path = thePath

func _on_timer_timeout() -> void:
	var newguy:PathFollow2D = load("res://root/scenes/scene/levels/dummySprite.tscn").instantiate()
	var some_path : Path
	some_path = get_node("StartPoints").get_node("StartPoint").default_path
	if(some_path):
		some_path.add_child(newguy)
	#get_node("Timer").wait_time = 100

#This is currently the only thing that happens on a click, but attempting to place a barrier should be made into one of many things a player can do
func tile_clicked(coords:Vector2) ->void :
	var local:Vector2 = tile_map.to_local(coords)
	var tile:Vector2i = tile_map.local_to_map(local)
	if tile_map.impassible.has(tile):
		tile_map.impassible.erase(tile)
		tile_map.barriers[tile].queue_free()
		tile_map.barriers.erase(tile)
	else:
		#This needs to be added right away so the recalculations are correct.
		#If the new layout is invalid, it needs to be removed.
		tile_map.impassible[tile] = true
		tile_map.barriers[tile] = true

		#Also, somewhere in all that, it should probably make sure the tile is walkable to begin with

		#There's a whole shit pile of way to set this to false.
		var valid:bool = true
		var orphans : Array[PathFollow2D]
		var new_paths : Array[Path]
		#We need to check and potentially modify EVERY path that potentially exists
		for any_path in paths:
			if any_path.map_points.has(tile):
				var broken_path:Path = any_path
				#Find the break point and sort the path follows into the ones before and after it.
				var break_offset:float = broken_path.curve.get_closest_offset(broken_path.to_local(coords))
				#Build a list of every enemy who is cut off from the end point by the new barricade
				for guy in broken_path.get_children():
					if guy.progress && guy.progress < break_offset - 8: #In pixels, probalby about half a tile
						orphans.append(guy)
		

		#Make sure every enemy in that list can reach the goal by some new path
		for guy in orphans:
			var has_path:bool = false
			for path in new_paths:
				if path.intersects_enemy(guy):
					has_path = true
			if !has_path:
				navigator = PathNavigator.new()
				var points: Array[Vector2i] = navigator.navigate(tile_map.local_to_map(tile_map.to_local(guy.global_position)), get_node("EndPoints").get_node("EndPoint").coordinates, tile_map)
				if !points:
					valid = false
				else:
					var path:Path = Path.build_path(points, tile_map)
					has_path = true
					#It will sometimes be necessary to draw the path a little beyond its designated start square to ensure it intersects the enemy it was initially draw for
					if !path.intersects_enemy(guy):
						var actual_position_local:Vector2i = path.to_local(guy.global_position)
						path.curve.add_point(actual_position_local, Vector2(0,0), Vector2(0,0), 0)
					new_paths.append(path)
		#We need to make sure there is still some path from the start point to the goal point
		navigator = PathNavigator.new()
		var candidate_path: Path
		var candidate_points:Array[Vector2i] = navigator.navigate(get_node("StartPoints").get_node("StartPoint").coordinates, get_node("EndPoints").get_node("EndPoint").coordinates, tile_map)
		if !candidate_points:
			print("It's the main path that is broken")
			valid = false
		else:
			candidate_path = Path.build_path(candidate_points, tile_map)
			new_paths.append(candidate_path)

		#If valid, assign every enemy in the orphan list to one of the paths that was generated for the orphans
		if valid:
			tile_map.place_barrier(tile)
			for new_path in new_paths:
				paths.append(new_path)
				add_child(new_path)
			for guy in orphans:
				var placed : bool = false
				for new_path in new_paths:
					if !placed:
						if new_path.intersects_enemy(guy):
							var local_position:Vector2i = new_path.to_local(guy.global_position)
							placed = true
							guy.get_parent().remove_child(guy)
							new_path.add_child(guy)
							guy.progress = new_path.progress_at_point(local_position)
							add_child(new_path)
				#There is some rare mish-mash of coordinates which allows an enemy to not be placed at this point.  It must be placed somehwere.
				if !placed:
					print("This code has been reached")
					hard_place(guy)
			#if valid, replace the default path for the start point with the new start-to-finish path that was created
			if get_node("StartPoints").get_node("StartPoint").default_path.get_children().size() == 0:
				delete_path(get_node("StartPoints").get_node("StartPoint").default_path)
			else:
				get_node("StartPoints").get_node("StartPoint").default_path.is_default = false
			candidate_path.is_default = true
			candidate_path.name = "default"
			get_node("StartPoints").get_node("StartPoint").default_path = candidate_path
		
			#clean up any created paths that didn't end up getting used:
			for path in paths:
				#print(path, " has ", path.get_children().size(), " children and default is ", path.is_default)
				#print(path, "has children: ", path.get_children())
				if path.get_children().size() == 0 && !path.is_default:
					#print("delete should be getting called on path ", path)
					delete_path(path)
		else:
			#TODO Replace with meaningful feedback
			tile_map.impassible.erase(tile)
			tile_map.barriers.erase(tile)
			print("Barricade can not be placed there because some enemies would have no route to their goal")

func delete_path(dead_path: Path) -> void:
	dead_path.queue_free()
	paths.erase(dead_path)

#only runs when some goofy shit stops all the normal placement from running 
func hard_place(guy:PathFollow2D) -> void:
	var i : int = 0
	var local_coords : Vector2 = paths[0].to_local(guy.global_position)
	var closest_point : Vector2 = paths[0].curve.get_closest_point(local_coords)
	var best_distance : float = closest_point.distance_to(local_coords)
	var best_path : int  = i
	while(i < paths.size()):
		local_coords = paths[i].to_local(guy.global_position)
		closest_point = paths[i].curve.get_closest_point(local_coords)
		var distance : float = closest_point.distance_to(local_coords)
		if distance < best_distance:
			best_distance = distance
			best_path = i
		i = i + 1
	var progress:float  = paths[best_path].curve.get_closest_offset(paths[best_path].to_local(guy.global_position))
	guy.get_parent().remove_child(guy)
	paths[best_path].append_child(guy)
	guy.progress = progress
