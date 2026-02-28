@icon("uid://b0ujitsmcmrbu")
extends Node2D
class_name ResourceLoaderBase

@export var loading_node : CanvasItem
@export var file : Resource

func _ready() -> void:
	update_object()

func set_file(newfile : Resource) -> void:
	file = newfile
	update_object()

func update_object() -> void:
	if loading_node.is_class("Sprite2D"):
		Lib.debug(Lib.LOG.ASSETS, ["Loading sprite ", file.resource_name])
		loading_node.texture = file
