extends ResourceLoaderBase
class_name SpriteLoader

@export var colour : Color

func _ready() -> void:
	super()

func set_icon(img : CompressedTexture2D, c : Color) -> void:
	file = img
	colour = c
	update_object()

func update_object() -> void:
	super()
	loading_node.modulate = colour
