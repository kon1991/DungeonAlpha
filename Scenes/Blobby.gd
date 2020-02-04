extends "res://Scenes/EnemyStats.gd"

onready var monsterName = "Blobby"
onready var monsterDamage = 2
onready var monsterMood = "Slimy"
onready var monsterHP = 10

func _ready():
	set_stats(monsterName, monsterDamage, monsterHP, monsterMood)
	greet()
	yield(textBox, "end_enemy_text")
	pass # Replace with function body.

func take_turn():
	regen()
	yield(textBox, "end_enemy_text")
	attack()
	
func attack():
	player.set_hp(-damage)
#	potentionally debuffs you, scrambles letter and placement of buttons maybe?
	set_text("Slimy tendrils grope you!")
	yield(textBox, "end_enemy_text")
	emit_signal("end_turn")
	
func regen():
	set_hp(2)
	set_text("Blobby regenerates!")
	
func greet():
	set_array_text(["Slime flows down form the ceiling", "It unites into Blobby!"])