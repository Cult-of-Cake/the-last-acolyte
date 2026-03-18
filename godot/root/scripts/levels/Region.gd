extends Area2D
class_name Region

@export var collider : CollisionShape2D
@export var match_area : MarginContainer

func _ready() -> void:
	var collision_shape : RectangleShape2D = RectangleShape2D.new()
	var rect : Rect2 = match_area.get_rect()
	position = (rect.size / 2)
	collision_shape.size = rect.size
	collider.shape = collision_shape
