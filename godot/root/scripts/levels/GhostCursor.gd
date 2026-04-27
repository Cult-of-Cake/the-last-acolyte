extends Node2D
class_name GhostCursor

@export var barrier : Sprite2D
@export var tower : Sprite2D

func _ready() -> void:
	SignalBus.lvl_pet_result.connect(on_tower_placement)

func mouse_moved_to(coords : Vector2i) -> void:
	position = coords

#region Visibility
func set_to_barrier() -> void:
	barrier.visible = true
	tower.visible = false
func set_to_tower() -> void:
	barrier.visible = false
	tower.visible = true
func unset() -> void:
	barrier.visible = false
	tower.visible = false
#endregion

func on_tower_placement(pet : Tower) -> void:
	tower.texture = pet.cursor_img
	set_to_tower()

func flash_red() -> void:
	var tween := create_tween()
	tween.tween_property(self, "modulate", Color(1, 0, 0), 0.2)
	await tween.finished
	tween = create_tween()
	tween.tween_property(self, "modulate", Color(1, 1, 1), 0.1)
