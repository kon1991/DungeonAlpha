extends Node

var type 
var main
var player
var enemy
var activated = false

signal effect_activated

func set_stats(_type,_player,_enemy, _main):
	type = _type
	player = _player
	enemy = _enemy
	main = _main
	