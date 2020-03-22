extends Node

var enemy
var player 
var weapon_name
var damage
var attack_num
var attack_text


func _init(_name, _damage, _attack_num, _attack_text, _enemy, _player):
	weapon_name = _name
	damage = _damage
	attack_num = _attack_num
	attack_text = _attack_text
	enemy = _enemy
	player = _player
	print("WEAPON CREATED") 
	print(enemy)
	
func attack():
	print("ATTACCKKK")
	player.set_text(attack_text + enemy.mname)
	enemy.set_hp(-(damage + player.damage_mod))
