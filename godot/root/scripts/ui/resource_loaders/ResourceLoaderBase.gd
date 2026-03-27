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
	if loading_node is Sprite2D:
		if file:
			out.ASSETS.debug(["Loading sprite ", file.resource_name])
			loading_node.texture = file
	if loading_node is TextureRect:
		if file:
			out.ASSETS.debug(["Loading texture ", file.resource_name])
			loading_node.texture = file
