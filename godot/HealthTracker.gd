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
	init_shake_vars()

func take_damage(amount : float) -> void:
	# Set the correct hit-points
	hit_points -= amount
	if hit_points <= 0:
		hit_points = 0
		died.emit()
	# Display the updated amount
	progress_bar.value = hit_points / max_hit_points * 100
	create_floaty_damage("%s" % amount)
	shake_me()


#region Visual effects

const damage_obj_path : String = Vars.Paths.PREFABS + "ui/level/endpoint_damage" + Vars.Paths.PREFAB_SUFFIX
const damage_obj : PackedScene = preload(damage_obj_path)

func create_floaty_damage(amount : String) -> void:
	var floater := damage_obj.instantiate() as FadingText
	floater.text = amount
	add_child(floater)

@export var shake_sprite : Sprite2D
@export var shake_main : Vector2 = Vector2(10, 10)
@export var shake_time : float = 0.3
var currently_shaking : bool = false
# Calculated vars
var orig_position : Vector2
var shake_recoil : Vector2
var time_for_stage_1 : float
var time_for_stage_2 : float
var time_for_stage_3 : float
var time_for_stage_4 : float

func init_shake_vars() -> void:
	# Simple math, but the shake might get called 100 times in a level, so let's do it just the once
	orig_position = shake_sprite.position
	shake_recoil = shake_main * -0.5
	time_for_stage_1 = shake_time * 0.2
	time_for_stage_2 = shake_time * 0.3
	time_for_stage_3 = shake_time * 0.15
	time_for_stage_4 = shake_time * 0.35

func shake_me() -> void:
	if shake_sprite and !currently_shaking:
		currently_shaking = true
		await move_to(orig_position + shake_main, time_for_stage_1)
		await move_to(orig_position, time_for_stage_2)
		await move_to(orig_position + shake_recoil, time_for_stage_3)
		await move_to(orig_position, time_for_stage_4)
		currently_shaking = false

func move_to(posn : Vector2, duration : float) -> void:
	await create_tween().tween_property(shake_sprite, "position", posn, duration).finished

#endregion
