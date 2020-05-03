extends Node

var enemy
var player 
var armor_name
var damage_reduction
var has_effect = false setget ,get_effect
var resistances 
var immunities

#func _init(_name, _damage, _attack_num, _attack_text, _enemy, _player):
func set_stats(_name, _damage_reduction, _res, _imm, _effect, _enemy, _player):
	armor_name = _name
	damage_reduction = _damage_reduction
	enemy = _enemy
	player = _player
	has_effect = _effect
	resistances = _res
	immunities = _imm

func calculate_damage(damage, type="phys"):
	var new_damage
	print("DAMAGE IS  *** " + str(damage))
	for res in resistances:
		print("RESISTANCE")
		if res == type:
			print(res)
			new_damage = int(damage/2)
			return new_damage
	for imm in immunities:
		print("IMMUNITY")
		if imm == type:
			print(imm)
			new_damage = 0
			return new_damage
	new_damage = int(clamp(damage + damage_reduction, -INF,0))
	print("NEW DAMAGE IS  *** " + str(new_damage))
	return new_damage
	
func get_effect():
	return has_effect