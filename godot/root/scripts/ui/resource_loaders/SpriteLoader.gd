@icon("uid://b0ujitsmcmrbu")
extends ResourceLoaderBase
class_name SpriteLoader

@export var colour : Color

func _ready() -> void:
	Lib.enable_debug(Lib.LOG.ASSETS)
	_asset_extension = ".png"
	_asset_directory_relative = "PLACEHOLDERS/Laura/Elements/"
	update_object()

func set_icon(fname : String, c : Color) -> void:
	colour = c
	set_file(fname)

func update_object() -> void:
	super()
	loading_node.modulate = colour
