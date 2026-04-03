extends Node2D
class_name HealthTracker

#@export var creature : Creature
@export var max_hit_points : float = 1000.0
@export var progress_bar : TextureProgressBar

var hit_points : float = 1000.0
signal died

func _ready() -> void:
	hit_points = max_hit_points
	progress_bar.value = 100

func take_damage(amount : float) -> void:
	hit_points -= amount
	if hit_points <= 0:
		hit_points = 0
		died.emit()
	progress_bar.value = hit_points / max_hit_points * 100
