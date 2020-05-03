extends "res://Scenes/Weapons/Weapon.gd"

func _init(_enemy, _player):
	print("WEAPON")
	set_stats("Flame Sword", 9, 1, "You burn the ", "fire", _enemy,_player)
	pass
	
func attack():
	if enemy.has_tag("fire_vuln"):
		player.set_array_text(["Your Flame Sword flashes!","You sear the "+ enemy.mname])
	else:
		player.set_text(attack_text + enemy.mname)
	
	damage_dealt = -(damage + player.damage_mod)
	enemy.set_hp(damage_dealt, "fire")
	return damage_dealt