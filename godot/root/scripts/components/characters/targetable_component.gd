class_name TargetableComponent extends CharacterBody2D

@export var radius:float = 20
@export var true_body:Enemy

func _ready()->void:
	get_node("CollisionShape2D").shape.radius = radius
