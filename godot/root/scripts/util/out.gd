extends Node
class_name out

# Not global. Just static.
# Because here I am trying to make logging even easier, again.
# At this point I'm not sure that I haven't gone full-circle.

# I was trying to avoid needing to remember which log stream you're using in a
# given class, but that meant having to instantiate the streams everywhere, which
# ALSO meant they were getting set to debug on/off all over the place, making it
# difficult to actually turn everything off when you need to.

# This solution lets you just call pre-existing static streams,
# and it puts all the debug enabling in one place.

static var ACTIONS : Lib.EasyLog
static var MOVEMENT : Lib.EasyLog
static var ASSETS : Lib.EasyLog
static var SAVE_SYSTEM : Lib.EasyLog
static var PATHING : Lib.EasyLog
static var DIALOGUE : Lib.EasyLog
