extends Node
class_name PetListManager

const row_template = preload(Vars.Paths.PREFABS + "hub/pet_row.tscn")

@export var row_container : Control

var initiated : bool = false

func create_starters() -> void:
	# TODO: Decide what the starters actually are, haha
	for _seed in range(0, 5):
		sprout_seed()

func update_display() -> void:
	# Clear out the old
	var children : Array[Node] = row_container.get_children(false)
	var i : int = 0
	for c in children:
		if i >= 2:
			c.queue_free()
		i += 1
	# Display the new
	for sprout_id in Game.get_pet_ids():
		#var pet : PetRegistryData = Game.get_pet_data(sprout_id)
		var new_row := row_template.instantiate()
		new_row.get_node("PetRow").set_id(sprout_id)
		row_container.add_child(new_row)

func sprout_seed() -> void:
	var reg := PetRegistryData.new(true)
	
	# Type, element, name
	# TODO: We might like to have a "favour" mechanic where the god can influence
	# these odds, and the strength of that will likely increase each time you fail
	var elem : Vars.ELEMENT = Vars.ELEMENT.values().pick_random()
	reg.set_element(elem)
	reg.given_name = Vars.RandomNames.pick(elem)
	reg.name = reg.given_name # Might as well name the node too
	reg.set_role(Vars.ROLE.DAMAGE) # TODO: Randomize this too, but later
	
	# Random starting stats
	# TODO: We probably want to revisit this algorithm, but variance here will be
	# useful for testing the TD levels so doing this for now
	stat_add_variance(reg, Vars.STAT.SPEED)
	stat_add_variance(reg, Vars.STAT.MAX_HP)
	if elem == Vars.ELEMENT.ELECTRIC:
		reg.set_stat(Vars.STAT.CRIT_CHANCE, 10)
		reg.set_stat(Vars.STAT.CRIT_MULTIPLIER, 2.5)
	stat_add_variance(reg, Vars.STAT.ATTACK_ELEMENTAL)
	stat_add_variance(reg, Vars.STAT.ATTACK_COSMIC)
	stat_add_variance(reg, Vars.STAT.DEFENSE_ELEMENTAL)
	stat_add_variance(reg, Vars.STAT.DEFENSE_COSMIC)
	Game.set_pet_data(reg)

func stat_add_variance(reg : PetRegistryData, s : String) -> void:
	var initial : float = reg.get_stat(s)
	var variance : float = randf_range(0.8, 2.0)
	var final : float = roundf(initial * variance * 2) / 2 # Round to nearest .5
	reg.set_stat(s, final)

func _process(_delta: float) -> void:
	if !initiated:
		if Data.is_node_ready():
			out.SAVE_SYSTEM.debug("Save system ready")
			Data.load_save_file()
			if Game.get_pet_ids().size() == 0:
				out.SAVE_SYSTEM.debug("Creating starter pets")
				create_starters()
				Data.save_save_file()
			else:
				out.SAVE_SYSTEM.debug("Found save file")
			update_display()
			initiated = true
