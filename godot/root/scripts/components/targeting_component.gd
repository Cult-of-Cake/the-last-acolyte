class_name TargetingComponent extends Node2D

@export var primary_targeting_shape:CollisionShape2D
@export var primary_targeting:Area2D


@export var tower_range:int= 150

signal target_detected
signal no_target_detected

func _ready()->void:
	primary_targeting_shape.shape.radius = tower_range

#func _physics_process(delta:float)->void:
#	get_targets()

func get_targets() -> Array[Enemy]:
	var overlaps := primary_targeting.get_overlapping_bodies()
	var true_bodies:Array[Enemy]
	for overlap in overlaps:
		true_bodies.append(overlap.true_body)
	if true_bodies:
		pass
	else:
		no_target_detected.emit()
	return true_bodies

func get_target()->Enemy:
	var enemies:Array[Enemy] = get_targets()
	if enemies:
		return enemies[0]
	else:
		return null

func _on_primary_targeting_body_entered(body: Node2D) -> void:
	primary_targeting_shape.shape.radius = 900
	target_detected.emit()
