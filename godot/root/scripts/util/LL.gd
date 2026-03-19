extends Node
class_name LL

# Not global. Just static.
# Because here I am trying to make logging even easier, again.
# At this point I'm not sure that I haven't gone full-circle.

static var ACTIONS : Lib.EasyLog
static var MOVEMENT : Lib.EasyLog
static var ASSETS : Lib.EasyLog
static var SAVE_SYSTEM : Lib.EasyLog
static var PATHING : Lib.EasyLog
static var DIALOGUE : Lib.EasyLog

static func init_log_streams() -> void:
	ACTIONS = Lib.EasyLog.new(Lib.LOG.ACTIONS)
	MOVEMENT = Lib.EasyLog.new(Lib.LOG.MOVEMENT)
	ASSETS = Lib.EasyLog.new(Lib.LOG.ASSETS)
	SAVE_SYSTEM = Lib.EasyLog.new(Lib.LOG.SAVE_SYSTEM)
	PATHING = Lib.EasyLog.new(Lib.LOG.PATHING)
	DIALOGUE = Lib.EasyLog.new(Lib.LOG.DIALOGUE)
