extends Enemy
class_name PathFollowEnemy

var pathing_base : PathingBase
var follow_path : Path2D

func set_speed_multiplier(mult : float) -> void:
	super(mult)
	pathing_base.speed = true_speed
	
func initialize(spawner : MapPoint, end_goal : MapPoint) -> void:
	super(spawner, end_goal)
	add_to_path(spawner.default_path)

# Path follow objects MUST be the direct child of Path, so we must be a child of that.
# Since we're trying to follow the logical structure of significant functionality
# being put in child nodes of significant objects, each Enemy is its own main
# scene (prefab) but THIS enemy re-parents itself under Path (as needs must) on init.

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
