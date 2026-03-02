class_name SaveData
extends Node
## Base script for save data in save files.
## [br][br]
## Original File MIT License Copyright (c) 2024 TinyTakinTeller

## If left empty, will fallback to name of the node.
@export var category: String = ""
## Metadata is loaded before save file is selected.
@export var metadata: bool = false

var _export_var_names: Array[String] = []


func _ready() -> void:
	_init_export_vars()


## Custom updates after any modifications to save file.
func saved(_index: int = -1) -> void:
	pass  # override this


## Custom updates after save file was selected and loaded.
func selected_and_loaded(_index: int = -1) -> void:
	pass  # override this


## Clear data vars to defaults.
func clear(_index: int = -1) -> void:
	push_error("Not implemented.")  # override this


func is_metadata() -> bool:
	return metadata


func get_category() -> String:
	if StringUtils.is_empty(category):
		return name
	return category


## Returns list of data vars names.
func get_export_var_names() -> Array[String]:
	return _export_var_names


func get_as_dict() -> Dictionary:
	var dict: Dictionary = {}
	for var_name: String in get_export_var_names():
		if var_name in self:
			dict[var_name] = self.get(var_name)
	return dict


func set_from_dict(dict: Dictionary, index: int = -1) -> void:
	clear(index)
	for var_name: String in dict:
		Lib.debug(LevelManager.log_stream, ["Found var ", var_name, "=", dict[var_name]])
		if var_name in self:
			#if var_val.begins_with("{"):
			if dict[var_name] is Dictionary:
				Lib.debug(LevelManager.log_stream, ["Is dictionary"])
				var var_dict : Dictionary = dict[var_name] #MarshallsUtils.string_to_dict(var_val)
				if var_dict.has("DUMMY"):
					Lib.debug(LevelManager.log_stream, ["Found DUMMY, it's ", var_dict["DUMMY"]])
				
				#if self.has_method("set_stars"):
					#Lib.debug(LevelManager.log_stream, ["CALLING"])
					#self.call("set_stars", LevelManager.LEVEL_ID.DUMMY, 4)
				if self.has_method("load_stars_earned"):
					Lib.debug(LevelManager.log_stream, ["CALLING"])
					self.call("load_stars_earned", var_dict)
			else:
				self.set(var_name, dict[var_name])
			Lib.debug(LevelManager.log_stream, ["Set ", var_name, " to ", dict[var_name]])


## return true if variable is not private (no underscore prefix) and is a plain script variable
func _is_valid_export_var(property_name: String, property_usage: int) -> bool:
	if property_name[0] == "_":
		return false
	return property_usage == PropertyUsageFlags.PROPERTY_USAGE_SCRIPT_VARIABLE


func _init_export_vars() -> void:
	var properties: Array[Dictionary] = (self.get_script() as Script).get_script_property_list()
	for property: Dictionary in properties:
		var property_name: String = property["name"]
		#var property_class_name: String = property["class_name"]
		#var property_type: int = property["type"]
		#var property_hint: int = property["hint"]
		#var property_hint_string: String = property["hint_string"]
		var property_usage: int = property["usage"]

		var is_valid: bool = _is_valid_export_var(property_name, property_usage)
		if is_valid:
			_export_var_names.append(property_name)
