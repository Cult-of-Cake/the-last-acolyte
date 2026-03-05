extends SaveData
class_name CharacterStats

enum STAT {
	# The usual
	SPEED, MAX_HP, HP_REGEN_AMOUNT, CRIT_CHANCE, CRIT_MULTIPLIER,
	# All towers will have powers that use both, albeit usually more of one
	ATTACK_ELEMENTAL, ATTACK_COSMIC,
	DEFENSE_ELEMENTAL, DEFENSE_COSMIC,
	# Optional (e.g. Player has MP, Pets have rage, boss enemies have armour
	MAX_MP, MP_REGEN_AMOUNT, MAX_RAGE, RAGE_REGEN_AMOUNT, HEAL_AMOUNT,
	ARMOUR, ARMOUR_PENETRATION,
	# Be careful with this one, it probably shouldn't ever go beyond, say, 2
	RANGE_MULTIPLIER,
}
var defaults : Array[float] = [
	10, 50, 0, 0, 1,
	5, 5,
	0, 0,
	0, 1, 0, 1, 0,
	0, 0,
	1,
]

var _values : Dictionary[STAT, float]
var values_str : Dictionary[String, float] # This one is needed to save to file

func _init() -> void:
	for s : int in range(0, STAT.size()):
		_values[s] = defaults[s]

func get_stat(idx : STAT) -> float:
	return _values[idx]
func set_stat(idx : STAT, val : float) -> void:
	_values[idx] = val
	values_str[EnumUtils.to_name(int(idx), STAT)] = val
