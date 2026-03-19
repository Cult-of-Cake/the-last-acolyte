class_name Path extends Path2D

var map_points: Dictionary
var is_default: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	is_default = false
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

static func build_path(point_list: Array[Vector2i], tile_map: TileMapLayer) -> Path:
	var path:Path = Path.new()
	path.curve = Curve2D.new()
	for point in point_list:
		path.map_points[point] = true
		var global_coords : Vector2 = tile_map.to_global(tile_map.map_to_local(point))
		path.curve.add_point(global_coords)
	return path

func intersects_enemy(enemy: PathFollow2D) -> bool:
	var closest_point:Vector2 = curve.get_closest_point(enemy.global_position)
	if closest_point.distance_to(enemy.global_position) < 2: #hard coded cutoff for now, in pixels, TODO
		return true
	else:
		return false

func progress_at_point(point: Vector2) -> float:
	var offset:float = curve.get_closest_offset(point)
	return offset
	
func get_ordered_follows() -> Array[PathFollow2D]:
	var enemies: Array[PathFollow2D]
	var children:Array[Node] = self.get_children()
	for child in children:
		if child.is_class("PathFollow2D"):
			enemies.append(child)
	enemies.sort_custom(sort_by_progress)
	return enemies
	
func sort_by_progress(a:PathFollow2D, b:PathFollow2D ) -> bool:
	var rv: bool
	if a.progress < b.progress:
		rv = true
	else:
		rv = false
	return rv
