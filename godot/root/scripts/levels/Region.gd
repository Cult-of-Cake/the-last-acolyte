extends Area2D
class_name Region

@export var collision_shape: RectangleShape2D
@export var match_area: MarginContainer


func _ready() -> void:
	var rect: Rect2 = match_area.get_rect()
	collision_shape.size = rect.size
	position = (rect.size / 2)
