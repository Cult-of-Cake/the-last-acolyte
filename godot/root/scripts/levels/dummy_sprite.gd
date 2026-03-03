extends PathFollow2D

var speed = 75

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress = progress + (speed * delta)
	if progress_ratio >= 1:
		var parent_path:Path = get_parent()
		parent_path.remove_child(self)
		if parent_path.get_children().size() == 0 && !parent_path.is_default:
			SignalBus.delete_path.emit(parent_path)
		goal_reached()
		
func goal_reached() -> void:
	queue_free()
