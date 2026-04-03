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
	print(damage_obj_path)

func take_damage(amount : float) -> void:
	# Set the correct hit-points
	hit_points -= amount
	if hit_points <= 0:
		hit_points = 0
		died.emit()
	# Display the updated amount
	progress_bar.value = hit_points / max_hit_points * 100
	create_floaty_damage("%s" % amount)


#region Floaty damage text

const damage_obj_path : String = Vars.Paths.PREFABS + "ui/level/endpoint_damage" + Vars.Paths.PREFAB_SUFFIX
const damage_obj : PackedScene = preload(damage_obj_path)

func create_floaty_damage(amount : String) -> void:
	var floater := damage_obj.instantiate() as FadingText
	floater.text = amount
	add_child(floater)

#endregion
