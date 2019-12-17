extends "res://Scenes/EnemyStats.gd"

onready var monsterName = "Magic Man"
onready var monsterDamage = 2
onready var monsterMood = "Trippi"
onready var monsterHP = 15

func _ready():
	set_stats(monsterName, monsterDamage, monsterHP, monsterMood)
	greet()
	pass # Replace with function body.

func take_turn():
	if(mood == "???"):
		set_text("The magic man vanishes!")
		yield(textBox, "end_enemy_text")
		escape()
	else:
		attack()
	pass
	
func attack():
	player.set_hp(-damage)
#	potentionally debuffs you, scrambles letter and placement of buttons maybe?
	set_text("The magic man zaps you!")
	yield(textBox, "end_enemy_text")
	emit_signal("end_turn")

func greet():
	set_text("The magic man wanders around")
	
func set_hp(new_hp):
	.set_hp(new_hp)
	if(hp <=7):
		set_mood("???")
		
func escape(): 
	main._on_Enemy_died()