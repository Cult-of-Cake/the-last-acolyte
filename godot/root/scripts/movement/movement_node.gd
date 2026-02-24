extends Node2D
class_name movement_node

@export var motion_obj : PhysicsBody2D

var velocity : Vector2 :
	get:
		return motion_obj.velocity
	set (value):
		motion_obj.velocity = value
