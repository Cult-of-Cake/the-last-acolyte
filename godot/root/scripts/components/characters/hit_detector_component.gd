class_name HitDetectorComponent extends CharacterBody2D

signal hit(projectile:Projectile)

enum Shape {CIRLCE}

@export var shape:Shape
@export var radius:float

func _ready()->void:
	get_node("CollisionShape2D").shape.radius = radius

func get_hit(projectile:Projectile)->void:
	print("occurred")
	hit.emit(projectile)
