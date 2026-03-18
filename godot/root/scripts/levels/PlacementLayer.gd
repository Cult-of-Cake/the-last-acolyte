extends TileMapLayer
class_name PlacementLayer

var barriers : Array[Sprite2D] = []

func _ready() -> void:
	for obj : Sprite2D in find_children("*", "Sprite2D", false) as Array[Sprite2D]:
		barriers.append(obj)

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
	obj.global_position = to_global(map_to_local(coordinates))
