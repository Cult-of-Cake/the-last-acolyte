extends SaveData
class_name PetRegistryData

var sprout_id : int = 0
var given_name : String = "~Rick~"
var _element : Vars.ELEMENT
var element_str : String: # This one is needed to save to file
	get:
		return element_str
	set (elem):
		element_str = elem
		_element = EnumUtils.from_name(elem, Vars.ELEMENT) as Vars.ELEMENT
var _role : Vars.ROLE
var role_str : String: # This one is needed to save to file
	get:
		return role_str
	set (r):
		role_str = r
		_role = EnumUtils.from_name(r, Vars.ROLE) as Vars.ROLE
	
var recolour : Color = Vars.NO_COLOUR
var _stats : CharacterStats
var stats : String

func _init(sprouting_new : bool = false) -> void:
	if sprouting_new:
		Data.pet.num_sprouted += 1
	sprout_id = Data.pet.num_sprouted
	set_element(Vars.ELEMENT.SPECIAL)
	set_role(Vars.ROLE.DAMAGE)
	_stats = CharacterStats.new()
	_init_export_vars()

func get_element() -> Vars.ELEMENT:
	return _element
func set_element(elem : Vars.ELEMENT) -> void:
	# This already sets both via setter, don't add another and cause a stack overflow
	element_str = EnumUtils.to_name(int(elem), Vars.ELEMENT)
func get_role() -> Vars.ROLE:
	return _role
func set_role(r : Vars.ROLE) -> void:
	# This already sets both via setter, don't add another and cause a stack overflow
	role_str = EnumUtils.to_name(int(r), Vars.ROLE)
func get_stat(s : String) -> float:
	return _stats.get_stat(s)
func set_stat(s : String, val : float) -> void:
	_stats.set_stat(s, val)

# This works because we extend SaveData
func serialize() -> String:
	stats = _stats.serialize()
	return JSON.stringify(get_as_dict())

func load_stats(arr : Dictionary) -> void:
	_stats = CharacterStats.new()
	for key : String in arr.keys():
		_stats.values[key] = arr[key]
