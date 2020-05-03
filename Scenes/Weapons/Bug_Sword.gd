extends "res://Scenes/Weapons/Weapon.gd"

var broken = false

func _init(_enemy, _player):
	print("WEAPON")
	set_stats("Bug Sword", 2, 1, "You scratch the ", null, _enemy,_player)
	pass
	
func attack():
	randomize()
	if !broken:
		if randi()%100 < 10:
			player.set_text(attack_text + enemy.mname)
			
		else:
			player.set_array_text(["You slash the " +enemy.mname + " twice in a flash!", "The Bug Sword breaks in half..."])
			damage_dealt = -(int(damage*(3)) + player.damage_mod)
			enemy.set_hp(damage_dealt)
			broken = true
	else:
		player.set_text(attack_text + enemy.mname)
#		enemy.set_hp()
		damage_dealt = -(int(damage/2) + player.damage_mod)
		enemy.set_hp(damage_dealt)
	return damage_dealt