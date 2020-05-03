extends Node

onready var main = get_tree().current_scene
onready var textBox = main.textBox
onready var player = main.find_node("PlayerStats")
onready var enemy 
var attack_end = []
onready var effects_activated = false

signal player_attack_end_over

func _ready():
#	player.connect("player_attack_start", self, "_on_player_attack_start")
	pass
func _on_player_attack_start():
	print("attacl startderd")
	pass
	
func _on_player_attack_end(damage_dealt):
	for passive in attack_end:
		var current_passive = passive
		current_passive.activate(damage_dealt)
		if current_passive.activated:
			print("ASdFFSASFASF")
			yield(current_passive, "passive_over")
#	yield(get_tree().create_timer(0.5), "timeout")
	emit_signal("player_attack_end_over")
	effects_activated = false
	
func initiate_passives():
	if player.passiveAbilities != []:
		for passive in player.passiveAbilities:
			var Passive = load("res://Scenes/"+passive+".gd")
			var newPassive = Passive.new(player,enemy,main)
			newPassive.connect("effect_activated", self, "on_passive_activated")
			match newPassive.type:
				"attack_end": 
					attack_end.append(newPassive)
					
func on_passive_activated():
	print("EFFECTS AND SHIET")
	effects_activated = true