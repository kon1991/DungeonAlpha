extends "res://Scenes/Weapons/Weapon.gd"

func _init(_enemy, _player):
	set_stats("Mana Sword", 5, 1, "You slash the ", "magic", _enemy,_player)
	pass
	
func attack():
	if player.mp >=2 :
		damage_dealt = -(damage + 4 + player.damage_mod)
		enemy.set_hp(damage_dealt, "magic")
		player.set_text("Your sword fills with magical energy as you slash the "+ enemy.mname + "!")
		player.set_mp(-4)
	else:
		player.set_text(attack_text + enemy.mname)
		damage_dealt = -(damage + player.damage_mod)
		enemy.set_hp(damage_dealt)
	
	return damage_dealt