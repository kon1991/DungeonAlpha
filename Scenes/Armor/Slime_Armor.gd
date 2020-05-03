extends "res://Scenes/Armor/Armor.gd"

func _init(_enemy, _player):
	set_stats("Slime Armor", 1, [], ["acid"], false, _enemy, _player)