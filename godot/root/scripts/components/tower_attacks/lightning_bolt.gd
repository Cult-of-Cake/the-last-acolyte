extends TowerAttack

@onready var damage:int = 15
@onready var bounces:int = 0

func _ready():
	cooldown = 5

func fire(target:Enemy)->void:
	if !on_cooldown:
		on_cooldown = true
		var bolt = load("res://root/scenes/projectiles/arcing_bolt.tscn").instantiate()
		add_child(bolt)
		bolt.spawn_sprites(global_position, target)
		bolt.strike(target)
		do_cooldown()

func get_target()->Enemy:
	var rv:Enemy
	if !on_cooldown:
		rv = targeting_component.get_target()
	return rv

func do_cooldown()->void:
	await get_tree().create_timer(cooldown).timeout
	on_cooldown = false
