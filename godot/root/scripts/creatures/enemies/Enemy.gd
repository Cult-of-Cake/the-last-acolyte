extends Creature
class_name Enemy

@export var base_speed: float = 300
@export var path: PathingBase

var speed_multiplier: float = 1.0

func set_speed_multiplier(mult: float) -> void:
	speed_multiplier = mult
	path.speed = base_speed * speed_multiplier

func reset_speed() -> void:
	set_speed_multiplier(1.0)

# Path follow - MUST be the direct child of Path, so Enemy must be a child of that

var pathing_base : PathingBase
var follow_path : Path2D
func add_to_path(new_path : Path2D) -> void:
	if pathing_base == null:
		pathing_base = PathingBase.new()
		pathing_base.name = name + " Parent"
		pathing_base.rotates = false
		get_parent().add_child(pathing_base)
		move_node(self, pathing_base)
	self.follow_path = new_path
	move_node(pathing_base, follow_path)

func move_node(node : Node2D, new_parent : Node2D) -> void:
	node.get_parent().remove_child(node)
	new_parent.add_child(node)
