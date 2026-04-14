class_name HomingBullet extends TowerAttack

var enemy:Enemy

func _ready()->void:
	cooldown = 1000

func fire(target:Enemy) -> void:
	if !on_cooldown:
		on_cooldown = true
		var bullet:Projectile = load("res://root/scenes/projectiles/tower_bullet.tscn").instantiate()
		bullet.enemy = target
		bullet.start_point = self.global_position
		add_child(bullet)
		do_cooldown()

func do_cooldown()->void:
	await get_tree().create_timer(cooldown).timeout
	on_cooldown = false

func get_target()->Enemy:
	var rv:Enemy
	if !on_cooldown:
		rv =  targeting_component.get_target()
	return rv
