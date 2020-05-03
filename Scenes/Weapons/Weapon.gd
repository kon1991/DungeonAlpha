extends Node

var enemy
var player 
var weapon_name
var damage
var attack_num
var attack_text
var effect = null
signal attack_end

var damage_dealt

#func _init(_name, _damage, _attack_num, _attack_text, _enemy, _player):
func set_stats(_name, _damage, _attack_num, _attack_text, _effect, _enemy, _player):
	weapon_name = _name
	damage = _damage
	attack_num = _attack_num
	attack_text = _attack_text
	effect = _effect
	enemy = _enemy
	player = _player
	print(enemy)
	
func attack():
	player.set_text(attack_text + enemy.mname)
	damage_dealt = -(damage + player.damage_mod)
	enemy.set_hp(damage_dealt)
	return damage_dealt
