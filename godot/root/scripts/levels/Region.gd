extends Area2D
class_name Region

@export var collision_shape : RectangleShape2D
@export var collider : CollisionShape2D
@export var match_area : MarginContainer

func _ready() -> void:
	var rect : Rect2 = match_area.get_rect()
	position = (rect.size / 2)
	collision_shape = RectangleShape2D.new()
	collision_shape.size = rect.size
	collider.shape = collision_shape
