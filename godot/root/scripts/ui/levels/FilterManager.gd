extends Node2D
class_name FilterManager

@export var faves_button : ImageCycler
@export var tribe_button : ImageCycler
@export var affinity_button : ImageCycler
@export var tribe_label : Label
@export var affinity_label : Label

func _ready() -> void:
	SignalBus.lvl_pet_filter_cycle_favourite.connect(on_key_favourite)
	SignalBus.lvl_pet_filter_cycle_tribe.connect(on_key_tribe)
	SignalBus.lvl_pet_filter_cycle_affinity.connect(on_key_element)
	SignalBus.lvl_pet_filter_reset.connect(on_key_reset_filters)

var NO_FILTER : int = -1
var FAVES_FILTER_DEFAULT : bool = true
var TRIBE_FILTER_DEFAULT : int = NO_FILTER
var AFFINITY_FILTER_DEFAULT : int = NO_FILTER
var faves_filter : bool = FAVES_FILTER_DEFAULT
var tribe_filter : int = TRIBE_FILTER_DEFAULT
var affinity_filter : int = AFFINITY_FILTER_DEFAULT

# Turns favourites-only on or off
func on_key_favourite() -> void:
	faves_filter = !faves_filter
	if faves_filter:
		faves_button.set_to_image(0)
	else:
		faves_button.show_none()

# Cycle tribe through the roles, then back to all
func on_key_tribe() -> void:
	if tribe_filter == NO_FILTER:
		tribe_filter = 0
	else:
		tribe_filter += 1
		if tribe_filter >= Vars.ROLE.size():
			tribe_filter = NO_FILTER
	# And update the button
	var label : String
	if tribe_filter == NO_FILTER:
		tribe_button.show_all()
		label = "Any"
	else:
		tribe_button.set_to_image(tribe_filter)
		label = Vars.ROLE_NAMES[tribe_filter]
	tribe_label.text = "Tribe: " + label

# E cycles affinity through the elements, then back to all
# C cycles affinity through the cosmics, then back to all
# A cycles either affinity - elements then cosmics - then back to all
func on_key_element() -> void:
	if affinity_filter == NO_FILTER:
		affinity_filter = 0
	else:
		affinity_filter += 1
		if affinity_filter >= Vars.ELEMENT.size() - 1: # We're ignoring Special, for now
			affinity_filter = NO_FILTER
	out.ACTIONS.debug(["Affinity filter: ", affinity_filter])
	# And update the button
	var label : String
	if affinity_filter == NO_FILTER:
		affinity_button.show_all()
		label = "Any"
	else:
		affinity_button.set_to_image(affinity_filter)
		label = Vars.ELEMENT_NAMES[affinity_filter + 1] # Again, ignoring Special
	affinity_label.text = "Element: " + label

# A is being used by WASD anyway, let's just figure this out if/when cosmic gets added
#func on_key_affinity() -> void:
	#if affinity_filter == NO_FILTER:
		#affinity_filter = 1
	#else:
		#affinity_filter += 1
		#if affinity_filter >= Vars.ELEMENT.size() - 1: #TODO: + COSMIC - 1 ?
			## If we end up with an AFFINITY enum that just has all, maybe we update
			## the later functions instead to use AFFINITY.size / 2 ?
			#affinity_filter = NO_FILTER

#func on_filter_changed(fav : bool, tribe : int, aff : int) -> void:
	#pass
	
# Resets all filters
func on_key_reset_filters() -> void:
	faves_filter = FAVES_FILTER_DEFAULT
	tribe_filter = TRIBE_FILTER_DEFAULT
	affinity_filter = AFFINITY_FILTER_DEFAULT
	on_key_favourite()
	on_key_tribe()
	on_key_element()
