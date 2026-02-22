class_name PathNavigator

var open: Dictionary

var closed: Dictionary

var goal: Dictionary
var goal_coordinates: Vector2

var barricades: Dictionary

var start: Dictionary

var solved = false

var the_tilemap: TileMapLayer

var the_path = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#TODO accept a list of barricaded tiles and add them to the list of barricades
func navigate(start_tile:Vector2, goal_tile:Vector2, tilemap, barricades):
	the_tilemap = tilemap
	var goal_data = tilemap.get_cell_tile_data(goal_tile) 
	if !goal_data:
		print("error: goal coordinates is outside tile map")
		return false
	if !goal_data.get_navigation_polygon(0).get_polygon(0):
		print("error: goal coordinate are an unwalkable tile")
		return false
	var first_tile = build_PathTile(start_tile, 0)
	start[start_tile] = first_tile
	open[start_tile] = first_tile
	goal[goal_tile] = tilemap.get_cell_tile_data(goal_tile)
	goal_coordinates = goal_tile
	while(open.size() > 0 && !solved):
		#start by just grabbing any open tile:
		var keys = open.keys()
		var best_next = open[keys[0]]
		#Then compare it against all open tiles to find the best candidate to explore next
		for key in open:
			var candidate = open[key]
			if(candidate.combined_distance < best_next.combined_distance || (candidate.combined_distance == best_next.combined_distance && candidate.to_goal < best_next.to_goal)):
				best_next = candidate
		explore(best_next)
	return the_path

func explore(tile):
	#potentially, there are up to 8 tiles that might be adjacent and walkable next to the tile being explores
	var top_coordinates = tile.coordinates + Vector2(0, -1)
	var right_coordinates = tile.coordinates + Vector2(1, 0)
	var bottom_coordinates = tile.coordinates + Vector2(0, 1)
	var left_coordinates = tile.coordinates + Vector2(-1, 0)
	var top_right_coordinates = tile.coordinates + Vector2(1, -1)
	var bottom_right_coordinates = tile.coordinates + Vector2(1, 1)
	var top_left_coordinates = tile.coordinates + Vector2(-1, -1)
	var bottom_left_coordinates = tile.coordinates + Vector2(-1, 1)
	
	top_coordinates = check_coordinates(tile, top_coordinates, 10)
	right_coordinates = check_coordinates(tile, right_coordinates, 10)
	left_coordinates = check_coordinates(tile, left_coordinates, 10)
	bottom_coordinates = check_coordinates(tile, bottom_coordinates, 10)
	
	#only attempt diagonal tiles if the "straight" moves to either side are both available
	#diagonal moves cost slightly more than straight ones
	if top_coordinates && right_coordinates:
		top_right_coordinates = check_coordinates(tile, top_right_coordinates, 14)
	if right_coordinates && bottom_coordinates:
		bottom_right_coordinates = check_coordinates(tile, bottom_right_coordinates, 14)
	if left_coordinates && bottom_coordinates:
		bottom_left_coordinates = check_coordinates(tile, bottom_left_coordinates, 14)
	if left_coordinates && top_coordinates:
		top_left_coordinates = check_coordinates(tile, top_left_coordinates, 14)
	
	#once exploration of the tile is complete, move it from open to closed
	closed[tile.coordinates] = tile
	open.erase(tile.coordinates)
	
#returns true if the test coordinates are in the tilemap and walkable, otherwise returns false
func check_coordinates(tile: PathTile, test_coordinates: Vector2, cost):
	if open.has(test_coordinates):
		var top_tile = open[test_coordinates]
		if top_tile.from_start > tile.from_start + 10:
			open[test_coordinates].from_start = tile.from_start + cost
			open[test_coordinates].combined_distance = open[test_coordinates].from_start + open[test_coordinates].to_goal
		return true
	elif closed.has(test_coordinates):
		return true
	elif !closed.has(test_coordinates):
		#Only do it if the tilemap exists
		var tile_data = the_tilemap.get_cell_tile_data(test_coordinates)
		if tile_data && tile_data.get_navigation_polygon(0) && tile_data.get_navigation_polygon(0).get_polygon(0):
			var new_tile = build_PathTile(test_coordinates, tile.from_start + cost)
			new_tile.previous = tile.coordinates
			open[test_coordinates] = new_tile
			if goal.has(test_coordinates):
				solved = true
				closed[tile.coordinates] = tile
				assemble_path(new_tile)
			return true
	else:
		return false


func is_walkable(tile):
	if tile.get_navigation_polygon(0).get_polygon(0):
		return true
	else:
		return false

func build_PathTile(coordinates: Vector2, _from_start):
	#It's really important to know if the tile is walkable
	var tile = PathTile.new()
	if the_tilemap.get_cell_tile_data(coordinates).get_navigation_polygon(0).get_polygon(0):
		tile.walkable = true
	else:
		tile.walkable = false
		
	#approximates a straight-line distance from this tile to the goal tile, ignoreing obstacles
	var x_distance = abs(coordinates.x - goal_coordinates.x)
	var y_distance = abs(coordinates.y - goal_coordinates.y)
	var big
	var small
	if(x_distance > y_distance):
		big = x_distance
		small = y_distance
	else:
		big = y_distance
		small = x_distance
	var total_distance = small * 14 + ((big-small) * 10)
	tile.to_goal = total_distance
	
	#obviously this needs to be in there:
	tile.coordinates = coordinates
	
	#this will have to get passed in based on outside data
	tile.from_start = _from_start
	
	#primary favorability indicator for next search
	tile.combined_distance = tile.to_goal + tile.from_start
	
	return tile
	
func assemble_path(end_tile):
	var current_tile = end_tile
	the_path.push_front(end_tile.coordinates)
	while(current_tile.previous):
		the_path.push_front(current_tile.previous)
		current_tile = closed[current_tile.previous]
