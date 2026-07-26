extends Node2D
class_name FilterManager

const PET_BUTTON : PackedScene = preload(Vars.Paths.LVL_UI + "button_pp_pet" + Vars.Paths.PREFAB_SUFFIX)
@export var pet_button_parent : Control
const MAPPED_KEYS_COUNT : int = 5

func _ready() -> void:
	connect_keypress_signals()
	if Vars.save_data_ready:
		load_available_towers()
	else:
		SignalBus.save_data_is_ready.connect(load_available_towers)

#region Key presses

@export var faves_button : ImageCycler
@export var tribe_button : ImageCycler
@export var affinity_button : ImageCycler
@export var tribe_label : Label
@export var affinity_label : Label

var NO_FILTER : int = -1
var FAVES_FILTER_DEFAULT : bool = true
var TRIBE_FILTER_DEFAULT : int = NO_FILTER
var AFFINITY_FILTER_DEFAULT : int = NO_FILTER
var faves_filter : bool = FAVES_FILTER_DEFAULT
var tribe_filter : int = TRIBE_FILTER_DEFAULT
var affinity_filter : int = AFFINITY_FILTER_DEFAULT

func connect_keypress_signals() -> void:
	SignalBus.lvl_pet_filter_cycle_favourite.connect(on_key_favourite)
	SignalBus.lvl_pet_filter_cycle_tribe.connect(on_key_tribe)
	SignalBus.lvl_pet_filter_cycle_affinity.connect(on_key_element)
	SignalBus.lvl_pet_filter_reset.connect(on_key_reset_filters)
	SignalBus.lvl_pet_pick.connect(on_pet_number)
	SignalBus.lvl_pet_placed.connect(on_tower_placed)

# Turns favourites-only on or off
func on_key_favourite() -> void:
	faves_filter = !faves_filter
	update_fave_display()
	refilter()

func update_fave_display() -> void:
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
	update_tribe_display()
	refilter()

func update_tribe_display() -> void:
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
		affinity_filter = Vars.ELEMENT.FIRE
	else:
		affinity_filter += 1
		if affinity_filter >= Vars.ELEMENT.WATER:
			affinity_filter = NO_FILTER
	out.ACTIONS.debug(["Affinity filter: ", affinity_filter])
	update_element_display()
	refilter()

func update_element_display() -> void:
	var label : String
	if affinity_filter == NO_FILTER:
		affinity_button.show_all()
		label = "Any"
	else:
		affinity_button.set_to_image(affinity_filter - 1) # Ignoring special
		label = Vars.ELEMENT_NAMES[affinity_filter]
	affinity_label.text = "Element: " + label

# --- Non-filter button action --------------------------------------------------
# Handles barrier, pet selection, etc
# This shouldn't strictly be here, but 1) creating a new class for these other actions seems
# like overkill, and 2) all the rest are here so this makes things easier to debug/maintain.
static func fake_event_signal(signal_name : String) -> void:
	#out.ACTIONS.debug("fake_event_signal ", signal_name)
	var event := InputEventAction.new()
	event.action = signal_name
	event.pressed = true
	Input.parse_input_event(event)


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
	update_fave_display()
	update_tribe_display()
	update_element_display()
	refilter()

#endregion

func on_pet_number(n : int) -> void:
	# This should return the ID of the nth pet who has not been filtered out and has not been placed
	selected = available_towers.get(filtered_towers[n])
	SignalBus.lvl_pet_result.emit(selected)

#region Towers

var selected : Tower
var available_towers : Dictionary[int, Tower]
var placed_towers : Array[int]
var filtered_towers : Array[int]
var pet_button_list : Dictionary[int, PetPickerButton]

func load_available_towers() -> void:
	filtered_towers.clear()
	var added_count : int = 0
	for p_id in Game.get_pet_ids():
		var pet : PetRegistryData = Game.get_pet_data(p_id)
		var tower : Tower = Vars.get_tower_prefab(pet).instantiate() as Tower
		tower.init(pet)
		available_towers[pet.sprout_id] = tower
		var pet_button := PET_BUTTON.instantiate() as PetPickerButton
		pet_button.init(tower)
		pet_button_parent.add_child(pet_button)
		pet_button_list[pet.sprout_id] = pet_button
		# Do a default sort, this will change a lot though
		filtered_towers.append(pet.sprout_id)
		pet_button.display_on_bar(added_count + 1, added_count < MAPPED_KEYS_COUNT)
		added_count += 1

func on_tower_placed(coords : Vector2i) -> void:
	selected.coords = coords
	placed_towers.append(selected.data.sprout_id)
	refilter()

#endregion

func refilter() -> void:
	filtered_towers.clear()
	var added_count : int = 0
	for tower : Tower in available_towers.values():
		var pet := tower.data
		var is_match : bool = true
		is_match = is_match && (!placed_towers.has(pet.sprout_id))
		#TODO Put this back when favourites exist: is_match = is_match && (!faves_filter or pet.is_favourite)
		is_match = is_match && (tribe_filter == NO_FILTER or tribe_filter == tower.role)
		is_match = is_match && (affinity_filter == NO_FILTER or affinity_filter == tower.affinity)
		if is_match:
			filtered_towers.append(pet.sprout_id)
			pet_button_list[pet.sprout_id].display_on_bar(added_count + 1, added_count < MAPPED_KEYS_COUNT)
			added_count += 1
		else:
			pet_button_list[pet.sprout_id].hide_from_bar()
