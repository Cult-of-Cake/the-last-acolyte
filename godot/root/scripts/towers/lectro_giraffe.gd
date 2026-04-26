class_name LectroGiraffe extends Tower

@onready var active:bool= true
@onready var attacks = %Attacks
@onready var cooldown_time = 0.5

func _ready() -> void:
	#targeting_component.target_detected.connect(activate)
	#targeting_component.no_target_detected.connect(deactivate)
	pass

func activate()->void:
	active = true

func deactivate()->void:
	active = false

func _physics_process(delta:float)->void:
	if(active):
		var attack:TowerAttack = select_attack()
		if attack:
			out.TD.debug(["Found an attack: ", attack])
			var enemy:Enemy = attack.get_target()
			attack.fire(enemy)
			start_cooldown()
		
func select_attack()->TowerAttack:
	var selected_attack:TowerAttack
	var attack_list:Array[TowerAttack]
	attack_list.assign(%Attacks.get_children())
	for attack in attack_list:
		if attack.get_target():
			selected_attack = attack
			return selected_attack
	return selected_attack

func start_cooldown()->void:
	active = false
	await get_tree().create_timer(cooldown_time).timeout
	active = true

#func select_enemy()->Enemy:
#	var enemy:Enemy = targeting_component.get_target()
#	return enemy
