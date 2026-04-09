extends Node
class_name CharacterStats

var values : Dictionary[String, float]

func _init() -> void:
	set_stat(Vars.STAT.SPEED, 10)
	set_stat(Vars.STAT.MAX_HP, 50)
	set_stat(Vars.STAT.HP_REGEN_AMOUNT, 0)
	set_stat(Vars.STAT.CRIT_CHANCE, 0)
	set_stat(Vars.STAT.CRIT_MULTIPLIER, 1)
	set_stat(Vars.STAT.RANGE_MULTIPLIER, 1)
	set_stat(Vars.STAT.ATTACK_ELEMENTAL, 8)
	set_stat(Vars.STAT.ATTACK_COSMIC, 8)
	set_stat(Vars.STAT.DEFENSE_ELEMENTAL, 4)
	set_stat(Vars.STAT.DEFENSE_COSMIC, 4)
	# Optional
	set_stat(Vars.STAT.MAX_MP, 0)
	set_stat(Vars.STAT.MP_REGEN_AMOUNT, 1)
	set_stat(Vars.STAT.MAX_RAGE, 0)
	set_stat(Vars.STAT.RAGE_REGEN_AMOUNT, 1)
	set_stat(Vars.STAT.HEAL_AMOUNT, 0)
	set_stat(Vars.STAT.ARMOUR, 0)
	set_stat(Vars.STAT.ARMOUR_PENETRATION, 0)

func get_stat(idx : String) -> float:
	return values[idx]
func set_stat(idx : String, val : float) -> void:
	values[idx] = val

func serialize() -> String:
	return JSON.stringify(values)
