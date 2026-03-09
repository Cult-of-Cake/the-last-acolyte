extends Enemy
class_name PathFollowEnemy

var pathing_base : PathingBase
var follow_path : Path2D

func set_speed_multiplier(mult : float) -> void:
	super(mult)
	pathing_base.speed = true_speed
	
func initialize(spawner : MapPoint, end_goal : MapPoint) -> void:
	super(spawner, end_goal)
	# TODO: This is a bad, bad way to find Map but thePath shouldn't belong
	# to map anyway, since each spawner will eventually have its own default
	# path and orphaned paths etc, I suspect.  So fixing this can wait.
	var map : Map = get_tree().root.get_node("Level/Map")
	add_to_path(map.thePath)

# Path follow - MUST be the direct child of Path, so Enemy must be a child of that

func add_to_path(new_path : Path2D) -> void:
	follow_path = new_path
	if pathing_base == null:
		pathing_base = PathingBase.new()
		pathing_base.name = name + " Parent"
		pathing_base.rotates = false
		get_parent().add_child(pathing_base)
		move_node(self, pathing_base)
	move_node(pathing_base, follow_path)

func move_node(node : Node2D, new_parent : Node2D) -> void:
	node.get_parent().remove_child(node)
	new_parent.add_child(node)
