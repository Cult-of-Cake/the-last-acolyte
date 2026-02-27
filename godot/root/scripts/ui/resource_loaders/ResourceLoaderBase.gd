@icon("uid://b0ujitsmcmrbu")
extends Node2D
class_name ResourceLoaderBase

const asset_directory_base = "res://root/assets/"
var _asset_directory_relative : String = ""
var _asset_extension : String = ".unknown"

@export var filename : String
@export var loading_node : CanvasItem

func set_file(fname : String) -> void:
	if filename != fname:
		filename = fname
		update_object()

func update_object() -> void:
	var fullfile : String = Lib.join([asset_directory_base, _asset_directory_relative, filename, _asset_extension])
	Lib.debug(Lib.LOG.ASSETS, ["ResourceLoader: ", fullfile, "type node ", typeof(loading_node),
		"type sprite2d ", typeof(Sprite2D), "type spriteloader ", typeof(SpriteLoader), "is class ", loading_node.is_class("SpriteLoader")])
	if typeof(loading_node) == typeof(TextEdit):
		Lib.debug(Lib.LOG.ASSETS, ["Is text"])
	if typeof(loading_node) == typeof(Sprite2D):
		Lib.debug(Lib.LOG.ASSETS, ["Is sprite"])
		loading_node.texture = Lib.get_texture(fullfile)
