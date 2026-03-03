extends Region
class_name SpeedRegion

@export var speed_multiplier: float = 1.0


func _on_body_entered(body: Node2D) -> void:
	#if body is Enemy:
	print("entered")
	var enemy: Enemy = Lib.Objects.find_child_of_type(body, Enemy, true)
	if enemy != null:
		print("is enemy")
		enemy.set_speed_multiplier(speed_multiplier)
