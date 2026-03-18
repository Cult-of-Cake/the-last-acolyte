class_name PathNavigator

###
var open: Dictionary[Vector2i, PathTile]

var closed: Dictionary

var goal: Dictionary
var goal_coordinates: Vector2i

var barricades: Dictionary

var start: Dictionary

var solved:bool = false

var the_tilemap: TileMapLayer

var impassible: Dictionary

var the_path : Array[Vector2i]

var logger := Lib.EasyLog.new(Lib.LOG.MOVEMENT)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


#TODO accept a list of barricaded tiles and add them to the list of barricades
func navigate(start_tile:Vector2i, goal_tile:Vector2i, tilemap:TileMapLayer) -> Array[Vector2i]:
	solved = false
	the_tilemap = tilemap
	var goal_data:TileData = tilemap.get_cell_tile_data(goal_tile)
	if !goal_data:
		logger.error("Goal coordinates outside tile map")
		return []
	if !goal_data.get_navigation_polygon(0).get_polygon(0):
		logger.error("Goal coordinates on an unwalkable tile")
		return []
	var first_tile : PathTile = build_PathTile(start_tile, 0)
	start[start_tile] = first_tile
	open[start_tile] = first_tile
	goal[goal_tile] = tilemap.get_cell_tile_data(goal_tile)
	goal_coordinates = goal_tile
	while open.size() > 0 && !solved:
		#start by just grabbing any open tile:
		var keys := open.keys()
		var best_next : PathTile = open[keys[0]]
		#Then compare it against all open tiles to find the best candidate to explore next
		for key in open:
			var candidate := open[key]
			if (
				candidate.combined_distance < best_next.combined_distance
				|| (
					candidate.combined_distance == best_next.combined_distance
					&& candidate.to_goal < best_next.to_goal
				)
			):
				best_next = candidate
		explore(best_next)
	if solved:
		return the_path
	else:
		return []


func explore(tile : PathTile) -> void:
	#potentially, there are up to 8 tiles that might be adjacent and walkable next to the tile being explores
	var top_coordinates := tile.coordinates + Vector2i(0, -1)
	var right_coordinates := tile.coordinates + Vector2i(1, 0)
	var bottom_coordinates := tile.coordinates + Vector2i(0, 1)
	var left_coordinates := tile.coordinates + Vector2i(-1, 0)
	var top_right_coordinates := tile.coordinates + Vector2i(1, -1)
	var bottom_right_coordinates := tile.coordinates + Vector2i(1, 1)
	var top_left_coordinates := tile.coordinates + Vector2i(-1, -1)
	var bottom_left_coordinates := tile.coordinates + Vector2i(-1, 1)
	
	var found_top : bool = check_coordinates(tile, top_coordinates, 10)
	var found_right : bool = check_coordinates(tile, right_coordinates, 10)
	var found_left : bool = check_coordinates(tile, left_coordinates, 10)
	var found_bottom : bool = check_coordinates(tile, bottom_coordinates, 10)

	#only attempt diagonal tiles if the "straight" moves to either side are both available
	#diagonal moves cost slightly more than straight ones
	if found_top && found_right:
		check_coordinates(tile, top_right_coordinates, 14)
	if found_right && found_bottom:
		check_coordinates(tile, bottom_right_coordinates, 14)
	if found_left && found_bottom:
		check_coordinates(tile, bottom_left_coordinates, 14)
	if found_left && found_top:
		check_coordinates(tile, top_left_coordinates, 14)

	#once exploration of the tile is complete, move it from open to closed
	closed[tile.coordinates] = tile
	open.erase(tile.coordinates)


#returns true if the test coordinates are in the tilemap and walkable, otherwise returns false
func check_coordinates(tile: PathTile, test_coordinates: Vector2i, cost : int) -> bool:
	if open.has(test_coordinates):
		var top_tile := open[test_coordinates]
		if top_tile.from_start > tile.from_start + 10:
			open[test_coordinates].from_start = tile.from_start + cost
			open[test_coordinates].combined_distance = (open[test_coordinates].from_start + open[test_coordinates].to_goal)
			open[test_coordinates].previous = tile.coordinates
		return true
	elif closed.has(test_coordinates):
		return true
	elif !closed.has(test_coordinates):
		#Only do it if the tile exists
		if is_walkable(test_coordinates):
			var new_tile := build_PathTile(test_coordinates, tile.from_start + cost)
			new_tile.previous = tile.coordinates
			open[test_coordinates] = new_tile
			if goal.has(test_coordinates):
				solved = true
				closed[tile.coordinates] = tile
				assemble_path(new_tile)
			return true
		else:
			return false
	else:
		return false


func is_walkable(coords : Vector2i) -> bool:
	var tile:TileData = the_tilemap.get_cell_tile_data(coords)
	if tile && tile.get_navigation_polygon(0) && tile.get_navigation_polygon(0).get_polygon_count() > 0 && !the_tilemap.impassible.has(coords):
		return true
	else:
		return false

func build_PathTile(coordinates: Vector2i, _from_start : int) -> PathTile:
	#It's really important to know if the tile is walkable
	var tile := PathTile.new()
	if the_tilemap.get_cell_tile_data(coordinates).get_navigation_polygon(0).get_polygon(0):
		tile.walkable = true
	else:
		tile.walkable = false

	#approximates a straight-line distance from this tile to the goal tile, ignoreing obstacles
	var x_distance : int = abs(coordinates.x - goal_coordinates.x)
	var y_distance : int = abs(coordinates.y - goal_coordinates.y)
	var big : int
	var small : int
	if x_distance > y_distance:
		big = x_distance
		small = y_distance
	else:
		big = y_distance
		small = x_distance
	var total_distance : int = small * 14 + ((big - small) * 10)
	tile.to_goal = total_distance

	#obviously this needs to be in there:
	tile.coordinates = coordinates

	#this will have to get passed in based on outside data
	tile.from_start = _from_start

	#primary favorability indicator for next search
	tile.combined_distance = tile.to_goal + tile.from_start

	return tile


func assemble_path(end_tile : PathTile) -> void:
	var current_tile := end_tile
	the_path.push_front(end_tile.coordinates)
	while current_tile.previous:
		the_path.push_front(current_tile.previous)
		current_tile = closed[current_tile.previous]
