extends Label
class_name FadingText

@export var fade_time : float
@export var distance : float
@export var x_motion : float
@export var y_motion : float

func _ready() -> void:
	create_tween().tween_property(self, "position", distance * Vector2(x_motion, y_motion), fade_time)
	create_tween().tween_property(self, "modulate:a", 0, fade_time)
