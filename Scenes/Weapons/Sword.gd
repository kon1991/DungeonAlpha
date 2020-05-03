extends "res://Scenes/Weapons/Weapon.gd"


func _init(_enemy, _player):
	print("WEAPON")
	set_stats("Sword", 9, 1, "You slash the ", null, _enemy,_player)
	pass