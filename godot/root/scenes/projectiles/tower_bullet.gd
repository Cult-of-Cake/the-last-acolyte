class_name TowerBullet extends Projectile

var enemy:Enemy
var start_point:Vector2
var damage:int = 5

@onready var max_flight_time:float = 1.0
@onready var max_lifetime:float = 2.0
@onready var base_speed:int = 800
@onready var alive:bool = true
var speed:float

func _ready()->void:
	speed = base_speed
	%Lifetime.wait_time = max_lifetime
	%Lifetime.start()
	await get_tree().create_timer(max_lifetime).timeout
	queue_free()
	pass

func _physics_process(delta:float)->void:
	#There's a lot of stuff here to speed up the bullet if it is going to fall short of reaching its target in an appropriate time
	#Also, if the enemy is eliminated, just don't move.
	if(enemy && alive):
		var distance:float = self.global_position.distance_to(enemy.global_position)
		var age:float = max_lifetime - %Lifetime.time_left
		var eta:float = 1.0 - age
		var remaining_flight:float = base_speed * eta
		if eta > 0:
			if(distance > remaining_flight):
				speed = speed * (distance/remaining_flight)
		else:#It should have arrived at the target already.  It's been on-screen too long
			var multiplier:float = eta * -20
			if(multiplier < 2):
				multiplier = 2
			speed = distance * multiplier
	 
		var direction:Vector2 = enemy.global_position - self.global_position
		direction = direction.normalized()
		velocity = direction * speed
		
		#Move
		#Unless the bullet has collided already.
		#Don't overshoot the target in a single frame.
		if(speed * delta >= distance):
			self.global_position = enemy.global_position
		else:
			self.global_position = self.global_position + velocity * delta
		var bodies:Array[Node2D] = %Area2D.get_overlapping_bodies()
		for body in bodies:
			if alive:
				collide(body)
	else:
		#Still move if there's no target and the bullet isn't stopped
		if alive:
			self.global_position = self.global_position + velocity * delta


func collide(body:Node2D)->void:
	if body.has_method("get_hit"):
		body.get_hit(self)
		alive = false
		#TODO Maybe replace its sprite with an explode animation or something for its last 0.2 seconds.
		await get_tree().create_timer(0.2).timeout
		queue_free()
