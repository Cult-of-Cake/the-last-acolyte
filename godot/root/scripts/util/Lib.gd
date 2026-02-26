extends Node
class_name Lib

#region Objects
class Objects:

	static func find_child_of_type(parent : Node, type : Variant, recursive : bool = false) -> Node2D:
		for child in parent.get_children():
			#print ("TYPE: Checking if ", child.name, " (", child.get_class(), ") is type ", type)
			if is_instance_of(child, type):
				return child
			if recursive:
				var grandchild : Node2D = find_child_of_type(child, type, true)
				if grandchild != null:
					return grandchild
		return null
	static func has_child_of_type(parent : Node, type : Variant) -> bool:
		var found : Node = find_child_of_type(parent, type)
		return found != null

#endregion

func _ready() -> void:
	print("huh")

#region Strings
static func join(messages:Array) -> String:
	return "".join(messages)
#endregion

#region Logging

# I want to make it easier to log to specific streams.
# Define the streams here - in the enum and also the array for its title
enum LOG { ACTIONS, MOVEMENT }
static var streams_text : Array = ["ACTION", "MOVE"]
const DEFAULT_LEVEL : Log.LogLevel = Log.LogLevel.INFO

# These can be left alone.  The first is auto-filled and the second is what fills it
static var streams : Array = []
static var throwaway : LogByStream = LogByStream.new()

# Log by stream - also accept arrays for easy concatenation
static func debug(stream : LOG, messages:Array, values:Variant=null) -> void:
	streams[stream].debug(Lib.join(messages), values)
static func info(stream : LOG, messages:Array, values:Variant=null) -> void:
	streams[stream].info(Lib.join(messages), values)
static func warn(stream : LOG, messages:Array, values:Variant=null) -> void:
	streams[stream].warn(Lib.join(messages), values)
static func error(stream : LOG, messages:Array, values:Variant=null) -> void:
	streams[stream].error(Lib.join(messages), values)

# Getting and setting log level by stream
static func set_log_level(stream : LOG, level : Log.LogLevel) -> void:
	var s : LogStream = Lib.streams[int(stream)]
	s._set_level(level)
static func get_log_level(stream : LOG) -> Log.LogLevel:
	var s : LogStream = Lib.streams[int(stream)]
	return s.current_log_level

# These are just going to be much more common than the others, let's give a shorthand
static func enable_debug(stream : LOG) -> void:
	Lib.set_log_level(stream, Log.LogLevel.DEBUG)
static func is_debugging(stream : LOG) -> bool:
	return Lib.get_log_level(stream) == Log.LogLevel.DEBUG

class LogByStream:
	func _init() -> void:
		for idx in range(0, Lib.streams_text.size()):
			var s : LogStream = LogStream.new(Lib.streams_text[idx], DEFAULT_LEVEL)
			Lib.streams.append(s)

#endregion
