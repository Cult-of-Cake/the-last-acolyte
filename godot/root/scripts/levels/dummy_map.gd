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
	#var newguy = load("res://root/scenes/scene/levels/BasicEnemy.tscn").instantiate()
	var the_path : Path2D = get_node("thePath")
	var newguy : Enemy = %WaveManager.get_next_enemy(the_path).instantiate()
	newguy.position = %StartPoint.position
	the_path.add_child(newguy)
	
	if newguy.is_class("FlyingEnemy"):
		newguy.set_goal(%EndPoint)
	else:
		newguy.add_to_path(the_path)
		
