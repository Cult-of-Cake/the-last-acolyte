extends Area2D

@export var layer : Node2D

func _on_body_entered(_body: Node2D) -> void:
	layer.visible = false

func _on_body_exited(_body: Node2D) -> void:
	layer.visible = true
