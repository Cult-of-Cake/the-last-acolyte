extends ResourceLoaderBase
class_name AffinityLoader

@export var affinity : Vars.ELEMENT
@export var alpha : float = 1

func _ready() -> void:
	file = Vars.ELEMENT_ICONS[affinity]
	update_object()

func set_alpha(a : float) -> void:
	alpha = a
	update_object()

func update_object() -> void:
	super()
	var colour : Color = Vars.ELEMENT_COLOURS[affinity]
	colour.a = alpha
	loading_node.modulate = colour
