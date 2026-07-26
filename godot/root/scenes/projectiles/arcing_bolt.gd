extends Projectile

@onready var sprite_length:int = 158

@onready var connected:bool = false

func _ready()->void:
	await get_tree().create_timer(0.8).timeout
	queue_free()

func spawn_sprites(origin:Vector2, target:Enemy)->void:
	var distance:float = origin.distance_to(target.global_position)
	if distance < sprite_length * 1.5:
		#In this case, stretch the bolt
		var x_ratio = distance/sprite_length
		var bolt_animation = load("res://root/scenes/component/tower_attacks/tower_projectiles/animated_bolt.tscn").instantiate()
		add_child(bolt_animation)
		bolt_animation.scale = Vector2(x_ratio, 1)
		bolt_animation.global_position = origin
		bolt_animation.look_at(target.global_position)
		pass
	else:
		#In this case, start building multiple bolts
		#print("Origin: ", origin, " target: ", target.global_position)
		var start:Vector2 = origin
		var angle:float = origin.angle_to_point(target.global_position)
		var deg_angle:float = rad_to_deg(angle)
		var variance:int = randi_range(-25, 25)
		deg_angle = deg_angle + variance
		var rad_angle:float = deg_to_rad(deg_angle)
		var progress_vector:Vector2 = Vector2.from_angle(rad_angle).normalized() * sprite_length
		var new_point:Vector2 = origin + progress_vector
		var bolt_animation = load("res://root/scenes/component/tower_attacks/tower_projectiles/animated_bolt.tscn").instantiate()
		add_child(bolt_animation)
		bolt_animation.global_position = start
		bolt_animation.look_at(new_point)
		spawn_sprites(new_point, target)
		
func strike(body:Node2D)->void:
	out.TD.debug("strike called")
	if body.has_method("get_hit"):
		body.get_hit(self)
		
		
