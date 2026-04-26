extends ResourceLoaderBase
class_name TribeLoader

@export var tribe : Vars.ROLE
@export var alpha : float = 1

func _ready() -> void:
	file = Vars.ROLE_ICONS[tribe]
	update_object()

func set_alpha(a : float) -> void:
	alpha = a
	update_object()

func update_object() -> void:
	super()
	var colour : Color = Vars.ROLE_COLOURS[tribe]
	colour.a = alpha
	loading_node.modulate = colour
