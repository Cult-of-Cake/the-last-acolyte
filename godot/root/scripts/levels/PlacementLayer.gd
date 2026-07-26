extends TileMapLayer
class_name PlacementLayer

var barriers : Array[Sprite2D] = []
var placed_nodes: Dictionary[Vector2i, Node]

func _ready() -> void:
	SignalBus.lvl_pet_result.connect(on_tower_selected)
	for obj : Sprite2D in find_children("*", "Sprite2D", false) as Array[Sprite2D]:
		barriers.append(obj)

#region Barriers
func get_barrier_sprite(n : int = -1) -> Sprite2D:
	if n >= 0 and n < barriers.size():
		return barriers[n]
	else:
		var rnd : int = randi() % barriers.size()
		return barriers[rnd]

func place_barrier(coordinates: Vector2i) -> void:
	var obj : Sprite2D = get_barrier_sprite().duplicate()
	obj.visible = true
	add_child(obj)
	placed_nodes[coordinates] = obj
	obj.global_position = to_global(map_to_local(coordinates))

# FIXME This is bugged to heck but better than we had before
func remove_barrier(coordinates : Vector2i) -> void:
	if placed_nodes.has(coordinates):
		var obj : Node = placed_nodes[coordinates]
		remove_child(obj)
		placed_nodes.erase(obj)
#endregion

#region Towers

var selected_tower : Tower
var placed_towers : Dictionary[Vector2i, Tower]

func on_tower_selected(tower : Tower) -> void:
	selected_tower = tower

func place_tower(coordinates: Vector2i) -> void:
	out.TD.info(["Placing tower ", selected_tower.data.given_name, " at ", coordinates])
	placed_towers[coordinates] = selected_tower
	add_child(selected_tower)
	selected_tower.global_position = to_global(map_to_local(coordinates))
	SignalBus.lvl_pet_placed.emit(coordinates)
	
#endregion
