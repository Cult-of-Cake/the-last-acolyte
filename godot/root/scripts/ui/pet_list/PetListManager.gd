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
	var elem : Vars.ELEMENT = Vars.ELEMENT.values().pick_random()
	reg.set_element(elem)
	reg.given_name = Vars.RandomNames.pick(elem)
	reg.name = reg.given_name # Might as well name the node too
	Game.set_pet_data(reg)

func _process(_delta: float) -> void:
	if !initiated:
		if Data.is_node_ready():
			print("Save system ready")
			Data.load_save_file()
			if Game.get_pet_ids().size() == 0:
				print("Creating starter pets")
				create_starters()
				Data.save_save_file()
			else:
				print("Found save file")
			update_display()
			initiated = true
