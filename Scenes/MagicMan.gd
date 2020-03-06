extends "res://Scenes/EnemyStats.gd"

onready var monsterName = "Magic Man"
onready var monsterDamage = 2
onready var monsterMood = "Trippi"
onready var monsterHP = 15
onready var specials = []

var vanish = false

func _ready():
	set_stats(monsterName, monsterDamage, monsterHP, monsterMood)
	greet()
	yield(textBox, "end_enemy_text")
	pass # Replace with function body.

func take_turn():
	if(vanish == true):
		set_text("The magic man poofs out of existence!")
		yield(textBox, "end_enemy_text")
		yield(get_tree().create_timer(0.8), "timeout")
		escape()
	if(mood == "???"):
		set_text("The magic man starts chanting!")
		vanish = true
		yield(textBox, "end_enemy_text")
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
	yield(textBox, "end_enemy_text")
	emit_signal("greet_over")
	
func set_hp(new_hp, type="phys"):
	.set_hp(new_hp)
	if(hp <=10):
		set_mood("???")
		
		
func escape(): 
	main._on_Enemy_died(false)