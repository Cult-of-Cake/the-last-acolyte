extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	NavigationServer2D.map_changed.connect(_on_map_changed)

func _on_map_changed(map):
	print("map changed")
	%StartPoint.calculate_path()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	var newguy = load("res://root/scenes/scene/levels/dummySprite.tscn").instantiate()
	var the_path = get_node("thePath")
	the_path.add_child(newguy)
